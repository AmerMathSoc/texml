/**  mandel.c   by Eric R. Weeks   written 9-28-96
 **  weeks@physics.emory.edu
 **  http://www.physics.emory.edu/~weeks/
 **
 **  This program is public domain, but this header must be left intact
 **  and unchanged.
 **
 **/

#include <avr/io.h>

#define CMD_COLOR 1
#define CMD_DOT 2



static
void setcolor(uint8_t r, uint8_t g, uint8_t b) {
    TWDR = r;
    TWDR = g;
    TWDR = b;
    TWAR = CMD_COLOR;
}

static
void dot(uint8_t x, uint8_t y) {
    TWDR = x, TWDR = y;
    TWAR = CMD_DOT;
}


/* Colors
import colorsys
def color(i):
    h = i/float(100)
    s = 1.0
    v = h
    print h, s, v
    x = colorsys.hsv_to_rgb(h, s, v)
    return (str(int(x[0] * 255)),
            str(int(x[1] * 255)),
            str(int(x[2] * 255)))

colors = [color (i) for i in range(0, 100)]

print "char color_R[] = {%s};" % (",".join([x[0] for x in colors]))
print "char color_G[] = {%s};" % (",".join([x[1] for x in colors]))
print "char color_B[] = {%s};" % (",".join([x[2] for x in colors]))
 */

char color_R[] = {0,2,5,7,10,12,15,17,20,22,25,28,30,33,35,38,40,42,42,41,40,39,38,36,34,31,29,26,22,19,15,11,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,13,24,35,47,58,70,83,95,108,121,135,149,163,177,192,207,214,216,219,221,224,226,229,232,234,237,239,242,244,247,249,252};
char color_G[] = {0,0,0,1,2,3,5,7,9,12,15,18,22,25,29,34,39,43,45,48,51,53,56,58,61,63,66,68,71,73,76,79,81,84,86,89,91,94,96,99,102,104,107,109,112,114,117,119,122,124,127,122,116,110,104,98,91,84,76,69,61,52,44,35,26,16,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
char color_B[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,8,14,20,27,33,40,48,55,63,71,80,89,98,107,117,127,130,132,135,137,140,142,145,147,150,153,155,158,160,163,165,168,170,173,175,178,181,183,186,188,191,193,196,198,201,204,206,209,211,205,195,184,173,161,149,137,125,112,99,86,72,58,44,29,15};


int main() {

    float x,xx,y,cx,cy;
    uint8_t iteration;
    uint8_t hx,hy;
#define itermax  100 /* how many iterations to do    */
#define magnify  4.0 /* no magnification         */
#define hxres    250   /* horizonal resolution      */
#define hyres    250   /* vertical resolution       */
#define ydelta 0
#define xdelta -0.75

    uint8_t i;
    for (hy=1;hy<=hyres;hy++)  {
        for (hx=1;hx<=hxres;hx++)  {
            cx = (((float)hx)/((float)hxres)-0.5)/magnify*3.0-0.7;
            cy = (((float)hy)/((float)hyres)-0.5)/magnify*3.0;
            cx += xdelta;
            cy += ydelta;
            x = 0.0; y = 0.0;
            for (iteration=1; iteration < itermax; iteration++)  {
                xx = x*x-y*y+cx;
                y = 2.0*x*y+cy;
                x = xx;
                if (x*x+y*y>128.0){
                    i = iteration;
                    iteration = itermax + 1;
                }
            }
            // Print a dot
            if (iteration<itermax+1) {
                setcolor(0,0,0);
            } else {
                setcolor(color_R[i],
                         color_G[i],
                         color_B[i]);
            }
            dot(hx-1, hy-1);
        }
    }

    asm volatile ("break");
}

/*
  check-name: Mandelbrot Set
  compiler-opts: -O3
  check-long: 1
  check-start:
  \def\avr@debug#1{}

  \avr@instr@run

  \avrdrawppm{mandelbrot.ppm}

  \immediate\write18{convert mandelbrot.ppm mandelbrot.png}
  
  \includegraphics[width=\linewidth]{mandelbrot.png}

  check-end:
*/
