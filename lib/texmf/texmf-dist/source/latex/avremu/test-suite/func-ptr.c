#include <avr/io.h>

// Produces LPM operations
__attribute__((noinline)) void bar() {
    UDR='X';
}
void (*foo)() = bar;

int main() {
    bar();
    foo();
    asm volatile ("break");
}

/*
  check-name: Function Pointers
  check-start:
  \avr@instr@stepn{1000000}

  \avr@test@UDR{XX}
  check-end:
*/
