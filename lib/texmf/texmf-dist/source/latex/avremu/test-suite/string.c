#include <avr/io.h>

// Produces LPM operations
const char *foo = "abc";

int main() {
    char* p = foo;
    while (*p) {
        UDR = *p++;
    }

  asm volatile ("break");
}

/*
  check-name: String Operations
  check-start:
  \avr@instr@stepn{1000000}

  \avr@test@UDR{abc}
  check-end:
*/
