
/******************************************************************************/
/*                                                                            */
/*      SKT.C                                                                 */
/*                                                                            */
/*      Pre-processor for LaTeX files containing commands of the series       */
/*      \skt.. converting the encoded sanskrit text to a form to use the      */
/*      SKTxx devanaagarii fonts, and/or to a transliterated Roman form       */
/*      using diacritical marks.                                              */
/*                                                                            */
/*      Note: you may need to tailor "tex_inputs" path in the first statement */
/*                                                                            */
/*      Revision 1.0 1996/02/13 Charles Wikner wikner@nacdh4.nac.ac.za        */
/*      Revision 1.1 1996/03/05 correct bugs picked up by gcc compiler        */
/*      Revision 2.0 1996/11/27 major upgrade: add/change many features       */
/*      Revision 2.1 1997/02/11 minor corrections; add more accents           */
/*      Revision 2.2 2002/01/02 minor corrections; tidy                       */
/*                                                                            */
/*      Copyright 1996 & 2002 Charles Wikner                                  */
/*      This program can be redistributed and/or modified under the terms     */
/*      of the LaTeX Project Public License Distributed from CTAN             */
/*      archives in directory macros/latex/base/lppl.txt; either              */
/*      version 1 of the License, or any later version.                       */
/*                                                                            */
/******************************************************************************/

#define DEBUG 0

/* Set DEBUG 0 for normal                                                     */
/* If non-zero, STDIO is used for input/output                                */
/* 1 = debug process(); output is internal code                               */
/* 2 = debug sktword(); output is final output                                */

#define total_options 199

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
void   sktcont     (void);
void   sktword     (void);
void   fixed       (char);
void   single      (void);
void   sam_warning (void);
void   addhooks    (void);
void   backac      (void);
void   autohyphen  (void);
void   samyoga     (void);
int    aci         (char *);
void   translit    (void);

FILE *infile, *outfile, *fopen();
char infilename[80];
char outfilename[80];

#define TRUE 1
#define FALSE 0

unsigned char feint;      /* flag TRUE while within {\sktf..}                 */
unsigned char bold;       /* flag TRUE while within {\sktb..}                 */
unsigned char xbold;      /* flag TRUE while within \sktX or \sktT            */
unsigned char sktline;    /* flag TRUE if there is any sanskrit on this line  */
unsigned char sktmode;    /* flag TRUE while within {\skt.. }                 */
unsigned char eof_flag;   /* flag True when end of file detected              */
unsigned char xlit;       /* flag TRUE while within {\sktx }                  */
unsigned char tech;       /* flag TRUE while within {\sktt }                  */
unsigned char ac_flag;    /* flag TRUE while processing skt vowels            */
unsigned char svara_flag; /* flag TRUE if previous input char was accent      */
unsigned char ylv_flag;   /* flag TRUE if previous input char was y, l, or v  */
unsigned char roman_flag; /* flag TRUE if previous output was Roman string    */

int nest_cnt;            /* '{' increments, '}' decrements, while in \skt..   */
int err_cnt;             /* incremented by any error while in \skt..          */
#define err_max 10       /* after err_max errors, program aborts              */
int line_cnt;            /* line number of current input line                 */

char inbuf[255];         /* input file line buffer of text being processed    */
char *i_ptr;             /* general pointer to input buffer                   */
char outbuf[2048];       /* output file line buffer of text processed         */
char *o_ptr;             /* general pointer to output buffer                  */

unsigned char cont_end;   /* flag TRUE when line ends with %-continuation     */
unsigned char cont_begin; /* flag TRUE when line begins after %-continuation  */
unsigned char hal_flag;   /* flag TRUE when hal_type detected in syllable     */
unsigned char accent;     /* storage for working accent character             */
unsigned char nasal;      /* storage for working nasal character              */
unsigned char ac_char;    /* storage for working vowel character              */
unsigned char pre_ra;     /* storage/flag for 'r' at beginning of samyoga     */
char ac_hook;             /* vowel hook code                                  */
char sktbuf[255];         /* storage for sanskrit in internal code            */
char *s_ptr;              /* general pointer to sanskrit buffer               */
char *old_sptr;           /* points to samyoga start; used by warning message */
char work[256];           /* general scratchpad                               */
char *w_ptr;              /* general pointer to work buffer                   */
char tmp[2048];           /* temporary buffer for previous syllable           */
int  wid;                 /* character print width                            */
int  top;                 /* amount to backspace for top flags                */
int  bot;                 /* amount to backspace for bottom flags             */
int  dep;                 /* character descender below line                   */
int  rldep;               /* dep reduction for .r and .l vowel hooks          */
int  fbar;                /* length hor. bar to inset if first int  of word   */
int  fwh;                 /* character front whiteness (without fbar)         */
int  bwh;                 /* character back whiteness                         */
int  ra;                  /* post_ra type to use with this character          */
int  ya;                  /* post_ya type to use with this character          */
int  bs;                  /* backspace flag for front-vowels                  */
int  vaflg;               /* zero at first time use of VA macro               */
int  whiteness;           /* back whiteness of previous syllable (in tmp)     */
int  end_bar;             /* flag to append vertical bar to end of syllable   */
int  bindu;               /* nasal flag                                       */
int  candrabindu;         /* nasal flag                                       */
int  post_ra;             /* flag to append ra to samyoga                     */
int  post_ya;             /* flag to append ya to samyoga                     */
int  virama;              /* flag to add viraama to samyoga (i.e. no vowel)   */
int  hr_flag;             /* flag indicates vowel picked up in samyoga (h.r)  */
int  option[total_options+1]; /* table of user option flags                   */
int  low_left;            /* interference value: top hooks                    */
int  low_right;           /* interference value: top hooks                    */
int  high_left;           /* interference value: raised accents               */
int  high_right;          /* interference value: raised accents               */
int  interspace;          /* inter-syllable space, determined from opt. 2 & 3 */
int  intraspace;          /* intra-syllable space, from above and option 1    */

/******************************************************************************/
/*                       MAIN                                                 */
/******************************************************************************/

main(argc,argv)
int argc;
char *argv[];
{ char *p; int k;

/* INITIALIZATION */

  sktmode = eof_flag = xlit = FALSE;
  nest_cnt = err_cnt = 0;
  line_cnt = 0;
  i_ptr = inbuf;  *i_ptr = '\0';
  s_ptr = sktbuf; *s_ptr = '\0';
  o_ptr = outbuf; *o_ptr = '\0';
  for (k=0; k<total_options+1; k++) option[k] = FALSE; /* disable everything  */

  printf("SKT.C Version 2.2 02-Jan-2002\n");

#if (DEBUG == 0)

/* FILE NAMES */

  switch(argc)
  { case 3:  strcpy(infilename,argv[1]);
             strcpy(outfilename,argv[2]);
             break;
    case 2:  strcpy(infilename,argv[1]);
             strcpy(outfilename,"");
             break;
    default: while(strlen(infilename) == 0)
                   { printf("Input file: "); scanf(infilename); }
             printf("Output file: ");
             scanf(outfilename);
  }
  if (strlen(outfilename) == 0) 
    { strcpy (outfilename,infilename);   /* default output file name */
      p = strchr(outfilename,'.');
      if (p != 0) *p = '\0';   /* delete out file name extension */
    }
  p = strchr(infilename,'.');
  if (p == 0) strcat(infilename,".skt");  /* default input file extension */
  if ((infile=fopen(infilename,"r")) == NULL)
        { printf("Cannot open file %s\n",infilename); exit(1); }
  p = strchr(outfilename,'.');
  if (p == 0) strcat(outfilename,".tex"); /* set default output file extension */
  if ((outfile=fopen(outfilename,"w")) == NULL)
        { printf("Cannot open output file %s\n",outfilename); exit(1); }
#else
  printf("Enter text (blank line terminates program) :\n");
#endif

  getline(); if (eof_flag) { printf("No input text.\n"); exit(1); }

#if (DEBUG == 0)

/* NORMAL MAIN LOOP */

  while(eof_flag == 0)
    { while(!sktmode && !eof_flag) search();  /* search for \skt command */
      while( sktmode && !eof_flag) process(); /* process sanskrit text */
      if (err_cnt >= err_max)
         { printf("Too many (%d) errors, aborting program\n",err_cnt); break; }
    }
  if ((err_cnt < err_max) && (nest_cnt != 0))
     printf("Brace mismatch within \\skt = %d\n",nest_cnt); 
  fclose(infile);
  fclose(outfile);
  exit(0);

#else

/* DEBUG MAIN LOOP */

  while(eof_flag == 0)
    { while(!sktmode && !eof_flag) search();  /* search for \skt command */
      while( sktmode && !eof_flag) process(); /* process sanskrit text */
    }
  exit(0);

#endif 

}

/******************************************************************************/
/*                       SEARCH                                               */
/******************************************************************************/

/* Function: search inbuf for '{\skt', getting more input lines as necessary  */
/*           until string found or end of file, copying input to output; if   */
/*           the string is found but command not recognised, it is treated as */
/*           ordinary text; if valid command i_ptr points to first sanskrit   */
/*           char after command, and sets sktmode TRUE.                       */

void search(void)
{
unsigned char c;
char *p,*q;
  xlit = 0;
  while (eof_flag == 0)
    { p = str_find(i_ptr,"{\\skt");
      if (p == 0)
        { if (sktline == TRUE) { strcat(outbuf,i_ptr); write_outbuf(); }
          else { write_line(inbuf); o_ptr = outbuf; *o_ptr = '\0';  }
          getline(); 
          continue; 
        }
      q = i_ptr; i_ptr = p;
      if ((p = command(p)) == 0)        /* test command string \skt..         */
        { p = i_ptr; i_ptr = q;         /* if bad \skt command                */
          c = *++p; *p = '\0';          /* copy partial line, and search more */
          strcat(outbuf,i_ptr); *p = c; i_ptr = p; continue;
        }
      i_ptr = q;
      nest_cnt++; c = *p; *p = '\0';    /* skip over '{\skt'                  */
      strcat(outbuf,i_ptr);             /* append partial line to outbuf      */
      *p = c; i_ptr = p; 
      sktmode = TRUE; sktline = TRUE;   /* now comes the fun!                 */
      break;
    }
}

/******************************************************************************/
/*                       WRITE_OUTBUF                                         */
/******************************************************************************/

/* Function: write outbuf in 80 char lines                                    */

