#include"uart.h"

int main(void) {
	int a = 17; 
	char c[12];
	itoa(a, c); 
	print(c);
	print("\n");
	// while(1) {
		// char x[12];
		// print("Enter a number: ");
		// readline(x); 
		// int b = atoi(x);
		// itoa(b, c);
		// print("You entered: ");
		// print(c);
		char x[32];
		print("Say Something: ");
		readline(x, 32); 
		print("You entered: ");
		print(x);
	// }
	return 0;
}