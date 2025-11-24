#include <avr/io.h>

char sum(char n) {
  if (n <= 1) {
    return n;
  }
  return n + sum(n-1);
}

int main() {
  UDR = sum(4);
  asm volatile ("break");
}

/*
  check-name: Complex Memory Operations
  check-start:

  \avr@instr@stepn{1000}
  \avr@test@REG{r24}{00001010}

  check-end:
*/
