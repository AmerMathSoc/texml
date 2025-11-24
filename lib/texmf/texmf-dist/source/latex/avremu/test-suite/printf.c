#include <avr/io.h>
#include <stdio.h>

char buffer[30];

volatile char buf[3];

static int uart_putchar(char c, FILE *stream);
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL,
                                         _FDEV_SETUP_WRITE);
static int
uart_putchar(char c, FILE *stream)
{
    UDR = c;
    return 0;
}


int
main(void)
{
    stdout = &mystdout;

    buf[0] = 'x';
    buf[1] = 'y';
    buf[2] = '\0';

    puts(buf);


    asm volatile("break;");

    printf(":%c", buf[0]);

    asm volatile("break;");

    printf(":%d:", buf[1]);

    asm volatile("break;");

    volatile float x=0.23;
    printf(":%.2f:", x);

    asm volatile("break;");

    return 0;
}


/**
   check-name: Print to Stdout
   compiler-opts: -Wl,-u,vfprintf -lm -lprintf_flt
   check-start:

   \avr@instr@stepn{100000}
   \avr@test@UDR{xy^10} % ^10 == \n
   \def\avr@UDR{}

   \avr@instr@stepn{100000}
   \avr@test@UDR{:x}

   \avr@instr@stepn{100000}
   \avr@test@UDR{:121:}

   \avr@instr@stepn{100000}
   \avr@test@UDR{:0.23:}

   check-end:
**/