void write_outbuf(void)
{ 
char c, d, e;
  while(1)
  { c = '\0'; 
    if (strlen(outbuf) < 81) { write_line(outbuf); break; }
    if (option[9])                                  /* if obey-lines enabled */
      { if (strlen(outbuf) > 250) 
         { printf("Line %4d    Warning: Very long output line: %d characters\n",
                   line_cnt, strlen(outbuf) );
         }
        write_line(outbuf); break;
      }
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

/******************************************************************************/
/*                       WRITE_LINE                                           */
/******************************************************************************/

/* Function: write p-string to output device                                  */

void write_line(char *p)
{
#if (DEBUG == 0)
  if (err_cnt == 0) fputs(p,outfile); 
#else
  printf("%s\n",p);
#endif
} 

/******************************************************************************/
/*                       STR_FIND                                             */
/******************************************************************************/

/* Function: find first occasion of string *str within *buf before '%' char;  */
/*           return pointer first char of str within buf, else 0.             */

char * str_find(char *buf, char *str)
{ char *p, *x;
  p = strstr(buf,str);
  if (p == 0) return(0);
  x = strchr(buf,'%');
  if ((x != 0) && (p > x)) return(0);
  return(p);
}

/******************************************************************************/
/*                       GETLINE                                              */
/******************************************************************************/

/* Function: get another line from input file; reset i_ptr, increments        */
/*           line_cnt, and sets eof_flag if EOF.                              */

void getline(void)
{ 
char *p;
  i_ptr = inbuf;
  *i_ptr = '\0';
  line_cnt++;
#if (DEBUG == 0)
  if (fgets(inbuf,133,infile) == NULL) eof_flag = TRUE;
#else
  scanf(inbuf);
  if (strlen(inbuf) == 0) eof_flag = TRUE;
#endif
  if (sktmode == FALSE) sktline = FALSE;
}

/******************************************************************************/
/*                       COMMAND                                              */
/******************************************************************************/

/* Function: check for valid \skt.. command: if \sktx or \sktX set xlit TRUE, */
/*           else clear it; if invalid command, print error message           */

char * command(char *p)
{ char c;
  p += 5;                                            /* skip over '{\skt'     */
  feint = bold = xlit = tech = xbold = FALSE;
  c = *p++;
  switch (c)
  {  case ' ': break;                                /* for \skt              */
     case 'X': xbold = TRUE;                         /* for \sktx or \sktX    */
     case 'x': xlit = TRUE; 
               if (*p++ != ' ') p = 0;
               break;
     case 'I': xbold = TRUE;                         /* for \sktx or \sktX    */
     case 'i': xlit = TRUE; 
               if (*p++ != ' ') p = 0;
               break;
     case 'T': xbold = TRUE;                         /* for \sktt or \sktT    */
     case 't': tech = TRUE;
               if (*p++ != ' ') p=0;
               break;
     case 'U': xbold = TRUE;                         /* for \sktu or \sktU    */
     case 'u': tech = TRUE;
               if (*p++ != ' ') p=0;
               break;
     case 'b': c = *p++; if (c=='s') c = *p++;       /* for \sktb or \sktbs   */
               if (c != ' ') p = 0;
               else bold = TRUE;
               break;
     case 's': if (*p++ != ' ') p = 0;               /* for \skts             */
               break;
     case 'f': c= *p++; if (c == 's') c = *p++;      /* for \sktf or \sktfs   */
               if (c != ' ') p = 0;
               else feint = TRUE; 
               break;
     default:  p = 0;
  }
  if (p == 0) error("Unrecognised command string",7);
  return(p);
}

/******************************************************************************/
/*                       ERROR                                                */
/******************************************************************************/

/* Function: print out error message, including string *s and 'n' characters  */
/*           of inbuf.                                                        */

void error(char *s, int n)
{ char err_str[80]; int j;
  if (++err_cnt <= err_max)
    { if (n > 0)  { for (j=0; j<n; j++) err_str[j] = *(i_ptr+j);
                    err_str[j] = '\0'; 
                  }
      if (n == 0) { strcpy(err_str,"oct(");
                    chrcat(err_str,'0' + (*i_ptr/64));
                    chrcat(err_str,'0' + ((*i_ptr/8)&&7));
                    chrcat(err_str,'0' + (*i_ptr & 7));
                    strcat(err_str,")"); 
                  }
      if (n < 0)  { err_str[0] = '\0'; }
    }
  printf("Line %4d    Error: %s %s\n",line_cnt,s,err_str);
}

/******************************************************************************/
/*                       PROCESS                                              */
/******************************************************************************/

/* Function: process input text within {\skt.., converting to internal        */
/*           format in sktbuf                                                 */

#define ISAC(c) (((strchr("aAiIuUwWxXeEoO",c) != 0) && c) ? TRUE : FALSE)

#define CAT(w,x,y,z) \
strcat(w,x); if((y)>9)chrcat(w,('0'+((y)/10))); \
chrcat(w,('0'+((y)%10))); strcat(w,z)

void process(void)
{ int j,k,cap_flag, underscore, nasal_vowel, n_flag, vedic;
unsigned char *i, c,d;
#define CF ac_flag=svara_flag=ylv_flag=underscore=cap_flag=roman_flag=nasal_vowel=n_flag=vedic=FALSE
#define CC CF; continue
#define CR ac_flag=svara_flag=ylv_flag=underscore=cap_flag=nasal_vowel=n_flag=vedic=FALSE;
#define CI i_ptr++; CC

 CF; 
 sktcont(); /* reset cont_begin flag */
 while(1)
  { if (eof_flag) return;
    if (err_cnt >= err_max) 
       { sktmode = FALSE; xlit = feint = bold = tech = FALSE; return; }
    c = *i_ptr; d = *(i_ptr+1);
/* END OF LINE */
    if ((c == '\0') || (c == '\n'))
      { sktword(); strcat (outbuf,i_ptr); write_outbuf(); getline(); CC; }
/* COMMENT DELIMITER */
    if (c == '%')
    { if (*(i_ptr+1) == '\n') sktcont();
      else sktword();
      strcat(outbuf,i_ptr); write_outbuf(); getline(); CC;
    }
/* ILLEGAL CHARS */
    if (strchr("&fqwxzFQWXZ\177",c))
/**/
       { error("Illegal sanskrit character: ",1); CI; }
    if (c>127) { error("Invalid character >80H: ",1); CI; }
/* CONTROL CHARACTERS */
    if (c < ' ')
    { error("Illegal control character: ",0); CI; }
/* ADDED IMBEDDED ROMAN */
    if ( (strchr("[`']",c) && c==d) || ((c == '.') && (d == '!')) )
    { if (sktbuf[0]) sktword(); 
      if (!xlit) { if (feint) strcat(outbuf,"\\ZF{");
                   if (bold)  strcat(outbuf,"\\ZB{");
                   if (!feint && !bold) strcat(outbuf,"\\ZN{");
                   roman_flag = TRUE;
                 }
      chrcat(outbuf,d); 
      if (!xlit) strcat(outbuf,"}");
      i_ptr+=2; 
      CR; continue;
    }
/* UNEXPECTED > or ] */
    if (c == '>') { error("Unexpected `>' character.",-1); CI; }
    if (c == ']') { error("Unexpected `]' character.",-1); CI; }
/* IMBEDDED ROMAN */
    if (strchr("()*+,-/:;=?",c) || ((c == '.') && (d == '.')))
    { if (c == '.') i_ptr++;
      if (sktbuf[0]) sktword(); 
      if (!xlit) { if (feint) strcat(outbuf,"\\ZF{");
                   if (bold)  strcat(outbuf,"\\ZB{");
                   if (!feint && !bold) strcat(outbuf,"\\ZN{");
                   roman_flag = TRUE;
                 }
      while(1)
      { chrcat(outbuf,c); c = *++i_ptr;
        if (c == '.')
        { if (*(i_ptr+1) != '.') break;
          i_ptr++; continue;
        }
        if ((strchr("()*+,-/:;=?",c) && c) == 0) break;
      }
      if (!xlit) strcat(outbuf,"}");
      CR; continue;
    }
/* IMBEDDED LATEX COMMAND STRINGS */
    if (c == '\\')
    { if (d == '-')                 /* imbedded discretionary hyphen */
         { strcat(sktbuf,"-"); i_ptr++; CI; }
      sktword(); 
      if (isalpha(d) == 0)
         { chrcat(outbuf,c); chrcat(outbuf,*++i_ptr); CI; }
      else
      { while (1)
           { chrcat(outbuf,c); c = *++i_ptr; if (isalpha(c) == 0) break; }
      }
      CC;
    }
/* $$-SPACE (treated as vowel): used for printing accent notation alone */
    if (c == '$') { if (d!='$') 
                       { error("Illegal Sanskrit character: ",1); CI; }
                    i_ptr++; d = *(i_ptr+1); 
                    c = '\26'; 
                  }
/**/
/* IMBEDDED OPTIONS */
    if (c =='[')
    { sktcont(); 
      while (1)
      { while (*++i_ptr == ' '); /* skip white space */
        if (*i_ptr == ']') break;
        j = k = 0;
        while (isdigit(*(i_ptr+j))) { k = (k*10) + *(i_ptr+j) - '0'; j++; }
        if ( k > total_options )
             { error("Invalid option value: ",j+1); k=-1; }
        else { switch(*(i_ptr+j))
               { case '+': if (k==0) 
                             { for(k=1; k<=total_options; k++) option[k]=TRUE;}
                           else { option[k] = TRUE; }
                           break;
                 case '-': if (k==0) 
                             { for(k=1; k<=total_options; k++) option[k]=FALSE;}
                           else { option[k] = FALSE; }
                           break;
                 default:  error("Expected option sign here: ",j+1); k=-1;
             } } 
        i_ptr += j;
        if (k==-1) break;
      }
      CI;
    }
/* BRACES */
    if (c == '{') { if (d == '}') { i_ptr++; CI; } /* for words like pra{}uga */
                    else { nest_cnt++; sktcont(); chrcat(outbuf,c); CI; }
                  }
    if (c == '}')
       { if (--nest_cnt == 0)
              { sktword(); sktmode = FALSE; xlit = feint = bold = tech = FALSE; 
                chrcat(outbuf,c); i_ptr++; return; 
              }
         else { sktcont(); chrcat(outbuf,c); CI; }
       }
/* SKTT UNDERSCORE */
    if ( (c=='_') && tech) 
       { underscore = TRUE;
         c = d; i_ptr++; d = *(i_ptr+1);
       }
/* SPACE CHAR */
    if (c == ' ')
       { if (underscore) { error("Space character after underscore",-1); CI; }
         else { sktword(); while(*++i_ptr == ' '); chrcat(outbuf,c); CC; }
       }
/* UPPER CASE */
    if (isupper(c) || (strchr("\"~.",c) && isupper(d)))
    { if (isupper(c)) 
        { if (!(xlit || tech)) { error("Invalid use of upper case: ",1); CI; }
          else { cap_flag = TRUE; c = tolower(c); }
        }
      else
        { if (!(xlit || tech)) { error("Invalid use of upper case: ",2); 
                                 i_ptr++; CI; }
          if (    (c=='.'  && strchr("TDSNHRLM",d)) 
               || (c=='\"' && strchr("SNHD",    d))
               || (c=='~'  && strchr("NM",      d)) )
             { d = tolower(d); cap_flag = TRUE; }
        }
    }
/* QUOTE CHAR */
    if (c == '\"') { switch(d)
                           { case 'd': c = 'L'; break;  
                             case 'h': c = '\\'; break;  
                             case 'n': c = 'z'; break;  
                             case 's': c = 'Z'; break;  
                             case 'm': c = 'R'; break;  
                             case '1': c = '1'; break; /* accent char! */
                             case '3': c = '1'; break; /* accent char! */
                           }
                     if (c=='\"') { error("Invalid quote_character",2); CI; }
                     if (c=='1') c='\"'; /* restore accent string */
                     else { i_ptr++; d = *(i_ptr+1); }
                    } 
/* TILDE CHAR */
    if (c == '~') { switch (d)
                    { case 'n': c = 'V'; break;
                      case 'm': c = '~'; break;
                      default : c = '*'; break;
                    }
                    if (c=='*') 
                       { error("Invalid use of tilde character: ",2); CI; }
                    i_ptr++; d = *(i_ptr+1);
                  }
/* ACCENTS */
/* since this tests for some dot-char accents, it must be before checking for
   dot-char characters; since it generates a '"' character as output, it must
   be after checking for "-char characters.                                   */
/* Saamaveda and other <> accents */
    if (c == '<')
      { k = 2; 
        switch (d)
        { case '1': c = ':'; break;
          case '2': c = ';'; if (*(i_ptr+2) == 'r') { c = '='; k++; }
                             if (*(i_ptr+2) == 'u') { c = '>'; k++; } break;
          case '3': c = '<'; if (*(i_ptr+2) == 'k') { c = '?'; k++; } break;
          case '^': c = '\30'; break;
          case 'u': c = '\31'; break;
          case 'w': c = '\32'; break;
          case '_': c = '\33'; break;
          case '.': c = '\34'; if (*(i_ptr+2) == '.') { c = '\35'; k++; } break;
          case '!': c = '\36'; if (*(i_ptr+2) == '!') { c = '\27'; k++; } break;
          case 's': c = '\37'; break;
          default:  k = 1;
        }
        if (*(i_ptr+k) != '>')
          { error("Invalid <> accent: ",k+1); i_ptr+=k; CI; }
        if (tech) 
          { error("Invalid <> accent in sktt mode: ",k+1); i_ptr+=k; CI; }
        if (xlit && !option[7]) 
          { error("<> accents not enabled in sktx mode: ",k+1); i_ptr+=k; CI; }
        if (!ac_flag && !nasal_vowel && !n_flag && !vedic)
          { i_ptr--; error("Accent is not allowed here: ",k+2); i_ptr+=(k+1); CI; }
        i_ptr += k;
      }
/* other accents */
    k = 0;
    if  (c == '!') k++;
    if  (c == '_')                { c = '&';  k++; }
    if  (c == '^')                { c = '(';  k++; }
    if ((c == '!') && (d == '!')) { c = '\"'; k++; }
    if ((c == '"') && (d == '1')) { c = '$';  k+=2; }
    if ((c == '"') && (d == '3')) { c = '%';  k+=2; }
    if ((c == '.') && (d == '1')) { c = ')';  k+=2; }
    if ((c == '.') && (d == '3')) { c = '*';  k+=2; }
    if ((c == '`') || (c == '\'')) k++;
    if (k != 0)
      { if (!ac_flag && !nasal_vowel && !n_flag && !vedic)
          { i_ptr--; error("Accent not allowed here: ",k+1); i_ptr+=k; CI; }
        if ((c == '`' || c == '\'') && (!xlit && !tech))
          { error("Invalid accent in skt mode: ",1); CI; }
        if (strchr("!\"$%&",c))
          { if (tech) 
              { error("Invalid accent in sktt mode: ",k); i_ptr+=k-1; CI; }
            if (xlit && !option[6]) 
              { error("Accent not enabled in sktx mode: ",k); i_ptr+=k-1; CI; }
          }
        i_ptr += (k-1);
      } 
/* DOT CHAR */
    if (c == '.') { switch(d)
                          { case 'a': c = 'Y'; break;
                            case 'd': c = 'q'; break;
                            case 'h': c = 'H'; break;
                            case 'l': c = 'w'; break;
                            case 'm': c = 'M'; break;
                            case 'n': c = 'N'; break;
                            case 'o': c = '/'; break;
                            case 'r': c = 'x'; break;
                            case 's': c = 'S'; break;
                            case 't': c = 'f'; break;
                           }
                    if (c=='.') { error("Invalid dot_character: ",2); CI; }
                    i_ptr++; d = *(i_ptr+1);
                  }
/* NEXT CHAR IS H */
    if ( (toupper(d) == 'H') && (!xlit) && (strchr("bcdfgjkptq",c)) )
       { if ( (isupper(d) && !cap_flag) || (!isupper(d) && cap_flag) )
              { error("Mixed case consonant: ",2); i_ptr++; CI; }
         else { c = toupper(c); i_ptr++; d = *(i_ptr+1); }
       }
/* TWO CHAR VOWELS */
    if ( strchr("aiu",c) && strchr("AIU", toupper(d)) )
       { if ( (isupper(d) && !cap_flag) || (!isupper(d) && cap_flag) )
            { error("Mixed case vowel: ",2); CI; }
         switch(c)
               { case 'a': switch(toupper(d))
                                 { case 'A': c = 'A'; break;
                                   case 'I': c = 'E'; break;
                                   case 'U': c = 'O'; break;
                                 } break;
                 case 'i': if (toupper(d) == 'I') c = 'I'; break;
                 case 'u': if (toupper(d) == 'U') c = 'U'; break;
               }
         if (isupper(c)) { i_ptr++; d = *(i_ptr+1); }
       }
/* FOUR CHAR VOWEL */
    if ( ( c=='x' || c=='w' ) && (d=='.') &&
         ( toupper(*(i_ptr+2))=='R' || toupper(*(i_ptr+2))=='L' ))
       { if ( (isupper(*(i_ptr+2)) && !cap_flag) || 
              (!isupper(*(i_ptr+2)) && cap_flag) )
            { i_ptr--; error("Mixed case vowel: ",4); i_ptr++; CI; }
         if ( c=='x' && toupper(*(i_ptr+2))=='R')
            { c='X'; i_ptr+=2; }
         if ( c=='w' && toupper(*(i_ptr+2))=='L')
            { c='W'; i_ptr+=2; }
       }
/* NOW CHAR SHOULD BE INTERNAL REPRESENTATION OF SANSKRIT CHAR */
    if ( ((c=='~'||c=='M'||c=='R') && !(ac_flag||svara_flag||nasal_vowel)) ||
         (c=='#' && !(ac_flag || svara_flag || ylv_flag))  )
         { if (xlit) 
              printf("Line %4d    Warning: No vowel before nasal\n",line_cnt);
           else
              { i_ptr -=2; error("No vowel for nasal: ",3); i_ptr +=2; CF; }
                          /* anusvara or yama must be after vowel or accent; */
                          /* candrabindu after vowel, accent or ylv          */
         }
    if (c=='H' && !(ac_flag || svara_flag))
       { if (xlit) 
            printf("Line %4d    Warning: No vowel before antahstha\n",line_cnt);
         else
            { i_ptr -=2; error("No vowel for antahstha: ",3); i_ptr +=2; CF; }
       }
    if (c=='Y' && !(ac_flag || svara_flag))
         printf("Line %4d    Warning: No vowel before avagraha\n",line_cnt);
    if (!strchr("ABCDEFGHIJKLMNOPQSTUVWXZ",toupper(c)) && !strchr("ry",c) && 
         underscore) { error("Invalid character after underscore",-1);
                       underscore = FALSE;
                     }
    if (underscore) chrcat(sktbuf,'_');
    if (cap_flag)   chrcat(sktbuf,'^');
    chrcat(sktbuf,c);
    CR;
    if (ISAC(c) || c=='\26') ac_flag = TRUE; 
/**/
    if (strchr("!\"%()&:;<=>?`\'\27\30\31\32\33\34\35\36\37",c) && c) 
        svara_flag = TRUE; 
    if ((c == 'y') || (c == 'l') || (c == 'v')) ylv_flag = TRUE;
    if (c == 'n') n_flag = TRUE; /* allow accents on letter 'n' */
    if (c == '~') vedic = TRUE;  /* allow accents on Vedic anusvaara */
    i_ptr++;
  }
}

#undef CI
#undef CC
#undef CR
#undef CF

/******************************************************************************/
/*                       CHRCAT                                               */
/******************************************************************************/

/* Function: append character c to end of buffer s                            */

void chrcat(char *s, char c)
{ char temp[] = " "; temp[0] = c; strcat(s,temp);
}

/******************************************************************************/
/*                       SKTCONT                                              */
/******************************************************************************/

/* Function: as sktword() but used where input text line ends in '%' to       */
/*           continue on next line.                                           */

void sktcont(void)
{
  if (sktbuf[0] == '\0') { cont_begin = FALSE; 
                           sktword(); 
                         }
  else                   { cont_end = TRUE; 
                           sktword();
                           cont_end = FALSE; 
                           cont_begin = TRUE;
                         }
}

/******************************************************************************/
/*                       SKTWORD                                              */
/******************************************************************************/

/* Function: convert contents of sktbuf to output string in outbuf            */

static char hal_chars[] = "BCDFGJKLNPQRSTVZbcdfghjklmnpqrstvyz";
                                              /* internal code for consonants */
#define ISHAL(c) (((strchr(hal_chars,c) != 0) && c) ? TRUE : FALSE)

#define CLRVADATA wid=top=bot=dep=rldep=fbar=fwh=bwh=ra=ya=bs=vaflg=0

#define CLRFLAGS \
ac_hook=post_ra=pre_ra=virama=bindu=candrabindu=accent=hal_flag=post_ya=0

#define VA(p,q,r,s,t,u,v,w,x,y,z) \
wid+=p; top=q; bot=r; dep=s; rldep=t; if(!vaflg){fbar=u; fwh=v;} bwh=w; \
ra=x; ya=y; strcat(work,z); vaflg++;

void sktword(void)
{ char c; 
  if (roman_flag && sktbuf[0]) roman_flag = FALSE;
#if DEBUG == 1

s_ptr = sktbuf;
while (*s_ptr)
{ if (*s_ptr >= ' ') chrcat(outbuf,*s_ptr++);
  else { chrcat(outbuf,'{'); chrcat(outbuf,'0'+((*s_ptr)/8)); 
         chrcat(outbuf,'0'+((*s_ptr++)%8)); chrcat(outbuf,'}'); }
/* CAT(outbuf,"^",*s_ptr++,""); */
}
  s_ptr = sktbuf; *s_ptr = '\0';
  return;

#else
  if (xlit || tech) { translit(); cont_begin = 0; return; }

/* A word is built up one syllable at a time: a syllable typically comprises  */
/* a consonant (or samyoga) followed by a vowel (with its nasalisation and    */
/* accents). If there is no consonant, then a front-vowel is output; if there */
/* is no vowel, then a viraama is appended to the consonant/samyoga.          */
/* One effect of this is that, if a consonant cluster is not fully resolved   */
/* into a single samyoga, it will be treated as two syllable: in particular,  */
/* the hook of the short-i will span one samyoga only.                        */
/*                                                                            */
/* The space between syllables is padded to produce (typically) 5 units of    */
/* separation (or `whiteness') between syllables (making use of the previous  */
/* syllable's trailing whiteness), and the back of the syllable is padded as  */
/* though at the end of a word, and its trailing whiteness stored.            */
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

  CLRVADATA;
  CLRFLAGS;
  s_ptr = sktbuf; c = *s_ptr;
  if (!cont_begin) { whiteness = 7; low_right = high_right = 0; }
  interspace = 6;
  if (option[2]) interspace = 5;
  if (option[3]) interspace = 4;
  intraspace = interspace;
  if (option[1]) intraspace--;
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
     if (ISAC(c) || strchr("/|\\~HY$)%*\37\26",c)) 
/**/
        { ac_char = c; 
          single(); 
          strcat(tmp,work);
          whiteness = bwh; *work = '\0'; cont_begin = 0;
          continue;
        }
     if (strchr("0123456789-@",c))
        { fixed(c); 
          strcat(tmp,work); 
          whiteness = bwh; *work = '\0'; cont_begin = 0;
          continue;
        }
     if (c == 'r') { pre_ra = TRUE; c = *s_ptr; }
     else s_ptr--;
     old_sptr = s_ptr; /* save pointer to start of samyoga                    */
     if (ISHAL(c)) { hal_flag = TRUE; CLRVADATA; samyoga(); c = *s_ptr; }
     ac_char = virama = 0; 
     if (!hr_flag) { if (ISAC(c)) { ac_char = *s_ptr++; }
                     else virama = TRUE;   /* hr_flag = h.r parsed by samyoga */
                   }
     if (virama && ISHAL(*s_ptr) && option[8]) sam_warning();
     backac(); hr_flag = FALSE;
     if (*tmp) { if (outbuf[0]=='\0' && tmp[0]=='[') strcat(outbuf,"{}");
                 strcat(outbuf,tmp); 
               }
     strcpy(tmp,work); whiteness = bwh;
     *work = '\0'; cont_begin = FALSE;
  }
  strcat(outbuf,work);
  s_ptr = sktbuf; *s_ptr = '\0';
  if (!cont_end && (low_right > 3) ) switch (low_right - 3)
                 { case  1: strcat(outbuf, "."); break;
                   case  2: strcat(outbuf, ":"); break;
                   case  3: strcat(outbuf, ";"); break;
                   case  4: strcat(outbuf, "+"); break;
                   default: strcat(outbuf, "+."); break;
                 }
  cont_begin = 0;
#endif
}

/******************************************************************************/
/*                         FIXED                                              */
/******************************************************************************/

/* Function: output fixed width (stand-alone) character to work buffer             */

void fixed(char c)
{
  switch(c)
  {  case '0':                     VA(12,0,0, 0,0,0, 3,2,0,0,"0");  break;  
     case '1':   if (option[61]) { VA(12,0,0, 0,0,0, 2,3,0,0,"@1"); break;}
                 else            { VA(12,0,0, 0,0,0, 3,2,0,0,"1");  break; }
     case '2':                     VA(12,0,0, 0,0,0, 2,2,0,0,"2");  break;
     case '3':                     VA(12,0,0, 0,0,0, 2,2,0,0,"3");  break;
     case '4':   if (option[64]) { VA(12,0,0, 0,0,0, 1,1,0,0,"@4"); break; }
                 else            { VA(12,0,0, 0,0,0, 2,2,0,0,"4");  break; }
     case '5':   if (option[75]) { VA(12,0,0, 0,0,0, 2,2,0,0,"@0"); break; }
                 if (option[65]) { VA(12,0,0, 0,0,0, 2,3,0,0,"@5"); break; }
                 else            { VA(12,0,0, 0,0,0, 3,2,0,0,"5");  break; }
     case '6':   if (option[66]) { VA(12,0,0, 0,0,0, 3,3,0,0,"@6"); break; }
                 else            { VA(12,0,0, 0,0,0, 2,2,0,0,"6");  break; }
     case '7':                     VA(12,0,0, 0,0,0, 2,2,0,0,"7");  break;
     case '8':   if (option[68]) { VA(12,0,0, 0,0,0, 2,2,0,0,"@8"); break; }
                 else              VA(12,0,0, 0,0,0, 2,3,0,0,"8");  break;
     case '9':   if (option[79]) { VA(12,0,5, 0,0,0, 2,3,0,0,"@2"); break; }
                 if (option[69]) { VA(12,0,5, 0,0,0, 2,3,0,0,"@9"); break; }
                 else              VA(12,0,5, 0,0,0, 2,3,0,0,"9");  break;
     case '-':   if (option[10] == 0) break;      /* discretionary hyphen */
                 switch (whiteness)                   
                   {  case 2: strcat(tmp,".");  break;
                      case 1: strcat(tmp,":");  break;
                      case 0: strcat(tmp,";");  break;
                   }
                 strcat(tmp,"\\-"); if (bwh < 3) bwh=3; break;
     case '@':   VA(10,0,0, 0,0,0, 3,3,0,0,"\\ZM{FTV}\\ZS{20}"); 
                 break;                                  /* continuation symbol  */
  }
  high_right = low_right = 0;
}

/******************************************************************************/
/*                       SINGLE                                               */
/******************************************************************************/

/* Function: process a front-vowel to workbuf                                 */

void single(void)
{ int k;
  k = pre_ra; CLRFLAGS; pre_ra = k;
  CLRVADATA;
  switch(ac_char)
  {  case 'a': if (option[40]) { VA(14,3,3, 0,0,0, 0,3,0,0,"`A"); break; }
               else            { VA(16,3,3, 0,0,0, 1,3,0,0,"A");  break; }
     case 'A': if (option[40]) { VA(14,3,3, 0,0,0, 0,3,0,0,"`A"); }
               else            { VA(16,3,3, 0,0,0, 1,3,0,0,"A"); }
               switch (intraspace)
               { case 6: strcat(work,";a");  break;
                 case 5: strcat(work,":a");  break;
                 case 4: strcat(work,".a");  break;
                 case 3: strcat(work,"a");   break;
               } break;
     case 'i': VA( 9,3,5, 0,0,0, 0,1,0,0,"I");    break;
     case 'I': VA( 9,3,5, 0,0,0, 0,1,0,0,"I"); pre_ra = TRUE; break;
     case 'u': if (whiteness < 7) { VA( 9,3,4, 0,0,0, 0,1,0,0,"\\ZS{-2}o"); }
               else               { VA(10,3,4, 0,0,0, 1,1,0,0,"o"); } 
               break;
     case 'U': if (whiteness < 7) { VA(14,7,7, 0,0,0, 0,1,0,0,"\\ZS{-2}`o"); }
               else               { VA(15,7,7, 0,0,0, 1,0,0,0,"`o");} 
               break;
     case 'x': if (option[41]) {
               VA(14,3,4, 2,0,0, 0,3,0,0,"`r");   break; }
               VA(15,8,8, 0,0,0, 0,1,0,0,"`x");   break;
     case 'X': if (option[41]) {
               VA(14,3,4, 4,0,0, 0,3,0,0,"`R");   break; }
               VA(16,9,9, 0,0,0, 0,2,0,0,"`X");   break;
     case 'w': VA(12,4,4, 0,0,0, 0,1,0,0,"`w");   break;
     case 'W': VA(12,4,4, 0,0,0, 0,2,0,0,"`W");   break;
     case 'e': VA(11,3,3, 0,0,0, 2,3,0,0,"O;");   break;
     case 'E': VA(11,3,3, 0,0,0, 2,3,0,0,"Oe;");  break;
     case 'o': if (option[40]) { VA(20,3,3, 0,0,0, 1,3,0,0,"`A"); }
               else            { VA(20,3,3, 0,0,0, 1,3,0,0,"A");  }
               switch (intraspace)
               { case 6: strcat(work,";ea");  break;
                 case 5: strcat(work,":ea");  break;
                 case 4: strcat(work,".ea");  break;
                 case 3: strcat(work,"ea");   break;
               } break;
     case 'O': if (option[40]) { VA(20,3,3, 0,0,0, 1,3,0,0,"`A"); }
               else            { VA(22,3,3, 0,0,0, 1,3,0,0,"A");  }
               switch (intraspace)
               { case 6: strcat(work,";Ea");  break;
                 case 5: strcat(work,":Ea");  break;
                 case 4: strcat(work,".Ea");  break;
                 case 3: strcat(work,"Ea");   break;
               } break;
     case '/':   VA(16,0,0, 0,0,0, 1,0,0,0,"?");  break;  /* pra.nava             */
     case '|':   VA( 6,0,0, 0,0,0, 6,0,0,0,"\\ZS{12}@A"); /* |                    */
                 if (*s_ptr == '|') 
               { VA( 3,0,0, 0,0,0, 6,0,0,0,"\\ZS{6}@A"); s_ptr++; }
                 break;
     case '\\':  VA(12,0,0, 0,0,0, 2,2,0,0,"H1"); break;  /* jihvaamuuliiya       */
     case '~':   switch (option[48] + option[48] + option[47] ) /* vedic anusvaara   */
                 { case 3:
                   case 2: VA(14,5,5, 1,0,0, 3,1,0,0,"`>");   break;
                   case 1: VA(10,3,3, 3,0,0, 0,3,0,0,".gM,a"); break;
                  default: VA(13,6,6, 0,0,0, 2,1,0,0,">");    break;
                 }
                 ac_char = virama = 0;
                 addhooks();
                 break;
     case 'H':   VA( 7,0,0, 0,0,0, 3,6,0,0,"H");          /* visarga              */
                 if (interspace==5) {strcat(work,"\\ZS{2}"); break;}
                 if (interspace>5) {strcat(work,"\\ZS{4}"); break;}
     case 'Y':   VA(12,0,0, 0,0,0, 2,3,0,0,"Y");  break;  /* avagraha             */
                 if (whiteness < 3) { CAT(tmp,"\\ZS{",2*(3-whiteness),"}"); }
                 break;
     case '$':   if (option[61]) { 
                 VA(12,0,0, 0,0,0, 2,3,0,0,"\\ZK{@1\\ZH{-12}{`7}\\ZH{-10}{`8}}");
                           break; }
                 VA(12,0,0, 0,0,0, 3,2,0,0,"\\ZK{1\\ZH{-12}{`7}\\ZH{-10}{`8}}"); 
                 break;
     case ')':   if (option[61]) { 
                 VA(12,0,0, 0,0,0, 3,3,0,0,"\\ZK{@1\\ZH{-10}{`8}}");
                           break; }
                 VA(12,0,0, 0,0,0, 3,2,0,0,"\\ZK{1\\ZH{-10}{`8}}"); 
                 break;
     case '*':
     case '%':   VA(12,0,0, 0,0,0, 3,2,0,0,"\\ZK{3\\ZH{-12}{`7}\\ZH{-8}{`8}}"); 
                 break;
     case '\37': VA(10,0,0, 0,0,0, 2,2,0,0,"\\ZK{`s}");
                 break;
     case '\26': VA(12,6,6, 0,0,0, 3,3,0,0,"\\ZS{24}"); /* test vocalic space */
                 break; 
/**/
     default:  error("Lost in single()",-1);
  }
  if ( (ac_char != '\26' ) && ( whiteness < 7) )
     { if (strchr("iIuUxXwWeE",ac_char) && ac_char)
       { switch (interspace - whiteness - fwh)
         { case 1: strcat(tmp,"."); break;
           case 2: strcat(tmp,":"); break;
           case 3: strcat(tmp,";"); break;
           case 4: strcat(tmp,"+"); break;
           case 5: strcat(tmp,"+."); break;
           case 6: strcat(tmp,"+:"); break;
       } }
       else if (interspace-whiteness-fwh > 0)
            { CAT(tmp,"\\ZS{",interspace-whiteness-fwh,"}"); }
     }
  ac_char = virama = 0;
  addhooks();
  autohyphen();
  high_right = low_right = 0;
}

/******************************************************************************/
/*                       SAM_WARNING                                          */
/******************************************************************************/

/* Function: print a warning message that a viraama will be used within a     */
/*           samyoga. Also print input file line number, together with an     */
/*           indication of the samyoga and where the viraama will be placed.  */

void sam_warning(void)
{ char *p, msg[80]="";
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
      case 'L': strcat(msg,"\"l"); break;
      case 'P': strcat(msg,"ph");  break;
      case 'T': strcat(msg,"th");  break;
      case 'f': strcat(msg,".t");  break;
      case 'F': strcat(msg,".th"); break;
      case 'N': strcat(msg,".n");  break;
      case 'q': strcat(msg,".d");  break;
      case 'Q': strcat(msg,".dh"); break;
      case 'R': strcat(msg,"\"m"); break;
      case 'S': strcat(msg,".s");  break;
      case 'V': strcat(msg,"~n");  break;
      case 'Y': strcat(msg,".a");  break;
      case 'z': strcat(msg,"\"n"); break;
      case 'Z': strcat(msg,"\"s"); break;
      default:  chrcat(msg,*p);    break;
    }
    if (++p == s_ptr) strcat(msg,"-");
  }
  if (ISAC(*p))
     { switch (*p)
       { case 'w': strcat(msg,".l"); break;
         case 'W': strcat(msg,".l.l"); break;
         case 'x': strcat(msg,".r"); break;
         case 'X': strcat(msg,".r.r"); break;
         case 'A': strcat(msg,"aa"); break;
         case 'E': strcat(msg,"ai"); break;
         case 'I': strcat(msg,"ii"); break;
         case 'O': strcat(msg,"au"); break;
         case 'U': strcat(msg,"uu"); break;
         default:  chrcat(msg,*p);   break;
       }
     }
  printf("Line %4d    Warning: samyoga viraama: %s\n",line_cnt,msg);
}         

