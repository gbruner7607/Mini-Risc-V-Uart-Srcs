#ifndef UART
#define UART 

void uart_put(char c); 
char uart_get(); 
char uart_poll(); 
void uart_write_blocking(char c);
char uart_read_blocking();

void print(char c[]);

void readline(char c[]);

#endif