#include "serial.h"
#include "driver/gpio.h"
#include "driver/uart.h"
#include "esp_log.h"
#include "hal/gpio_types.h"
#include "hal/uart_types.h"
#include "peripherals/phase_cut.h"
#include "peripherals/digout.h"
#include <liblightmodbus-esp/repo/include/lightmodbus/lightmodbus.h>
#include <liblightmodbus-esp/repo/include/lightmodbus/slave.h>
#include "network/network.h"
#include <string.h>
#include "config/app_config.h"

#define TAG "RS485_ECHO_APP"

#define UART_SCLK_DEFAULT 0

#define ECHO_TASK_STACK_SIZE (2048 + 1024)
#define ECHO_TASK_PRIO       (10)

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

#define BUF_SIZE  (127)
#define BAUD_RATE 115200

// Read packet timeout
#define PACKET_READ_TICS (10 / portTICK_PERIOD_MS)
#define ECHO_UART_PORT   1

// Timeout threshold for UART = number of symbols (~10 tics) with unchanged
// state on receive pin
#define ECHO_READ_TOUT (3)     // 3.5T * 8 = 28 ticks, TOUT=3 -> ~24..33 ticks

#define HOLDING_REGISTER_FAN_1              0
#define HOLDING_REGISTER_FAN_2              1
#define HOLDING_REGISTER_LIGHT_1            2
#define HOLDING_REGISTER_LIGHT_2            3
#define HOLDING_REGISTER_LIGHT_3            4
#define HOLDING_REGISTER_FIRMWARE_VERSION_1 5
#define HOLDING_REGISTER_FIRMWARE_VERSION_2 6
#define HOLDING_REGISTER_FIRMWARE_UPDATE    7
#define REG_COUNT                           8


static ModbusSlave slave;
static const int   uart_num       = ECHO_UART_PORT;
static uint8_t     minion_address = 0;
static uint8_t     activate_ap    = 0;


bool printErrorInfo(ModbusErrorInfo err) {
    if (modbusIsOk(err)) {
        return false;
    } else {
        ESP_LOGW(TAG, "%s: %s", modbusErrorSourceStr(modbusGetErrorSource(err)),
                 modbusErrorStr(modbusGetErrorCode(err)));
        return true;
    }
}


void serial_init(uint8_t address) {
    minion_address           = address;
    gpio_config_t gpioconfig = {BIT64(4), GPIO_MODE_OUTPUT, GPIO_PULLUP_DISABLE, GPIO_PULLDOWN_DISABLE,
                                GPIO_PIN_INTR_DISABLE};
    gpio_config(&gpioconfig);
    // quando a 1 ricevo, quando a 0 trasmetto
    gpio_set_level(GPIO_NUM_4, 1);

    uart_config_t uart_config = {
        .baud_rate           = BAUD_RATE,
        .data_bits           = UART_DATA_8_BITS,
        .parity              = UART_PARITY_DISABLE,
        .stop_bits           = UART_STOP_BITS_1,
        .flow_ctrl           = UART_HW_FLOWCTRL_DISABLE,
        .rx_flow_ctrl_thresh = 122,
        .source_clk          = UART_SCLK_DEFAULT,
    };

    // Set UART log level
    esp_log_level_set(TAG, ESP_LOG_INFO);

    ESP_LOGI(TAG, "Start RS485 application test and configure UART.");

    // Configure UART parameters
    ESP_ERROR_CHECK(uart_param_config(uart_num, &uart_config));

    ESP_LOGI(TAG, "UART set pins, mode and install driver.");
    ESP_LOGI(TAG, "TXD %d", ECHO_TEST_TXD);

    // Set UART pins as per KConfig settings
    ESP_ERROR_CHECK(uart_set_pin(uart_num, ECHO_TEST_TXD, ECHO_TEST_RXD, ECHO_TEST_RTS, ECHO_TEST_CTS));

    // Install UART driver (we don't need an event queue here)
    // In this example we don't even use a buffer for sending data.
    ESP_ERROR_CHECK(uart_driver_install(uart_num, BUF_SIZE * 2, 0, 0, NULL, 0));

    // Set RS485 half duplex mode
    ESP_ERROR_CHECK(uart_set_mode(uart_num, UART_MODE_RS485_HALF_DUPLEX));
    // ESP_ERROR_CHECK(uart_set_mode(uart_num, UART_MODE_UART));

    ModbusErrorInfo err;
    err = modbusSlaveInit(&slave, myRegisterCallback, slaveExceptionCallback, modbusDefaultAllocator,
                          modbusSlaveDefaultFunctions, modbusSlaveDefaultFunctionCount);
    printErrorInfo(err);

    xTaskCreate(echo_task_minion, TAG, ECHO_TASK_STACK_SIZE, (void *)(uintptr_t)address, ECHO_TASK_PRIO, NULL);
}