/******************************************************************************/
/*                       ADDHOOKS                                             */
/******************************************************************************/

/* Function: append hooks to current symbol in workbuf; the hooks are:        */
/*           e-, ai- hooks; u-, .r-, .l-hooks; pre-ra hook,                   */
/*           bindu, candrabindu, viraama, and accents (udaatta etc.)          */

#define TOPHOOKS \
(ac_hook=='e' || ac_hook=='E' || pre_ra || bindu || candrabindu)

#define TOPACCENT \
(strchr("!(\":;<=>?\27",accent) && accent)

#define BOTHOOKS \
(virama || c=='U' || c=='X' || c=='W') 

void addhooks(void)
{ char c; int t, j, h, v;
  accent = bindu = candrabindu = 0;
  c = *s_ptr;
  if (c == '#') { candrabindu = TRUE; c = *++s_ptr; }
  if (strchr("!(\"&:;<=>?\27\30\31\32\33\34\35\36",c) && c) 
     { accent = c; c = *++s_ptr; }
  if (c == '#') { candrabindu = TRUE; c = *++s_ptr; }
  if ( (c == 'M') || (c == 'R') ) { bindu = TRUE; c = *++s_ptr; }
  t = h = v = j = 0;
  low_right = high_right = -wid;
  switch (ac_char)
  { case 'i': low_right = 1-(top-bwh+3); 
               low_left = 2;             break;
    case 'I': low_right = 1-(bwh+3);
               low_left = 2-(wid-top);   break;
    case 'e': low_right = 1-(top-bwh+3);
               low_left = 8-(wid-top);   break;
    case 'E': low_right = 1-(top-bwh+3);
               low_left = 9-(wid-top);   break;
    case 'o': low_right = 1-(top-bwh+3);
               low_left = 8-(wid-top);   break;
    case 'O': low_right = 1-(top-bwh+3);
               low_left = 9-(wid-top);   break;
    default:  low_right = 0-(top-bwh+3);
               low_left = 0-(wid-top);
  }
  if (TOPHOOKS)
     { if (top) { CAT(work,"\\ZH{-",(2*top),"}{"); }
       if (toupper(ac_hook) == 'E') chrcat(work,ac_hook);
       if (pre_ra) t+=4; if (bindu) t+=2; if (candrabindu) t+=1;
       if (t)
       { switch (t)
         { case 1: strcat(work, "<");             v=10; h=5; j=4; break;
           case 2: strcat(work, "M");             v=8;  h=2; j=1; break;
           case 3: strcat(work, "<\\ZV{10}{M}");  v=18; h=5; j=4; break;
           case 4: strcat(work, "R");             v=8;  h=2; j=2; break;
           case 5: strcat(work, "R1");            v=12; h=4; j=3; break;
           case 6: strcat(work, "R2");            v=8;  h=3; j=3; break;
           case 7: strcat(work, "R2\\ZV{10}{<}"); v=20; h=3; j=4; break;
         }
         h += (1-(top-bwh+3));
         if (low_right < h) low_right = h;
         j -= (wid-top);
         if (low_left < j) low_left = j;
       }
       if (top) strcat(work,"}");
     }
  if (strstr(work,".gM,a")) v=8; /* for accent above ~m with option 47 */
  if (TOPACCENT)
     { t = 0; if (option[4]) t = 8; if (option[5]) t = 12;
              if (option[4] && option[5]) t = 16;
       if (t < v) t = v;
       if (    (strchr("eioEIO",ac_char) && ac_char) 
            && (strchr("=>?\"\27",accent)  && accent)  )
          { v=8; if ((accent=='\"') || (accent=='\27')) v=3; }
       if (t < v) t = v;
       if (t)   { CAT(work,"\\ZV{",t,"}{"); }
       switch (accent)
       { case ':':  if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`1}}"); }
                    else strcat(work,"\\ZK{`1}");
                    h=2-(top-bwh+3); j=2-(wid-top); break;
         case ';':  if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`2}}"); }
                    else strcat(work,"\\ZK{`2}"); 
                    h=1+2-(top-bwh+3); j=1+2-(wid-top); break;
         case '<':  if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`3}}"); }
                    else strcat(work,"\\ZK{`3}"); 
                    h=1+2-(top-bwh+3); j=1+2-(wid-top); break;
         case '!' : if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`7}}"); }
                    else strcat(work,"\\ZK{`7}"); 
                    h=1+1-(top-bwh+3); j=1+1-(wid-top); break;
         case '(' : if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`0}}"); }
                    else strcat(work,"\\ZK{`0}"); 
                    h=1+3-(top-bwh+3); j=1+2-(wid-top); break;
         case '\"': if (top) { CAT(work,"\\ZH{-",(2*top)+3,"}{\\ZK{`7}}"); 
                               CAT(work,"\\ZH{-",(2*top)-3,"}{\\ZK{`7}}");
                               h=1+2-(top-bwh+3); j=1+2-(wid-top); 
                             }
                    else     { CAT(work,"\\ZH{-",(2*top)+6,"}{\\ZK{`7}}");
                               CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`7}}"); 
                               h=1+1-(top-bwh+3); j=1+4-(wid-top); 
                             }
                    break;
         case '=': if ( ((wid-top) >= 4) && ((top-bwh+3) >= 5) ) /* centre align */
                        { if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`4}}"); }
                          else strcat(work,"\\ZK{`4}"); 
                          h=5-(top-bwh+3); j=1+4-(wid-top); 
                        }
                   else { if ( (wid-bwh+3) >= 9 )             /* right alight */
                            { CAT(work,"\\ZH{-",2*(top+5-top+bwh-3),"}{\\ZK{`4}}");
                              h=1; j=1+9-(wid-bwh+3); 
                            }
                          else                                  /* left align */
                            { CAT(work,"\\ZH{-",2*(wid-4),"}{\\ZK{`4}}"); 
                              h=9-(wid-bwh+3); j=1+0; 
                        }   }
                   break;
         case '>': if ( ((wid-top) >= 4) && ((top-bwh+3) >= 5) ) /* centre align */
                        { if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`5}}"); }
                          else strcat(work,"\\ZK{`5}"); 
                          h=1+5-(top-bwh+3); j=1+4-(wid-top); 
                        }
                   else { if ( (wid-bwh+3) >= 9 )             /* right alight */
                            { CAT(work,"\\ZH{-",2*(top+5-top+bwh-3),"}{\\ZK{`5}}");
                              h=1+1; j=1+9-(wid-bwh+3); 
                            }
                          else                                  /* left align */
                            { CAT(work,"\\ZH{-",2*(wid-4),"}{\\ZK{`5}}"); 
                              h=1+9-(wid-bwh+3); j=1+0; 
                        }   }
                   break;
         case '?': if ( ((wid-top) >= 5) && ((top-bwh+3) >= 6) ) /* centre align */
                        { if (top) { CAT(work,"\\ZH{-",(2*top),"}{\\ZK{`6}}"); }
                          else strcat(work,"\\ZK{`6}"); 
                          h=1+6-(top-bwh+3); j=1+5-(wid-top);
                        }
                   else { if ( (wid-bwh+3) >= 11 )             /* right alight */
                            { CAT(work,"\\ZH{-",2*(top+6-top+bwh-3),"}{\\ZK{`6}}");
                              h=1+1; j=1+11-(wid-bwh+3); 
                            }
                          else                                  /* left align */
                            { CAT(work,"\\ZH{-",2*(wid-5),"}{\\ZK{`6}}"); 
                              h=1+11-(wid-bwh+3); j=1+0; 
                        }   }
                   break;
         case '\27': if (top) { CAT(work,"\\ZH{-",(2*top)+5,"}{\\ZK{`!}}");
                               h=1+3-(top-bwh+3); j=1+2-(wid-top); 
                             }
                    else     { CAT(work,"\\ZH{-",(2*top)+6,"}{\\ZK{`!}}"); 
                               h=1+2-(top-bwh+3); j=1+4-(wid-top); 
                             }
                    break;
       }
       if (t) strcat(work,"}"); 
       if (t>=8) { high_right = h; 
                   high_left = j; 
                 }
       else      { if (low_right < h) low_right = h;
                   if  (low_left < j)  low_left = j;
                 }
     }
  v = 0;
  c = toupper(ac_hook);
  if (BOTHOOKS)
     { if (bot) { CAT(work,"\\ZH{-",(2*bot),"}{"); }
       if ( (c=='X') || (c=='W') ) dep -= rldep; 
       if (dep>0) { CAT(work,"\\ZV{-",(2*dep),"}{"); }
       if (dep<0) { CAT(work,"\\ZV{",(2*(-dep)),"}{"); } 
       v=dep;
       if (virama) strcat(work,",");
       if (c == 'U' || c == 'X' || c == 'W') 
          { chrcat(work,ac_hook); 
            switch (ac_hook)
            { case 'u': dep+=6; break;
              case 'U': dep+=6; break;
              case 'x': dep+=8; break;
              case 'X': dep+=11; break;
              case 'w': dep+=10; break;
              case 'W': dep+=11; break;
            }
          }
       if (v) strcat(work,"}");
       if (bot) strcat(work,"}");
     }
  if ( (strchr("&\30\31\32\33\34\35\36",accent) && accent) || (*s_ptr=='%') )
     { if (dep > 2) { if (v<0) v=dep-2-v; 
                      else v=dep-2; }
       else v=dep;
       h=bot; if (h>3) h-=2;
       switch (accent)
       { case '\30': v+=8; h=bot;   break;
         case '\33': v+=5; h+=5;    break;
         case '\34': v+=5; h=bot+1; break;
         case '\35': v+=5; h+=1;    break;
         case '\36': v+=6; h=bot;   break;
       }
       if ( v &&  h) { CAT(work,"\\ZP{-",2*h,"}"); CAT(work,"{-",2*v,"}{"); }
       if ( v && !h) { CAT(work,"\\ZV{-",2*v,"}{"); }
       if (!v &&  h) { CAT(work,"\\ZH{-",2*h,"}{"); }
       switch (accent)
       { case '\30': strcat(work,"\\ZK{@r\\ZP{-3}{5}{@b}\\ZV{2}{@b}}"); break;
         case '\31': strcat(work,"\\ZK{`u}");   break;
         case '\32': strcat(work,"\\ZK{`z}");   break;
         case '\33': strcat(work,"\\ZK{@I@o}"); break;
         case '\34': strcat(work,"\\ZK{@M}");   break;
         case '\35': strcat(work,"\\ZK{@M\\ZS{-9}@M}");  break;
         case '\36': strcat(work,"\\ZK{@I\\ZV{2}{@I}}"); break;
         default:    strcat(work,"\\ZK{`8}"); break; /* for & or % accent */
       }
       if ( h||v ) strcat(work,"}");
     }
}   

