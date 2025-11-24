#include <avr/io.h>

volatile char foo[30];

int main() {
  foo[0] = 5;
  foo[1] = 42;
  foo[2] = foo[1] >> foo[0];
  foo[3] = foo[1] << (foo[0]>>2);


  asm volatile ("break");
}

/*
  check-name: Shift Operations
  check-start:
  \avr@instr@stepn{1000}

  \avr@test@MEM{96}{00000101} % 5
  \avr@test@MEM{97}{00101010} % 42
  \avr@test@MEM{98}{00000001} % 0
  \avr@test@MEM{99}{01010100} % 42

  check-end:
*/
