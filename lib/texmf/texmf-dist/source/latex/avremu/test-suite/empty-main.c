int main() {
  asm volatile ("break");
}

/**
   check-name: Run simple main Function
   check-start:
\avr@instr@stepn{5000}
   check-end:
**/
