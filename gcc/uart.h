#ifndef UART_H
#define UART_H

void uart_put(char c);
char uart_get();
char uart_poll();

void uart_write_blocking(char c);
char uart_read_blocking();

void uart_print(char c[]);

void readline(char c[], int len);
int strlen(char c[]);

int atoi(char *c);
void itoa(int a, char *c);
#endif