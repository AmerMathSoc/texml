/*
 * File:		oct2otp.c
 * Date:		Thu Dec 18 14:39:34 1997
 * Author:		 (norbert)
 * 
 */

#include <stdio.h>

int main() 
{
  int c;
  while ((c=getchar())!=EOF) {
    if (c>127)
      printf("@'%o",c);
    else
      printf("%c",c);
  }
}

