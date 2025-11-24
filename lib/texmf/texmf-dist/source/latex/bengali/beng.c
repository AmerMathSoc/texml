/***************************************************************************/
/*                                                                         */
/*  beng.c v2.0                                                            */
/*                                                                         */
/*  Source code for "Bengali for TeX" preprocessor.                        */
/*  Anshuman Pandey <apandey@u.washington.edu>, 2002/03/27                 */
/*                                                                         */
/*  Based on Revision 1.1 1996/03/05 of skt.c preprocessor developed by    */
/*  Charles Wikner <wikner@nacdh4.nac.ac.za>                               */
/*                                                                         */
/***************************************************************************/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

/* DECLARE FUNCTIONS */
void   exit        (int);
void   search      (void);
void   write_outbuf(void);
void   write_line  (char *);
char * str_find    (char *, char *);
void   getline     (void);
char * command     (char *);
void   error       (char *, int);
void   process     (void);
void   chrcat      (char *, char);
void   bncont      (void);
void   bnword      (void);
void   single      (char);
void   frontac     (void);
void   backac      (void);
void   sam_warning (void);
void   samyoga     (void);

FILE *infile, *outfile, *fopen();
char infilename[80];
char outfilename[80];

#define TRUE 1
#define FALSE 0

unsigned char bnline;     /* flag TRUE if there is any Bengali on this line   */
unsigned char bnmode;     /* flag TRUE while within {\bn }                    */
unsigned char eof_flag;   /* flag True when end of file detected              */
unsigned char ac_flag;    /* flag TRUE while processing Bengali vowels        */
unsigned char roman_flag; /* flag TRUE if previous output was Roman string    */

int nest_cnt;             /* '{' increments, '}' decrements, while in \bn     */
int err_cnt;              /* incremented by any error while in \bn            */
#define err_max 10        /* after err_max errors, program aborts             */
int line_cnt;             /* line number of current input line                */

char inbuf[133];          /* input file line buffer of text being processed   */
char *i_ptr;              /* general pointer to input buffer                  */
char outbuf[512];         /* output file line buffer of text processed        */
char *o_ptr;              /* general pointer to output buffer                 */

unsigned char cont_end;   /* flag TRUE when line ends with %-continuation     */
unsigned char cont_begin; /* flag TRUE when line begins after %-continuation  */
unsigned char hal_flag;   /* flag TRUE when hal_type detected in syllable     */
unsigned char ac_char;    /* storage for working vowel character              */
unsigned char pre_ra;     /* storage/flag for 'r' at beginning of samyoga     */
char ac_hook;             /* vowel diacritic code                             */
char bnbuf[255];          /* storage for Bengali in internal code             */
char *s_ptr;              /* general pointer to Bengali buffer                */
char *old_sptr;           /* points to samyoga start; used by warning message */
char work[80];            /* general scratchpad                               */
char *w_ptr;              /* general pointer to work buffer                   */
char tmp[80];             /* temporary buffer for previous syllable           */
int  ra;                  /* post_ra type to use with this character          */
int  ya;                  /* post_ya type to use with this character          */
int  post_ra;             /* flag to append ra to samyoga                     */
int  post_ya;             /* flag to append ya to samyoga                     */
int  hasanta;             /* flag to add hasanta to samyoga (i.e. no vowel)   */
int  hr_flag;             /* flag indicates vowel picked up in samyoga (h.r)  */


/***************************************************************************/
/* Function: main()                                                        */
/***************************************************************************/

main(argc,argv)
int argc;
char *argv[];
{ char *p; int k;

  /* Initialization */

  bnmode = eof_flag = FALSE;
  nest_cnt = err_cnt = 0;
  line_cnt = 0;
  i_ptr = inbuf;  *i_ptr = '\0';
  s_ptr = bnbuf; *s_ptr = '\0';
  o_ptr = outbuf; *o_ptr = '\0';
  
  /* handle command-line options */

  k=0;
  if (argc>1) strcpy(infilename,argv[1]);
  if (strcmp(infilename,"-h")==0)
  { k=1; 
    strcpy(infilename,"");
    printf("Preprocessor for \"Bengali for TeX\" package, v2.0, 2002.03.27\n");
    printf("Anshuman Pandey <apandey@u.washington.edu>\n");
    printf("Syntax: beng infile[.bn] [outfile[.tex]]\n");
    exit(0);
  }

  /* then get file names */
  switch(argc-k)
  { case 3:  strcpy(infilename,argv[1+k]);
             strcpy(outfilename,argv[2+k]);
             break;
    case 2:  strcpy(infilename,argv[1+k]);
             strcpy(outfilename,"");
             break;
    default: strcpy(infilename,"");
             while(strlen(infilename) == 0)
             { printf("Input file: "); gets(infilename); }
             printf("Output file: ");
             gets(outfilename);
  }

  if (strlen(outfilename) == 0) 
    { strcpy (outfilename,infilename);   /* default output file name */
      p = strchr(outfilename,'.');
      if (p != 0) *p = '\0';   /* delete out file name extension */
    }
  p = strchr(infilename,'.');
  if (p == 0) strcat(infilename,".bn");  /* default input file extension */
  if ((infile=fopen(infilename,"r")) == NULL)
        { printf("Cannot open file %s\n",infilename); exit(1); }
  getline(); if (eof_flag)
        { printf("Input file %s is empty.\n",infilename); exit(1); }
  p = strchr(outfilename,'.');
  if (p == 0)
    { if (inbuf[0] == '@') strcat(outfilename,".dn");
      else strcat(outfilename,".tex"); /* set default output file extension */
    }
  if ((outfile=fopen(outfilename,"w")) == NULL)
        { printf("Cannot open output file %s\n",outfilename); exit(1); }
  
  /* Normal main loop */

  while(eof_flag == 0)
    { while(!bnmode && !eof_flag) search();  /* search for \bn command */
      while( bnmode && !eof_flag) process(); /* process bengali text */
      if (err_cnt >= err_max)
         { printf("Too many (%d) errors, aborting program\n",err_cnt); break; }
    }
  if ((err_cnt < err_max) && (nest_cnt != 0))
     printf("Brace mismatch within \\bn = %d\n",nest_cnt); 
  fclose(infile);
  fclose(outfile);
  exit(1);

}