void serial_destroy() {
    modbusSlaveDestroy(&slave);
}


static void echo_send(const int port, const char *str, uint8_t length) {
    gpio_set_level(GPIO_NUM_4, 0);
    ets_delay_us(10);

    int res = uart_write_bytes(port, str, length);

    if (res != length) {
        ESP_LOGE(TAG, "Send data critical failure: %i", res);
        // add your code to handle sending failure here
        abort();
    }
    uart_wait_tx_done(port, portMAX_DELAY);
    gpio_set_level(GPIO_NUM_4, 1);
    ets_delay_us(10);
}


void printResponse(const ModbusSlave *slave) {
    for (int i = 0; i < modbusSlaveGetResponseLength(slave); i++) {
        ESP_LOGI(TAG, "0x%02x ", modbusSlaveGetResponse(slave)[i]);
    }
}


void parseRequest(uint8_t *data, int length, uint8_t address) {
    ModbusErrorInfo err = modbusParseRequestRTU(&slave, address, data, length);
    if (modbusIsOk(err)) {
        echo_send(ECHO_UART_PORT, (const char *)modbusSlaveGetResponse(&slave), modbusSlaveGetResponseLength(&slave));
    } else {
        printErrorInfo(err);
        ESP_LOGW(TAG, "Len %i", length);
    }
}


ModbusError myRegisterCallback(const ModbusSlave *status, const ModbusRegisterCallbackArgs *args,
                               ModbusRegisterCallbackResult *result) {
    switch (args->query) {
        // R/W access check
        case MODBUS_REGQ_R_CHECK:
        case MODBUS_REGQ_W_CHECK:
            result->exceptionCode = args->index < REG_COUNT ? MODBUS_EXCEP_NONE : MODBUS_EXCEP_ILLEGAL_ADDRESS;
            break;

        // Read register
        case MODBUS_REGQ_R:
            switch (args->type) {
                case MODBUS_HOLDING_REGISTER:
                    switch (args->index) {
                        case HOLDING_REGISTER_FIRMWARE_VERSION_1:
                            result->value =
                                (APP_CONFIG_FIRMWARE_VERSION_MAJOR << 8) | APP_CONFIG_FIRMWARE_VERSION_MINOR;
                            break;
                        case HOLDING_REGISTER_FIRMWARE_VERSION_2:
                            result->value = APP_CONFIG_FIRMWARE_VERSION_PATCH;
                            break;
                    }
                    break;
                case MODBUS_INPUT_REGISTER:
                    break;
                case MODBUS_COIL:
                    break;
                case MODBUS_DISCRETE_INPUT:
                    break;
            }
            break;

        // Write register
        case MODBUS_REGQ_W:
            switch (args->type) {
                case MODBUS_HOLDING_REGISTER: {
                    switch (args->index) {
                        case HOLDING_REGISTER_FAN_1:
                        case HOLDING_REGISTER_FAN_2:
                            phase_cut_set_percentage(args->index, args->value);
                            break;

                        case HOLDING_REGISTER_LIGHT_1:
                            digout_update(DIGOUT_RISCALDAMENTO_VAPORE, args->value > 0);
                            break;

                        case HOLDING_REGISTER_LIGHT_2:
                            digout_update(DIGOUT_RISCALDAMENTO_PIANO, args->value > 0);
                            break;

                        case HOLDING_REGISTER_LIGHT_3:
                            digout_update(DIGOUT_RISCALDAMENTO_FERRO_2, args->value > 0);
                            break;

                        case HOLDING_REGISTER_FIRMWARE_UPDATE:
                            if (args->value > 0) {
                                activate_ap = 1;
                            }
                            break;
                    }
                    break;
                }

                case MODBUS_COIL:
                    break;
                default:
                    break;
            }
            break;
    }

    // Always return MODBUS_OK
    return MODBUS_OK;
}


ModbusError slaveExceptionCallback(const ModbusSlave *slave, uint8_t function, ModbusExceptionCode code) {
    ESP_LOGI(TAG, "Slave reports an exception %s (function %d)\n", modbusExceptionCodeStr(code), function);

    // Always return MODBUS_OK
    return MODBUS_OK;
}


void echo_task_minion(void *arg) {
    uint8_t address = (uint8_t)(uintptr_t)arg;

    // Allocate buffers for UART
    uint8_t data[BUF_SIZE] = {0};

    ESP_LOGI(TAG, "UART start receive loop (address %i)", address);
    for (;;) {
        memset(data, 0, BUF_SIZE);
        // Read data from UART
        int len = uart_read_bytes(uart_num, data, BUF_SIZE, PACKET_READ_TICS);

        // Write data back to UART
        if (len > 0) {
            parseRequest(data, len, address);
        }

        if (activate_ap) {
            network_start_ap(minion_address);
            activate_ap = 0;
        }
    }
    vTaskDelete(NULL);
}
