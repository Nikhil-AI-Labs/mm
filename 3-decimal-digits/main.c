int main() {
	int number = 0xEA; // binary: (1110)(1010), decimal: 14 * 16 + 10 = 234
	
	// maximum poossible 8-bit binary number's value in decimal is: 16 * 15 + 15 = 255
	
	int digit0 = number % 10;
	int digit1 = ((number % 100) - digit0) / 10;
  int digit2 = (number - 10 * digit1 - digit0) / 100;
	return 0;
}