/***************************************************************************/
/* Function: search()                                                      */
/*                                                                         */
/* Search inbuf for '{\bn', getting more input lines as necessary          */
/* until string found or end of file, copying input to output; if          */
/* the string is found but command not recognised, it is treated as        */
/* ordinary text; if valid command i_ptr points to first sanskrit          */
/* char after command, and sets bnmode TRUE.                              */
/***************************************************************************/

void search(void)
{
unsigned char c;
char *p,*q;
  while (eof_flag == 0)
    { p = str_find(i_ptr,"{\\bn");
      if (p == 0)
        { if (bnline == TRUE) { strcat(outbuf,i_ptr); write_outbuf(); }
          else { write_line(inbuf); o_ptr = outbuf; *o_ptr = '\0';  }
          getline(); 
          continue; 
        }
      q = i_ptr; i_ptr = p;
      if ((p = command(p)) == 0)        /* test command string \bn */
        { p = i_ptr; i_ptr = q;         /* if bad \bn command */
          c = *++p; *p = '\0';          /* copy partial line, and search more */
          strcat(outbuf,i_ptr); *p = c; i_ptr = p; continue;
        }
      i_ptr = q;
      nest_cnt++; c = *p; *p = '\0';    /* skip over '{\bn' */
      strcat(outbuf,i_ptr);             /* append partial line to outbuf */
      *p = c; i_ptr = p; 
      bnmode = TRUE; bnline = TRUE;   /* now comes the fun! */
      break;
    }
}


/***************************************************************************/
/* Function: write_outbuf()                                                */
/*                                                                         */
/* Write outbuf in 80 character lines                                      */
/***************************************************************************/

void write_outbuf(void)
{ 
char c, d, e;
  while(1)
  { c = '\0'; 
    if (strlen(outbuf) < 81) { write_line(outbuf); break; }
    for (o_ptr = outbuf + 78;     o_ptr > outbuf + 50;     o_ptr--) 
        { if (*o_ptr == ' ') break; }
    if (*o_ptr != ' ') { for (o_ptr = outbuf+78; o_ptr > outbuf + 50; o_ptr--)
                              if ((*o_ptr=='\\') && (*(o_ptr-1)!='\\')) break;
                         if (o_ptr == outbuf+50) o_ptr = outbuf+78;
                         c = *o_ptr; *o_ptr++ = '%'; d = *o_ptr;
                       }
    *o_ptr++ = '\n'; e = *o_ptr; *o_ptr = '\0'; 
    write_line(outbuf); 
    *o_ptr = e;
    if (c!='\0') { *--o_ptr = d; *--o_ptr = c; } /* restore displaced chars */
    strcpy(outbuf,o_ptr); 
  }
  o_ptr = outbuf;
  *o_ptr = '\0';
} 


/***************************************************************************/
/* Function: write_line()                                                  */
/*                                                                         */
/* Write p-string to output device                                         */
/***************************************************************************/

void write_line(char *p)
{
  if (err_cnt == 0) fputs(p,outfile); 
} 


/***************************************************************************/
/* Function: str_find()                                                    */
/*                                                                         */
/* Find first occasion of string *str within *buf before '%' char;         */
/* return pointer first char of str within buf, else 0.                    */
/***************************************************************************/

char * str_find(char *buf, char *str)
{ char *p, *x;
  p = strstr(buf,str);
  if (p == 0) return(0);
  x = strchr(buf,'%');
  if ((x != 0) && (p > x)) return(0);
  return(p);
}


/***************************************************************************/
/* Function: getline()                                                     */
/*                                                                         */
/* Get another line from input file; reset i_ptr, increments               */
/* line_cnt, and sets eof_flag if EOF.                                     */
/***************************************************************************/

void getline(void)
{ 
char *p;
  i_ptr = inbuf;
  *i_ptr = '\0';
  line_cnt++;
  if (fgets(inbuf,133,infile) == NULL) eof_flag = TRUE;
  if (bnmode == FALSE) bnline = FALSE;
}


/***************************************************************************/
/* Function: command()                                                     */
/*                                                                         */
/* Check for valid \bn command; if invalid command, print error message    */
/***************************************************************************/

char * command(char *p)
{ p += 4;                                            /* skip over '{\bn' */
  if (*p++ != ' ') p = 0;
  if (p == 0) error("Unrecognised command string",7);
  return(p);
}


/***************************************************************************/
/* Function: error()                                                       */
/*                                                                         */
/* Print out error message, including string *s and 'n' characters         */
/* of inbuf.                                                               */
/***************************************************************************/

void error(char *s, int n)
{ char err_str[80]; int j;
  if (++err_cnt <= err_max)
    { if (n > 0)  { for (j=0; j<n; j++) err_str[j] = *(i_ptr+j);
                    err_str[j] = '\0'; 
                  }
      if (n == 0) { strcpy(err_str,"oct(");
                    chrcat(err_str,'0' + (*i_ptr/64));
                    chrcat(err_str,'0' + (*i_ptr/8));
                    chrcat(err_str,'0' + (*i_ptr & 7));
                    strcat(err_str,")"); 
                  }
      if (n < 0)  { err_str[0] = '\0'; }
    }
  printf("Line %4d    Error: %s %s\n",line_cnt,s,err_str);
}