/******************************************************************************/
/*                       BACKAC                                               */
/******************************************************************************/

/* Function: adjust inter-syllable spacing, add i-hooks, and set ac_hook      */
/*           before calling addhooks().                                       */

void backac(void)
{  int j,k; char c; 
   ac_hook = end_bar = 0;
   if (pre_ra && !hal_flag)            /* case r.r, r.R, r.l, r.L, ru, rU, ra */
     { c = toupper(ac_char);
       if ((c =='X') || (c == 'W')) {single(); return; }
       if (c == 'U')
          { if (ac_char == 'u') 
                 { CLRVADATA; VA( 8,5,4, 0,0,1, 1,0,0,0,"r8"); ac_char = 'a'; }
            else { CLRVADATA; VA(10,7,6, 0,0,1, 1,1,0,0,"r9"); ac_char = 'a'; }
          }
       else {      CLRVADATA; VA( 6,3,1, 0,0,1, 1,2,0,0,"="); }   /* ra      */
       pre_ra = FALSE; hal_flag = TRUE;
     }
   if (post_ra)      /* to insert post_ra here, then ya                       */
   { j = 0; k = dep; 
     if (ra==5) k -=3;
     if (bot) j++; if (k) j+=2;
     switch (j)
     { case 3: CAT(work,"\\ZP{-",(2*bot),"}"); 
               CAT(work,"{-",(2*k),"}{"); break;
       case 2: CAT(work,"\\ZV{-",(2*k),"}{"); break;
       case 1: CAT(work,"\\ZH{-",(2*bot),"}{"); break;
     }
     switch (ra)
     { case 1: strcat(work,"r");  if(rldep)rldep--; break;
       case 2: strcat(work,"r1"); rldep=1; dep +=4; break;
       case 3: strcat(work,"r2"); rldep=1; dep +=6; break;
       case 4: strcat(work,"@R"); if(rldep)rldep--; break;
       case 5: strcat(work,"r1"); rldep=1; dep +=1; break;
       case 6: strcat(work,"r4"); if(rldep)rldep--; break;
     }
     if (j) strcat(work,"}");
   }
   if (post_ya) 
   { switch (ya)
     { case 1: VA( 8,0,0, 0,2,0, 0,0,1,1,"y");  break;
       case 2: VA( 8,0,0, 0,1,0, 0,0,1,1,"y1"); break;
       case 3: VA( 5,0,0, 0,0,0, 0,0,0,0,"y2+."); break;
       case 4: VA( 5,0,0, 0,0,0, 0,0,0,0,"\\ZV{2}{y2}+."); break;
       case 5: break;
       case 6: VA( 9,0,0, 0,1,0, 0,0,1,1,".y1"); break;
     }
   }
/* adjust space at back of current syllable for vowels that add vert. bar,    */
/* and insert hook for long-i                                                 */
   if (wid && !top) end_bar = TRUE;    /* to append vertical bar to character */
   c = ac_char;
   if (c == 'I') { if (end_bar) {CAT(work,"i",intraspace,"");}/* add I-hook */
                   else { CAT(work,"\\ZH{-",(2*top),"}"); 
                          k = top - bwh + intraspace;       
                          if (k <= 9) { CAT(work,"{i",k,"}"); }
                          if ((k > 9) && (k <= 16)) { CAT(work,"{Y",k-10,"}"); }
                          if (k > 16) { strcat(work,"{i0");
                                      for (j = 17; j < k; j++) strcat(work,"/");
                                      strcat(work,"Y7}");
                                      }
                        }
                 }
   if (c=='I' || c=='A' || c=='o' || c=='O')
      { if (end_bar)                /* add vert. bar to basic character */
            { strcat(work,"a"); bwh=3; }
        end_bar = TRUE;
        switch(intraspace - bwh)
        {  case 1: strcat(work,"."); break;
           case 2: strcat(work,":"); break;
           case 3: strcat(work,";"); break;
           case 4: strcat(work,"+"); break;
           case 5: strcat(work,"+."); break;
           case 6: strcat(work,"+:"); break;
        }
        top = bot = 0; wid += intraspace; bwh = 0;
      }
/* now set ac_flag according to vowel                                         */
   if (c == 'o') ac_hook = 'e';
   if (c == 'O') ac_hook = 'E';
   if (strchr("uUeExXwW",c) && c) ac_hook = ac_char;
/* finally add all flags, accents, nasals, and final vertical as necessary    */
   j=low_right; k=high_right;     /* save interference from previous syllable */
   addhooks();
   if (end_bar) { strcat(work,"a"); bwh = 3; }
   if (virama) bwh++;               /* bring 'broken' samyoga closer together */
/* now adjust inter-syllable spacing, taking interference into account */
   j += low_left; /* space to add to eliminate interference */
   k += high_left;
   if (j<k) j = k;
   k = interspace - whiteness;
   if (ac_char != 'i') k -= fwh; /* basic inter-syllable spacing */
   if (j < k) j = k;
   if (whiteness==7 && ac_char=='i') 
       k = 3; /* short hor. before short-i-hook at start of a word */
   if (j < k) j = k;
   if (whiteness==7) k=fbar; /* short hor. before some chars at start of word */
   if (j < k) j = k;
   if ( (tmp[0] == '\0') && (work[0] == '=') && (j > 2) ) 
      { CAT(tmp,"\\ZS{",j-3,"}"); j=2; }   /* special case: rai at word start */
   switch (j)   /* add space to end of previous syllable */
   { case  1: strcat(tmp,"."); break;
     case  2: strcat(tmp,":"); break;
     case  3: strcat(tmp,";"); break;
     case  4: strcat(tmp,"+"); break;
     case  5: strcat(tmp,"+."); break;
     case  6: strcat(tmp,"+:"); break;
     case  7: strcat(tmp,"+;"); break;
     case  8: strcat(tmp,"*"); break;
     case  9: strcat(tmp,"*."); break;
     case 10: strcat(tmp,"*:"); break;
     case 11: strcat(tmp,"*;"); break;
     case 12: strcat(tmp,"*+"); break;
   }
   if (ac_char == 'i')
   { k = intraspace - fwh;
     if (k < 0) k = 0;
     k = k + wid - top;
     if (k <= 9) { CAT(tmp,"i",k,""); }              /* add short-i hooks */
     if ((k > 9) && (k <= 16)) { CAT(tmp,"Y",k-10,""); }
     if (k > 16) { strcat(tmp,"\\ZH{0}{i0");           /* add long i-hook */
                   for (j = 17; j < k; j++) strcat(tmp,"/");
                   strcat(tmp,"Y7}");
                 }
     k = intraspace - fwh;           /* add vert. and hor. bars to i-hook */
     switch (k)
     { case 6: strcat(tmp,"a;");  break;
       case 5: strcat(tmp,"a:");  break;
       case 4: strcat(tmp,"a.");  break;
       case 3: strcat(tmp,"a");   break;
       case 2: strcat(tmp,"@A:"); break;
       case 1: strcat(tmp,"@A."); break;
       default: strcat(tmp,"@A");
     }
   }
   autohyphen();
}

/******************************************************************************/
/*                       AUTOHYPHEN                                           */
/******************************************************************************/

/* Function: add discretionary hyphen string (\-) to work buffer if           */
/*           autohyphen (option[11]) is enabled.                          */

void autohyphen(void)
{
char *p;
   if (option[11] && *s_ptr!='\0' && ac_char 
                      && !(*s_ptr=='-'  && option[10]))
      { 
/*$$ assume that back-whiteness is 3 on entry
switch (bwh)
        { case 2: strcat(work,"."); break;
          case 1: strcat(work,":"); break;
          case 0: strcat(work,";"); break;
        }
        bwh = 3;
*/                            /* aim to have back whiteness = 3 */
        strcat(work,"\\-");
      }
}

/******************************************************************************/
/*                       SAMYOGA                                              */
/******************************************************************************/

/* Function: work along sktbuf sequentially to build up a samyoga print       */
/*           string in the work buffer and update the samyoga parameters.     */
/*                                                                            */
/*           The method is quite unsophisticated, but its simplicity lends    */
/*           clarity for later additions or changes, and for this reason      */
/*           is done in sanskrit alphabetical order, but with longer          */
/*           strings before shorter.                                          */

/* Macros are used to simplify reading the program --- believe it or not!     */
/*                                                                            */
/* Switch/case is used on the first letter, then the main LS macro tests:     */
/*   (1) if the ligature is enabled in option[b], and                         */
/*   (2) if the test string matches the input exactly, then                   */
/*   (3) update samyoga parameters with VA macro (defined before sktword())   */
/*   (4) bump input pointer to the character after string match               */
/*   (5) use NC etc macro to break out of switch instruction                  */

/* LS : if (string_match && option[a]) VA;                                    */
/* LT : if (string_match && option[a]) { if (option[b]) VA#1 else VA#2 }      */

#define LS(t,u,v,w) n=strlen(t);              \
        if((option[u]==0) && (strncmp(p,t,n)==0))  \
          { w; p+=n; v;}

#define LT(t,u,v,w,x,y,z) n=strlen(t);        \
        if((option[u]==0) && (strncmp(p,t,n)==0))  \
          { if(option[x]==0) { w; p+=n; v; }     \
                     else { z; p+=n; y; } }   

#define NX sam_flag = 'X'; break; 
#define NR sam_flag = 'R'; break; 
#define NC sam_flag = 'C'; break;

#define IX p++; sam_flag = 'X'; break; 
#define IR p++; sam_flag = 'R'; break; 
#define IC p++; sam_flag = 'C'; break; 

/******************************************************************************/

