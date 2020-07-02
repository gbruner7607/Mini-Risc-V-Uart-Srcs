#include "uart.h"
#include "utils.h"

#define INT_OFFSET 48

void uart_put(char c)
{
	volatile char *p = (char *)0xaaaaa400;
	*p = c;
}

char uart_get()
{
	volatile char *p = (char *)0xaaaaa400;

	return *p;
}

char uart_poll()
{
	volatile char *p = (char *)0xaaaaa404;

	return *p;
}

void uart_write_blocking(char c)
{
	char s;
	do
	{
		s = uart_poll() & 2;
	} while (s != 0);

	uart_put(c);
}

char uart_read_blocking()
{
	char s;
	do
	{
		s = uart_poll() & 1;
	} while (s == 0);

	return uart_get();
}

void uart_print(char c[])
{
	int len = strlen(c);
	for (int i = 0; i < len; i++)
	{
		uart_write_blocking(c[i]);
	}
}

void readline(char c[], int len)
{
	//int len = strlen(c);
	for (int i = 0; i < len; i++)
	{
		char tmp;
		tmp = uart_read_blocking();
		// uart_write_blocking(tmp);

		if (tmp == 13)
		{
			for (int j = i; j < len; j++)
				c[j] = 0;

			uart_write_blocking('\r');
			uart_write_blocking('\n');

			return;
		}

		uart_write_blocking(tmp);
		c[i] = tmp;
	}
}

int strlen(char c[])
{
	char *ptr = &c[0];

	int offset = 0;
	while (*(ptr + offset) != '\0')
	{
		offset++;
	}

	return offset;
}

int atoi(char *c)
{
	int len = strlen(c);
	int i;
	int sum = 0;
	int mult = 1;

	for (i == (len - 1); i >= 0; i--)
	{
		int tmp = c[i] - INT_OFFSET;

		if (tmp == -3)
		{
			return (0 - sum);
		}
		else if ((tmp >= 0) && (tmp <= 9))
		{
			sum += multiply(tmp, mult);
		}
		else
			return -1;
	}

	return sum;
}

void itoa(int a, char *c)
{
	int p1, p2;
	int idx = 0;

	if (a < 0)
	{
		c[idx] = '-';
		a = 0 - a;
		idx++;
	}

	// get placing
	if (a < 10)
	{
		c[idx] = a + INT_OFFSET;

		return;
	}

	p1 = 1;

	while (divide(a, p1) > 0)
		p1 = multiply(p1, 10);

	p2 = divide(p1, 10);

	while (1)
	{
		int tmp = divide(modulo(a, p1), p2);
		c[idx] = tmp + INT_OFFSET;
		idx++;

		if ((p2 == 1) || (idx == 12))
			return;

		p2 = divide(p2, 10);
		p1 = divide(p1, 10);
	}
}