/***************************************************************************/
/* Function: process()                                                     */
/*                                                                         */
/* Process input text within {\bn, converting to internal format in bnbuf */
/***************************************************************************/

#define ISAC(c) (((strchr("aAiIuUxeEoO",c) != 0) && c) ? TRUE : FALSE)

/* wWX removed from the definition of ISAC above (.R .l .L) */

void process(void)
{ int cap_flag, underscore;
unsigned char *i, c, d;
#define CF ac_flag=underscore=cap_flag=roman_flag=FALSE
#define CC CF; continue
#define CR ac_flag=underscore=cap_flag=FALSE;
#define CI i_ptr++; CC

 CF; 
 while(1)
  { if (eof_flag) return;
    if (err_cnt >= err_max) 
       { bnmode = FALSE; return; }
    c = *i_ptr; d = *(i_ptr+1);
/* END OF LINE */
    if ((c == '\0') || (c == '\n'))
      { bnword(); strcat (outbuf,i_ptr); write_outbuf(); getline(); CC; }
/* IMBEDDED ROMAN */
    if (strchr("!'()*+,-/:;=?[]`",c) || ((c == '.') && (*(i_ptr+1) == '.')))
    { if (c == '.') i_ptr++;
      if (bnbuf[0]) { bnword(); }
      while(1)
      { chrcat(outbuf,c); c = *++i_ptr;
        if (c == '.')
        { if (*(i_ptr+1) != '.') break;
          i_ptr++; continue;
        }
        if ((strchr("!'()*+,-/:;=?[]`",c) && c) == 0) break;
      }
      CR; continue;
    }
/* ILLEGAL CHARS */
    if (strchr("_$fqwxzBCDEFGJKLNOPQSVWXYZ\177",c))
       { error("Illegal bengali character: ",1); CI; }
    if (c>127) { error("Invalid character >80H: ",1); CI; }
/*?? Since we are now case sensitive (unlike skt), the list of */
/*?? illegal chars has been increased (_ added, and & removed) */
/* CONTROL CHARACTERS */
    if (c < ' ')
    { error("Illegal control character: ",0); CI; }
/* IMBEDDED LATEX COMMAND STRINGS */
    if (c == '\\')
    { if (d == '-')                 /* imbedded discretionary hyphen */
         { strcat(bnbuf,"!"); i_ptr++; CI; }
      bnword(); 
      if (isalpha(d) == 0)
         { chrcat(outbuf,c); chrcat(outbuf,*++i_ptr); CI; }
      else
      { while (1)
           { chrcat(outbuf,c); c = *++i_ptr; if (isalpha(c) == 0) break; }
      }
      CC;
    }
/* SPACE CHAR */
    if (c == ' ')
       { bnword(); while(*++i_ptr == ' '); chrcat(outbuf,c); CC; 
       }
/*?? slight change here, since underscore is now an illegal character */
/* COMMENT DELIMITER */
    if (c == '%')
    { if (*(i_ptr+1) == '\n') bncont();
      else bnword();
      strcat(outbuf,i_ptr); write_outbuf(); getline(); CC;
    }

/* HASANTA */
    if (c == '&') {
        c = '@';
    }

/* BRACES */
    if (c == '{') { if (d == '}') { i_ptr++; CI; } /* for words like pra{}uga */
                    else { nest_cnt++; bncont(); chrcat(outbuf,c); CI; }
                  }
    if (c == '}')
       { bnword(); chrcat(outbuf,c);
         if (--nest_cnt == 0)
            { bnmode = FALSE; 
              i_ptr++; return; 
            }
         else CI;
       }
/* UPPER CASE */
    if (isupper(c)) 
           { switch (c)
                    { case 'A': 
                      case 'I':
                      case 'U':
                      case 'M':
                      case 'H': break;
                      case 'T': c = 'L'; break;
                      case 'R': c = 'w'; break;
                      default:  c = '*'; break;
                    }
             if (c=='*') { error("Invalid upper case: ",1); CI; }
           }
/*?? big change with that code: the upper case has a different *meaning* than */
/*?? the lower case: fortunately, AIUMH are the same as the internal code :-) */
/* DOT_CHAR */
    if (c == '.') { switch(d)
                          { case 'y': c = 'Y'; break;
                            case 'd': c = 'q'; break;
                            case 'h': c = 'H'; break;
                       /*   case 'l': c = 'w'; break; */
                            case 'm': c = 'M'; break;
                            case 'n': c = 'N'; break;
                            case 'o': c = '%'; break;
                            case 'r': c = 'x'; break;
                            case 's': c = 'S'; break;
                            case 't': c = 'f'; break;
                           }
                    if (c=='.') { error("Invalid dot_character: ",2); CI; }
                    i_ptr++; d = *(i_ptr+1);
                  }

/* NEXT CHAR IS H */
    if (d=='h')
       { if (strchr("bcdfgjkptqw",c)) { c=toupper(c); i_ptr++; d=*(i_ptr+1); }
       }

/* The upper/lowercase stuff removed: a following 'h' converts a consonant */
/* to its upper case internal code, e.g th --> T.  Note that 'w' is added  */
/* to the list for R Rh */

/* QUOTE CHAR */
    if (c == '\"') { switch(d)
                           { case 'n': c = 'z'; break;  
                             case 's': c = 'Z'; break;  
                           }
                     if (c=='\"') { error("Invalid quote_character",2); CI; }
                     i_ptr++; d = *(i_ptr+1);
                    } 

/* TILDE CHAR */
    if (c == '~') { switch (d)
                    { case 'n': c = 'V'; break;
                      case 'm': c = '~'; break;
                      case 'r': c = 'R'; break;
                      default : c = '*'; break;
                    }
                    if (c=='*') 
                       { error("Invalid use of tilde character: ",2); CI; }
                    i_ptr++; d = *(i_ptr+1);
                  }
/* TWO CHAR VOWELS */
    if ( strchr("aiu",c) && strchr("aiu",d) )
       { switch(c)
               { case 'a': switch(d)
                                 { case 'a': c = 'A'; break;
                                   case 'i': c = 'E'; break;
                                   case 'u': c = 'O'; break;
                                 } break;
                 case 'i': if (d=='i') c = 'I'; break;
                 case 'u': if (d=='u') c = 'U'; break;
               }
         if (isupper(c)) { i_ptr++; d = *(i_ptr+1); }
       }
/*?? all the upper/lowercase stuff removed */
/* NOW CHAR SHOULD BE INTERNAL REPRESENTATION OF SANSKRIT CHAR */
    if ( ((c=='~' || c=='M') && !(ac_flag)) ) { 
       i_ptr -=2; error("No vowel before nasal: ",3); i_ptr +=2; CF;
    }
        
    if (c=='H' && !(ac_flag)) { 
        i_ptr -=2; error("No vowel before visarga: ",3); i_ptr +=2; CF;
    }
    
    chrcat(bnbuf,c);
    CR;
    if (ISAC(c)) ac_flag = TRUE;
    i_ptr++;
   }
}