void samyoga(void)
{ 
char *p, sam_flag; int j,k,n;
 option[0] = 0;
 sam_flag = 0;
 p = s_ptr;
 while (1)
 { if (!ISHAL(*p)) { NX; }
   switch (*p++)
   { 
 case 'k':
  LT("kN",     0,NC,VA(33,0,0, 0,2,0, 0,0,6,1,"k1k1N"),
              44,NC,VA(33,0,0, 0,0,0, 0,0,2,1,"k1k1`N"));
  LT("kZr",    0,NR,VA(33,0,0, 0,0,0, 0,0,0,1,"k1k1)r"),
              51,NR,VA(33,0,0, 0,0,0, 0,0,0,1,"k1k1(r"));
  LS("kZ",     0,NR,VA(33,0,0, 0,0,0, 0,0,0,1,"k1k1Z"));
  LT("k",    101,NR,VA(10,4,4, 4,2,0, 0,0,2,4,"\\ZM{0NkLNPLPE00kL0PLhA}*:"),
             108,NR,VA(11,5,5, 4,2,0, 0,1,2,2,"\\ZM{0NkLNPLPE00kL0PLhA}*;"));
  LS("z",    102,NR,VA(11,5,6, 5,0,0, 0,1,2,0,"\\ZM{0NkLNPLPELNE00qP0M}*;"));
  LS("c",      0,NC,VA(21,0,0, 0,2,0, 0,0,6,1,"k1:c"));
  LS("tc",     0,NC,VA(28,0,0, 0,2,0, 0,0,6,1,"k1t:c"));
  LT("tr",   104,NR,VA(12,5,5, 5,1,0, 0,0,0,3,"k2\\ZP{-10}{-2}{r1}"),
             108,NC,VA(14,7,7, 5,1,0, 0,2,0,2,"k2\\ZP{-10}{-2}{r1}:"));
  if(option[104] && *p=='t' && *(p+1)=='r') {
                    VA(19,0,0, 0,1,0, 0,0,0,1,"k1+t4"); p++; IR;
                                            }
  LT("tv",     0,NR,VA(15,5,5, 2,2,0, 0,0,2,3,"k3"),
             105,NC,VA(25,0,0, 0,2,0, 0,0,6,1,"k1tv"));
  LT("t",    103,NR,VA(12,5,5, 1,0,0, 0,0,0,3,"k2"),
             108,NC,VA(14,7,7, 1,0,0, 0,2,0,2,"k2:"));
  LT("n",    106,NR,VA(10,4,4, 1,1,0, 0,0,3,4,"\\ZM{0NkLNPLPE0DnLDE}*:"),
             108,NC,VA(11,5,5, 1,2,0, 0,1,3,2,"\\ZM{0NkLNPLPE0DnLDE}*;"));
  LT("m",      0,NR,VA(20,3,3, 0,2,0, 0,3,2,2,"k4"),
             107,NC,VA(22,0,0, 0,2,0, 0,0,2,1,"k1m"));
  LT("y",      0,NR,VA(20,3,3, 0,1,0, 0,3,2,1,"ky2+.a"),
             108,NR,VA(20,0,0, 0,2,0, 0,0,1,1,"k1y"));
  LT("ry",     0,NR,VA(20,3,3, 0,1,0, 0,3,2,2,"k\\ZM{l0R}y2+.a"),
             108,NR,VA(20,0,0, 0,2,0, 0,0,1,1,"k1\\ZM{l0R}y"));
  if(*p=='r') { if (ISHAL(*(p+1)))    
                  { VA(12,6,6, 0,2,0, 0,0,0,0,"k1\\ZM{l0R}");IC; }
                    VA(12,6,6, 0,1,0, 0,0,0,0,"k\\ZM{l0R}"); IX; }
  if(option[46]==0) {
  LT("ly",   109,NR,VA(18,3,3, 0,2,0, 0,3,6,2,"*\\ZM{pNkdNPdPEdFIp0lBHy}+;a"),
             108,NR,VA(19,0,0, 0,2,0, 0,0,6,0,"\\ZM{0NkLNPLPELFI00l}*;y1"));
    if(*p=='l' && ISHAL(*(p+1)))
                  { VA(23,0,0, 0,0,0, 0,0,2,1,"k1l1"); IC; }
  LT("l",      0,NX,VA(10,4,3, 3,0,0, 0,0,2,4,"\\ZM{0NkLNPLPELFI00l}*:"),
             109,NX,VA(24,4,3, 0,0,0, 0,1,0,0,"k1l"));
                    }
  else {
  LT("ly",   109,NR,VA(20,3,3, 0,2,0, 1,3,6,2,"*\\ZM{lNk0NP00A0bEp0LFHy}*.a"),
             108,NR,VA(21,0,0, 0,2,0, 1,0,6,1,"\\ZM{DNkPNPP0APbE00L}*+.y1")); 
    if(*p=='l' && ISHAL(*(p+1)))
                  { VA(23,0,0, 0,2,0, 0,0,2,1,"k1l1"); IC; }
  LT("l",      0,NX,VA(12,4,4, 4,2,0, 1,0,2,4,"\\ZM{DNkPNPP0APbE00L}*+"),
             109,NX,VA(23,0,0, 0,2,0, 0,0,2,1,"k1l1")); }
  LT("v",    110,NR,VA(10,4,4, 4,1,0, 0,0,2,4,"\\ZM{0NkLNPLPE00kLhA}*:"),
             108,NC,VA(11,5,5, 4,1,0, 0,1,2,2,"\\ZM{0NkLNPLPE00kLhA}*;"));
  LT("S",      0,NC,VA(10,0,0, 0,0,0, 0,0,3,1,"["),
              49,NC,VA(10,0,0, 0,0,0, 1,0,3,1,"`["));
  if (ISHAL(*p))  { VA(12,6,6, 0,2,0, 0,0,6,1,"k1"); NC; }
                    VA(12,6,6, 0,2,0, 0,0,6,2,"k");  NX; 

 case 'K':
  LS("n",    111,NR,VA(12,3,3, 4,1,0, 0,3,2,2,"\\ZM{0NKFRIDbnMbeRbE}*.a"));
  if (ISHAL(*p))  { VA(12,0,0, 0,0,0, 0,0,3,1,"K."); NC; }
                    VA(11,0,0, 0,0,0, 0,0,0,0,"K");  NX;

 case 'g':
  LT("jV",     0,NC,VA(14,0,0, 0,0,0, 0,0,3,1,"g.]"),
              50,NC,VA(14,0,0, 0,0,0, 0,0,3,1,"g\\ZS{-2}`]"));
  LS("j",      0,NC,VA(14,0,0, 0,0,0, 0,0,3,1,"g\\ZS{-2}i"));
  LS("n",    112,NR,VA(10,3,3, 0,0,0, 0,3,2,2,"\\ZM{0NgFRI0FnIFe}+;a"));
                    VA( 7,0,0, 0,3,0, 0,0,6,1,"g"); NC;

 case 'G':
  LS("n",    113,NR,VA(12,3,3, 1,0,0, 2,3,2,2,"\\ZM{BNHMDeDDnR0ARbA}*+"));
                    VA( 7,0,0, 0,2,3, 0,0,1,1,"G"); NC;

 case 'z':
  LS("kty",    0,NX,VA(17,3,3, 7,0,0, 0,3,0,0,"*\\ZM{pPq0OMpBo0hYpktkcefbEffE0hyLnA}+:a"));
  LS("ktry",   0,NX,VA(17,3,3, 7,1,0, 0,3,0,0,"*\\ZM{pPq0OMpBo0hYpktkcefbEffE0hyLnAftrfnE}+:a"));
  LS("ktv",    0,NX,VA(12,4,4, 7,2,0, 1,1,0,0,"\\ZM{DPqTOM0BoUhYPbE0ltHfVPhEMBi}*+"));
  LS("kt",     0,NR,VA(10,4,5, 6,0,0, 0,1,3,0,"\\ZM{0PqPOM0BoPhY0ktEceJbEJfE}*:"));
  LT("kT",     0,NR,VA(19,3,3, 5,1,0, 0,3,2,2,"*.\\ZM{rPqbOMrbvhbwhdEBbTNdEh0I}\\ZS{10}:a"),
              45,NR,VA(19,3,3, 5,1,0, 0,3,2,2,"*.\\ZM{rPqbOMrbvhbwhdEBbTNdEh0I}+;a"));
  LS("ky",     0,NR,VA(18,3,3, 5,1,0, 0,3,2,2,"*\\ZM{pPq0OMpbvfdwfdEf0IBbYBbyNdE}+;a"));
  LS("kv",     0,NR,VA(10,4,5,11,2,0, 0,1,2,0,"\\ZM{0PqPOM0bvJbPJbE0nvJpE}*:"));
  LT("kSNv",  49,NX,VA(16,4,2,10,1,0, 1,1,0,0,"*\\ZM{p0xdPqLOMbbNbBILDIBnvLtAd0a}*"),
              44,NX,VA(18,4,2,12,1,0, 1,1,0,0,"*\\ZM{pBx0PqPOMbbOPBEErvPxAdBa}*:"));
  LT("kSN",   49,NX,VA(16,4,2, 5,2,0, 1,1,0,0,"*\\ZM{p0xdPqLOMbbNbBILBELdEd0a}*"),
              44,NX,VA(18,4,2, 5,0,0, 1,1,0,0,"*\\ZM{pBx0PqPOMbbOPBEPdEdBa}*:"));
  if (option[49]) {
  LT("kSNv",   0,NX,VA(17,4,2, 9,1,0, 1,1,0,0,"*\\ZM{pjXbPqNOM0bN0BINDIDlvNrA}*."),
              44,NX,VA(18,4,2,12,1,0, 1,1,0,0,"*\\ZM{phX0PqPOMbbOPBEFrvPxA}*:"));
  LT("kSN",    0,NX,VA(17,4,2, 4,2,0, 1,1,0,0,"*\\ZM{pbXbPqNOM0bN0BINDINbEN0E}*."),
              44,NX,VA(18,4,2, 5,0,0, 1,1,0,0,"*\\ZM{phX0PqPOMbbOPDIPdE}*:"));
                  }
  LT("kSm",    0,NR,VA(19,3,3, 5,2,0, 2,3,6,2,"*\\ZM{jPqfbeFOMpbxbbmIbiPdE}*a"),
              49,NR,VA(19,3,3, 6,2,0, 1,3,6,2,"*\\ZM{hPqHOMrjXdbmKbePfE}*a"));
  LT("kSy",    0,NR,VA(17,3,3, 6,1,0, 1,3,2,2,"*\\ZM{pPq0OMmdxbda0dY0dyLmA}+:a"),
              49,NR,VA(18,3,3, 6,2,0, 1,3,2,2,"*\\ZM{pPq0OMnhXB0YB0yNfE}+;a"));
  LT("kSv",    0,NX,VA(13,4,2, 6,0,0, 2,1,0,0,"\\ZM{FPqVOM0bxLcvVfEVBE}*+."),
              49,NX,VA(14,4,2, 5,0,0, 1,1,0,0,"\\ZM{HPqXOM0gXNbvXBEXdE}*+:"));
  LT("kS",     0,NR,VA(10,4,2, 7,0,0, 1,1,2,0,"\\ZM{0PqPOM0dxKdePnA}*:"),
              49,NR,VA(10,4,2, 6,0,0, 1,1,3,0,"\\ZM{0PqPOM0hXPBEPfE}*:"));
  LS("k",      0,NR,VA(10,4,5, 5,1,0, 0,1,2,0,"\\ZM{0PqPOM0bvJbPJbEJdE}*:"));
  LS("Kn",     0,NX,VA(11,4,2,11,1,0, 0,1,0,0,"\\ZM{BPqROM0bKRnAFAIDpnRvAMpe}*;"));
  LS("Ky",     0,NR,VA(18,3,3, 6,2,0, 0,3,2,2,"*\\ZM{nPqBOMpbKjBIBbyNmA}+;a"));
  LS("K",      0,NR,VA(11,4,2, 6,0,0, 1,1,3,0,"\\ZM{BPqROM0bKRBERfEFAI}*;"));
  LS("gm",     0,NR,VA(18,3,3, 3,1,0, 1,3,2,2,"*\\ZM{lPqpagdbmNbEjBIFOMIbe}+;a"));
  LS("gy",     0,NR,VA(16,3,3, 5,1,0, 0,3,2,2,"*\\ZM{pPq0OMpbgbdYbdyJdE}+.a"));
  LT("gl",     0,NR,VA(14,5,1, 5,0,0, 1,1,3,0,"\\ZM{FPqVOM00gFEILdlXDI}*+:"),
              46,NR,VA(17,3,3, 5,1,0, 1,3,2,2,"*\\ZM{lPqDOMp0gjBIddLLdE}+:a"));
  LS("gv",     0,NR,VA(12,4,2, 4,1,0, 1,1,2,2,"\\ZM{DPqTOM00gFBITbETDILbV}*+"));
  LS("g",      0,NR,VA(10,4,3, 5,2,0, 0,1,2,0,"\\ZM{0PqPOM0bgNaENdE}*:"));
  LS("Gy",     0,NR,VA(17,3,3, 4,2,0, 0,3,2,2,"*\\ZM{pPq0OMpbH0DI0bI00yLhA}+:a"));
  LS("G",      0,NR,VA(10,4,2, 5,1,0, 0,1,5,6,"\\ZM{0PqPOM0bHPBEPdE}*:"));
  LS("z",      0,NX,VA(10,4,5, 6,0,0, 0,1,0,0,"\\ZM{0PqPOM0bqPbM}*:"));
  LS("c",      0,NX,VA(11,4,2, 4,1,0, 1,1,0,0,"\\ZM{BPqROM0fcRBERbE}*;"));
  LS("j",      0,NX,VA(10,4,2, 4,0,0, 0,1,0,0,"\\ZM{0PqPOMbhjPdEPBE}*:"));
  LT("Nv",     0,NX,VA(10,4,2,10,1,0, 1,1,0,0,"\\ZM{0PqPOMBbNBBIPDIFnvPtA}*:"),
              44,NX,VA(11,4,2,11,0,0, 1,1,0,0,"\\ZM{BPqROMFAIRBERdE0bOFrkRxA}*;"));
  LT("N",      0,NX,VA(10,4,2, 4,2,0, 1,1,0,0,"\\ZM{0PqPOMBbNBBIPBEPbE}*:"),
              44,NX,VA(12,4,3, 5,0,0, 1,1,0,0,"\\ZM{DPqTOM0bOFBIRaERdE}*+"));
  LS("t",      0,NX,VA(10,4,3, 5,0,0, 1,1,0,0,"\\ZM{0PqPOMBhtI0eNcENaE}*:"));
  LS("D",      0,NX,VA(12,4,2, 3,1,0, 1,1,0,0,"\\ZM{DPqTOMD0DT0ETDI}*+"));
  LS("n",      0,NX,VA(10,4,3, 3,1,0, 0,1,0,0,"\\ZM{0PqPOM00nI0eNaE}*:"));
  LS("p",      0,NR,VA(10,4,3, 6,2,0, 1,1,4,0,"\\ZM{0PqPOMDapNfENAI}*:"));
  LS("By",     0,NR,VA(17,3,3, 5,0,0, 0,3,3,2,"*\\ZM{pPq0OMpdB0dY0dyLdE}+:a"));
  LS("B",      0,NX,VA(11,4,3, 4,2,0, 1,1,0,0,"\\ZM{BPqROM0bBPaEPbE}*;"));
  LS("m",      0,NR,VA(15,3,3, 4,2,0, 1,3,2,2,"\\ZM{0PqPOMDbmQbiX0AXhA}*+;"));
  LS("y",      0,NR,VA(16,3,3, 0,2,0, 0,3,2,2,"zy3a"));
  LS("rvy",    0,NR,VA(16,3,3, 3,1,0, 0,3,2,0,"\\ZM{0PqPOMD0vHbrN0yZ0E}*+.a"));
  LS("rv",     0,NX,VA(11,5,4, 7,1,0, 0,1,0,0,"z\\ZM{rfuhhEhdInhR}"));
  LT("l",      0,NX,VA(10,4,3, 5,0,0, 0,1,0,0,"\\ZM{0PqPOM0dlL0I}*:"),
              46,NX,VA(10,4,2, 5,1,0, 0,1,0,0,"\\ZM{0PqPOM0dLPBEPdE}*:"));
  LS("v",      0,NX,VA(11,5,4, 7,1,0, 0,1,0,0,"z\\ZM{rfuhhEhdI}"));
  LS("Z",      0,NX,VA(10,4,2, 5,0,0, 0,1,0,0,"\\ZM{0PqPOM00ZPdEPDI}*:"));
  LS("S",      0,NX,VA(10,4,3, 5,2,0, 1,1,0,0,"\\ZM{0PqPOMDaSNdENAI}*:"));
  LT("sT",     0,NR,VA(18,3,3, 5,1,0, 0,3,5,2,"*\\ZM{pPq0OMpbsebiBbTNjA}.\\ZS{8}:a"),
              45,NR,VA(18,3,3, 5,1,0, 0,3,5,2,"*\\ZM{pPq0OMpbsebiBbTNjA}+;a"));
  LS("sp",     0,NX,VA(13,4,1, 6,2,0, 0,1,0,0,"\\ZM{FPqVOM0bsNbpXfEXBEFEIIbe}*+."));
  LS("sv",     0,NX,VA(12,4,2, 5,1,0, 0,1,0,0,"\\ZM{DPqTOM0bsFBILbVTBETdE}*+"));
  LS("s",      0,NX,VA(11,4,2, 4,0,0, 0,1,0,0,"\\ZM{BPqROM0bsKbiRbERDI}*;"));
  LS("hy",     0,NX,VA(15,3,3, 7,0,0, 1,3,0,0,"\\ZM{0PqPOMDbhLhyXnA}*+a"));
  LS("hr",     0,NX,VA(10,4,4, 7,0,0, 1,1,0,0,"\\ZM{0PqPOMFbhEnMCpM}*:"));
  LS("h",      0,NX,VA(10,4,5, 7,0,0, 1,1,0,0,"\\ZM{0PqPOMDbh}*:"));
                    VA(11,5,6, 0,0,1, 0,1,2,5,"z"); NR;

 case 'c':
  LT("c",      0,NC,VA( 9,0,0, 0,0,0, 0,0,2,1,"c1"),
             114,NC,VA(15,0,0, 0,2,1, 0,0,6,1,".cc"));
  LT("V",      0,NC,VA(12,3,3, 2,2,0, 1,3,2,2,"\\ZM{0JcBBzRdA}*.a"),
             115,NR,VA(19,0,0, 0,2,1, 0,0,6,1,".c.V"));
  LS("tr",     0,NC,VA(14,0,0, 0,1,1, 0,0,0,1,".c;t4"));
  LS("n",    116,NR,VA(12,3,3, 1,1,0, 1,3,2,2,"\\ZM{0JcDDnMDeRDE}*.a"));
                    VA( 8,0,0, 0,2,1, 0,0,6,1,".c"); NC;

 case 'C':
  LS("n",      0,NR,VA(10,3,4, 4,1,0, 0,2,2,2,"\\ZM{0PC00nLbELAIG0e}*:"));
  LT("m",      0,NR,VA(15,3,3, 4,2,0, 0,3,2,2,"\\ZM{0PCDbmQbiXbEJ0I}*+a"),
             117,NR,VA(21,0,0, 0,2,0, 0,0,6,1,"C.m2"));
  LT("y",      0,NR,VA(18,3,3, 0,1,0, 0,3,2,2,"C1"),
             118,NR,VA(20,0,0, 0,2,0, 0,0,6,0,"C.y1"));
  LT("ry",     0,NR,VA(18,3,3, 0,1,0, 0,3,0,2,"C1\\ZH{-24}{r1}"),
             118,NR,VA(20,0,0, 0,2,0, 0,3,0,2,"C\\ZH{-14}{r1}.y1"));
  LT("l",      0,NX,VA(10,3,3, 5,0,0, 0,2,0,2,"\\ZM{0PC0dlLAI}*:"),
              46,NX,VA(10,3,2, 5,1,0, 0,2,0,2,"\\ZM{0PC0dLPdEPbIP0I}*:"));
  LS("v",      0,NR,VA(11,3,4, 7,1,0, 0,1,2,0,"C\\ZM{rguheEhhE}"));
                    VA(11,3,6, 0,0,0, 0,1,2,0,"C"); NR;

 case 'j':
  LT("jV",     0,NC,VA(18,0,0, 0,0,0, 0,0,3,1,"j\\ZM{cNe}.]"),
              50,NC,VA(18,0,0, 0,0,0, 0,0,3,1,"j\\ZS{-2}`]"));
  LS("jy",   119,NC,VA(20,0,0, 0,2,0, 1,0,6,2,"\\ZM{0Jj0djRdA}*.ay1"));
  if(*p=='j') { if (ISHAL(*(p+1)) || option[119]) {
                    VA(18,0,0, 0,0,0, 1,0,2,1,"j2"); IC; }
              else  VA(12,3,3, 2,0,0, 1,3,3,2,"\\ZM{0Jj0djRdA}*.a"); IR; }
  LT("J",      0,NR,VA(23,0,0, 0,0,0, 0,3,2,1,"jJ"),
              42,NR,VA(25,4,4, 0,2,0, 0,1,1,2,"j1`J"));
  LT("V",      0,NC,VA( 8,0,0, 0,0,0, 1,0,3,1,":]"),
              50,NC,VA( 8,0,0, 0,0,0, 0,0,3,1,"`]"));
  LS("n",    120,NR,VA(12,3,3, 1,1,0, 2,3,2,2,"\\ZM{0JjDDnMDeRDE}*.a"));
  if ( (strchr("CNPphSqrz",*p) && *p) || ISAC(*p) || *p=='\0' )
                  { VA(11,0,0, 0,0,1, 1,0,2,0,"j");  NC; }
                    VA(11,0,0, 0,0,1, 1,0,2,1,"j1"); NC;

 case 'J':
  if(option[42]) {
  LS("J",      0,NR,VA(25,3,3, 0,2,0, 0,1,1,2,"\\ZM{aXiFPE0LmRBYRXe}\\ZS{22}`J"));
  LS("n",      0,NR,VA(15,3,3, 0,0,0, 0,1,2,2,"B\\ZM{jFnHBYhLoaFe}:a"));
  LS("m",      0,NR,VA(24,3,3, 0,2,0, 0,3,4,2,"\\ZM{aXiFPE0LmRBYRXe}\\ZS{22}ma"));
  LT("l",      0,NR,VA(14,4,3, 3,0,0, 0,0,2,2,".\\ZM{cXiDRIbNmXDYF0lHNoRPERJE}\\ZS{12}+;"),
              46,NR,VA(14,4,4, 3,1,0, 0,0,2,2,"\\ZM{aXiFRI0NmZDYD0LJNoT0E}\\ZS{14};a."));
  LS("v",      0,NR,VA(14,4,4, 2,0,0, 0,1,2,2,"\\ZM{JBuTBE}`J"));
                    VA(14,4,4, 0,2,0, 0,1,4,2,"`J"); NR;
                 }
  else {
  LS("J",      0,NR,VA(27,3,3, 0,0,0, 0,3,4,2,"JJa"));
  LS("n",      0,NR,VA(12,3,3, 3,1,0, 1,3,2,2,"\\ZM{0PJBbnKbiRbE}*.a"));
  LS("m",      0,NR,VA(27,3,3, 0,2,0, 0,3,4,2,"Jam2a"));
  LS("y",      0,NR,VA(23,0,0, 0,2,0, 0,0,6,1,"Jay1"));
  if (*p=='u' || *p=='U')
                  { VA(12,0,1, 1,0,0, 0,0,2,2,"J"); NX; } 
                    VA(12,0,0, 0,0,0, 0,0,2,2,"J"); NC;
                 }

 case 'V':
  LS("cC",   121,NR,VA(20,3,7, 0,0,0, 1,1,2,0,"\\ZM{BOz0bc}*.C"));
  LS("cm",   121,NR,VA(21,0,0, 0,2,0, 1,0,4,1,"\\ZM{BOz0bc}*.am2"));
  LS("cv",   121,NR,VA(14,0,0, 0,1,0, 1,0,2,1,"*\\ZM{pOzcOi0JupccLDE}+:"));
  LT("c",      0,NC,VA(12,3,3, 3,1,0, 1,3,2,2,"\\ZM{BNz0dcRfA}*.a"),
             121,NC,VA(17,0,0, 0,2,0, 0,0,4,1,"Vc"));
  LT("jV",     0,NR,VA(16,0,0, 0,0,0, 0,0,3,1,"V]"),
              50,NR,VA(17,0,0, 0,0,0, 0,0,3,1,"V\\ZS{-2}`]"));
  LS("jm",   122,NR,VA(21,0,0, 0,2,0, 1,0,4,1,"\\ZM{BNz0djR0ARdA}*+m2"));
  LS("jv",   122,NR,VA(16,3,3, 2,2,0, 0,3,2,2,"\\ZM{0cj0OzMEiNJuZBEMOaLOi}*+.a"));
  LT("j",      0,NC,VA(12,3,3, 2,0,0, 1,3,2,2,"\\ZM{BNz0djR0ARdA}*+"),
             122,NC,VA(15,0,0, 0,0,0, 0,0,3,1,"V\\ZS{-6}i"));
  LS("V",    123,NR,VA(11,3,3, 2,0,0, 0,3,3,2,"\\ZM{0Oz0BzPBE}*a"));
  LS("n",    124,NR,VA(11,3,3, 0,1,0, 0,3,2,2,"\\ZM{0OzBFnKFe}*a"));
                    VA(10,0,0, 0,2,0, 0,0,6,1,"V"); NC;

 case 'f':
  LS("k",      0,NR,VA(10,4,5, 4,2,0, 1,1,2,2,"\\ZM{BPf00vJ0PJ0EJbE}*:"));
  LS("K",      0,NR,VA(10,4,1, 5,0,1, 1,1,3,2,"\\ZM{BPf00KRDERdEFBI}*:"));
  LS("c",      0,NR,VA(10,4,1, 3,0,0, 1,1,2,2,"\\ZM{BPf0fcRFER0E}*:"));
  LS("C",      0,NR,VA( 9,4,5, 5,0,1, 0,1,2,2,"\\ZM{0Pf00C}*."));
  LS("fy",     0,NR,VA(17,0,0, 0,0,0, 0,0,4,0,"\\ZM{0Pf00f}*.y1"));
  LS("f",      0,NR,VA( 8,3,4, 4,0,0, 0,0,2,2,"\\ZM{0Pf00f}*"));
  LS("Fy",     0,NR,VA(17,0,0, 0,0,0, 0,0,4,0,"\\ZM{0Pf00F}*.y1"));
  LS("F",      0,NR,VA( 8,3,4, 4,0,0, 0,0,2,2,"\\ZM{0Pf00F}*"));
  LS("Q",      0,NR,VA( 8,3,3, 4,0,0, 0,0,2,2,"\\ZM{0PfB0Q}*"));
  LT("N",      0,NR,VA( 8,3,0, 3,2,0, 0,0,2,2,"\\ZM{0PfC0NCCIP0EPDE}*"),
              44,NR,VA( 9,3,0, 4,0,1, 0,0,2,2,"\\ZM{BPf00OFBIRbERDE}*."));
  LS("tr",     0,NR,VA( 8,3,2, 5,1,0, 0,1,0,2,"\\ZM{0PfLdEL0ELhrB0w}*"));
  LS("ts",     0,NR,VA(12,3,0, 4,1,0, 1,0,2,2,"\\ZM{0ftG0sHPfXbEXFIQ0i}*+"));
  LS("t",      0,NR,VA( 8,3,1, 4,1,0, 0,1,0,2,"\\ZM{0PfBftIBeNbENAE}*"));
  LT("T",      0,NR,VA(15,3,3, 5,1,0, 0,3,2,2,"\\ZM{0PfLdTXjA}+:\\ZS{8}:a"),
              45,NR,VA(15,3,3, 5,0,0, 0,3,2,2,"\\ZM{0PfLdTXjA}*+a"));
  if ( *(p+1)=='x' || *(p+1)=='X' )
  { LS("d",    0,NR,VA( 8,3,1, 5,1,0, 0,1,4,2,"\\ZM{0PfB0d}*")); }
  else
  { LS("d",    0,NR,VA( 8,3,3, 3,0,0, 0,1,4,2,"\\ZM{0PfB0d}*")); }
  LS("n",      0,NR,VA( 8,3,1, 3,1,0, 0,1,2,2,"\\ZM{0Pf0BnIBeN0ENCI}*"));
  LS("p",      0,NR,VA( 8,3,2, 4,2,0, 0,1,4,2,"\\ZM{0PfBBpLbELBI}*"));
  LS("P",      0,NR,VA(10,5,4, 4,2,0, 0,1,4,2,"\\ZM{0PfBBpLbELBIL0P}*:"));
  LS("b",      0,NR,VA( 8,3,1, 5,1,0, 0,1,2,2,"\\ZM{0PfCbuNdENAEBbb}*"));
  LT("m",      0,NR,VA(14,3,3, 3,2,0, 0,3,2,2,"\\ZM{0PfB0mQ0eV0E}*;a"),
             125,NR,VA(20,0,0, 0,2,0, 0,0,4,2,"fm2"));
  LS("y",      0,NR,VA(19,0,0, 0,2,0, 0,0,2,2,"fy1"));
  LS("rv",     0,NR,VA(11,4,3, 6,0,1, 0,2,2,2,"f\\ZM{pfuffEnhR}"));
  LT("l",      0,NR,VA( 8,3,1, 4,0,0, 0,1,2,2,"\\ZM{0Pf0blLBI}*"),
              46,NR,VA( 8,3,0, 5,1,0, 0,0,2,2,"\\ZM{0Pf0bLPdEPDE}*"));
  LS("v",      0,NR,VA(11,4,3, 6,0,0, 0,3,2,2,"f\\ZM{pfuffE}"));
  LS("Zvy",    0,NR,VA(20,3,3, 4,2,0, 0,3,2,2,"*\\ZM{pBZd0VF0YF0ymPfRbE}*.a"));
  LS("Zv",     0,NR,VA(11,3,0, 4,1,0, 1,0,2,2,"\\ZM{0BZFPfLbvVbEVDE}*;"));
  LS("Z",      0,NR,VA( 8,3,0, 4,0,0, 0,0,2,2,"\\ZM{0Pf0BZPbEPFI}*"));
  LS("S",      0,NR,VA( 8,3,2, 4,2,0, 0,0,4,2,"\\ZM{0PfB0SLbELBI}*"));
  LS("st",     0,NR,VA(11,3,0, 4,0,0, 0,0,3,2,"\\ZM{00sNftVbEVDEFPfI0eFFE}*;"));
  LT("sl",     0,NR,VA(14,6,1, 3,0,1, 1,1,2,2,"\\ZM{FPf00sFFEL0lXFIVLa}*+:"),
              46,NR,VA(17,3,3, 3,1,1, 1,3,2,2,"*\\ZM{jPfp0sjFEd0LL0E}+:a"));
  LS("sv",     0,NR,VA(12,4,1, 3,1,1, 1,1,2,2,"\\ZM{FPf00sN0VV0EFFEVFII0e}*+"));
  LS("s",      0,NR,VA(10,3,1, 4,1,1, 0,1,2,2,"\\ZM{DPf00sK0iRbERCI}*:"));
                    VA(11,4,6, 0,0,0, 0,3,2,2,"f"); NR;

 case 'F':
  LS("F",      0,NR,VA( 8,3,4, 4,0,0, 0,0,2,6,"\\ZM{0PF00F}*"));
  LT("N",      0,NR,VA( 8,3,0, 3,1,0, 0,0,2,6,"\\ZM{0PFC0NCCIP0EPDE}*"),
              44,NR,VA( 9,3,0, 4,1,1, 1,0,2,6,"\\ZM{BPF00OFBIRbERDE}*."));
  LT("T",      0,NR,VA(15,3,3, 5,2,0, 0,3,4,2,"\\ZM{0PFLbTXjA}+:\\ZS{8}:a"),
              45,NR,VA(15,3,3, 5,2,0, 0,3,4,2,"\\ZM{0PFLbTXjA}*+a"));
  LS("n",      0,NR,VA( 8,3,1, 3,1,0, 0,0,2,6,"\\ZM{0PF0BnIBeN0ENAE}*"));
  LT("m",      0,NR,VA(14,3,3, 3,2,0, 0,3,2,2,"\\ZM{0PFB0mQ0eV0E}*;a"),
             126,NR,VA(21,0,0, 0,2,0, 0,0,4,2,"F:m2"));
  LT("y",      0,NR,VA(17,3,3, 0,1,0, 0,3,2,2,"F:y3a"),
             127,NR,VA(18,0,0, 0,2,0, 0,0,2,2,"Fy1"));
  LT("ry",     0,NR,VA(17,3,3, 0,1,0, 0,3,2,2,"F\\ZH{-10}{r1}:y3a"),
             127,NR,VA(18,0,0, 0,2,0, 0,0,2,2,"F\\ZH{-10}{r1}y1"));
  LT("l",      0,NR,VA( 8,3,1, 4,0,0, 0,0,2,6,"\\ZM{0PF0blLBI}*"),
              46,NR,VA( 8,3,0, 4,1,0, 0,0,2,6,"\\ZM{0PF0bLPbEPDE}*"));
  LS("v",      0,NR,VA(10,4,3, 7,1,0, 0,1,2,2,"F\\ZM{pfufgEfhE}"));
  LS("s",      0,NR,VA(10,3,1, 4,1,0, 1,0,2,6,"\\ZM{DPF00sK0iRAERbE}*:"));
                    VA(10,4,5, 0,0,0, 0,1,2,2,"F"); NR;

 case 'q':
  LS("gy",     0,NR,VA(16,3,3, 5,0,1, 1,3,2,2,"*\\ZM{pPqpbgbdYbdyJjA}+.a"));
  LS("g",      0,NR,VA( 8,2,1, 5,2,1, 1,1,2,6,"\\ZM{0Pq0bgNaENdE}*"));
  LS("Gr",     0,NR,VA( 8,2,0, 6,1,0, 1,0,0,6,"\\ZM{0Pq0bHPBEPdE}*\\ZV{-4}{r1}"));
  LS("G",      0,NR,VA( 8,2,0, 5,1,0, 1,0,4,6,"\\ZM{0Pq0bHPBEPdE}*"));
  LS("j",      0,NR,VA( 8,2,0, 5,1,1, 1,0,2,6,"\\ZM{0PqbhjPdEPBE}*"));
  LT("J",      0,NR,VA(11,3,3, 5,2,0, 1,1,2,2,"\\ZM{DPq00BPbEPdEO0eUjY}*;"),
              42,NR,VA( 9,2,0, 6,0,0, 1,0,3,6,"\\ZM{BPq0bJRBERfE}*."));
  LS("f",      0,NR,VA( 8,2,3, 5,0,0, 1,0,2,6,"\\ZM{0Pq0bf}*"));
  LS("qv",     0,NR,VA( 8,2,2,13,2,0, 1,0,2,6,"\\ZM{0Pq0bqDrVLtE}*"));
  LS("q",      0,NR,VA( 8,2,3, 6,0,0, 1,0,2,6,"\\ZM{0Pq0bq}*"));
  LS("Qv",     0,NR,VA( 8,2,2,12,1,0, 1,0,2,6,"\\ZM{0PqBbQDrVLsE}*"));
  LS("Q",      0,NR,VA( 8,2,3, 7,0,0, 1,0,2,6,"\\ZM{0PqBbQ}*"));
  LT("N",      0,NR,VA( 8,2,0, 5,2,0, 0,0,4,6,"\\ZM{0PqAbNADIPBEPdE}*"),
              44,NR,VA( 9,2,0, 5,0,1, 1,0,2,6,"\\ZM{DPq0bOFBIRBERdE}*."));
  LS("n",      0,NR,VA( 8,2,1, 4,2,0, 1,1,2,6,"\\ZM{0Pq00nI0eNbENaE}*"));
  LS("b",      0,NR,VA( 9,3,2, 7,1,0, 0,1,2,2,"q\\ZM{nfudhEddInfb}"));
  LS("By",     0,NR,VA(17,3,3, 5,1,0, 1,3,2,2,"*\\ZM{pPqpdB0dY0dyLjA}+:a"));
  LS("B",      0,NR,VA( 9,2,0, 4,2,0, 1,0,2,6,"\\ZM{BPq0bBRbERBEMbe}*."));
  LT("m",      0,NR,VA(14,3,3, 4,2,0, 1,3,2,2,"\\ZM{0PqDbmObiVbE}*;a"),
             128,NR,VA(23,3,3, 0,2,0, 0,3,6,2,"q:m2a"));
  LT("y",      0,NR,VA(16,3,3, 0,1,0, 0,3,2,2,"q:y3a"),
             129,NR,VA(20,3,3, 0,2,0, 0,3,6,2,"qy1a"));
  LT("l",      0,NR,VA( 8,2,1, 5,0,0, 1,0,3,6,"\\ZM{0Pq0dlL0I}*"),
              46,NR,VA( 8,2,0, 5,1,0, 1,0,2,6,"\\ZM{0Pq0dLPBEPdE}*"));
  LT("vy",     0,NR,VA(16,3,3, 0,0,0, 0,3,2,2,"q\\ZM{nfudhEddI}:y3a"),
             129,NR,VA(20,3,3, 0,0,0, 0,3,6,2,"q\\ZM{nfudhEddI}y1a"));
  LS("v",      0,NX,VA( 9,3,2, 7,1,0, 0,0,0,0,"q\\ZM{nfudhEddI}"));
                    VA( 9,3,4, 0,0,1, 0,1,2,2,"q"); NR;

 case 'Q':
  LS("Q",      0,NR,VA( 8,3,4, 6,0,0, 0,1,2,2,"\\ZM{0PQ0bQ}*"));
  LT("N",      0,NR,VA( 7,2,0, 4,2,0, 0,0,2,6,"\\ZM{0PQ0bN0FINBENbE}+;"),
              44,NR,VA( 9,2,0, 5,0,1, 1,0,2,6,"\\ZM{DPQ0bOFBIRBERdE}*."));
  LS("n",      0,NR,VA( 7,2,0, 4,2,0, 0,0,2,6,"\\ZM{0PQ00nNbEI0eNBE}+;"));
  LT("m",      0,NR,VA(13,3,3, 3,2,0, 0,3,2,2,"\\ZM{0PQB0mO0eT0E}*:a"),
             130,NR,VA(23,3,3, 0,2,0, 0,3,6,2,"Q.m2a"));
  LT("y",      0,NR,VA(16,3,3, 0,1,0, 0,3,2,2,"Q.y3a"),
             131,NR,VA(18,0,0, 0,2,0, 0,0,4,0,"Qy1"));
  LT("ry",     0,NR,VA(16,3,3, 0,1,0, 0,3,2,2,"Q.y3a\\ZH{-20}{r1}"),
             131,NR,VA(18,0,0, 0,2,0, 0,0,4,0,"Qy1\\ZH{-24}{r1}"));
  LT("l",      0,NR,VA( 8,3,1, 5,0,0, 0,1,2,2,"\\ZM{0PQ0dlLAI}*"),
              46,NR,VA( 8,2,0, 5,1,0, 1,0,2,6,"\\ZM{BPQ0dLPBEPdE}*"));
  LS("v",      0,NR,VA(10,3,3, 6,1,0, 0,2,2,2,"Q\\ZM{ffEpeu}"));
                    VA(10,3,5, 0,0,0, 0,2,2,2,"Q"); NR;

 case 'N':
  if (!option[44]) {
  LS("j",      0,NC,VA(17,0,0, 0,0,2, 0,0,3,1,"Ni"));
  LS("c",      0,NC,VA(17,0,0, 0,2,2, 0,0,6,1,"N.c"));
  LS("n",    132,NR,VA(12,3,3, 2,1,2, 0,3,2,2,"\\ZM{DBnMBeRdI}Na"));
  LS("ra",   133,NX,VA(16,3,3, 0,0,2, 0,2,0,0,"N.="); hr_flag = TRUE);
                    VA( 9,0,0, 0,2,2, 0,0,4,1,"N"); NC; }
  else { 
  LS("c",      0,NC,VA(18,0,0, 0,0,1, 0,0,6,1,"`N:c"));
                    VA( 9,0,0, 0,0,1, 0,0,3,1,"`N"); NC; }

 case 't':
  if (option[46]) {
  LS("kl",   109,NR,VA(17,4,4, 4,2,0, 1,0,2,4,"t\\ZM{0NkLNPL0ALbEd0L}*:"));
  LS("pl",   150,NR,VA(16,3,3, 4,1,2, 0,3,2,2,"tp\\ZM{pbL0bE}a"));
                  }
  LS("c",      0,NC,VA(16,0,0, 0,2,0, 0,0,6,1,"t:c"));
  LS("tr",     0,NR,VA(10,0,0, 0,0,0, 1,0,0,1,"\\ZM{0DtHLaaAb}+;t4"));
  LS("tn",   135,NR,VA(17,0,0, 0,2,0, 0,0,2,2,"tt2"));
  LS("t",    134,NC,VA(10,0,0, 0,0,0, 1,0,2,1,"t1"));
  LS("nv",   135,NR,VA(15,0,0, 0,2,0, 0,0,6,1,"t2\\ZM{bLu}+."));
  LS("n",    135,NR,VA(10,0,0, 0,2,0, 0,0,4,1,"t2"));
  LS("r",      0,NC,VA( 7,0,0, 0,0,0, 1,0,0,1,"t3"));
                    VA( 7,0,0, 0,0,0, 0,0,0,1,"t"); NC;

 case 'T':
  LT("n",    136,NR,VA(11,3,3, 2,1,0, 0,3,2,2,"T\\ZM{pBneBe0BE}a"),
              45,NR,VA(11,3,3, 2,1,0, 0,3,2,2,"`T\\ZM{pBneBe0BE}a"));
  LT("m",      0,NR,VA(17,0,0, 0,2,0, 0,0,6,1,"Tm1"),
              45,NR,VA(17,0,0, 0,2,0, 0,0,6,1,"`Tm1"));
  if (option[45]) { VA( 8,0,0, 0,2,0, 0,0,1,1,"`T"); NC; }
  else {            VA( 8,0,0, 0,2,0, 0,0,1,1,"T");  NC; }

 case 'd':
  LS("gy",   143,NR,VA(16,3,3, 2,1,0, 0,3,2,2,"d2\\ZM{rbgdByHBE}+a"));
  LS("gr",     0,NR,VA( 9,3,2, 7,1,1, 0,2,2,2,"d2\\ZM{rbgddE}\\ZP{-4}{-6}{r1}"));
  LS("g",      0,NR,VA( 9,3,2, 5,2,1, 0,2,2,2,"d2\\ZM{rbgddE}"));
  LS("Gr",     0,NR,VA(10,3,2, 5,1,0, 1,2,2,2,".d2\\ZM{t0HdbE}\\ZP{-4}{-2}{r1}"));
  LS("G",      0,NR,VA(10,3,2, 4,1,0, 1,2,2,2,".d2\\ZM{t0HdbE}"));
  LT("J",      0,NX,VA(10,3,2, 6,0,0, 1,2,3,2,".d2\\ZM{vaJddEdfE}"),
              42,NX,VA(13,5,4, 5,3,0, 1,2,4,2,":d2\\ZM{v0Bg0iBjYddE}:"));
  LS("qq",     0,NR,VA( 9,3,3,15,0,0, 0,2,2,2,"d2\\ZM{pbqptq}"));
  LS("q",      0,NR,VA( 9,3,3, 6,0,0, 0,2,2,2,"d2\\ZM{pbq}"));
  LS("Q",      0,NR,VA( 9,3,3, 7,0,0, 0,2,2,2,"d2\\ZM{ndQ}"));
  LS("db",     0,NR,VA( 8,3,4, 5,0,0, 0,2,2,2,"d1\\ZM{oekoeb}"));
  LS("dy",   137,NR,VA(15,3,3, 4,1,0, 0,3,2,2,"d1\\ZM{dbyHbE}+a"));
  LS("dvy",  138,NR,VA(15,3,3, 4,1,0, 0,3,2,2,"d1\\ZM{oekdbyHbE}+a"));
  LS("dv",     0,NR,VA( 8,3,4, 5,0,0, 0,2,2,2,"d1\\ZM{oek}"));
  if ( *(p+1)=='x' || *(p+1)=='X' )
  { LS("d",    0,NX,VA( 8,3,1, 2,1,0, 0,2,2,2,"d1")); }
  else
  { LS("d",    0,NR,VA( 8,3,4, 0,0,0, 0,2,2,2,"d1")); }
  LS("Dn",     0,NR,VA(12,3,2, 6,0,1, 1,2,2,2,";d2\\ZM{tBDrhnihedfE}"));
  LT("Dm",     0,NR,VA(19,3,3, 7,2,1, 1,3,2,2,";d2\\ZM{tBDjhmCheHnAdbE}+a"),
             139,NR,VA(24,3,3, 0,2,1, 1,3,6,2,";d\\ZM{t0Dj0b}m2a"));
  LS("Dy",   140,NR,VA(18,3,3, 3,2,1, 1,3,2,2,";d\\ZM{t0DfByF0E};a"));
  LS("Dry",  140,NR,VA(18,3,3, 3,2,1, 1,3,2,2,";d\\ZM{t0DfByF0EfjR};a"));
  LS("Dv",     0,NR,VA(12,3,1, 5,0,1, 1,3,2,2,";d\\ZM{t0Dhfv}"));
  LS("D",      0,NR,VA(12,3,5, 3,0,1, 1,3,2,2,";d\\ZM{t0Dj0b}"));
  LS("n",      0,NR,VA( 9,3,2, 3,1,1, 0,2,3,2,"d2\\ZM{r0ni0ed0E}"));
  LS("b",      0,NR,VA( 9,3,4, 3,0,0, 0,3,2,2,"d\\ZM{oaupabj0b}"));
  LS("By",   141,NR,VA(18,3,3, 3,2,1, 0,3,2,2,";d\\ZM{x0Bi0efByF0E};a"));
  LS("B",      0,NR,VA(12,3,2, 3,2,1, 0,2,2,2,";d2\\ZM{x0Bi0ed0E}"));
  LT("m",      0,NR,VA(16,3,3, 3,2,0, 0,3,2,2,"d2\\ZM{j0mC0eH0E}+a"),
             142,NR,VA(21,3,3, 0,2,0, 0,3,6,2,"dm2a"));
  LS("y",    143,NR,VA(15,3,3, 3,2,0, 0,3,2,2,"d\\ZM{fByF0E};a"));
  LS("ry",   143,NR,VA(15,3,3, 3,2,0, 0,3,2,2,"d\\ZM{fByF0Ehdr};a"));
  LS("rv",     0,NR,VA( 9,3,4, 4,0,1, 0,2,2,2,"d\\ZM{jdRnbu}"));
  if ( *(p+1)=='u' || *(p+1)=='U' )
  { LS("r",    0,NX,VA( 9,3,4, 1,0,0, 0,2,0,2,"d\\ZP{-8}{-4}{@R}")); }
  else
  { LS("r",    0,NR,VA( 9,3,4, 0,0,0, 0,2,0,2,"d\\ZP{-8}{-4}{@R}")); }
  LT("l",      0,NX,VA( 9,3,1, 5,0,0, 0,2,2,2,"d2\\ZM{pdl}"),
              46,NX,VA(10,3,2, 6,2,0, 1,2,2,2,".d2\\ZM{tdLdfE}"));
  LS("vy",   143,NR,VA(15,3,3, 3,2,0, 0,3,2,2,"d\\ZM{oaufByF0E};a"));
  LS("vry",  143,NR,VA(15,3,3, 3,1,0, 0,3,2,2,"d\\ZM{oaufByF0EinrhlIhnI};a"));
  LS("v",      0,NR,VA( 9,3,4, 3,0,0, 0,3,2,2,"d\\ZM{oau}"));
  if (*p=='x' || *p=='X')
                  { VA( 9,3,2, 1,2,0, 0,3,0,2,"d"); NX; }
  else            { VA( 9,3,5, 0,2,0, 0,3,0,2,"d"); NR; }

 case 'D':
  LS("nv",   144,NR,VA(18,3,3, 0,2,1, 1,3,6,2,"\\ZM{aXeDPGFGnPGe}\\ZS{18}va"));
  LS("n",    144,NR,VA(12,3,3, 1,0,0, 2,3,2,2,"\\ZM{0XiBNHMXeDDnRDENXiKDi}\\ZS{14}:a"));
  LS("m",      0,NR,VA(17,0,0, 0,2,3, 0,0,6,1,"Dm1\\ZM{cLe}."));
                    VA( 7,0,0, 0,2,3, 0,0,1,1,"D"); NC;

 case 'n':
  LS("c",    145,NR,VA(12,3,3, 0,0,0, 0,3,2,2,"\\ZM{00cBRnMRe}*.a"));
  LT("jv",     0,NR,VA(16,3,3, 0,2,0, 1,3,2,2,"\\ZM{0aj0QnKQiMGiNLu}*+.a"),
             146,NR,VA(19,0,0, 0,2,0, 1,3,4,1,"n\\ZS{-6}iv"));
  LT("j",      0,NR,VA(12,3,3, 0,0,0, 2,3,2,2,"\\ZM{00jDRnKRi}*.a"),
             146,NR,VA(13,0,0, 0,0,0, 1,0,3,1,"n\\ZS{-6}i"));
  LS("tt",   134,NR,VA(16,0,0, 0,0,0, 1,0,2,1,"\\ZM{0JnLJe}+:t1"));
  LS("tr",     0,NR,VA(13,0,0, 0,0,0, 1,0,0,1,"n:t4"));
  LS("dDy",  140,NR,VA(23,3,3, 3,1,0, 1,3,2,2,"+;\\ZM{nPnePibaDNaIN0yZ0E}d2+a"));
  LS("dD",     0,NR,VA(16,3,2, 5,1,0, 1,2,2,2,"+;\\ZM{nNnfNibdDNdE}d2"));
  LT("n",      0,NC,VA( 9,0,0, 0,1,0, 0,0,2,1,"n1"),
             147,NC,VA( 7,0,0, 0,1,0, 0,0,2,1,"\\ZM{0Rn0HnIReIHe}+;"));
  LS("my",     0,NR,VA(25,0,0, 0,0,0, 0,0,6,1,"nm1y"));
  LS("m",      0,NC,VA(18,0,0, 0,2,0, 0,0,6,0,"nm1\\ZM{cLe}."));
                    VA( 8,0,0, 0,2,0, 0,0,6,1,"n"); NC;

 case 'p':
  LS("tr",     0,NC,VA(12,0,0, 0,1,2, 0,0,0,1,"p;t4"));
  LS("t",    148,NC,VA( 7,0,0, 0,0,0, 0,0,0,1,"p1"));
  LS("n",    149,NR,VA( 9,3,3, 2,0,2, 0,3,2,2,"p\\ZM{lBn0BE}a"));
  LS("lv",   150,NR,VA(16,3,3, 5,1,0, 1,3,2,2,"\\ZM{0bLPbuZdE}+;pa"));
  LT("l",    150,NR,VA( 9,3,2, 4,0,2, 0,2,2,2,"p\\ZM{lbl0FI0PE};"),
              46,NR,VA(11,3,3, 4,1,2, 0,3,2,2,":p\\ZM{pbL0bE}a"));
  LS("Z",      0,NC,VA(16,0,0, 0,0,2, 0,0,3,1,"p.Z"));
                    VA( 6,0,0, 0,2,2, 0,0,1,1,"p"); NC;

 case 'P':
  LS("n",    151,NR,VA(11,5,5, 2,0,2, 0,1,2,3,"P\\ZM{vBnjBE}"));
  LS("y",    152,NR,VA(19,3,3, 0,1,2, 0,3,2,2,"Py2+.a"));
  if (*p=='r') { if (ISHAL(*(p+1))) {
                    VA(12,5,5, 0,1,2, 0,1,1,1,"P1\\ZH{-12}{r}"); IC; }
                    VA(11,5,5, 0,1,2, 0,1,1,1,"P\\ZH{-10}{r}");  IX; }
  if (ISHAL(*p)) {  VA(12,5,5, 0,2,2, 0,1,1,1,"P1"); NC; }
                    VA(11,5,5, 0,2,2, 0,1,1,1,"P"); NX;

 case 'b':
  LS("j",      0,NR,VA(15,0,0, 0,0,0, 0,0,3,1,"b.i"));
  LS("n",    153,NR,VA(10,3,3, 0,0,0, 0,3,2,2,"\\ZM{0Ok0Ob0FnIFe}+;a"));
  LS("b",    154,NR,VA(10,3,3, 2,1,0, 0,3,2,2,"\\ZM{0Ok0Ob0Bk0BbNdA}+;a"));
  LS("v",    155,NR,VA(10,3,3, 2,1,0, 0,3,2,2,"\\ZM{0Ok0Ob0BkNdA}+;a"));
  if (ISHAL(*p)) {  VA( 7,0,0, 0,0,0, 0,0,1,1,"b."); NC; }
                    VA( 6,0,0, 0,2,0, 0,0,1,1,"b");  NX;

 case 'B':
  LS("nv",   156,NR,VA(18,3,3, 0,2,0, 0,3,6,2,"B\\ZM{jGnbGi0Lu}+.a"));
  LS("n",    156,NR,VA(14,3,3, 0,0,0, 0,3,3,2,"B\\ZM{jFncLe}.a"));
  LS("m",      0,NR,VA(20,0,0, 0,2,0, 0,0,6,1,"Bm1\\ZM{cLe}."));
                    VA(10,0,0, 0,2,0, 0,0,1,1,"B"); NC;

 case 'm':
  if (option[46]) {
  LS("pl",   150,NR,VA(19,3,3, 4,1,2, 0,3,2,2,"m1.p\\ZM{qLepbL0bE}a"));
                  }
  LS("n",    157,NR,VA(14,3,3, 0,0,0, 0,3,2,2,"m1\\ZM{hFnaLe}:a"));
  LT("l",    158,NR,VA(13,2,1, 2,0,0, 0,1,2,6,"m1\\ZM{aLeDPEDFIhBl}+"),
              46,NR,VA(14,3,3, 5,1,0, 0,3,2,2,"m1\\ZM{aLeDdElbL}:a"));
  if (strchr("mr",*p) && *p)
                  { VA(10,0,0, 0,1,0, 0,0,4,1,"m"); NC; }
  if (strchr("lbByv",*p) && *p)
                  { VA( 9,0,0, 0,0,0, 0,0,1,1,"m1"); NC; }
  if (ISHAL(*p))  { VA(10,0,0, 0,3,0, 0,0,4,1,"m1\\ZM{cLe}."); NC; }
                    VA(10,0,0, 0,1,0, 0,0,4,1,"m"); NC; 
   
case 'y':
  if (!ya) {
  LS("n",    159,NR,VA(11,3,3, 2,0,0, 0,3,2,2,"y\\ZM{nBneBe0BE}a"));
                    VA( 8,0,0, 0,2,0, 0,0,1,1,"y"); }
  else {
    switch(ya)
    { case 6:  VA( 9,0,0, 0,1,0, 0,0,1,1,".y1" );         break;
      case 5:  break;
      case 4:  VA( 5,0,0, 0,0,0, 0,0,0,0,"\\ZV{2}{y2}+.");break;
      case 3:  VA( 5,0,0, 0,0,0, 0,0,0,0,"y2+.");         break;
      case 2:  VA( 8,0,0, 0,1,0, 0,0,1,1,"y1");           break;
      default: VA( 8,0,0, 0,2,0, 0,0,1,1,"y");            break;
    } }
  /* if nasalised ya with i-vowel, print as halanta */
  if(*p=='#'){if(aci(p)){strcat(work,"\\ZH{-6}{<}");IX;}
              strcat(work,"\\ZH{-6}{<}");IC;}
  NC;

case 'r': 
  j=0;
  if (ra)
     { k=dep; 
       if (ra==5) k-=3;
       if (bot) j++; if (k) j+=2; 
       switch (j)
       { case 3: CAT(work,"\\ZP{-",(2*bot),"}");
                 if (k<0) { k=-k; CAT(work,"{",(2*k),"}{");  break; }
                 else     {       CAT(work,"{-",(2*k),"}{"); break; }
         case 2: if (k<0) { k=-k; CAT(work,"\\ZV{",(2*k),"}{");  break; }
                 else     {       CAT(work,"\\ZV{-",(2*k),"}{"); break; }
         case 1: CAT(work,"\\ZH{-",(2*bot),"}{"); break;
     } }
  switch (ra)
    { case 6: strcat(work,"r4"); if(rldep) rldep--;   break;
      case 5: strcat(work,"r1"); rldep = 1; dep += 1; break;
      case 4: strcat(work,"@R"); if(rldep) rldep--;   break;
      case 3: strcat(work,"r2"); rldep = 1; dep += 6; break;
      case 2: strcat(work,"r1"); rldep = 1; dep += 4; break;
      case 1: strcat(work,"r" ); if(rldep) rldep--;   break;
    }
  if (j) strcat(work,"}"); 
  if(ra!=0) { ra=0; NC; }
  else {
      if(*p=='u') { VA( 8,5,4, 0,0,1, 0,0,0,0,"r8"); *p='a'; NX; }
      if(*p=='U') { VA(10,7,6, 0,0,1, 0,1,0,0,"r9"); *p='a'; NX; }
                    VA( 6,3,1, 0,0,1, 0,2,0,0,"="); NX; }

case 'l':
  if (option[160]==0) {
  LT("ly",     0,NX,VA(18,0,0, 0,2,0, 0,0,0,0,"l2:y1"),
              46,NX,VA(19,0,0, 0,2,0, 0,0,0,0,"\\ZM{0CL0MLPBE}++ay1"));
  LT("l",      0,NX,VA( 8,2,1, 1,0,0, 0,0,2,0,"l2"),
              46,NX,VA(11,3,3, 2,1,0, 0,3,2,0,"\\ZM{0CL0MLPBE}++a"));
                      }
  LS("r",     46,NX,VA(12,4,3, 4,1,0, 0,1,0,0,"l\\ZH{-6}{r1}"));
  /* if nasalised la with i-vowel, print as halanta */
  if (*p=='#') { if(aci(p)) { if (option[46]) { 
                    VA(11,0,0, 0,0,0, 0,0,2,1,"l1\\ZH{-8}{<}"); IX; }
                    VA(12,4,4, 0,0,0, 0,0,2,1,"l\\ZH{-8}{<}" ); IX; }
                    VA(11,0,0, 0,0,0, 0,0,2,1,"l1\\ZH{-8}{<}"); IC; }
  if (ISHAL(*p) || option[46])
                  { VA(11,0,0, 0,2,0, 0,0,2,1,"l1"); NC; }
                    VA(12,4,3, 0,0,0, 0,1,0,0,"l");  NX;

case 'v':
  LS("j",      0,NC,VA(14,0,0, 0,0,0, 0,0,3,1,"vi"));
  LS("n",    161,NR,VA(10,3,3, 0,1,0, 0,3,2,2,"\\ZM{0Ok0FnIFeN0A}+;a"));
  LS("v",    162,NR,VA(10,3,3, 2,1,0, 0,3,2,2,"\\ZM{0Ok0BkNdA}+;a"));
  /* if nasalised va with i-vowel, print as halanta */
  if (*p=='#') { if (aci(p)) {
                    VA( 6,0,0, 0,0,0, 0,0,0,0,"v\\ZH{-6}{<}");  IX; }
                    VA( 7,0,0, 0,0,0, 0,0,1,1,"v\\ZH{-6}{<}."); IC; }
  if (ISHAL(*p))  { VA( 7,0,0, 0,0,0, 0,0,1,1,"v."); NC; }
                    VA( 6,0,0, 0,2,0, 0,0,0,0,"v");  NX;

 case 'Z':
   if (option[51]) {
     if (option[52]) {
     if (*p=='x') { VA(12,3,3, 6,0,0, 0,0,0,0,")\\ZV{4}{x}a"); hr_flag=TRUE; IX;}
     if (*p=='X') { VA(12,3,3, 9,0,0, 0,0,0,0,")\\ZV{4}{X}a"); hr_flag=TRUE; IX;}
                     }
  LT("c",      0,NC,VA( 9,0,0, 0,0,0, 0,0,2,1,")\\ZM{rac0FI}"),
             163,NC,VA(17,0,0, 0,2,0, 0,0,4,1,"Z.c"));
  LS("n",    164,NR,VA(12,3,3, 0,1,0, 1,3,2,2,")\\ZM{pFngFi}a"));
  LS("r",      0,NC,VA( 9,0,0, 0,0,0, 0,0,1,1,")r"));
  LT("l",    165,NR,VA(12,3,2, 2,0,0, 1,2,2,2,")\\ZM{lBl0FI0PE};"),
              46,NR,VA(12,3,3, 3,1,0, 1,3,2,2,")\\ZM{pBL00E}a"));
  LS("v",    166,NC,VA(12,0,0, 0,1,0, 1,0,2,1,")\\ZM{dGu};"));
                    VA( 9,0,0, 0,0,0, 0,0,0,1,"Z"); NC;
                   }
  else {
     if (option[52]) {
     if (*p=='x') { VA(12,3,3, 6,0,0, 0,0,0,0,"(\\ZV{4}{x}a"); hr_flag=TRUE; IX;}
     if (*p=='X') { VA(12,3,3, 9,0,0, 0,0,0,0,"(\\ZV{4}{X}a"); hr_flag=TRUE; IX;}
                     }
  LT("c",      0,NC,VA( 9,0,0, 0,0,0, 0,0,2,1,"(\\ZM{rac0FI}"),
             163,NC,VA(17,0,0, 0,2,0, 0,0,0,0,"Z.c"));
  LS("n",    164,NR,VA(12,3,3, 0,1,0, 1,3,2,2,"(\\ZM{pFngFi}a"));
  LS("r",      0,NC,VA( 9,0,0, 0,0,0, 0,0,1,1,"(r"));
  LT("l",    165,NR,VA(12,3,2, 2,0,0, 1,2,2,2,"(\\ZM{lBl0FI0PE};"),
              46,NR,VA(12,3,3, 3,1,0, 1,3,2,2,"(\\ZM{pBL00E}a"));
  LS("v",    166,NC,VA(12,0,0, 0,1,0, 1,0,2,1,"(\\ZM{dGu};"));
                    VA( 9,0,0, 0,0,0, 0,0,0,1,"Z"); NC;
                   }

 case 'S':
  LS("fn",   167,NR,VA( 9,3,2, 6,0,2, 0,3,2,2,"S1\\ZM{rfnifeddEdfE}"));
  LT("fl",   167,NR,VA( 9,3,2, 8,0,2, 0,3,2,2,"S1\\ZM{rjlffIfdI}"),
              46,NR,VA( 9,3,2, 9,2,2, 0,2,2,2,"S1\\ZM{tjLdlEddE}"));
  LS("fv",   167,NR,VA( 9,3,3, 6,0,2, 0,3,2,2,"S1\\ZM{pfuffE}"));
  LS("f",    167,NR,VA( 9,3,5, 0,0,2, 0,3,2,2,"S1"));
  LT("Fy",   168,NR,VA(15,3,3, 0,1,2, 0,3,1,2,"S2.y3a"),
             127,NR,VA(17,0,0, 0,2,2, 0,0,2,0,"S2y1"));
  LT("Fry",  168,NR,VA(15,3,3, 0,1,2, 0,3,1,2,"S2\\ZH{-10}{r1}.y3a"),
             127,NR,VA(17,0,0, 0,2,2, 0,0,2,0,"S2\\ZH{-10}{r1}y1"));
  LS("Fv",   168,NR,VA( 9,3,3, 6,0,2, 0,2,2,2,"S2\\ZM{pfuffE}"));
  LS("F",    168,NR,VA( 9,3,5, 0,0,2, 0,2,2,2,"S2"));
  LS("n",    169,NR,VA( 9,3,3, 2,0,2, 0,3,2,2,"S\\ZM{lBn0dI}a"));
                    VA( 6,0,0, 0,2,2, 0,0,1,1,"S"); NC;

 case 's':
  if (option[46]) {
  LS("pl",   150,NR,VA(19,3,3, 4,1,2, 0,3,2,2,"s1.p\\ZM{qLepbL0bE}a"));
                  }
  LS("tt",   134,NC,VA(17,0,0, 0,0,1, 0,0,3,1,"s\\ZS{-6}t1"));
  LS("tr",     0,NC,VA(14,0,0, 0,1,1, 0,0,0,1,"s1:t4"));
  LS("nv",   170,NR,VA(19,3,3, 0,2,1, 0,3,6,2,"=\\ZM{fMo0HnHMu}*:a"));
  LS("n",    170,NR,VA(12,0,0, 0,1,1, 0,0,2,1,"=+:\\ZM{rMolHneHegMi}"));
  LS("r",      0,NC,VA(11,0,0, 0,0,1, 0,0,2,1,"s1\\ZM{aLeDDr}:"));
  if (strchr("sm",*p) && *p) {
                    VA(10,0,0, 0,0,1, 0,0,2,1,"s"); NC; }
  if (strchr("GZCJqNdDpPBrZSh",*p) && *p) {
                    VA(10,0,0, 0,0,1, 0,0,2,1,"s1\\ZM{cLe}."); NC; }
  if (ISHAL(*p))  { VA( 9,0,0, 0,0,1, 0,0,2,1,"s1"); NC; }
                    VA(10,0,0, 0,0,1, 0,0,2,1,"s"); NC;

case 'h':
  if (*p=='x') {    VA( 8,2,3, 4,0,0, 0,1,0,0,"h1"); hr_flag=TRUE; IX; }
  if (*p=='X') {    VA( 9,3,4, 4,0,0, 0,2,0,0,"h5"); hr_flag=TRUE; IX; }
  LT("N",      0,NR,VA(10,4,0, 3,0,0, 0,0,0,2,"h3\\ZM{m0NmDIfDI}"),
              44,NR,VA(12,6,0, 5,0,0, 0,0,0,2,"h4\\ZM{rcOlDIfDI0dE}"));
  LS("ny",     0,NR,VA(18,0,0, 0,0,0, 0,0,0,2,"h3\\ZM{nCneCe}y1"));
  LS("nv",     0,NR,VA(12,6,0, 9,0,0, 0,0,0,2,"h4\\ZM{qBngBillk0lE}"));
  LS("n",      0,NR,VA(10,4,0, 3,0,0, 0,0,0,2,"h3\\ZM{nCneCe}"));
  LS("b",      0,NR,VA(10,4,0, 3,0,0, 0,0,0,2,"h3\\ZM{mAkmAb}"));
  LS("my",     0,NR,VA(23,0,0, 0,2,0, 0,0,0,2,"h2y1"));
  LS("m",      0,NR,VA(15,3,3, 2,2,0, 0,3,0,2,"h2"));
  LS("y",      0,NR,VA(14,3,3, 2,0,0, 0,3,0,2,"h\\ZM{hByDBE}:a"));
  LS("ry",     0,NR,VA(14,3,3, 2,0,2, 0,3,0,2,"h\\ZM{hByDBEojr}:a"));
  LS("r",      0,NR,VA( 9,3,5, 4,0,2, 0,3,0,2,"h\\ZM{ojr}"));
  LS("l",      0,NR,VA(12,6,0, 4,0,0, 0,0,0,2,"h4\\ZM{p0L}"));
  LS("v",      0,NR,VA(10,4,0, 3,0,0, 0,0,2,2,"h3\\ZM{mAk}"));
                    VA( 9,3,4, 4,0,0, 0,3,0,2,"h"); NX; 

 case 'L': 
  if (option[43]) { if (*p=='h') {
                    VA(10,0,0, 0,2,0, 0,0,2,1,"L2");  NC; }
                    if(ISHAL(*p)) { 
                    VA(11,0,0, 0,0,0, 0,0,2,1,"L2."); NC; }
               else VA(10,0,0, 0,2,0, 0,0,2,1,"L2");  NC; }
  if(ISHAL(*p))   { VA(10,3,3, 0,0,0, 0,0,3,1,"L1");  NC; }
                    VA(10,3,3, 0,3,0, 0,0,3,1,"L" );  NX;

 default: error("Lost in samyoga()",-1); NX;
   }
   if (sam_flag == 'X') { s_ptr = p; break; }
   if (sam_flag == 'R') { if ((*p=='r') && ra) { post_ra = TRUE; p++; }
                          if ((*p=='y') && ya) { post_ya = TRUE; p++; }
                          s_ptr = p; break;
                        }
   if (!ISHAL(*p)) { s_ptr = p; break; }
  }  
}

