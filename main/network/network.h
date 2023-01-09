#ifndef NETWORK_H_INCLUDED
#define NETWORK_H_INCLUDED


#include <stdint.h>


void    network_init(void);
void    network_start_ap(uint8_t address);
uint8_t network_is_ap_running(void);


#endif