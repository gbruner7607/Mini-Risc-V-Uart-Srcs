int __mulsi3(int a, int b) {
	int product = 0; 
	int i;
	if (b < 0) {
		a = 0 - a; 
		b = 0 - b;
	}
	for (i = 0; i < b; i++) {
		product += a; 
	}
	return product;
}

int __divsi3(int a, int b) {
	int cnt = 0; 
	while(1) {
		if (a < b) return cnt; 
		a = a - b; 
		cnt++;
	}
}

int __modsi3(int a, int b) {
	
	while(1) {
		if (b > a) return a;
		a = a - b;
	}
}