/******************************************************************************/
/*                       ACI                                                  */
/******************************************************************************/

/* Function: test for short-i following samyoga                               */

int aci(char *p)
{ int j;
  for (j=0; j<6; j++) if (!ISHAL(*(p+j))) break;
  if (*(p+j) == 'i') return(TRUE);
  else return(FALSE);
}

/******************************************************************************/
/*                       TRANSLIT                                             */
/******************************************************************************/

/* Function: transliterate contents of sktbuf, output result in outbuf        */

#define SWITCHFLAG(Y,Z) switch(flag)                                        \
            {  case 0: strcat(outbuf,Y); break;                             \
               case 1: if (tech) strcat(outbuf,"\\ZX{"); strcat(outbuf,Z);  \
                       if (tech) strcat(outbuf,"}"); break;                 \
               case 2: strcat(outbuf,"\\ZW{"); strcat(outbuf,Y);            \
                       strcat(outbuf,"}"); break;                           \
               case 3: strcat(outbuf,"\\ZY{"); strcat(outbuf,Z);            \
                       strcat(outbuf,"}"); break;                           \
             } flag=0

#define XLIT(X,Y,Z) case X: SWITCHFLAG(Y,Z); break

#define STACK(X,Y,Z) case X: ISTACK(X,Y,Z)

