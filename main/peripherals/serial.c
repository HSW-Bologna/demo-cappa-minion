#include "serial.h"
#include "driver/gpio.h"
#include "driver/uart.h"
#include "esp_log.h"
#include "hal/gpio_types.h"
#include "hal/uart_types.h"
#include "peripherals/phase_cut.h"
#include <liblightmodbus-esp/repo/include/lightmodbus/lightmodbus.h>
#include <liblightmodbus-esp/repo/include/lightmodbus/slave.h>
#include <string.h>

#define TAG "RS485_ECHO_APP"

#define UART_SCLK_DEFAULT 0

// Note: Some pins on target chip cannot be assigned for UART communication.
// Please refer to documentation for selected board and target to configure pins
// using Kconfig.
#define ECHO_TEST_TXD 5
#define ECHO_TEST_RXD 27

// RTS for RS485 Half-Duplex Mode manages DE/~RE
// #define ECHO_TEST_RTS 4
#define ECHO_TEST_RTS -1

// CTS is not used in RS485 Half-Duplex Mode
#define ECHO_TEST_CTS -1

#define BUF_SIZE (127)
#define BAUD_RATE 115200

// Read packet timeout
#define PACKET_READ_TICS (30 / portTICK_PERIOD_MS)
#define ECHO_UART_PORT 1

// Timeout threshold for UART = number of symbols (~10 tics) with unchanged
// state on receive pin
#define ECHO_READ_TOUT (3) // 3.5T * 8 = 28 ticks, TOUT=3 -> ~24..33 ticks

#define REG_COUNT 16
#define MINION_ADDR 1
uint16_t registers[REG_COUNT];
uint16_t inputRegisters[REG_COUNT];
uint8_t coils[REG_COUNT / 8];          // Each coil corresponds to one bit
uint8_t discreteInputs[REG_COUNT / 8]; // Each input corresponds to one bit
ModbusSlave slave;

bool printErrorInfo(ModbusErrorInfo err) {
  if (modbusIsOk(err)) {
    ESP_LOGI(TAG, "OK");
    return false;
  } else {
    ESP_LOGI(TAG, "%s: %s", modbusErrorSourceStr(modbusGetErrorSource(err)),
             modbusErrorStr(modbusGetErrorCode(err)));
    return true;
  }
}

void serial_init() {
  ModbusErrorInfo err;
  err = modbusSlaveInit(
      &slave,
      myRegisterCallback,          // Callback for register operations
      slaveExceptionCallback,      // Callback for handling slave exceptions
                                   // (optional)
      modbusDefaultAllocator,      // Memory allocator for allocating responses
      modbusSlaveDefaultFunctions, // Set of supported functions
      modbusSlaveDefaultFunctionCount // Number of supported functions
  );
  printErrorInfo(err);
}
void serial_destroy() { modbusSlaveDestroy(&slave); }

static void echo_send(const int port, const char *str, uint8_t length) {
  gpio_set_level(GPIO_NUM_4, 0);
  ets_delay_us(10);
  if (uart_write_bytes(port, str, length) != length) {
    ESP_LOGE(TAG, "Send data critical failure.");
    // add your code to handle sending failure here
    abort();
  }
  uart_wait_tx_done(port, portMAX_DELAY);
  gpio_set_level(GPIO_NUM_4, 1);
  ets_delay_us(10);
}

void printResponse(const ModbusSlave *slave) {
  for (int i = 0; i < modbusSlaveGetResponseLength(slave); i++)
    ESP_LOGI(TAG, "0x%02x ", modbusSlaveGetResponse(slave)[i]);
}

void parseRequest(uint8_t *data, int length) {
  ModbusErrorInfo err =
      modbusParseRequestRTU(&slave, MINION_ADDR, data, length);
  echo_send(ECHO_UART_PORT, (const char *)modbusSlaveGetResponse(&slave),
            modbusSlaveGetResponseLength(&slave));
  printErrorInfo(err);
}

ModbusError myRegisterCallback(const ModbusSlave *status,
                               const ModbusRegisterCallbackArgs *args,
                               ModbusRegisterCallbackResult *result) {
  ESP_LOGI(TAG, "CALLBACK\n");
  switch (args->query) {
  // R/W access check
  case MODBUS_REGQ_R_CHECK:
  case MODBUS_REGQ_W_CHECK:
    // If result->exceptionCode of a read/write access query is not
    // MODBUS_EXCEP_NONE, an exception is reported by the slave. If
    // result->exceptionCode is not set, the behavior is undefined.
    result->exceptionCode = args->index < REG_COUNT
                                ? MODBUS_EXCEP_NONE
                                : MODBUS_EXCEP_ILLEGAL_ADDRESS;
    break;

  // Read register
  case MODBUS_REGQ_R:
    switch (args->type) {
    case MODBUS_HOLDING_REGISTER:
      result->value = registers[args->index];
      break;
    case MODBUS_INPUT_REGISTER:
      result->value = inputRegisters[args->index];
      break;
    case MODBUS_COIL:
      result->value = modbusMaskRead(coils, args->index);
      break;
    case MODBUS_DISCRETE_INPUT:
      result->value = modbusMaskRead(discreteInputs, args->index);
      break;
    }
    break;

  // Write register
  case MODBUS_REGQ_W:
    ESP_LOGI(TAG, "Writing %d\n", args->value);
    switch (args->type) {
    case MODBUS_HOLDING_REGISTER:
      registers[args->index] = args->value;
      break;
    case MODBUS_COIL:
      modbusMaskWrite(coils, args->index, args->value);
      break;
    default:
      break;
    }
    break;
  }

  // Always return MODBUS_OK
  return MODBUS_OK;
}

