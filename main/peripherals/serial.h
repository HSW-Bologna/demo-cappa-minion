#ifndef SERIAL_H_INCLUDED
#define SERIAL_H_INCLUDED
#include <liblightmodbus-esp/repo/include/lightmodbus/lightmodbus.h>
#include <liblightmodbus-esp/repo/include/lightmodbus/slave.h>

void        serial_init(uint8_t address);
ModbusError myRegisterCallback(const ModbusSlave *status, const ModbusRegisterCallbackArgs *args,
                               ModbusRegisterCallbackResult *result);
ModbusError slaveExceptionCallback(const ModbusSlave *slave, uint8_t function, ModbusExceptionCode code);
void        echo_task_minion(void *arg);

#endif