#define ISTACK(X,Y,Z) c=0; if(*p=='#'){c+=30; if(option[38]) c+=30; p++;}  \
         switch(*p)                                                        \
         {case'\27': c++; case'\30': c++;                                  \
          case'\37': c++; case'\36': c++; case'\35': c++; case'\34': c++;  \
          case'\33': c++; case'\32': c++; case'\31': c++; case'*': c++;    \
          case')': c++;  case'?':  c++;  case'>': c++;  case'=':  c++;     \
          case'<': c++;  case';':  c++;  case':': c++;  case'\'': c++;     \
          case'`': c++;  case'\"': c++;  case'(': c++;  case'$':  c++;     \
          case'%': c++;  case'&':  c++;  case'!': c++; p++;}               \
         if(*p=='#'){c+=30; if(option[38]) c+=30; p++;}                    \
         if (c != 0) { CAT(outbuf,"\\ZA{",c,"}{"); }                       \
         SWITCHFLAG(Y,Z);                                                  \
         if (c != 0) strcat(outbuf,"}");                                   \
         if(ISAC(X))                                                       \
         { if (ISAC(*p))                                                   \
           strcat(outbuf,"\\ZS{1}\\raisebox{.4ex}{.}\\ZS{-1}");\
           else { if(option[11] && (*p!='\0') && !(*p=='-' && option[10])) \
                      strcat(outbuf,"\\-"); }                              \
         }                                                                 \
         break

