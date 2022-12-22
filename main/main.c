#include "controller/controller.h"
#include "controller/gui.h"
#include "driver/uart.h"
#include "esp32s2/rom/ets_sys.h"
#include "esp_log.h"
#include "esp_system.h"
#include "freertos/FreeRTOS.h"
#include "freertos/portmacro.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "freertos/timers.h"
#include "lvgl_helpers.h"
#include "lvgl_i2c/i2c_manager.h"
#include "model/model.h"
#include "nvs_flash.h"
#include "peripherals/phase_cut.h"
#include "peripherals/serial.h"
#include "sdkconfig.h"
#include "view/view.h"
#include <driver/i2c.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * This is a example which echos any data it receives on UART back to the sender
 * using RS485 interface in half duplex mode.
 */
#define TAG                  "RS485_ECHO_APP"
#define ECHO_TASK_STACK_SIZE (2048)
#define ECHO_TASK_PRIO       (10)

void app_main(void) {
    model_t model;

    phase_cut_init();
    lvgl_i2c_init(I2C_NUM_0);
    lvgl_driver_init();

    model_init(&model);
    view_init(&model, disp_driver_flush, ft6x36_read);
    controller_init(&model);

    xTaskCreate(echo_task_minion, "uart_echo_task", ECHO_TASK_STACK_SIZE, NULL, ECHO_TASK_PRIO, NULL);

    ESP_LOGI(TAG, "Begin main loop");
    for (;;) {
        controller_gui_manage(&model);
        controller_manage(&model);

        vTaskDelay(pdMS_TO_TICKS(5));
    }
}