#undef CI
#undef CC
#undef CR
#undef CF


/***************************************************************************/
/* Function: chrcat()                                                      */
/*                                                                         */
/* Append character c to end of buffer s                                   */
/***************************************************************************/

void chrcat(char *s, char c)
{ char temp[] = " "; temp[0] = c; strcat(s,temp);
}


/***************************************************************************/
/* Function: bncont()                                                     */
/*                                                                         */
/* Similar to bnword() but used where input text line ends in '%' to      */
/* continue on next line.                                                  */
/***************************************************************************/

void bncont(void)
{
  cont_end = TRUE; bnword();
  cont_end = FALSE; cont_begin = TRUE;
}


/***************************************************************************/
/* Function: bnword()                                                     */
/*                                                                         */
/* Convert contents of bnbuf to output string in outbuf                   */
/***************************************************************************/

/* internal code for consonants */
static char hal_chars[] = "BCDFGJKLNPQRSTVWYZbcdfghjklmnpqrstvwyz";

#define ISHAL(c) (((strchr(hal_chars,c) != 0) && c) ? TRUE : FALSE)

#define CLRFLAGS ac_hook=post_ra=pre_ra=hasanta=hal_flag=post_ya=0

#define CAT(w,x,z) \
strcat(w,x); strcat(w,z)

void bnword(void)
{ char c;
  if (roman_flag && bnbuf[0]) { strcat(outbuf,"\\,"); roman_flag = FALSE; }
  
/* A word is built up one syllable at a time: a syllable typically comprises  */
/* a consonant (or samyoga) followed by a vowel (with its nasalisation).      */
/* If there is no consonant, then a front-vowel is output; if there           */
/* is no vowel, then a viraama is appended to the consonant/samyoga.          */
/* One effect of this is that, if a consonant cluster is not fully resolved   */
/* into a single samyoga, it will be treated as two syllable: in particular,  */
/* the hook of the short-i will span one samyoga only.                        */
/*                                                                            */
/* The `work' buffer is used as a scratchpad while building a syllable; on    */
/* completion it is stored in the `tmp' buffer before shipping to the output  */
/* buffer. This temporary storage while working on the next syllable, allows  */
/* changes to the back spacing of the previous syllable for more effiecient   */
/* output.                                                                    */
/*                                                                            */
/* `ra' is difficult: the first `r' of a consonant cluster is simply flagged  */
/* in `pre_ra', and similarly the final `r' in `post_ra', and then these are  */
/* dealt with when appending a vowel.                                         */
  
  CLRFLAGS;
  s_ptr = bnbuf; c = *s_ptr;
  if (c == '\0') return; 
  *tmp = '\0'; *work = '\0';
  while (1)
  {  CLRFLAGS; /* in particular, need to clear hal_flag for the likes of kara */
     c= *s_ptr++; 
     if (c == '\0') 
        { if (*tmp) { if (outbuf[0]=='\0' && tmp[0]=='[') strcat(outbuf,"{}");
                      strcat(outbuf,tmp); 
                    }
          break; 
        }
     if (ISAC(c)) 
        { ac_char = c; 
          frontac(); 
          if (*tmp) { if (outbuf[0]=='\0' && tmp[0]=='[') strcat(outbuf,"{}");
                      strcat(outbuf,tmp); 
                    }
          strcpy(tmp,work);
          *work = '\0'; cont_begin = 0;
          continue;
        }
     if (strchr("0123456789\"!%|\\@~HM",c))
        { single(c); 
          if (*tmp) { if (outbuf[0]=='\0' && tmp[0]=='[') strcat(outbuf,"{}");
                      strcat(outbuf,tmp); 
                    }
          strcpy(tmp,work); 
          *work = '\0'; cont_begin = 0;
          continue;
        }
     if (c == 'r') { pre_ra = TRUE; c = *s_ptr; }
     else s_ptr--;
     old_sptr = s_ptr; /* save pointer to start of samyoga                    */
     if (ISHAL(c)) { hal_flag = TRUE; samyoga(); c = *s_ptr; }
     ac_char = hasanta = 0; 
     if (!hr_flag) { if (ISAC(c)) { ac_char = *s_ptr++; }
                     else hasanta = TRUE;   /* hr_flag = h.r parsed by samyoga */
                   }
     backac(); hr_flag = FALSE;
     if (*tmp) { if (outbuf[0]=='\0' && tmp[0]=='[') strcat(outbuf,"{}");
                 strcat(outbuf,tmp); 
               }
     strcpy(tmp,work);
     *work = '\0'; cont_begin = FALSE;

  }
  strcat(outbuf,work);
  s_ptr = bnbuf; *s_ptr = '\0';
  cont_begin = 0;
}


