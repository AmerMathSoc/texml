#include <avr/io.h>

char fib(char n) {
  if (n <= 1) {
    return 1;
  }
  return fib(n-1) + fib(n-2);
}

int main() {
  UDR = fib(5);
  asm volatile ("break");
}
/*
  check-name: Fibonacci (Recursive)
  check-start:
  \avr@instr@stepn{1000}
  \avr@test@REG{r24}{00001000}
  check-end:
*/
