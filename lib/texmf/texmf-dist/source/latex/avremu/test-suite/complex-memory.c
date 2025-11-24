#include <avr/io.h>

volatile char foo[30];

int main() {
  foo[0] = 23;
  foo[1] = 42;
  foo[2] = foo[0] + foo[1];

  asm volatile ("break");
}

/*
  check-name: Complex Memory Operations
  check-start:
  \avr@instr@stepn{1000}

  \avr@test@MEM{96}{00010111} % 23
  \avr@test@MEM{97}{00101010} % 42
  \avr@test@MEM{98}{01000001} % 65
  check-end:
*/