/***************************************************************************/
/* Function: single()                                                      */
/*                                                                         */
/* Output single (stand-alone) character to work buffer                    */
/***************************************************************************/

void single(char c)
{
  switch(c)
  {  case '0':   strcat(work,"0");  break; /* numerals */
     case '1':   strcat(work,"1");  break;
     case '2':   strcat(work,"2");  break;
     case '3':   strcat(work,"3");  break;
     case '4':   strcat(work,"4");  break;
     case '5':   strcat(work,"5");  break;
     case '6':   strcat(work,"6");  break;
     case '7':   strcat(work,"7");  break;
     case '8':   strcat(work,"8");  break;
     case '9':   strcat(work,"9");  break;
     case '!':   strcat(tmp,"\\-"); break; /* discretionary hyphen */
/*   case '%':   strcat(work,"?");  break; */
     case '|':   strcat(work,".");  break; /* dnari */
/*   case '\\':  strcat(work,"H1"); break; */
     case '@':   strcat(work,"\\30Cz");  break; /* hasanta */
     case '~':   strcat(work,"w");  break; /* candrabindu */
     case 'H':   strcat(work,"H");  break; /* visarga */
     case 'M':   strcat(work,"M");  break; /* anusvara */
     }
}


/***************************************************************************/
/* Function: frontac()                                                     */
/*                                                                         */
/* Process a front-vowel to workbuf                                        */
/***************************************************************************/

void frontac(void) 
{ 
  CLRFLAGS;
  switch(ac_char)
  {  case 'a': strcat(work,"a");  break;
     case 'A': strcat(work,"aA"); break;
     case 'i': strcat(work,"\\302z");   break;
     case 'I': strcat(work,"\\303z");   break;
     case 'u': strcat(work,"\\304z");   break;
     case 'U': strcat(work,"\\305z");   break;
     case 'x': strcat(work,"\\306z");   break;
 /*  case 'w': strcat(work,"--");       break; */
     case 'e': strcat(work,"\\308z");   break;
     case 'E': strcat(work,"\\309z");   break;
     case 'o': strcat(work,"\\30Az");   break;
     case 'O': strcat(work,"\\30Bz");   break;
     default : error("Lost in frontac()",-1);
  }
}


/***************************************************************************/
/* Function: sam_warning()                                                 */
/*                                                                         */
/* Print a warning message that a hasanta will be used within a             */
/* samyoga. Also print input file line number, together with an            */
/* indication of the samyoga and where the viraama will be placed.         */
/***************************************************************************/

void sam_warning(void)
{ 
  char *p, msg[80]="";
  p = old_sptr;
  if (pre_ra)
     { strcat(msg,"r");
       if (p==s_ptr) strcat(msg,"-");
     }
  while (ISHAL(*p))
  { switch (*p)
    { case 'B': strcat(msg,"bh");  break;
      case 'C': strcat(msg,"ch");  break;
      case 'D': strcat(msg,"dh");  break;
      case 'G': strcat(msg,"gh");  break;
      case 'H': strcat(msg,".h");  break;
      case 'J': strcat(msg,"jh");  break;
      case 'K': strcat(msg,"kh");  break;
      case 'P': strcat(msg,"ph");  break;
      case 'T': strcat(msg,"th");  break;
      case 'f': strcat(msg,".t");  break;
      case 'F': strcat(msg,".th"); break;
      case 'N': strcat(msg,".n");  break;
      case 'q': strcat(msg,".d");  break;
      case 'Q': strcat(msg,".dh"); break;
      case 'S': strcat(msg,".s");  break;
      case 'V': strcat(msg,"~n");  break;
      case 'Y': strcat(msg,".y");  break;
      case 'z': strcat(msg,"\"n"); break;
      case 'Z': strcat(msg,"\"s"); break;
      default:  chrcat(msg,*p);    break;
    }
    if (++p == s_ptr) strcat(msg,"-");
  }
  if (ISAC(*p))
     { switch (*p)
       { /* case 'w': strcat(msg,".l"); break; */
         case 'x': strcat(msg,".r"); break;
         default:  chrcat(msg,*p);   break;
       }
     }
  printf("Line %4d    Warning: samyoga viraama: %s\n",line_cnt,msg);
}         


/***************************************************************************/
/* Function: backac()                                                      */
/*                                                                         */
/* Handle vowel diacritics                                                 */
/***************************************************************************/