/*
    Exception callback for printing out exceptions
*/
ModbusError slaveExceptionCallback(const ModbusSlave *slave, uint8_t function,
                                   ModbusExceptionCode code) {
  ESP_LOGI(TAG, "Slave reports an exception %s (function %d)\n",
           modbusExceptionCodeStr(code), function);

  // Always return MODBUS_OK
  return MODBUS_OK;
}

// An example of echo test with hardware flow control on UART
void echo_task_minion(void *arg) {
  serial_init();
  gpio_config_t gpioconfig = {BIT64(4), GPIO_MODE_OUTPUT, GPIO_PULLUP_DISABLE,
                              GPIO_PULLDOWN_DISABLE, GPIO_PIN_INTR_DISABLE};
  gpio_config(&gpioconfig);
  // quando a 1 ricevo, quando a 0 trasmetto
  gpio_set_level(GPIO_NUM_4, 1);

  const int uart_num = ECHO_UART_PORT;
  uart_config_t uart_config = {
      .baud_rate = BAUD_RATE,
      .data_bits = UART_DATA_8_BITS,
      .parity = UART_PARITY_DISABLE,
      .stop_bits = UART_STOP_BITS_1,
      .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
      .rx_flow_ctrl_thresh = 122,
      .source_clk = UART_SCLK_DEFAULT,
  };

  // Set UART log level
  esp_log_level_set(TAG, ESP_LOG_INFO);

  ESP_LOGI(TAG, "Start RS485 application test and configure UART.");

  // Configure UART parameters
  ESP_ERROR_CHECK(uart_param_config(uart_num, &uart_config));

  ESP_LOGI(TAG, "UART set pins, mode and install driver.");
  ESP_LOGI(TAG, "TXD %d", ECHO_TEST_TXD);

  // Set UART pins as per KConfig settings
  ESP_ERROR_CHECK(uart_set_pin(uart_num, ECHO_TEST_TXD, ECHO_TEST_RXD,
                               ECHO_TEST_RTS, ECHO_TEST_CTS));

  // Install UART driver (we don't need an event queue here)
  // In this example we don't even use a buffer for sending data.
  ESP_ERROR_CHECK(uart_driver_install(uart_num, BUF_SIZE * 2, 0, 0, NULL, 0));

  // Set RS485 half duplex mode
  ESP_ERROR_CHECK(uart_set_mode(uart_num, UART_MODE_RS485_HALF_DUPLEX));
  // ESP_ERROR_CHECK(uart_set_mode(uart_num, UART_MODE_UART));

  // Set read timeout of UART TOUT feature
  // ESP_ERROR_CHECK(uart_set_rx_timeout(uart_num, ECHO_READ_TOUT));

  // phase_cut_init();
  // for (int i = 1; i <= 10; i++) {
  //   phase_cut_set_percentage(i * 10);
  //   vTaskDelay(pdMS_TO_TICKS(5000));
  // }

  // Allocate buffers for UART
  uint8_t *data = (uint8_t *)malloc(BUF_SIZE);

  ESP_LOGI(TAG, "UART start recieve loop.\r\n");
  // echo_send(uart_num, "[m] Start RS485 UART test.\r\n", 24);

  int c = 0;
  while (1) {
    memset(data, 0, BUF_SIZE);
    // Read data from UART
    int len = uart_read_bytes(uart_num, data, BUF_SIZE, PACKET_READ_TICS);

    // Write data back to UART
    if (len > 0) {
      ESP_LOGI(TAG, "[%d] size %d - %s\n", c++, len, data);
      parseRequest(data, len);
      ESP_LOG_BUFFER_HEX(TAG, data, len);
      echo_send(uart_num, "b\n", 2);
      // char prefix[] = "RS485 Received: [";
      // echo_send(uart_num, prefix, (sizeof(prefix) - 1));
      // ESP_LOGI(TAG, "Received %u bytes:", len);
      // ESP_LOGI(TAG, "[ ");
      // for (int i = 0; i < len; i++) {
      //   ESP_LOGI(TAG, "0x%.2X ", (uint8_t)data[i]);
      //   echo_send(uart_num, (const char *)&data[i], 1);
      //   // Add a Newline character if you get a return charater from paste
      //   // (Paste tests multibyte receipt/buffer)
      //   if (data[i] == '\r') {
      //     echo_send(uart_num, "\n", 1);
      //   }
      // }
      // ESP_LOGI(TAG, "] \n");
      // echo_send(uart_num, "]\r\n", 3);
    } else {
      // Echo a "." to show we are alive while we wait for input
      // echo_send(uart_num, ".", 1);
      // ESP_ERROR_CHECK(uart_wait_tx_done(uart_num, 10));
    }
  }
  vTaskDelete(NULL);
}
