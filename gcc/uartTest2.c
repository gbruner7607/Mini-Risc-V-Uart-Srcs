#include "uart.h"
#include "print.h"
#include "utils.h"

int main(void)
{
	uart_init();

    int i = 0;
    int sum = 0;
	char numchar[12];

    for(i = 0; i < 10; i++)
    {
        sum++;
    }

    for(i = 0; i < 2; i++)
    {
        sum--;
    }

    print(sum);

	itoa(sum, numchar);
	uart_print(numchar);

	return 0;
}