void backac(void)
{  int j,k; char c, *p; 

   if (pre_ra && (*work=='\0'))        /* case r.r, r.R, r.l, r.L, ru, rU, ra */
     { c = toupper(ac_char);
      /* if ((c =='X') || (c == 'W')) {frontac(); return; } */
       if (c == 'U')
              { if (ac_char == 'u') 
                        { strcat(work,"\\319z"); ac_char = 'a'; }
                   else { strcat(work,"\\31Az"); ac_char = 'a'; }
              }
           
       else { strcat(work,"r"); }   /* ra */
       pre_ra = FALSE; hal_flag = TRUE;
     }

   if (post_ra) { strcat(work,"\\30Fz"); }      /* ra-phala */
   if (post_ya) { strcat(work,"\\30Dz"); }      /* ya-phala */
   post_ya = post_ra = 0;

c = ac_char;

if (pre_ra) { strcat(work,"\\30Ez"); }         /* add repha */
/* if (hasanta)   { strcat(work,"\\30Cz"); }    /* add hasanta */

if (ac_char == 'A') { strcat(work,"A");}                   /* add aa-dia */
if (ac_char == 'i') { CAT(tmp,"i",""); }                   /* add i-dia */
if (ac_char == 'I') { strcat(work,"I"); }                  /* add ii-dia */
if (ac_char == 'u') { strcat(work,"u");}                   /* add u-dia */ 
if (ac_char == 'U') { strcat(work,"U");}                   /* add uu-dia */
if (ac_char == 'x') { strcat(work,"W");}                   /* add .r dia */
if (ac_char == 'e') { CAT(tmp,"e",""); }                   /* add e-dia */
if (ac_char == 'E') { CAT(tmp,"E",""); }                   /* add ai-dia */
if (ac_char == 'o') { CAT(tmp,"e",""); strcat(work,"A");}  /* add o-dia */
if (ac_char == 'O') { CAT(tmp,"e",""); strcat(work,"O");}  /* add au-dia */

}

/***************************************************************************/
/* Function: samyoga()                                                     */
/*                                                                         */
/* Work along bnbuf sequentially to build up a samyoga print              */
/* string in the work buffer and update the samyoga parameters.            */
/*                                                                         */
/* The method is quite unsophisticated, but its simplicity lends           */
/* clarity for later additions or changes, and for this reason             */
/* is done in Devanagari alphabetical order, but with longer               */
/* strings before shorter.                                                 */
/*                                                                         */
/* Cr and Cy conjuncts are not defined in the individual cases for each    */
/* consonant. Rather these are handled in bulk by the program at the end   */
/* of the function.                                                        */
/*                                                                         */
/* Macros are used to simplify reading the program --- believe it or not!  */
/*                                                                         */
/* Switch/case is used on the first letter, then the main LS macro tests:  */
/*   (1) if the test string matches the input exactly, then                */
/*   (2) bump input pointer to the character after string match            */
/*   (3) use NC etc macro to break out of switch instruction               */
/***************************************************************************/


#define LS(a,c,z) n=strlen(a);        \
        if(strncmp(p,a,n)==0) { strcat(work,z); p+=n; c;}

#define NX sam_flag = 'X'; break; 
#define NR sam_flag = 'R'; break; 
#define NC sam_flag = 'C'; break;

#define IX p++; sam_flag = 'X'; break; 
#define IR p++; sam_flag = 'R'; break; 
#define IC p++; sam_flag = 'C'; break; 

/******************************************************************************/