#define NASAL(X,Y,Z) case X: if (*p == '#') strcat(outbuf,"\\~{");         \
                             SWITCHFLAG(Y,Z);                              \
                             if (*p == '#') { strcat(outbuf,"}"); p++; }   \
                             break       

void translit(void)
{ 
int save, flag = 0;
char c, *p;
 p = s_ptr;
 while (*p)
 { switch (*p++)
  { 
   case '^':  flag = flag | 1; break;
   case '_':  flag = flag | 2; break;
   case '-':  if(option[10]) strcat(outbuf,"\\-"); break;
   case '|':  if (xbold) { if (*p=='|') 
                   { strcat(outbuf,"{\\upshape\\boldmath\\,$\\mid\\mid$}"); 
                     p++; break; }
                   strcat(outbuf,"{\\upshape\\boldmath\\,$\\mid$}"); 
                   break; }
              if (*p=='|') { strcat(outbuf,"{\\upshape\\,$\\mid\\mid$}"); 
                   p++; break; }
              strcat(outbuf,"{\\upshape\\,$\\mid$}"); break;

   case '@':  if (xbold) { strcat(outbuf,"{\\upshape\\boldmath$^\\circ$}");
                   break; }
              strcat(outbuf,"{\\upshape$^\\circ$}"); break;

   case '/':  if (option[37]) { SWITCHFLAG("AUM","AUM"); break; }
              if (option[36]) { SWITCHFLAG("A{\\relsize{-3}UM}","A{\\relsize{-3}um}"); break; }
              if (option[35]) { SWITCHFLAG("OM","OM"); break; }
              if (option[34]) { SWITCHFLAG("O{\\relsize{-3}M}","O{\\relsize{-3}M}"); break; }
              if (option[33]) { SWITCHFLAG("Om","Om"); break; }
              SWITCHFLAG("O\\~m","O\\~M"); break;

   case '\\': if (option[32]) { SWITCHFLAG("\\b h","\\b H"); break; }
              SWITCHFLAG("\\ZZ h","\\ZZ H"); break;

   case '~':  if (option[20]) { ISTACK('~',"\\d m","\\d M"); break; }
              if (option[21]) { ISTACK('~',"\\.m","\\.M"); break; }
              ISTACK('~',"\\d{\\~m}","\\d{\\~M}"); break;

   XLIT('0',"0","0");        XLIT('1',"1","1");     XLIT('2',"2","2");
   XLIT('3',"3","3");        XLIT('4',"4","4");     XLIT('5',"5","5");
   XLIT('6',"6","6");        XLIT('7',"7","7");     XLIT('8',"8","8");
   XLIT('9',"9","9");

   XLIT('b',"b","B");        XLIT('c',"c","C");     XLIT('d',"d","D");
   XLIT('f',"\\d t","\\d T"); XLIT('g',"g","G");     XLIT('h',"h","H");
   XLIT('j',"j","J");        XLIT('k',"k","K");     XLIT('m',"m","M");
   STACK('n',"n","N");       XLIT('p',"p","P");     XLIT('q',"\\d d","\\d D");
   XLIT('r',"r","R");        XLIT('s',"s","S");     XLIT('t',"t","T");
   XLIT('z',"\\.n","\\.N");        
      
   XLIT('B',"bh","BH");         XLIT('C',"ch","CH"); XLIT('D',"dh","DH");
   XLIT('F',"\\d th","\\d TH"); XLIT('G',"gh","GH"); XLIT('H',"\\d h","\\d H");
   XLIT('J',"jh","JH");         XLIT('K',"kh","KH"); 
   XLIT('N',"\\d n","\\d N");   XLIT('P',"ph","PH"); XLIT('Q',"\\d dh","\\d DH");
   XLIT('T',"th","TH"); XLIT('V',"\\~n","\\~N");
   
   case 'S':  if (option[28]) { SWITCHFLAG("sh","SH"); break; }
              SWITCHFLAG("\\d s","\\d S"); break;

   case 'Y':  if (xbold) { SWITCHFLAG("\\,{\\boldmath $^\\prime\\kern-.1em$}",
                             "\\,{\\boldmath $\\prime\\kern-.1em$}"); break; }
              SWITCHFLAG("\\,$^\\prime\\kern-.1em$",
                             "\\,$^\\prime\\kern-.1em$"); break;

   case 'Z':  if (option[27]) { SWITCHFLAG("\\.s","\\.S"); break; }
              SWITCHFLAG("\\'s","\\'S"); break;

   NASAL('l',"l","L");          NASAL('v',"v","V");  NASAL('y',"y","Y");

   case 'M':  if (option[22]) { SWITCHFLAG("\\.m","\\.M"); break; }
              SWITCHFLAG("\\d m","\\d M"); break;

   case 'L':  if (option[31]) { SWITCHFLAG("\\b d","\\b D"); break; }
              if (option[30]) { SWITCHFLAG("\\b l","\\b L"); break; }
              if (option[29]) { SWITCHFLAG("\\d l","\\d L"); break; }
              SWITCHFLAG("\\ZZ d","\\ZZ D"); break;

   case 'R':  if (option[24]) { SWITCHFLAG("\\b n","\\b N"); break; }
              if (option[23]) { SWITCHFLAG("\\d m","\\d M"); break; }
              SWITCHFLAG("\\.m","\\.M"); break;

   /* now for the vowels with stacked nasal and accent                     */

   case 'i': if (strchr("!`'\"(#\27",*p) && *p) { ISTACK('i',"{\\i}","I"); }
             else { ISTACK('i',"i","I"); } break;
   case 'E': if (strchr("!`'\"(#\27",*p) && *p) { ISTACK('E',"{a\\i}","AI"); }
             else { ISTACK('E',"ai","AI"); } break;
   

   STACK('a',"a","A");           STACK('u',"u","U");
   STACK('e',"e","E");           STACK('o',"o","O");

   STACK('A',"\\=a","\\=A");     STACK('I',"\\={\\i}","\\=I"); 
   STACK('U',"\\=u","\\=U");     STACK('O',"au","AU");         

   STACK('\26'," "," ");

   case 'w': if (option[26])
             { save = flag; SWITCHFLAG("lr\\llap{\\d{\\kern.51em}}","L\\d R");
               flag = save; if ( strchr("!\"#$%&'():;<=>?`",*p) && *p)
                               { ISTACK('w',"{\\i}","I"); break; }
                            ISTACK('w',"i","I"); break; }   
             ISTACK('w',"\\d l","\\d L"); break;

   case 'W': if (option[26])
             { save = flag; SWITCHFLAG("lr\\llap{\\d{\\kern.51em}}","L\\d R");
               flag = save; ISTACK('W',"\\={\\i}","\\=I"); break; }
             ISTACK('W',"\\d{\\=l}","\\d{\\=L}"); break;

   case 'x': if (option[25])
             { save = flag; SWITCHFLAG("r\\llap{\\d{\\kern.51em}}","\\d R");
               flag = save; if (strchr("!\"#$%&'():;<=>?`",*p) && *p)
                               { ISTACK('x',"{\\i}","I"); break; }
                            ISTACK('x',"i","I"); break; }   
             ISTACK('x',"r\\llap{\\d{\\kern.51em}}","\\d R"); break;

   case 'X': if (option[25])
             { save = flag; SWITCHFLAG("r\\llap{\\d{\\kern.51em}}","\\d R");
               flag = save; ISTACK('X',"\\={\\i}","\\=I"); break; }
             ISTACK('X',"\\=r\\llap{\\d{\\kern.51em}}","\\d{\\=R}"); break;

   default: error("Lost in translit()",-1); 
break;
  }  
 }
 s_ptr = sktbuf; *s_ptr = '\0'; cont_begin = 0;
}

/******************************************************************************/
/*                       ITI                                                  */
/******************************************************************************/
