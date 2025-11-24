#include <avr/io.h>

volatile char foo[30];

int main() {
  foo[0] = 23;
  foo[1] = 42;
  // Should produce a mul
  foo[2] = foo[0] * foo[1];

  // Contains a decrement (8 Bit Dividend)
  foo[3] = (unsigned char)((unsigned char )foo[1] / (unsigned char)foo[0]);

  foo[4] = foo[1] % foo[0];

  volatile uint16_t x = 1000;
  volatile uint16_t y = 55;

  foo[5] = x * y;
  foo[20] = 165;

  itoa((unsigned char)foo[20], &foo[6], 10);
  itoa((signed char)foo[20], &foo[9], 10);


  asm volatile ("break");
}

/*
  check-name: Complex Memory Operations
  check-start:
  \avr@instr@stepn{100000}

  \avr@test@MEM{96}{00010111} % 23
  \avr@test@MEM{97}{00101010} % 42
  \avr@test@MEM{98}{11000110} % 198

  \avr@test@MEM{99}{00000001} % 1
  \avr@test@MEM{100}{00010011} % 19

  \avr@test@MEM{101}{11011000} % 216

  \avr@test@MEM{102}{00110001} % '1'
  \avr@test@MEM{103}{00110110} % '6'
  \avr@test@MEM{104}{00110101} % '5'

  \avr@test@MEM{105}{00101101} % '-'
  \avr@test@MEM{106}{00111001} % '9'
  \avr@test@MEM{107}{00110001} % '1'

  check-end:
*/