void samyoga(void)
{ 
char *p, sam_flag; int n;
 sam_flag = 0;
 p = s_ptr;
 while (1)
 { if (!ISHAL(*p)) { NX; }
   switch (*p++)
   { 

 /* k */
 case 'k': if(*p=='u') 
                   {p+=1;  strcat(work,"k{\\kern-.25em}u{\\kern.25em}");NX;}
           if(*p=='U') 
                   {p+=1;  strcat(work,"k{\\kern-.25em}U{\\kern.25em}");NX;}
           if(*p=='x') 
                   {p+=1;  strcat(work,"k{\\kern-.25em}W{\\kern.25em}");NX;}
           if(*p=='S' && *(p+1)=='N')
                   {p+=2;  strcat(work,"\\388z");NR;}
           if(*p=='S' && *(p+1)=='m')
                   {p+=2;  strcat(work,"\\389z");NR;}
           LS("k",  NR, "\\380z" );
           LS("f",  NR, "\\381z" );
           LS("t",  NR, "\\382z" );
           LS("b",  NR, "\\383z" );
           LS("m",  NR, "\\384z" );
           LS("r",  NR, "\\385z" );
           LS("l",  NR, "\\386z" );
           LS("v",  NR, "\\383z" );
           LS("s",  NR, "\\38Az" );
           LS("S",  NR, "\\387z" );
           strcat(work,"k"); NR;
           
 /* kh */
 case 'K': strcat(work,"K"); NR;

 /* g */          
 case 'g': LS("D",  NR, "\\38Bz" );
           LS("n",  NR, "\\38Cz" );
           LS("b",  NR, "\\38Dz" );
           LS("m",  NR, "\\38Ez" );
           LS("l",  NR, "\\38Fz" );
           LS("v",  NR, "\\38Dz" );
           strcat(work,"g"); NR;
           
 /* gh */
 case 'G': LS("n",  NR, "\\390z");
           strcat(work,"G"); NR;
           
 /* "n */
 case 'z': if(*p=='k' && *(p+1)=='S')
                   {p+=2;  strcat(work,"\\392z");NR;}
           LS("k",  NR, "\\391z");
           LS("K",  NR, "\\393z");           
           LS("g",  NR, "\\394z");
           LS("G",  NR, "\\395z");
           LS("m",  NR, "\\396z");
           strcat(work,"q"); NR;
           
 /* c */
 case 'c': if(*p=='C' && (*(p+1)=='b' || *(p+1)=='v'))
                   {p+=2;  strcat(work,"\\399z");NR;}
           LS("c",  NR, "\\397z");
           LS("C",  NR, "\\398z");
           LS("V",  NR, "\\39Az");
           strcat(work,"c"); NR;
           
 /* ch */
 case 'C': strcat(work,"C"); NR;
           
 /* j */
 case 'j': if(*p=='j' && (*(p+1)=='b' || *(p+1)=='v'))
                  {p+=2;  strcat(work,"\\39Cz");NR;}
           LS("j",  NR, "\\39Bz" );
           LS("J",  NR, "\\39Dz" );
           LS("V",  NR, "\\39Ez" );
           LS("b",  NR, "\\39Fz" );
           LS("v",  NR, "\\39Fz" );
           strcat(work,"j"); NR;
           
 /* jh */  
 case 'J': if(*p=='u') 
                   {p+=1;  strcat(work,"J{\\kern-.24em}u{\\kern.24em}");NX;}
           if(*p=='U')                             
                   {p+=1;  strcat(work,"J{\\kern-.24em}U{\\kern.24em}");NX;}
           if(*p=='x') 
                   {p+=1;  strcat(work,"J{\\kern-.24em}W{\\kern.24em}");NX;}
           strcat(work,"J"); NR;

 /* ~n */
 case 'V': if(*p=='u') 
                   {p+=1;  strcat(work,"Q{\\kern-.39em}u{\\kern.39em}");NX;}
           if(*p=='U') 
                   {p+=1;  strcat(work,"Q{\\kern-.39em}U{\\kern.39em}");NX;}
           if(*p=='x') 
                   {p+=1;  strcat(work,"Q{\\kern-.39em}W{\\kern.39em}");NX;}
           LS("c",  NR, "\\3A0z" );
           LS("C",  NR, "\\3A1z" );
           LS("j",  NR, "\\3A2z" );
           LS("J",  NR, "\\3A3z" );
           strcat(work,"Q"); NR;

 /* .t */
 case 'f': LS("f",  NR, "\\3A4z" );
           LS("b",  NR, "\\3A5z" );
           LS("v",  NR, "\\3A5z" );
           strcat(work,"T"); NR;

 /* .th */
 case 'F': strcat(work,"Z"); NR;
           
 /* .da */
 case 'q': LS("q",  NR, "\\3A6z" );
           strcat(work,"D"); NR;
           
 /* .dh */
 case 'Q': strcat(work,"X"); NR;
           
 /* .n */
 case 'N': LS("f",   NR, "\\3A7z" );
           LS("F",   NR, "\\3A8z" );
           LS("q",   NR, "\\3A9z" );
           LS("N",   NR, "\\3AAz" );
           LS("t",   NR, "\\3ACz" );
           LS("m",   NR, "\\3ABz" );
           strcat(work,"N"); NR;
        
 /* t */
 case 't': if(*p=='t' && (*(p+1)=='b' || *(p+1)=='v'))
                  {p+=2;  strcat(work,"\\3ADz"); NR;}
           if(*p=='r' && *(p+1)=='u')
                  {p+=2;  strcat(work,"\\3B3z"); NX;}
           LS("t",  NR, "\\3ACz" );
           LS("T",  NR, "\\3AEz" );
           LS("n",  NR, "\\3AFz" );
           LS("b",  NR, "\\3B0z" );
           LS("m",  NR, "\\3B1z" );
           LS("r",  NR, "\\3B2z" );
           LS("v",  NR, "\\3B0z" );
           strcat(work,"t"); NR;
           
 /* th */
 case 'T': LS("b",  NR, "\\4Lz");
           LS("v",  NR, "\\4Lz");
           strcat(work,"z"); NR;

 /* d */
 case 'd': if(*p=='B' && *(p+1)=='r')
                  {p+=2;  strcat(work,"\\3BAz");NR;}
           LS("g",  NR, "\\3B4z");
           LS("G",  NR, "\\3B5z");
           LS("d",  NR, "\\3B6z");
           LS("D",  NR, "\\3B7z");
           LS("b",  NR, "\\3B8z");
           LS("B",  NR, "\\3B9z");
           LS("m",  NR, "\\3BBz");
           LS("v",  NR, "\\3B8z" );
           strcat(work,"d"); NR;
           
 /* dh */
 case 'D': LS("n",  NR, "\\3BCz" );
           LS("b",  NR, "\\3BDz" );
           LS("v",  NR, "\\3BDz" );
           strcat(work,"x"); NR;
           
 /* n */
 case 'n': if(*p=='t' && *(p+1)=='u')  
                    {p+=2; strcat(work,"\\3C1z");NR;}
           if(*p=='t' && (*(p+1)=='b' || *(p+1)=='v'))
                    {p+=2; strcat(work,"\\3C2z");NR;}
           if(*p=='t' && *(p+1)=='r')  
                    {p+=2; strcat(work,"\\3C3z");NR;}
           if(*p=='d' && (*(p+1)=='b' || *(p+1)=='v'))  
                    {p+=2; strcat(work,"\\4Pz");NR;}
           LS("f",  NR, "\\3BEz" );
           LS("q",  NR, "\\3BFz" );
           LS("t",  NR, "\\3C0z" );
           LS("T",  NR, "\\3C4z" );
           LS("d",  NR, "\\3C5z" );
           LS("D",  NR, "\\3C6z" );
           LS("n",  NR, "\\3C7z" );
           LS("b",  NR, "\\3C8z" );
           LS("m",  NR, "\\3C9z" );
           LS("s",  NR, "\\3CAz" );
           LS("v",  NR, "\\3C8z" );
           strcat(work,"n"); NR;
           
 /* p */
 case 'p': LS("f",  NR, "\\3CBz" );
           LS("t",  NR, "\\3CCz" );
           LS("n",  NR, "\\3CDz" );
           LS("p",  NR, "\\3CEz" );
           LS("l",  NR, "\\3CFz" );
           LS("s",  NR, "\\3D0z" );
           strcat(work,"p"); NR;
           
 /* ph */
 case 'P': if(*p=='u') 
                   {p+=1;  strcat(work,"f{\\kern-.21em}u{\\kern.21em}");NX;}
           if(*p=='U') 
                   {p+=1;  strcat(work,"f{\\kern-.21em}U{\\kern.21em}");NX;}
           if(*p=='x') 
                   {p+=1;  strcat(work,"f{\\kern-.21em}W{\\kern.21em}");NX;}
           LS("l",  NR, "\\3D1z" );
           strcat(work,"f"); NR;
           
 /* b */
 case 'b': LS("j",  NR, "\\3D2z" );
           LS("d",  NR, "\\3D3z" );
           LS("D",  NR, "\\3D4z" );
           LS("b",  NR, "\\3D5z" );
           LS("l",  NR, "\\3D6z" );
           strcat(work,"b"); NR;

 /* bh */
 case 'B': LS("r",  NR, "\\3D7z" );
           LS("l",  NR, "\\3D8z" );
           strcat(work,"v"); NR;
           
 /* m */
 case 'm': if(*p=='B' && *(p+1)=='r')  
                    {p+=2; strcat(work,"\\3DEz");NR;}
           LS("n",  NR, "\\3D9z" );
           LS("p",  NR, "\\3DAz" );
           LS("P",  NR, "\\3DBz" );
           LS("b",  NR, "\\3DCz" );
           LS("B",  NR, "\\3DDz" );
           LS("m",  NR, "\\3DFz" );
           LS("l",  NR, "\\3E0z" );
           LS("v",  NR, "\\3DCz" );
           strcat(work,"m"); NR;
           
 /* y */
 case 'y': strcat(work,"Y"); NR;

 /* .y */
 case 'Y': strcat(work,"y"); NR;
 
 /* r */
 case 'r': strcat(work,"r"); NR;
 
 /* l */
 case 'l': if(*p=='g' && *(p+1)=='u')
                   {p+=2;  strcat(work,"\\3E3z");NX;}
           LS("k",  NR, "\\3E1z" );
           LS("g",  NR, "\\3E2z" );
           LS("f",  NR, "\\3E4z" );
           LS("q",  NR, "\\3E5z" );
           LS("p",  NR, "\\3E6z" );
           LS("b",  NR, "\\3E7z" );
           LS("m",  NR, "\\3E8z" );
           LS("l",  NR, "\\3E9z" );
           strcat(work,"l"); NR;

 /* "s */
 case 'Z': LS("c",  NR, "\\3EAz" );
           LS("C",  NR, "\\3EBz" );
           LS("n",  NR, "\\3ECz" );
           LS("m",  NR, "\\3EDz");
           LS("b",  NR, "\\3EFz" );
           LS("l",  NR, "\\3EEz" );
           LS("v",  NR, "\\3EFz" );
           strcat(work,"S"); NR;
           
 /* .s */
 case 'S': if(*p=='k' && *(p+1)=='r')
                   {p+=2;  strcat(work,"\\3F1z");NR;}
           LS("k",  NR, "\\3F0z" );
           LS("f",  NR, "\\3F2z" );
           LS("F",  NR, "\\3F3z" );
           LS("N",  NR, "\\3F4z" );
           LS("p",  NR, "\\3F5z" );
           LS("P",  NR, "\\3F6z" );
           LS("m",  NR, "\\3F7z" );
           strcat(work,"F"); NR;

 /* s */           
 case 's': if(*p=='k' && *(p+1)=='r')
                   {p+=2;  strcat(work,"\\3F9z");NR;}
           if(*p=='k' && *(p+1)=='l')
                   {p+=2;  strcat(work,"\\3FAz");NR;}
           if(*p=='t' && *(p+1)=='u')
                   {p+=2;  strcat(work,"\\3FEz");NX;}
           if(*p=='t' && *(p+1)=='r')
                   {p+=2;  strcat(work,"\\3FFz");NR;}
           if(*p=='p' && *(p+1)=='l')
                   {p+=2;  strcat(work,"\\313z");NR;}
           LS("k",  NR, "\\3F8z" );
           LS("K",  NR, "\\3FBz" );
           LS("f",  NR, "\\3FCz" );
           LS("t",  NR, "\\3FDz" );
           LS("T",  NR, "\\310z" );
           LS("n",  NR, "\\311z" );
           LS("p",  NR, "\\312z" );
           LS("P",  NR, "\\314z" );
           LS("b",  NR, "\\315z" );
           LS("m",  NR, "\\316z" );
           LS("l",  NR, "\\317z" );
           LS("v",  NR, "\\315z" );
           strcat(work,"s"); NR;
           
 /* h */           
 case 'h': if(*p=='x') { strcat(work,"\\31Cz");hr_flag = TRUE; IX; }
           LS("N",  NR, "\\318z");
           LS("n",  NR, "\\31Fz");
           LS("b",  NR, "\\33Ez");
           LS("m",  NR, "\\320z");
           LS("l",  NR, "\\37Dz");
           LS("v",  NR, "\\33Ez");
           strcat(work,"h"); NR;

 case 'w': LS("g",  NR, "\\37Fz");
           strcat(work,"R"); NR;

 case 'W': strcat(work,"V"); NR;
           
 case 'L': strcat(work,"B"); NR;

 /* Assamese r */
 case 'R': strcat(work,"\\4rz"); NR;

 /* Assamese v */
 case 'v': strcat(work,"\\4vz"); NR;

 default: error("Lost in samyoga()",-1); NX;
 }

   if (sam_flag == 'X') { s_ptr = p; break; }
   if (sam_flag == 'R') { /* if ((*p=='r') && ra) { post_ra = TRUE; p++; } */
                             if ((*p=='r')) { post_ra = TRUE; p++; }
                          /* if ((*p=='y') && ya) { post_ya = TRUE; p++; } */
                             if ((*p=='y')) { post_ya = TRUE; p++; }
                          s_ptr = p; break;
                        }
   if (!ISHAL(*p)) { s_ptr = p; break; }
  }  
}

/***************************************************************************/
/*                                samapta                                  */
/***************************************************************************/
