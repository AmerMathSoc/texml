#include <avr/io.h>
#include <stdio.h>

static int uart_putchar(char c, FILE *stream);
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL,
                                         _FDEV_SETUP_WRITE);
static int
uart_putchar(char c, FILE *stream)
{
    UDR = c;
    return 0;
}

volatile uint16_t xxx = 65;

int
main(void)
{
    stdout = &mystdout;

    volatile float a = 0.23;
    volatile float b = 0.43;

    printf("%.2f", 1/ (a * b * 3));
    asm volatile("break;");

    return 0;
}


/**
   check-name: Calculate with floats
   compiler-opts: -Wl,-u,vfprintf -lm -lprintf_flt

   check-start:

   \avr@instr@stepn{100000}
   \avr@test@UDR{3.37}

   check-end:
**/
