#define EXTERN extern
#include "texd.h"

void 
#ifdef HAVE_PROTOTYPES
initialize ( void ) 
#else
initialize ( ) 
#endif
{
  initialize_regmem 
  integer i  ;
  integer k  ;
  hyphpointer z  ;
  xchr [32 ]= ' ' ;
  xchr [33 ]= '!' ;
  xchr [34 ]= '"' ;
  xchr [35 ]= '#' ;
  xchr [36 ]= '$' ;
  xchr [37 ]= '%' ;
  xchr [38 ]= '&' ;
  xchr [39 ]= '\'' ;
  xchr [40 ]= '(' ;
  xchr [41 ]= ')' ;
  xchr [42 ]= '*' ;
  xchr [43 ]= '+' ;
  xchr [44 ]= ',' ;
  xchr [45 ]= '-' ;
  xchr [46 ]= '.' ;
  xchr [47 ]= '/' ;
  xchr [48 ]= '0' ;
  xchr [49 ]= '1' ;
  xchr [50 ]= '2' ;
  xchr [51 ]= '3' ;
  xchr [52 ]= '4' ;
  xchr [53 ]= '5' ;
  xchr [54 ]= '6' ;
  xchr [55 ]= '7' ;
  xchr [56 ]= '8' ;
  xchr [57 ]= '9' ;
  xchr [58 ]= ':' ;
  xchr [59 ]= ';' ;
  xchr [60 ]= '<' ;
  xchr [61 ]= '=' ;
  xchr [62 ]= '>' ;
  xchr [63 ]= '?' ;
  xchr [64 ]= '@' ;
  xchr [65 ]= 'A' ;
  xchr [66 ]= 'B' ;
  xchr [67 ]= 'C' ;
  xchr [68 ]= 'D' ;
  xchr [69 ]= 'E' ;
  xchr [70 ]= 'F' ;
  xchr [71 ]= 'G' ;
  xchr [72 ]= 'H' ;
  xchr [73 ]= 'I' ;
  xchr [74 ]= 'J' ;
  xchr [75 ]= 'K' ;
  xchr [76 ]= 'L' ;
  xchr [77 ]= 'M' ;
  xchr [78 ]= 'N' ;
  xchr [79 ]= 'O' ;
  xchr [80 ]= 'P' ;
  xchr [81 ]= 'Q' ;
  xchr [82 ]= 'R' ;
  xchr [83 ]= 'S' ;
  xchr [84 ]= 'T' ;
  xchr [85 ]= 'U' ;
  xchr [86 ]= 'V' ;
  xchr [87 ]= 'W' ;
  xchr [88 ]= 'X' ;
  xchr [89 ]= 'Y' ;
  xchr [90 ]= 'Z' ;
  xchr [91 ]= '[' ;
  xchr [92 ]= '\\' ;
  xchr [93 ]= ']' ;
  xchr [94 ]= '^' ;
  xchr [95 ]= '_' ;
  xchr [96 ]= '`' ;
  xchr [97 ]= 'a' ;
  xchr [98 ]= 'b' ;
  xchr [99 ]= 'c' ;
  xchr [100 ]= 'd' ;
  xchr [101 ]= 'e' ;
  xchr [102 ]= 'f' ;
  xchr [103 ]= 'g' ;
  xchr [104 ]= 'h' ;
  xchr [105 ]= 'i' ;
  xchr [106 ]= 'j' ;
  xchr [107 ]= 'k' ;
  xchr [108 ]= 'l' ;
  xchr [109 ]= 'm' ;
  xchr [110 ]= 'n' ;
  xchr [111 ]= 'o' ;
  xchr [112 ]= 'p' ;
  xchr [113 ]= 'q' ;
  xchr [114 ]= 'r' ;
  xchr [115 ]= 's' ;
  xchr [116 ]= 't' ;
  xchr [117 ]= 'u' ;
  xchr [118 ]= 'v' ;
  xchr [119 ]= 'w' ;
  xchr [120 ]= 'x' ;
  xchr [121 ]= 'y' ;
  xchr [122 ]= 'z' ;
  xchr [123 ]= '{' ;
  xchr [124 ]= '|' ;
  xchr [125 ]= '}' ;
  xchr [126 ]= '~' ;
  {register integer for_end; i = 0 ;for_end = 31 ; if ( i <= for_end) do 
    xchr [i ]= i ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 127 ;for_end = 255 ; if ( i <= for_end) do 
    xchr [i ]= i ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 0 ;for_end = 255 ; if ( i <= for_end) do 
    mubyteread [i ]= -268435455L ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 0 ;for_end = 255 ; if ( i <= for_end) do 
    mubytewrite [i ]= 0 ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 0 ;for_end = 128 ; if ( i <= for_end) do 
    mubytecswrite [i ]= -268435455L ;
  while ( i++ < for_end ) ;} 
  mubytekeep = 0 ;
  mubytestart = false ;
  writenoexpanding = false ;
  csconverting = false ;
  specialprinting = false ;
  messageprinting = false ;
  noconvert = false ;
  activenoconvert = false ;
  {register integer for_end; i = 0 ;for_end = 255 ; if ( i <= for_end) do 
    xord [chr ( i ) ]= 127 ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 128 ;for_end = 255 ; if ( i <= for_end) do 
    xord [xchr [i ]]= i ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 0 ;for_end = 126 ; if ( i <= for_end) do 
    xord [xchr [i ]]= i ;
  while ( i++ < for_end ) ;} 
  {register integer for_end; i = 0 ;for_end = 255 ; if ( i <= for_end) do 
    xprn [i ]= ( eightbitp || ( ( i >= 32 ) && ( i <= 126 ) ) ) ;
  while ( i++ < for_end ) ;} 
  if ( translatefilename ) 
  readtcxfile () ;
  if ( interactionoption == 4 ) 
  interaction = 3 ;
  else interaction = interactionoption ;
  deletionsallowed = true ;
  setboxallowed = true ;
  errorcount = 0 ;
  helpptr = 0 ;
  useerrhelp = false ;
  interrupt = 0 ;
  OKtointerrupt = true ;
	;
#ifdef TEXMF_DEBUG
  wasmemend = memmin ;
  waslomax = memmin ;
  washimin = memmax ;
  panicking = false ;
#endif /* TEXMF_DEBUG */
  nestptr = 0 ;
  maxneststack = 0 ;
  curlist .modefield = 1 ;
  curlist .headfield = memtop - 1 ;
  curlist .tailfield = memtop - 1 ;
  curlist .auxfield .cint = -65536000L ;
  curlist .mlfield = 0 ;
  curlist .pgfield = 0 ;
  shownmode = 0 ;
  pagecontents = 0 ;
  pagetail = memtop - 2 ;
  lastglue = 268435455L ;
  lastpenalty = 0 ;
  lastkern = 0 ;
  pagesofar [7 ]= 0 ;
  pagemaxdepth = 0 ;
  {register integer for_end; k = 15167 ;for_end = 16017 ; if ( k <= for_end) 
  do 
    xeqlevel [k ]= 1 ;
  while ( k++ < for_end ) ;} 
  nonewcontrolsequence = true ;
  saveptr = 0 ;
  curlevel = 1 ;
  curgroup = 0 ;
  curboundary = 0 ;
  maxsavestack = 0 ;
  magset = 0 ;
  curmark [0 ]= -268435455L ;
  curmark [1 ]= -268435455L ;
  curmark [2 ]= -268435455L ;
  curmark [3 ]= -268435455L ;
  curmark [4 ]= -268435455L ;
  curval = 0 ;
  curvallevel = 0 ;
  radix = 0 ;
  curorder = 0 ;
  {register integer for_end; k = 0 ;for_end = 16 ; if ( k <= for_end) do 
    readopen [k ]= 2 ;
  while ( k++ < for_end ) ;} 
  condptr = -268435455L ;
  iflimit = 0 ;
  curif = 0 ;
  ifline = 0 ;
  nullcharacter .b0 = 0 ;
  nullcharacter .b1 = 0 ;
  nullcharacter .b2 = 0 ;
  nullcharacter .b3 = 0 ;
  totalpages = 0 ;
  maxv = 0 ;
  maxh = 0 ;
  maxpush = 0 ;
  lastbop = -1 ;
  doingleaders = false ;
  deadcycles = 0 ;
  curs = -1 ;
  halfbuf = dvibufsize / 2 ;
  dvilimit = dvibufsize ;
  dviptr = 0 ;
  dvioffset = 0 ;
  dvigone = 0 ;
  downptr = -268435455L ;
  rightptr = -268435455L ;
  adjusttail = -268435455L ;
  lastbadness = 0 ;
  packbeginline = 0 ;
  emptyfield .v.RH = 0 ;
  emptyfield .v.LH = -268435455L ;
  nulldelimiter .b0 = 0 ;
  nulldelimiter .b1 = 0 ;
  nulldelimiter .b2 = 0 ;
  nulldelimiter .b3 = 0 ;
  alignptr = -268435455L ;
  curalign = -268435455L ;
  curspan = -268435455L ;
  curloop = -268435455L ;
  curhead = -268435455L ;
  curtail = -268435455L ;
  {register integer for_end; z = 0 ;for_end = hyphsize ; if ( z <= for_end) 
  do 
    {
      hyphword [z ]= 0 ;
      hyphlist [z ]= -268435455L ;
      hyphlink [z ]= 0 ;
    } 
  while ( z++ < for_end ) ;} 
  hyphcount = 0 ;
  hyphnext = 608 ;
  if ( hyphnext > hyphsize ) 
  hyphnext = 607 ;
  outputactive = false ;
  insertpenalties = 0 ;
  ligaturepresent = false ;
  cancelboundary = false ;
  lfthit = false ;
  rthit = false ;
  insdisc = false ;
  aftertoken = 0 ;
  longhelpseen = false ;
  formatident = 0 ;
  {register integer for_end; k = 0 ;for_end = 17 ; if ( k <= for_end) do 
    writeopen [k ]= false ;
  while ( k++ < for_end ) ;} 
  editnamestart = 0 ;
  stopatspace = true ;
  mltexenabledp = false ;
  enctexenabledp = false ;
	;
#ifdef INITEX
  if ( iniversion ) 
  {
    {register integer for_end; k = membot + 1 ;for_end = membot + 19 ; if ( 
    k <= for_end) do 
      mem [k ].cint = 0 ;
    while ( k++ < for_end ) ;} 
    k = membot ;
    while ( k <= membot + 19 ) {
	
      mem [k ].hh .v.RH = -268435454L ;
      mem [k ].hh.b0 = 0 ;
      mem [k ].hh.b1 = 0 ;
      k = k + 4 ;
    } 
    mem [membot + 6 ].cint = 65536L ;
    mem [membot + 4 ].hh.b0 = 1 ;
    mem [membot + 10 ].cint = 65536L ;
    mem [membot + 8 ].hh.b0 = 2 ;
    mem [membot + 14 ].cint = 65536L ;
    mem [membot + 12 ].hh.b0 = 1 ;
    mem [membot + 15 ].cint = 65536L ;
    mem [membot + 12 ].hh.b1 = 1 ;
    mem [membot + 18 ].cint = -65536L ;
    mem [membot + 16 ].hh.b0 = 1 ;
    rover = membot + 20 ;
    mem [rover ].hh .v.RH = 268435455L ;
    mem [rover ].hh .v.LH = 1000 ;
    mem [rover + 1 ].hh .v.LH = rover ;
    mem [rover + 1 ].hh .v.RH = rover ;
    lomemmax = rover + 1000 ;
    mem [lomemmax ].hh .v.RH = -268435455L ;
    mem [lomemmax ].hh .v.LH = -268435455L ;
    {register integer for_end; k = memtop - 13 ;for_end = memtop ; if ( k <= 
    for_end) do 
      mem [k ]= mem [lomemmax ];
    while ( k++ < for_end ) ;} 
    mem [memtop - 10 ].hh .v.LH = 14614 ;
    mem [memtop - 9 ].hh .v.RH = 256 ;
    mem [memtop - 9 ].hh .v.LH = -268435455L ;
    mem [memtop - 7 ].hh.b0 = 1 ;
    mem [memtop - 6 ].hh .v.LH = 268435455L ;
    mem [memtop - 7 ].hh.b1 = 0 ;
    mem [memtop ].hh.b1 = 255 ;
    mem [memtop ].hh.b0 = 1 ;
    mem [memtop ].hh .v.RH = memtop ;
    mem [memtop - 2 ].hh.b0 = 10 ;
    mem [memtop - 2 ].hh.b1 = 0 ;
    avail = -268435455L ;
    memend = memtop ;
    himemmin = memtop - 13 ;
    varused = membot + 20 - membot ;
    dynused = 14 ;
    eqtb [12526 ].hh.b0 = 101 ;
    eqtb [12526 ].hh .v.RH = -268435455L ;
    eqtb [12526 ].hh.b1 = 0 ;
    {register integer for_end; k = 1 ;for_end = eqtbtop ; if ( k <= for_end) 
    do 
      eqtb [k ]= eqtb [12526 ];
    while ( k++ < for_end ) ;} 
    eqtb [12527 ].hh .v.RH = membot ;
    eqtb [12527 ].hh.b1 = 1 ;
    eqtb [12527 ].hh.b0 = 117 ;
    {register integer for_end; k = 12528 ;for_end = 13056 ; if ( k <= 
    for_end) do 
      eqtb [k ]= eqtb [12527 ];
    while ( k++ < for_end ) ;} 
    mem [membot ].hh .v.RH = mem [membot ].hh .v.RH + 530 ;
    eqtb [13057 ].hh .v.RH = -268435455L ;
    eqtb [13057 ].hh.b0 = 118 ;
    eqtb [13057 ].hh.b1 = 1 ;
    {register integer for_end; k = 13058 ;for_end = 13322 ; if ( k <= 
    for_end) do 
      eqtb [k ]= eqtb [12526 ];
    while ( k++ < for_end ) ;} 
    eqtb [13323 ].hh .v.RH = -268435455L ;
    eqtb [13323 ].hh.b0 = 119 ;
    eqtb [13323 ].hh.b1 = 1 ;
    {register integer for_end; k = 13324 ;for_end = 13578 ; if ( k <= 
    for_end) do 
      eqtb [k ]= eqtb [13323 ];
    while ( k++ < for_end ) ;} 
    eqtb [13579 ].hh .v.RH = 0 ;
    eqtb [13579 ].hh.b0 = 120 ;
    eqtb [13579 ].hh.b1 = 1 ;
    {register integer for_end; k = 13583 ;for_end = 13630 ; if ( k <= 
    for_end) do 
      eqtb [k ]= eqtb [13579 ];
    while ( k++ < for_end ) ;} 
    eqtb [13631 ].hh .v.RH = 0 ;
    eqtb [13631 ].hh.b0 = 120 ;
    eqtb [13631 ].hh.b1 = 1 ;
    {register integer for_end; k = 13632 ;for_end = 15166 ; if ( k <= 
    for_end) do 
      eqtb [k ]= eqtb [13631 ];
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      {
	eqtb [13631 + k ].hh .v.RH = 12 ;
	eqtb [14655 + k ].hh .v.RH = k ;
	eqtb [14399 + k ].hh .v.RH = 1000 ;
      } 
    while ( k++ < for_end ) ;} 
    eqtb [13644 ].hh .v.RH = 5 ;
    eqtb [13663 ].hh .v.RH = 10 ;
    eqtb [13723 ].hh .v.RH = 0 ;
    eqtb [13668 ].hh .v.RH = 14 ;
    eqtb [13758 ].hh .v.RH = 15 ;
    eqtb [13631 ].hh .v.RH = 9 ;
    {register integer for_end; k = 48 ;for_end = 57 ; if ( k <= for_end) do 
      eqtb [14655 + k ].hh .v.RH = k + 28672 ;
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 65 ;for_end = 90 ; if ( k <= for_end) do 
      {
	eqtb [13631 + k ].hh .v.RH = 11 ;
	eqtb [13631 + k + 32 ].hh .v.RH = 11 ;
	eqtb [14655 + k ].hh .v.RH = k + 28928 ;
	eqtb [14655 + k + 32 ].hh .v.RH = k + 28960 ;
	eqtb [13887 + k ].hh .v.RH = k + 32 ;
	eqtb [13887 + k + 32 ].hh .v.RH = k + 32 ;
	eqtb [14143 + k ].hh .v.RH = k ;
	eqtb [14143 + k + 32 ].hh .v.RH = k ;
	eqtb [14399 + k ].hh .v.RH = 999 ;
      } 
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 15167 ;for_end = 15484 ; if ( k <= 
    for_end) do 
      eqtb [k ].cint = 0 ;
    while ( k++ < for_end ) ;} 
    eqtb [15222 ].cint = 256 ;
    eqtb [15223 ].cint = -1 ;
    eqtb [15184 ].cint = 1000 ;
    eqtb [15168 ].cint = 10000 ;
    eqtb [15208 ].cint = 1 ;
    eqtb [15207 ].cint = 25 ;
    eqtb [15212 ].cint = 92 ;
    eqtb [15215 ].cint = 13 ;
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      eqtb [15485 + k ].cint = -1 ;
    while ( k++ < for_end ) ;} 
    eqtb [15531 ].cint = 0 ;
    {register integer for_end; k = 15741 ;for_end = 16017 ; if ( k <= 
    for_end) do 
      eqtb [k ].cint = 0 ;
    while ( k++ < for_end ) ;} 
    hashused = 10514 ;
    hashhigh = 0 ;
    cscount = 0 ;
    eqtb [10523 ].hh.b0 = 116 ;
    hash [10523 ].v.RH = 514 ;
    {register integer for_end; k = - (integer) trieopsize ;for_end = 
    trieopsize ; if ( k <= for_end) do 
      trieophash [k ]= 0 ;
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      trieused [k ]= mintrieop ;
    while ( k++ < for_end ) ;} 
    maxopused = mintrieop ;
    trieopptr = 0 ;
    trienotready = true ;
    hash [10514 ].v.RH = 1202 ;
    if ( iniversion ) 
    formatident = 1282 ;
    hash [10522 ].v.RH = 1324 ;
    eqtb [10522 ].hh.b1 = 1 ;
    eqtb [10522 ].hh.b0 = 113 ;
    eqtb [10522 ].hh .v.RH = -268435455L ;
  } 
#endif /* INITEX */
} 
#ifdef INITEX
boolean 
#ifdef HAVE_PROTOTYPES
getstringsstarted ( void ) 
#else
getstringsstarted ( ) 
#endif
{
  /* 30 10 */ register boolean Result; getstringsstarted_regmem 
  unsigned char k, l  ;
  ASCIIcode m, n  ;
  strnumber g  ;
  integer a  ;
  boolean c  ;
  poolptr = 0 ;
  strptr = 0 ;
  strstart [0 ]= 0 ;
  {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
    {
      if ( ( ( k < 32 ) || ( k > 126 ) ) ) 
      {
	{
	  strpool [poolptr ]= 94 ;
	  incr ( poolptr ) ;
	} 
	{
	  strpool [poolptr ]= 94 ;
	  incr ( poolptr ) ;
	} 
	if ( k < 64 ) 
	{
	  strpool [poolptr ]= k + 64 ;
	  incr ( poolptr ) ;
	} 
	else if ( k < 128 ) 
	{
	  strpool [poolptr ]= k - 64 ;
	  incr ( poolptr ) ;
	} 
	else {
	    
	  l = k / 16 ;
	  if ( l < 10 ) 
	  {
	    strpool [poolptr ]= l + 48 ;
	    incr ( poolptr ) ;
	  } 
	  else {
	      
	    strpool [poolptr ]= l + 87 ;
	    incr ( poolptr ) ;
	  } 
	  l = k % 16 ;
	  if ( l < 10 ) 
	  {
	    strpool [poolptr ]= l + 48 ;
	    incr ( poolptr ) ;
	  } 
	  else {
	      
	    strpool [poolptr ]= l + 87 ;
	    incr ( poolptr ) ;
	  } 
	} 
      } 
      else {
	  
	strpool [poolptr ]= k ;
	incr ( poolptr ) ;
      } 
      g = makestring () ;
    } 
  while ( k++ < for_end ) ;} 
  namelength = strlen ( poolname ) ;
  nameoffile = xmallocarray ( ASCIIcode , namelength + 1 ) ;
  strcpy ( stringcast ( nameoffile + 1 ) , poolname ) ;
  if ( aopenin ( poolfile , kpsetexpoolformat ) ) 
  {
    c = false ;
    do {
	{ 
	if ( eof ( poolfile ) ) 
	{
	  ;
	  fprintf ( stdout , "%s%s%s\n",  "! " , poolname , " has no check sum." ) ;
	  aclose ( poolfile ) ;
	  Result = false ;
	  return Result ;
	} 
	read ( poolfile , m ) ;
	read ( poolfile , n ) ;
	if ( m == '*' ) 
	{
	  a = 0 ;
	  k = 1 ;
	  while ( true ) {
	      
	    if ( ( xord [n ]< 48 ) || ( xord [n ]> 57 ) ) 
	    {
	      ;
	      fprintf ( stdout , "%s%s%s\n",  "! " , poolname ,               " check sum doesn't have nine digits." ) ;
	      aclose ( poolfile ) ;
	      Result = false ;
	      return Result ;
	    } 
	    a = 10 * a + xord [n ]- 48 ;
	    if ( k == 9 ) 
	    goto lab30 ;
	    incr ( k ) ;
	    read ( poolfile , n ) ;
	  } 
	  lab30: if ( a != 128540375L ) 
	  {
	    ;
	    fprintf ( stdout , "%s%s%s\n",  "! " , poolname ,             " doesn't match; tangle me again (or fix the path)." ) ;
	    aclose ( poolfile ) ;
	    Result = false ;
	    return Result ;
	  } 
	  c = true ;
	} 
	else {
	    
	  if ( ( xord [m ]< 48 ) || ( xord [m ]> 57 ) || ( xord [n ]< 48 
	  ) || ( xord [n ]> 57 ) ) 
	  {
	    ;
	    fprintf ( stdout , "%s%s%s\n",  "! " , poolname ,             " line doesn't begin with two digits." ) ;
	    aclose ( poolfile ) ;
	    Result = false ;
	    return Result ;
	  } 
	  l = xord [m ]* 10 + xord [n ]- 48 * 11 ;
	  if ( poolptr + l + stringvacancies > poolsize ) 
	  {
	    ;
	    fprintf ( stdout , "%s\n",  "! You have to increase POOLSIZE." ) ;
	    aclose ( poolfile ) ;
	    Result = false ;
	    return Result ;
	  } 
	  {register integer for_end; k = 1 ;for_end = l ; if ( k <= for_end) 
	  do 
	    {
	      if ( eoln ( poolfile ) ) 
	      m = ' ' ;
	      else read ( poolfile , m ) ;
	      {
		strpool [poolptr ]= xord [m ];
		incr ( poolptr ) ;
	      } 
	    } 
	  while ( k++ < for_end ) ;} 
	  readln ( poolfile ) ;
	  g = makestring () ;
	} 
      } 
    } while ( ! ( c ) ) ;
    aclose ( poolfile ) ;
    Result = true ;
  } 
  else {
      
    ;
    fprintf ( stdout , "%s%s%s\n",  "! I can't read " , poolname , "; bad path?" ) ;
    aclose ( poolfile ) ;
    Result = false ;
    return Result ;
  } 
  return Result ;
} 
#endif /* INITEX */
#ifdef INITEX
void 
#ifdef HAVE_PROTOTYPES
sortavail ( void ) 
#else
sortavail ( ) 
#endif
{
  sortavail_regmem 
  halfword p, q, r  ;
  halfword oldrover  ;
  p = getnode ( 1073741824L ) ;
  p = mem [rover + 1 ].hh .v.RH ;
  mem [rover + 1 ].hh .v.RH = 268435455L ;
  oldrover = rover ;
  while ( p != oldrover ) if ( p < rover ) 
  {
    q = p ;
    p = mem [q + 1 ].hh .v.RH ;
    mem [q + 1 ].hh .v.RH = rover ;
    rover = q ;
  } 
  else {
      
    q = rover ;
    while ( mem [q + 1 ].hh .v.RH < p ) q = mem [q + 1 ].hh .v.RH ;
    r = mem [p + 1 ].hh .v.RH ;
    mem [p + 1 ].hh .v.RH = mem [q + 1 ].hh .v.RH ;
    mem [q + 1 ].hh .v.RH = p ;
    p = r ;
  } 
  p = rover ;
  while ( mem [p + 1 ].hh .v.RH != 268435455L ) {
      
    mem [mem [p + 1 ].hh .v.RH + 1 ].hh .v.LH = p ;
    p = mem [p + 1 ].hh .v.RH ;
  } 
  mem [p + 1 ].hh .v.RH = rover ;
  mem [rover + 1 ].hh .v.LH = p ;
} 
#endif /* INITEX */
#ifdef INITEX
void 
#ifdef HAVE_PROTOTYPES
zprimitive ( strnumber s , quarterword c , halfword o ) 
#else
zprimitive ( s , c , o ) 
  strnumber s ;
  quarterword c ;
  halfword o ;
#endif
{
  primitive_regmem 
  poolpointer k  ;
  smallnumber j  ;
  smallnumber l  ;
  if ( s < 256 ) 
  curval = s + 257 ;
  else {
      
    k = strstart [s ];
    l = strstart [s + 1 ]- k ;
    {register integer for_end; j = 0 ;for_end = l - 1 ; if ( j <= for_end) 
    do 
      buffer [j ]= strpool [k + j ];
    while ( j++ < for_end ) ;} 
    curval = idlookup ( 0 , l ) ;
    {
      decr ( strptr ) ;
      poolptr = strstart [strptr ];
    } 
    hash [curval ].v.RH = s ;
  } 
  eqtb [curval ].hh.b1 = 1 ;
  eqtb [curval ].hh.b0 = c ;
  eqtb [curval ].hh .v.RH = o ;
} 
#endif /* INITEX */
#ifdef INITEX
trieopcode 
#ifdef HAVE_PROTOTYPES
znewtrieop ( smallnumber d , smallnumber n , trieopcode v ) 
#else
znewtrieop ( d , n , v ) 
  smallnumber d ;
  smallnumber n ;
  trieopcode v ;
#endif
{
  /* 10 */ register trieopcode Result; newtrieop_regmem 
  integer h  ;
  trieopcode u  ;
  integer l  ;
  h = abs ( intcast ( n ) + 313 * intcast ( d ) + 361 * intcast ( v ) + 1009 * 
  intcast ( curlang ) ) % ( trieopsize - negtrieopsize ) + negtrieopsize ;
  while ( true ) {
      
    l = trieophash [h ];
    if ( l == 0 ) 
    {
      if ( trieopptr == trieopsize ) 
      overflow ( 961 , trieopsize ) ;
      u = trieused [curlang ];
      if ( u == maxtrieop ) 
      overflow ( 962 , maxtrieop - mintrieop ) ;
      incr ( trieopptr ) ;
      incr ( u ) ;
      trieused [curlang ]= u ;
      if ( u > maxopused ) 
      maxopused = u ;
      hyfdistance [trieopptr ]= d ;
      hyfnum [trieopptr ]= n ;
      hyfnext [trieopptr ]= v ;
      trieoplang [trieopptr ]= curlang ;
      trieophash [h ]= trieopptr ;
      trieopval [trieopptr ]= u ;
      Result = u ;
      return Result ;
    } 
    if ( ( hyfdistance [l ]== d ) && ( hyfnum [l ]== n ) && ( hyfnext [l 
    ]== v ) && ( trieoplang [l ]== curlang ) ) 
    {
      Result = trieopval [l ];
      return Result ;
    } 
    if ( h > - (integer) trieopsize ) 
    decr ( h ) ;
    else h = trieopsize ;
  } 
  return Result ;
} 
triepointer 
#ifdef HAVE_PROTOTYPES
ztrienode ( triepointer p ) 
#else
ztrienode ( p ) 
  triepointer p ;
#endif
{
  /* 10 */ register triepointer Result; trienode_regmem 
  triepointer h  ;
  triepointer q  ;
  h = abs ( intcast ( triec [p ]) + 1009 * intcast ( trieo [p ]) + 2718 * 
  intcast ( triel [p ]) + 3142 * intcast ( trier [p ]) ) % triesize ;
  while ( true ) {
      
    q = triehash [h ];
    if ( q == 0 ) 
    {
      triehash [h ]= p ;
      Result = p ;
      return Result ;
    } 
    if ( ( triec [q ]== triec [p ]) && ( trieo [q ]== trieo [p ]) && ( 
    triel [q ]== triel [p ]) && ( trier [q ]== trier [p ]) ) 
    {
      Result = q ;
      return Result ;
    } 
    if ( h > 0 ) 
    decr ( h ) ;
    else h = triesize ;
  } 
  return Result ;
} 
triepointer 
#ifdef HAVE_PROTOTYPES
zcompresstrie ( triepointer p ) 
#else
zcompresstrie ( p ) 
  triepointer p ;
#endif
{
  register triepointer Result; compresstrie_regmem 
  if ( p == 0 ) 
  Result = 0 ;
  else {
      
    triel [p ]= compresstrie ( triel [p ]) ;
    trier [p ]= compresstrie ( trier [p ]) ;
    Result = trienode ( p ) ;
  } 
  return Result ;
} 
void 
#ifdef HAVE_PROTOTYPES
zfirstfit ( triepointer p ) 
#else
zfirstfit ( p ) 
  triepointer p ;
#endif
{
  /* 45 40 */ firstfit_regmem 
  triepointer h  ;
  triepointer z  ;
  triepointer q  ;
  ASCIIcode c  ;
  triepointer l, r  ;
  short ll  ;
  c = triec [p ];
  z = triemin [c ];
  while ( true ) {
      
    h = z - c ;
    if ( triemax < h + 256 ) 
    {
      if ( triesize <= h + 256 ) 
      overflow ( 963 , triesize ) ;
      do {
	  incr ( triemax ) ;
	trietaken [triemax ]= false ;
	trietrl [triemax ]= triemax + 1 ;
	trietro [triemax ]= triemax - 1 ;
      } while ( ! ( triemax == h + 256 ) ) ;
    } 
    if ( trietaken [h ]) 
    goto lab45 ;
    q = trier [p ];
    while ( q > 0 ) {
	
      if ( trietrl [h + triec [q ]]== 0 ) 
      goto lab45 ;
      q = trier [q ];
    } 
    goto lab40 ;
    lab45: z = trietrl [z ];
  } 
  lab40: trietaken [h ]= true ;
  triehash [p ]= h ;
  q = p ;
  do {
      z = h + triec [q ];
    l = trietro [z ];
    r = trietrl [z ];
    trietro [r ]= l ;
    trietrl [l ]= r ;
    trietrl [z ]= 0 ;
    if ( l < 256 ) 
    {
      if ( z < 256 ) 
      ll = z ;
      else ll = 256 ;
      do {
	  triemin [l ]= r ;
	incr ( l ) ;
      } while ( ! ( l == ll ) ) ;
    } 
    q = trier [q ];
  } while ( ! ( q == 0 ) ) ;
} 
void 
#ifdef HAVE_PROTOTYPES
ztriepack ( triepointer p ) 
#else
ztriepack ( p ) 
  triepointer p ;
#endif
{
  triepack_regmem 
  triepointer q  ;
  do {
      q = triel [p ];
    if ( ( q > 0 ) && ( triehash [q ]== 0 ) ) 
    {
      firstfit ( q ) ;
      triepack ( q ) ;
    } 
    p = trier [p ];
  } while ( ! ( p == 0 ) ) ;
} 
void 
#ifdef HAVE_PROTOTYPES
ztriefix ( triepointer p ) 
#else
ztriefix ( p ) 
  triepointer p ;
#endif
{
  triefix_regmem 
  triepointer q  ;
  ASCIIcode c  ;
  triepointer z  ;
  z = triehash [p ];
  do {
      q = triel [p ];
    c = triec [p ];
    trietrl [z + c ]= triehash [q ];
    trietrc [z + c ]= c ;
    trietro [z + c ]= trieo [p ];
    if ( q > 0 ) 
    triefix ( q ) ;
    p = trier [p ];
  } while ( ! ( p == 0 ) ) ;
} 
void 
#ifdef HAVE_PROTOTYPES
newpatterns ( void ) 
#else
newpatterns ( ) 
#endif
{
  /* 30 31 */ newpatterns_regmem 
  char k, l  ;
  boolean digitsensed  ;
  trieopcode v  ;
  triepointer p, q  ;
  boolean firstchild  ;
  ASCIIcode c  ;
  if ( trienotready ) 
  {
    if ( eqtb [15217 ].cint <= 0 ) 
    curlang = 0 ;
    else if ( eqtb [15217 ].cint > 255 ) 
    curlang = 0 ;
    else curlang = eqtb [15217 ].cint ;
    scanleftbrace () ;
    k = 0 ;
    hyf [0 ]= 0 ;
    digitsensed = false ;
    while ( true ) {
	
      getxtoken () ;
      switch ( curcmd ) 
      {case 11 : 
      case 12 : 
	if ( digitsensed || ( curchr < 48 ) || ( curchr > 57 ) ) 
	{
	  if ( curchr == 46 ) 
	  curchr = 0 ;
	  else {
	      
	    curchr = eqtb [13887 + curchr ].hh .v.RH ;
	    if ( curchr == 0 ) 
	    {
	      {
		if ( interaction == 3 ) 
		;
		if ( filelineerrorstylep ) 
		printfileline () ;
		else printnl ( 262 ) ;
		print ( 969 ) ;
	      } 
	      {
		helpptr = 1 ;
		helpline [0 ]= 968 ;
	      } 
	      error () ;
	    } 
	  } 
	  if ( k < 63 ) 
	  {
	    incr ( k ) ;
	    hc [k ]= curchr ;
	    hyf [k ]= 0 ;
	    digitsensed = false ;
	  } 
	} 
	else if ( k < 63 ) 
	{
	  hyf [k ]= curchr - 48 ;
	  digitsensed = true ;
	} 
	break ;
      case 10 : 
      case 2 : 
	{
	  if ( k > 0 ) 
	  {
	    if ( hc [1 ]== 0 ) 
	    hyf [0 ]= 0 ;
	    if ( hc [k ]== 0 ) 
	    hyf [k ]= 0 ;
	    l = k ;
	    v = mintrieop ;
	    while ( true ) {
		
	      if ( hyf [l ]!= 0 ) 
	      v = newtrieop ( k - l , hyf [l ], v ) ;
	      if ( l > 0 ) 
	      decr ( l ) ;
	      else goto lab31 ;
	    } 
	    lab31: ;
	    q = 0 ;
	    hc [0 ]= curlang ;
	    while ( l <= k ) {
		
	      c = hc [l ];
	      incr ( l ) ;
	      p = triel [q ];
	      firstchild = true ;
	      while ( ( p > 0 ) && ( c > triec [p ]) ) {
		  
		q = p ;
		p = trier [q ];
		firstchild = false ;
	      } 
	      if ( ( p == 0 ) || ( c < triec [p ]) ) 
	      {
		if ( trieptr == triesize ) 
		overflow ( 963 , triesize ) ;
		incr ( trieptr ) ;
		trier [trieptr ]= p ;
		p = trieptr ;
		triel [p ]= 0 ;
		if ( firstchild ) 
		triel [q ]= p ;
		else trier [q ]= p ;
		triec [p ]= c ;
		trieo [p ]= mintrieop ;
	      } 
	      q = p ;
	    } 
	    if ( trieo [q ]!= mintrieop ) 
	    {
	      {
		if ( interaction == 3 ) 
		;
		if ( filelineerrorstylep ) 
		printfileline () ;
		else printnl ( 262 ) ;
		print ( 970 ) ;
	      } 
	      {
		helpptr = 1 ;
		helpline [0 ]= 968 ;
	      } 
	      error () ;
	    } 
	    trieo [q ]= v ;
	  } 
	  if ( curcmd == 2 ) 
	  goto lab30 ;
	  k = 0 ;
	  hyf [0 ]= 0 ;
	  digitsensed = false ;
	} 
	break ;
	default: 
	{
	  {
	    if ( interaction == 3 ) 
	    ;
	    if ( filelineerrorstylep ) 
	    printfileline () ;
	    else printnl ( 262 ) ;
	    print ( 967 ) ;
	  } 
	  printesc ( 965 ) ;
	  {
	    helpptr = 1 ;
	    helpline [0 ]= 968 ;
	  } 
	  error () ;
	} 
	break ;
      } 
    } 
    lab30: ;
  } 
  else {
      
    {
      if ( interaction == 3 ) 
      ;
      if ( filelineerrorstylep ) 
      printfileline () ;
      else printnl ( 262 ) ;
      print ( 964 ) ;
    } 
    printesc ( 965 ) ;
    {
      helpptr = 1 ;
      helpline [0 ]= 966 ;
    } 
    error () ;
    mem [memtop - 12 ].hh .v.RH = scantoks ( false , false ) ;
    flushlist ( defref ) ;
  } 
} 
void 
#ifdef HAVE_PROTOTYPES
inittrie ( void ) 
#else
inittrie ( ) 
#endif
{
  inittrie_regmem 
  triepointer p  ;
  integer j, k, t  ;
  triepointer r, s  ;
  opstart [0 ]= - (integer) mintrieop ;
  {register integer for_end; j = 1 ;for_end = 255 ; if ( j <= for_end) do 
    opstart [j ]= opstart [j - 1 ]+ trieused [j - 1 ];
  while ( j++ < for_end ) ;} 
  {register integer for_end; j = 1 ;for_end = trieopptr ; if ( j <= for_end) 
  do 
    trieophash [j ]= opstart [trieoplang [j ]]+ trieopval [j ];
  while ( j++ < for_end ) ;} 
  {register integer for_end; j = 1 ;for_end = trieopptr ; if ( j <= for_end) 
  do 
    while ( trieophash [j ]> j ) {
	
      k = trieophash [j ];
      t = hyfdistance [k ];
      hyfdistance [k ]= hyfdistance [j ];
      hyfdistance [j ]= t ;
      t = hyfnum [k ];
      hyfnum [k ]= hyfnum [j ];
      hyfnum [j ]= t ;
      t = hyfnext [k ];
      hyfnext [k ]= hyfnext [j ];
      hyfnext [j ]= t ;
      trieophash [j ]= trieophash [k ];
      trieophash [k ]= k ;
    } 
  while ( j++ < for_end ) ;} 
  {register integer for_end; p = 0 ;for_end = triesize ; if ( p <= for_end) 
  do 
    triehash [p ]= 0 ;
  while ( p++ < for_end ) ;} 
  triel [0 ]= compresstrie ( triel [0 ]) ;
  {register integer for_end; p = 0 ;for_end = trieptr ; if ( p <= for_end) 
  do 
    triehash [p ]= 0 ;
  while ( p++ < for_end ) ;} 
  {register integer for_end; p = 0 ;for_end = 255 ; if ( p <= for_end) do 
    triemin [p ]= p + 1 ;
  while ( p++ < for_end ) ;} 
  trietrl [0 ]= 1 ;
  triemax = 0 ;
  if ( triel [0 ]!= 0 ) 
  {
    firstfit ( triel [0 ]) ;
    triepack ( triel [0 ]) ;
  } 
  if ( triel [0 ]== 0 ) 
  {
    {register integer for_end; r = 0 ;for_end = 256 ; if ( r <= for_end) do 
      {
	trietrl [r ]= 0 ;
	trietro [r ]= mintrieop ;
	trietrc [r ]= 0 ;
      } 
    while ( r++ < for_end ) ;} 
    triemax = 256 ;
  } 
  else {
      
    triefix ( triel [0 ]) ;
    r = 0 ;
    do {
	s = trietrl [r ];
      {
	trietrl [r ]= 0 ;
	trietro [r ]= mintrieop ;
	trietrc [r ]= 0 ;
      } 
      r = s ;
    } while ( ! ( r > triemax ) ) ;
  } 
  trietrc [0 ]= 63 ;
  trienotready = false ;
} 
#endif /* INITEX */
void 
#ifdef HAVE_PROTOTYPES
zlinebreak ( integer finalwidowpenalty ) 
#else
zlinebreak ( finalwidowpenalty ) 
  integer finalwidowpenalty ;
#endif
{
  /* 30 31 32 33 34 35 22 */ linebreak_regmem 
  boolean autobreaking  ;
  halfword prevp  ;
  halfword q, r, s, prevs  ;
  internalfontnumber f  ;
  smallnumber j  ;
  unsigned char c  ;
  packbeginline = curlist .mlfield ;
  mem [memtop - 3 ].hh .v.RH = mem [curlist .headfield ].hh .v.RH ;
  if ( ( curlist .tailfield >= himemmin ) ) 
  {
    mem [curlist .tailfield ].hh .v.RH = newpenalty ( 10000 ) ;
    curlist .tailfield = mem [curlist .tailfield ].hh .v.RH ;
  } 
  else if ( mem [curlist .tailfield ].hh.b0 != 10 ) 
  {
    mem [curlist .tailfield ].hh .v.RH = newpenalty ( 10000 ) ;
    curlist .tailfield = mem [curlist .tailfield ].hh .v.RH ;
  } 
  else {
      
    mem [curlist .tailfield ].hh.b0 = 12 ;
    deleteglueref ( mem [curlist .tailfield + 1 ].hh .v.LH ) ;
    flushnodelist ( mem [curlist .tailfield + 1 ].hh .v.RH ) ;
    mem [curlist .tailfield + 1 ].cint = 10000 ;
  } 
  mem [curlist .tailfield ].hh .v.RH = newparamglue ( 14 ) ;
  initcurlang = curlist .pgfield % 65536L ;
  initlhyf = curlist .pgfield / 4194304L ;
  initrhyf = ( curlist .pgfield / 65536L ) % 64 ;
  popnest () ;
  noshrinkerroryet = true ;
  if ( ( mem [eqtb [12534 ].hh .v.RH ].hh.b1 != 0 ) && ( mem [eqtb [
  12534 ].hh .v.RH + 3 ].cint != 0 ) ) 
  {
    eqtb [12534 ].hh .v.RH = finiteshrink ( eqtb [12534 ].hh .v.RH ) ;
  } 
  if ( ( mem [eqtb [12535 ].hh .v.RH ].hh.b1 != 0 ) && ( mem [eqtb [
  12535 ].hh .v.RH + 3 ].cint != 0 ) ) 
  {
    eqtb [12535 ].hh .v.RH = finiteshrink ( eqtb [12535 ].hh .v.RH ) ;
  } 
  q = eqtb [12534 ].hh .v.RH ;
  r = eqtb [12535 ].hh .v.RH ;
  background [1 ]= mem [q + 1 ].cint + mem [r + 1 ].cint ;
  background [2 ]= 0 ;
  background [3 ]= 0 ;
  background [4 ]= 0 ;
  background [5 ]= 0 ;
  background [2 + mem [q ].hh.b0 ]= mem [q + 2 ].cint ;
  background [2 + mem [r ].hh.b0 ]= background [2 + mem [r ].hh.b0 ]+ 
  mem [r + 2 ].cint ;
  background [6 ]= mem [q + 3 ].cint + mem [r + 3 ].cint ;
  minimumdemerits = 1073741823L ;
  minimaldemerits [3 ]= 1073741823L ;
  minimaldemerits [2 ]= 1073741823L ;
  minimaldemerits [1 ]= 1073741823L ;
  minimaldemerits [0 ]= 1073741823L ;
  if ( eqtb [13057 ].hh .v.RH == -268435455L ) 
  if ( eqtb [15758 ].cint == 0 ) 
  {
    lastspecialline = 0 ;
    secondwidth = eqtb [15744 ].cint ;
    secondindent = 0 ;
  } 
  else {
      
    lastspecialline = abs ( eqtb [15208 ].cint ) ;
    if ( eqtb [15208 ].cint < 0 ) 
    {
      firstwidth = eqtb [15744 ].cint - abs ( eqtb [15758 ].cint ) ;
      if ( eqtb [15758 ].cint >= 0 ) 
      firstindent = eqtb [15758 ].cint ;
      else firstindent = 0 ;
      secondwidth = eqtb [15744 ].cint ;
      secondindent = 0 ;
    } 
    else {
	
      firstwidth = eqtb [15744 ].cint ;
      firstindent = 0 ;
      secondwidth = eqtb [15744 ].cint - abs ( eqtb [15758 ].cint ) ;
      if ( eqtb [15758 ].cint >= 0 ) 
      secondindent = eqtb [15758 ].cint ;
      else secondindent = 0 ;
    } 
  } 
  else {
      
    lastspecialline = mem [eqtb [13057 ].hh .v.RH ].hh .v.LH - 1 ;
    secondwidth = mem [eqtb [13057 ].hh .v.RH + 2 * ( lastspecialline + 1 ) 
    ].cint ;
    secondindent = mem [eqtb [13057 ].hh .v.RH + 2 * lastspecialline + 1 ]
    .cint ;
  } 
  if ( eqtb [15186 ].cint == 0 ) 
  easyline = lastspecialline ;
  else easyline = 268435455L ;
  threshold = eqtb [15167 ].cint ;
  if ( threshold >= 0 ) 
  {
	;
#ifdef STAT
    if ( eqtb [15199 ].cint > 0 ) 
    {
      begindiagnostic () ;
      printnl ( 945 ) ;
    } 
#endif /* STAT */
    secondpass = false ;
    finalpass = false ;
  } 
  else {
      
    threshold = eqtb [15168 ].cint ;
    secondpass = true ;
    finalpass = ( eqtb [15761 ].cint <= 0 ) ;
	;
#ifdef STAT
    if ( eqtb [15199 ].cint > 0 ) 
    begindiagnostic () ;
#endif /* STAT */
  } 
  while ( true ) {
      
    if ( threshold > 10000 ) 
    threshold = 10000 ;
    if ( secondpass ) 
    {
	;
#ifdef INITEX
      if ( trienotready ) 
      inittrie () ;
#endif /* INITEX */
      curlang = initcurlang ;
      lhyf = initlhyf ;
      rhyf = initrhyf ;
    } 
    q = getnode ( 3 ) ;
    mem [q ].hh.b0 = 0 ;
    mem [q ].hh.b1 = 2 ;
    mem [q ].hh .v.RH = memtop - 7 ;
    mem [q + 1 ].hh .v.RH = -268435455L ;
    mem [q + 1 ].hh .v.LH = curlist .pgfield + 1 ;
    mem [q + 2 ].cint = 0 ;
    mem [memtop - 7 ].hh .v.RH = q ;
    activewidth [1 ]= background [1 ];
    activewidth [2 ]= background [2 ];
    activewidth [3 ]= background [3 ];
    activewidth [4 ]= background [4 ];
    activewidth [5 ]= background [5 ];
    activewidth [6 ]= background [6 ];
    passive = -268435455L ;
    printednode = memtop - 3 ;
    passnumber = 0 ;
    fontinshortdisplay = 0 ;
    curp = mem [memtop - 3 ].hh .v.RH ;
    autobreaking = true ;
    prevp = curp ;
    while ( ( curp != -268435455L ) && ( mem [memtop - 7 ].hh .v.RH != 
    memtop - 7 ) ) {
	
      if ( ( curp >= himemmin ) ) 
      {
	prevp = curp ;
	do {
	    f = mem [curp ].hh.b0 ;
	  activewidth [1 ]= activewidth [1 ]+ fontinfo [widthbase [f ]+ 
	  fontinfo [charbase [f ]+ effectivechar ( true , f , mem [curp ]
	  .hh.b1 ) ].qqqq .b0 ].cint ;
	  curp = mem [curp ].hh .v.RH ;
	} while ( ! ( ! ( curp >= himemmin ) ) ) ;
      } 
      switch ( mem [curp ].hh.b0 ) 
      {case 0 : 
      case 1 : 
      case 2 : 
	activewidth [1 ]= activewidth [1 ]+ mem [curp + 1 ].cint ;
	break ;
      case 8 : 
	if ( mem [curp ].hh.b1 == 4 ) 
	{
	  curlang = mem [curp + 1 ].hh .v.RH ;
	  lhyf = mem [curp + 1 ].hh.b0 ;
	  rhyf = mem [curp + 1 ].hh.b1 ;
	} 
	break ;
      case 10 : 
	{
	  if ( autobreaking ) 
	  {
	    if ( ( prevp >= himemmin ) ) 
	    trybreak ( 0 , 0 ) ;
	    else if ( ( mem [prevp ].hh.b0 < 9 ) ) 
	    trybreak ( 0 , 0 ) ;
	    else if ( ( mem [prevp ].hh.b0 == 11 ) && ( mem [prevp ].hh.b1 
	    != 1 ) ) 
	    trybreak ( 0 , 0 ) ;
	  } 
	  if ( ( mem [mem [curp + 1 ].hh .v.LH ].hh.b1 != 0 ) && ( mem [
	  mem [curp + 1 ].hh .v.LH + 3 ].cint != 0 ) ) 
	  {
	    mem [curp + 1 ].hh .v.LH = finiteshrink ( mem [curp + 1 ].hh 
	    .v.LH ) ;
	  } 
	  q = mem [curp + 1 ].hh .v.LH ;
	  activewidth [1 ]= activewidth [1 ]+ mem [q + 1 ].cint ;
	  activewidth [2 + mem [q ].hh.b0 ]= activewidth [2 + mem [q ]
	  .hh.b0 ]+ mem [q + 2 ].cint ;
	  activewidth [6 ]= activewidth [6 ]+ mem [q + 3 ].cint ;
	  if ( secondpass && autobreaking ) 
	  {
	    prevs = curp ;
	    s = mem [prevs ].hh .v.RH ;
	    if ( s != -268435455L ) 
	    {
	      while ( true ) {
		  
		if ( ( s >= himemmin ) ) 
		{
		  c = mem [s ].hh.b1 ;
		  hf = mem [s ].hh.b0 ;
		} 
		else if ( mem [s ].hh.b0 == 6 ) 
		if ( mem [s + 1 ].hh .v.RH == -268435455L ) 
		goto lab22 ;
		else {
		    
		  q = mem [s + 1 ].hh .v.RH ;
		  c = mem [q ].hh.b1 ;
		  hf = mem [q ].hh.b0 ;
		} 
		else if ( ( mem [s ].hh.b0 == 11 ) && ( mem [s ].hh.b1 == 
		0 ) ) 
		goto lab22 ;
		else if ( mem [s ].hh.b0 == 8 ) 
		{
		  if ( mem [s ].hh.b1 == 4 ) 
		  {
		    curlang = mem [s + 1 ].hh .v.RH ;
		    lhyf = mem [s + 1 ].hh.b0 ;
		    rhyf = mem [s + 1 ].hh.b1 ;
		  } 
		  goto lab22 ;
		} 
		else goto lab31 ;
		if ( eqtb [13887 + c ].hh .v.RH != 0 ) 
		if ( ( eqtb [13887 + c ].hh .v.RH == c ) || ( eqtb [15205 ]
		.cint > 0 ) ) 
		goto lab32 ;
		else goto lab31 ;
		lab22: prevs = s ;
		s = mem [prevs ].hh .v.RH ;
	      } 
	      lab32: hyfchar = hyphenchar [hf ];
	      if ( hyfchar < 0 ) 
	      goto lab31 ;
	      if ( hyfchar > 255 ) 
	      goto lab31 ;
	      ha = prevs ;
	      if ( lhyf + rhyf > 63 ) 
	      goto lab31 ;
	      hn = 0 ;
	      while ( true ) {
		  
		if ( ( s >= himemmin ) ) 
		{
		  if ( mem [s ].hh.b0 != hf ) 
		  goto lab33 ;
		  hyfbchar = mem [s ].hh.b1 ;
		  c = hyfbchar ;
		  if ( eqtb [13887 + c ].hh .v.RH == 0 ) 
		  goto lab33 ;
		  if ( hn == 63 ) 
		  goto lab33 ;
		  hb = s ;
		  incr ( hn ) ;
		  hu [hn ]= c ;
		  hc [hn ]= eqtb [13887 + c ].hh .v.RH ;
		  hyfbchar = 256 ;
		} 
		else if ( mem [s ].hh.b0 == 6 ) 
		{
		  if ( mem [s + 1 ].hh.b0 != hf ) 
		  goto lab33 ;
		  j = hn ;
		  q = mem [s + 1 ].hh .v.RH ;
		  if ( q > -268435455L ) 
		  hyfbchar = mem [q ].hh.b1 ;
		  while ( q > -268435455L ) {
		      
		    c = mem [q ].hh.b1 ;
		    if ( eqtb [13887 + c ].hh .v.RH == 0 ) 
		    goto lab33 ;
		    if ( j == 63 ) 
		    goto lab33 ;
		    incr ( j ) ;
		    hu [j ]= c ;
		    hc [j ]= eqtb [13887 + c ].hh .v.RH ;
		    q = mem [q ].hh .v.RH ;
		  } 
		  hb = s ;
		  hn = j ;
		  if ( odd ( mem [s ].hh.b1 ) ) 
		  hyfbchar = fontbchar [hf ];
		  else hyfbchar = 256 ;
		} 
		else if ( ( mem [s ].hh.b0 == 11 ) && ( mem [s ].hh.b1 == 
		0 ) ) 
		{
		  hb = s ;
		  hyfbchar = fontbchar [hf ];
		} 
		else goto lab33 ;
		s = mem [s ].hh .v.RH ;
	      } 
	      lab33: ;
	      if ( hn < lhyf + rhyf ) 
	      goto lab31 ;
	      while ( true ) {
		  
		if ( ! ( ( s >= himemmin ) ) ) 
		switch ( mem [s ].hh.b0 ) 
		{case 6 : 
		  ;
		  break ;
		case 11 : 
		  if ( mem [s ].hh.b1 != 0 ) 
		  goto lab34 ;
		  break ;
		case 8 : 
		case 10 : 
		case 12 : 
		case 3 : 
		case 5 : 
		case 4 : 
		  goto lab34 ;
		  break ;
		  default: 
		  goto lab31 ;
		  break ;
		} 
		s = mem [s ].hh .v.RH ;
	      } 
	      lab34: ;
	      hyphenate () ;
	    } 
	    lab31: ;
	  } 
	} 
	break ;
      case 11 : 
	if ( mem [curp ].hh.b1 == 1 ) 
	{
	  if ( ! ( mem [curp ].hh .v.RH >= himemmin ) && autobreaking ) 
	  if ( mem [mem [curp ].hh .v.RH ].hh.b0 == 10 ) 
	  trybreak ( 0 , 0 ) ;
	  activewidth [1 ]= activewidth [1 ]+ mem [curp + 1 ].cint ;
	} 
	else activewidth [1 ]= activewidth [1 ]+ mem [curp + 1 ].cint ;
	break ;
      case 6 : 
	{
	  f = mem [curp + 1 ].hh.b0 ;
	  activewidth [1 ]= activewidth [1 ]+ fontinfo [widthbase [f ]+ 
	  fontinfo [charbase [f ]+ effectivechar ( true , f , mem [curp + 
	  1 ].hh.b1 ) ].qqqq .b0 ].cint ;
	} 
	break ;
      case 7 : 
	{
	  s = mem [curp + 1 ].hh .v.LH ;
	  discwidth = 0 ;
	  if ( s == -268435455L ) 
	  trybreak ( eqtb [15171 ].cint , 1 ) ;
	  else {
	      
	    do {
		if ( ( s >= himemmin ) ) 
	      {
		f = mem [s ].hh.b0 ;
		discwidth = discwidth + fontinfo [widthbase [f ]+ fontinfo 
		[charbase [f ]+ effectivechar ( true , f , mem [s ].hh.b1 
		) ].qqqq .b0 ].cint ;
	      } 
	      else switch ( mem [s ].hh.b0 ) 
	      {case 6 : 
		{
		  f = mem [s + 1 ].hh.b0 ;
		  discwidth = discwidth + fontinfo [widthbase [f ]+ 
		  fontinfo [charbase [f ]+ effectivechar ( true , f , mem [
		  s + 1 ].hh.b1 ) ].qqqq .b0 ].cint ;
		} 
		break ;
	      case 0 : 
	      case 1 : 
	      case 2 : 
	      case 11 : 
		discwidth = discwidth + mem [s + 1 ].cint ;
		break ;
		default: 
		confusion ( 949 ) ;
		break ;
	      } 
	      s = mem [s ].hh .v.RH ;
	    } while ( ! ( s == -268435455L ) ) ;
	    activewidth [1 ]= activewidth [1 ]+ discwidth ;
	    trybreak ( eqtb [15170 ].cint , 1 ) ;
	    activewidth [1 ]= activewidth [1 ]- discwidth ;
	  } 
	  r = mem [curp ].hh.b1 ;
	  s = mem [curp ].hh .v.RH ;
	  while ( r > 0 ) {
	      
	    if ( ( s >= himemmin ) ) 
	    {
	      f = mem [s ].hh.b0 ;
	      activewidth [1 ]= activewidth [1 ]+ fontinfo [widthbase [f 
	      ]+ fontinfo [charbase [f ]+ effectivechar ( true , f , mem [
	      s ].hh.b1 ) ].qqqq .b0 ].cint ;
	    } 
	    else switch ( mem [s ].hh.b0 ) 
	    {case 6 : 
	      {
		f = mem [s + 1 ].hh.b0 ;
		activewidth [1 ]= activewidth [1 ]+ fontinfo [widthbase [
		f ]+ fontinfo [charbase [f ]+ effectivechar ( true , f , 
		mem [s + 1 ].hh.b1 ) ].qqqq .b0 ].cint ;
	      } 
	      break ;
	    case 0 : 
	    case 1 : 
	    case 2 : 
	    case 11 : 
	      activewidth [1 ]= activewidth [1 ]+ mem [s + 1 ].cint ;
	      break ;
	      default: 
	      confusion ( 950 ) ;
	      break ;
	    } 
	    decr ( r ) ;
	    s = mem [s ].hh .v.RH ;
	  } 
	  prevp = curp ;
	  curp = s ;
	  goto lab35 ;
	} 
	break ;
      case 9 : 
	{
	  autobreaking = ( mem [curp ].hh.b1 == 1 ) ;
	  {
	    if ( ! ( mem [curp ].hh .v.RH >= himemmin ) && autobreaking ) 
	    if ( mem [mem [curp ].hh .v.RH ].hh.b0 == 10 ) 
	    trybreak ( 0 , 0 ) ;
	    activewidth [1 ]= activewidth [1 ]+ mem [curp + 1 ].cint ;
	  } 
	} 
	break ;
      case 12 : 
	trybreak ( mem [curp + 1 ].cint , 0 ) ;
	break ;
      case 4 : 
      case 3 : 
      case 5 : 
	;
	break ;
	default: 
	confusion ( 948 ) ;
	break ;
      } 
      prevp = curp ;
      curp = mem [curp ].hh .v.RH ;
      lab35: ;
    } 
    if ( curp == -268435455L ) 
    {
      trybreak ( -10000 , 1 ) ;
      if ( mem [memtop - 7 ].hh .v.RH != memtop - 7 ) 
      {
	r = mem [memtop - 7 ].hh .v.RH ;
	fewestdemerits = 1073741823L ;
	do {
	    if ( mem [r ].hh.b0 != 2 ) 
	  if ( mem [r + 2 ].cint < fewestdemerits ) 
	  {
	    fewestdemerits = mem [r + 2 ].cint ;
	    bestbet = r ;
	  } 
	  r = mem [r ].hh .v.RH ;
	} while ( ! ( r == memtop - 7 ) ) ;
	bestline = mem [bestbet + 1 ].hh .v.LH ;
	if ( eqtb [15186 ].cint == 0 ) 
	goto lab30 ;
	{
	  r = mem [memtop - 7 ].hh .v.RH ;
	  actuallooseness = 0 ;
	  do {
	      if ( mem [r ].hh.b0 != 2 ) 
	    {
	      linediff = intcast ( mem [r + 1 ].hh .v.LH ) - intcast ( 
	      bestline ) ;
	      if ( ( ( linediff < actuallooseness ) && ( eqtb [15186 ].cint 
	      <= linediff ) ) || ( ( linediff > actuallooseness ) && ( eqtb [
	      15186 ].cint >= linediff ) ) ) 
	      {
		bestbet = r ;
		actuallooseness = linediff ;
		fewestdemerits = mem [r + 2 ].cint ;
	      } 
	      else if ( ( linediff == actuallooseness ) && ( mem [r + 2 ]
	      .cint < fewestdemerits ) ) 
	      {
		bestbet = r ;
		fewestdemerits = mem [r + 2 ].cint ;
	      } 
	    } 
	    r = mem [r ].hh .v.RH ;
	  } while ( ! ( r == memtop - 7 ) ) ;
	  bestline = mem [bestbet + 1 ].hh .v.LH ;
	} 
	if ( ( actuallooseness == eqtb [15186 ].cint ) || finalpass ) 
	goto lab30 ;
      } 
    } 
    q = mem [memtop - 7 ].hh .v.RH ;
    while ( q != memtop - 7 ) {
	
      curp = mem [q ].hh .v.RH ;
      if ( mem [q ].hh.b0 == 2 ) 
      freenode ( q , 7 ) ;
      else freenode ( q , 3 ) ;
      q = curp ;
    } 
    q = passive ;
    while ( q != -268435455L ) {
	
      curp = mem [q ].hh .v.RH ;
      freenode ( q , 2 ) ;
      q = curp ;
    } 
    if ( ! secondpass ) 
    {
	;
#ifdef STAT
      if ( eqtb [15199 ].cint > 0 ) 
      printnl ( 946 ) ;
#endif /* STAT */
      threshold = eqtb [15168 ].cint ;
      secondpass = true ;
      finalpass = ( eqtb [15761 ].cint <= 0 ) ;
    } 
    else {
	
	;
#ifdef STAT
      if ( eqtb [15199 ].cint > 0 ) 
      printnl ( 947 ) ;
#endif /* STAT */
      background [2 ]= background [2 ]+ eqtb [15761 ].cint ;
      finalpass = true ;
    } 
  } 
  lab30: 
	;
#ifdef STAT
  if ( eqtb [15199 ].cint > 0 ) 
  {
    enddiagnostic ( true ) ;
    normalizeselector () ;
  } 
#endif /* STAT */
  postlinebreak ( finalwidowpenalty ) ;
  q = mem [memtop - 7 ].hh .v.RH ;
  while ( q != memtop - 7 ) {
      
    curp = mem [q ].hh .v.RH ;
    if ( mem [q ].hh.b0 == 2 ) 
    freenode ( q , 7 ) ;
    else freenode ( q , 3 ) ;
    q = curp ;
  } 
  q = passive ;
  while ( q != -268435455L ) {
      
    curp = mem [q ].hh .v.RH ;
    freenode ( q , 2 ) ;
    q = curp ;
  } 
  packbeginline = 0 ;
} 
void 
#ifdef HAVE_PROTOTYPES
prefixedcommand ( void ) 
#else
prefixedcommand ( ) 
#endif
{
  /* 30 10 */ prefixedcommand_regmem 
  smallnumber a  ;
  internalfontnumber f  ;
  halfword j  ;
  fontindex k  ;
  halfword p, q, r  ;
  integer n  ;
  boolean e  ;
  a = 0 ;
  while ( curcmd == 93 ) {
      
    if ( ! odd ( a / curchr ) ) 
    a = a + curchr ;
    do {
	getxtoken () ;
    } while ( ! ( ( curcmd != 10 ) && ( curcmd != 0 ) ) ) ;
    if ( curcmd <= 70 ) 
    {
      {
	if ( interaction == 3 ) 
	;
	if ( filelineerrorstylep ) 
	printfileline () ;
	else printnl ( 262 ) ;
	print ( 1191 ) ;
      } 
      printcmdchr ( curcmd , curchr ) ;
      printchar ( 39 ) ;
      {
	helpptr = 1 ;
	helpline [0 ]= 1192 ;
      } 
      backerror () ;
      return ;
    } 
  } 
  if ( ( curcmd != 97 ) && ( a % 4 != 0 ) ) 
  {
    {
      if ( interaction == 3 ) 
      ;
      if ( filelineerrorstylep ) 
      printfileline () ;
      else printnl ( 262 ) ;
      print ( 699 ) ;
    } 
    printesc ( 1183 ) ;
    print ( 1193 ) ;
    printesc ( 1184 ) ;
    print ( 1194 ) ;
    printcmdchr ( curcmd , curchr ) ;
    printchar ( 39 ) ;
    {
      helpptr = 1 ;
      helpline [0 ]= 1195 ;
    } 
    error () ;
  } 
  if ( eqtb [15210 ].cint != 0 ) 
  if ( eqtb [15210 ].cint < 0 ) 
  {
    if ( ( a >= 4 ) ) 
    a = a - 4 ;
  } 
  else {
      
    if ( ! ( a >= 4 ) ) 
    a = a + 4 ;
  } 
  switch ( curcmd ) 
  {case 87 : 
    if ( ( a >= 4 ) ) 
    geqdefine ( 13579 , 120 , curchr ) ;
    else eqdefine ( 13579 , 120 , curchr ) ;
    break ;
  case 97 : 
    {
      if ( odd ( curchr ) && ! ( a >= 4 ) && ( eqtb [15210 ].cint >= 0 ) ) 
      a = a + 4 ;
      e = ( curchr >= 2 ) ;
      getrtoken () ;
      p = curcs ;
      q = scantoks ( true , e ) ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 111 + ( a % 4 ) , defref ) ;
      else eqdefine ( p , 111 + ( a % 4 ) , defref ) ;
    } 
    break ;
  case 94 : 
    if ( curchr == 11 ) 
    ;
    else if ( curchr == 10 ) 
    {
      selector = 19 ;
      gettoken () ;
      mubytestoken = curtok ;
      if ( curtok <= 4095 ) 
      mubytestoken = curtok % 256 ;
      mubyteprefix = 60 ;
      mubyterelax = false ;
      mubytetablein = true ;
      mubytetableout = true ;
      getxtoken () ;
      if ( curcmd == 10 ) 
      getxtoken () ;
      if ( curcmd == 8 ) 
      {
	mubytetableout = false ;
	getxtoken () ;
	if ( curcmd == 8 ) 
	{
	  mubytetableout = true ;
	  mubytetablein = false ;
	  getxtoken () ;
	} 
      } 
      else if ( ( mubytestoken > 4095 ) && ( curcmd == 6 ) ) 
      {
	mubytetableout = false ;
	scanint () ;
	mubyteprefix = curval ;
	getxtoken () ;
	if ( mubyteprefix > 50 ) 
	mubyteprefix = 52 ;
	if ( mubyteprefix <= 0 ) 
	mubyteprefix = 51 ;
      } 
      else if ( ( mubytestoken > 4095 ) && ( curcmd == 0 ) ) 
      {
	mubytetableout = true ;
	mubytetablein = false ;
	mubyterelax = true ;
	getxtoken () ;
      } 
      r = getavail () ;
      p = r ;
      while ( curcs == 0 ) {
	  
	{
	  q = getavail () ;
	  mem [p ].hh .v.RH = q ;
	  mem [q ].hh .v.LH = curtok ;
	  p = q ;
	} 
	getxtoken () ;
      } 
      if ( ( curcmd != 67 ) || ( curchr != 10 ) ) 
      {
	{
	  if ( interaction == 3 ) 
	  ;
	  if ( filelineerrorstylep ) 
	  printfileline () ;
	  else printnl ( 262 ) ;
	  print ( 639 ) ;
	} 
	printesc ( 528 ) ;
	print ( 640 ) ;
	{
	  helpptr = 2 ;
	  helpline [1 ]= 641 ;
	  helpline [0 ]= 1207 ;
	} 
	backerror () ;
      } 
      p = mem [r ].hh .v.RH ;
      if ( ( p == -268435455L ) && mubytetablein ) 
      {
	{
	  if ( interaction == 3 ) 
	  ;
	  if ( filelineerrorstylep ) 
	  printfileline () ;
	  else printnl ( 262 ) ;
	  print ( 1208 ) ;
	} 
	printesc ( 1205 ) ;
	print ( 1209 ) ;
	{
	  helpptr = 2 ;
	  helpline [1 ]= 1210 ;
	  helpline [0 ]= 1211 ;
	} 
	error () ;
      } 
      else {
	  
	while ( p != -268435455L ) {
	    
	  {
	    strpool [poolptr ]= mem [p ].hh .v.LH % 256 ;
	    incr ( poolptr ) ;
	  } 
	  p = mem [p ].hh .v.RH ;
	} 
	flushlist ( r ) ;
	if ( ( strstart [strptr ]+ 1 == poolptr ) && ( strpool [poolptr - 1 
	]== mubytestoken ) ) 
	{
	  if ( mubyteread [mubytestoken ]!= -268435455L && mubytetablein ) 
	  disposemunode ( mubyteread [mubytestoken ]) ;
	  if ( mubytetablein ) 
	  mubyteread [mubytestoken ]= -268435455L ;
	  if ( mubytetableout ) 
	  mubytewrite [mubytestoken ]= 0 ;
	  poolptr = strstart [strptr ];
	} 
	else {
	    
	  if ( mubytetablein ) 
	  mubyteupdate () ;
	  if ( mubytetableout ) 
	  {
	    if ( mubytestoken > 4095 ) 
	    {
	      disposemutableout ( mubytestoken - 4095 ) ;
	      if ( ( strstart [strptr ]< poolptr ) || mubyterelax ) 
	      {
		r = mubytecswrite [( mubytestoken - 4095 ) % 128 ];
		p = getavail () ;
		mubytecswrite [( mubytestoken - 4095 ) % 128 ]= p ;
		mem [p ].hh .v.LH = mubytestoken - 4095 ;
		mem [p ].hh .v.RH = getavail () ;
		p = mem [p ].hh .v.RH ;
		if ( mubyterelax ) 
		{
		  mem [p ].hh .v.LH = 0 ;
		  poolptr = strstart [strptr ];
		} 
		else mem [p ].hh .v.LH = slowmakestring () ;
		mem [p ].hh .v.RH = r ;
	      } 
	    } 
	    else {
		
	      if ( strstart [strptr ]== poolptr ) 
	      mubytewrite [mubytestoken ]= 0 ;
	      else mubytewrite [mubytestoken ]= slowmakestring () ;
	    } 
	  } 
	  else poolptr = strstart [strptr ];
	} 
      } 
    } 
    else {
	
      n = curchr ;
      getrtoken () ;
      p = curcs ;
      if ( n == 0 ) 
      {
	do {
	    gettoken () ;
	} while ( ! ( curcmd != 10 ) ) ;
	if ( curtok == 3133 ) 
	{
	  gettoken () ;
	  if ( curcmd == 10 ) 
	  gettoken () ;
	} 
      } 
      else {
	  
	gettoken () ;
	q = curtok ;
	gettoken () ;
	backinput () ;
	curtok = q ;
	backinput () ;
      } 
      if ( curcmd >= 111 ) 
      incr ( mem [curchr ].hh .v.LH ) ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , curcmd , curchr ) ;
      else eqdefine ( p , curcmd , curchr ) ;
    } 
    break ;
  case 95 : 
    if ( curchr == 7 ) 
    {
      scancharnum () ;
      p = 14911 + curval ;
      scanoptionalequals () ;
      scancharnum () ;
      n = curval ;
      scancharnum () ;
      if ( ( eqtb [15224 ].cint > 0 ) ) 
      {
	begindiagnostic () ;
	printnl ( 1220 ) ;
	print ( p - 14911 ) ;
	print ( 1221 ) ;
	print ( n ) ;
	printchar ( 32 ) ;
	print ( curval ) ;
	enddiagnostic ( false ) ;
      } 
      n = n * 256 + curval ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 120 , n ) ;
      else eqdefine ( p , 120 , n ) ;
      if ( ( p - 14911 ) < eqtb [15222 ].cint ) 
      if ( ( a >= 4 ) ) 
      geqworddefine ( 15222 , p - 14911 ) ;
      else eqworddefine ( 15222 , p - 14911 ) ;
      if ( ( p - 14911 ) > eqtb [15223 ].cint ) 
      if ( ( a >= 4 ) ) 
      geqworddefine ( 15223 , p - 14911 ) ;
      else eqworddefine ( 15223 , p - 14911 ) ;
    } 
    else {
	
      n = curchr ;
      getrtoken () ;
      p = curcs ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 0 , 256 ) ;
      else eqdefine ( p , 0 , 256 ) ;
      scanoptionalequals () ;
      switch ( n ) 
      {case 0 : 
	{
	  scancharnum () ;
	  if ( ( a >= 4 ) ) 
	  geqdefine ( p , 68 , curval ) ;
	  else eqdefine ( p , 68 , curval ) ;
	} 
	break ;
      case 1 : 
	{
	  scanfifteenbitint () ;
	  if ( ( a >= 4 ) ) 
	  geqdefine ( p , 69 , curval ) ;
	  else eqdefine ( p , 69 , curval ) ;
	} 
	break ;
	default: 
	{
	  scaneightbitint () ;
	  switch ( n ) 
	  {case 2 : 
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 73 , 15229 + curval ) ;
	    else eqdefine ( p , 73 , 15229 + curval ) ;
	    break ;
	  case 3 : 
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 74 , 15762 + curval ) ;
	    else eqdefine ( p , 74 , 15762 + curval ) ;
	    break ;
	  case 4 : 
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 75 , 12545 + curval ) ;
	    else eqdefine ( p , 75 , 12545 + curval ) ;
	    break ;
	  case 5 : 
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 76 , 12801 + curval ) ;
	    else eqdefine ( p , 76 , 12801 + curval ) ;
	    break ;
	  case 6 : 
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 72 , 13067 + curval ) ;
	    else eqdefine ( p , 72 , 13067 + curval ) ;
	    break ;
	  } 
	} 
	break ;
      } 
    } 
    break ;
  case 96 : 
    {
      scanint () ;
      n = curval ;
      if ( ! scankeyword ( 854 ) ) 
      {
	{
	  if ( interaction == 3 ) 
	  ;
	  if ( filelineerrorstylep ) 
	  printfileline () ;
	  else printnl ( 262 ) ;
	  print ( 1084 ) ;
	} 
	{
	  helpptr = 2 ;
	  helpline [1 ]= 1222 ;
	  helpline [0 ]= 1223 ;
	} 
	error () ;
      } 
      getrtoken () ;
      p = curcs ;
      readtoks ( n , p ) ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 111 , curval ) ;
      else eqdefine ( p , 111 , curval ) ;
    } 
    break ;
  case 71 : 
  case 72 : 
    {
      q = curcs ;
      if ( curcmd == 71 ) 
      {
	scaneightbitint () ;
	p = 13067 + curval ;
      } 
      else p = curchr ;
      scanoptionalequals () ;
      do {
	  getxtoken () ;
      } while ( ! ( ( curcmd != 10 ) && ( curcmd != 0 ) ) ) ;
      if ( curcmd != 1 ) 
      {
	if ( curcmd == 71 ) 
	{
	  scaneightbitint () ;
	  curcmd = 72 ;
	  curchr = 13067 + curval ;
	} 
	if ( curcmd == 72 ) 
	{
	  q = eqtb [curchr ].hh .v.RH ;
	  if ( q == -268435455L ) 
	  if ( ( a >= 4 ) ) 
	  geqdefine ( p , 101 , -268435455L ) ;
	  else eqdefine ( p , 101 , -268435455L ) ;
	  else {
	      
	    incr ( mem [q ].hh .v.LH ) ;
	    if ( ( a >= 4 ) ) 
	    geqdefine ( p , 111 , q ) ;
	    else eqdefine ( p , 111 , q ) ;
	  } 
	  goto lab30 ;
	} 
      } 
      backinput () ;
      curcs = q ;
      q = scantoks ( false , false ) ;
      if ( mem [defref ].hh .v.RH == -268435455L ) 
      {
	if ( ( a >= 4 ) ) 
	geqdefine ( p , 101 , -268435455L ) ;
	else eqdefine ( p , 101 , -268435455L ) ;
	{
	  mem [defref ].hh .v.RH = avail ;
	  avail = defref ;
	;
#ifdef STAT
	  decr ( dynused ) ;
#endif /* STAT */
	} 
      } 
      else {
	  
	if ( p == 13058 ) 
	{
	  mem [q ].hh .v.RH = getavail () ;
	  q = mem [q ].hh .v.RH ;
	  mem [q ].hh .v.LH = 637 ;
	  q = getavail () ;
	  mem [q ].hh .v.LH = 379 ;
	  mem [q ].hh .v.RH = mem [defref ].hh .v.RH ;
	  mem [defref ].hh .v.RH = q ;
	} 
	if ( ( a >= 4 ) ) 
	geqdefine ( p , 111 , defref ) ;
	else eqdefine ( p , 111 , defref ) ;
      } 
    } 
    break ;
  case 73 : 
    {
      p = curchr ;
      scanoptionalequals () ;
      scanint () ;
      if ( ( a >= 4 ) ) 
      geqworddefine ( p , curval ) ;
      else eqworddefine ( p , curval ) ;
    } 
    break ;
  case 74 : 
    {
      p = curchr ;
      scanoptionalequals () ;
      scandimen ( false , false , false ) ;
      if ( ( a >= 4 ) ) 
      geqworddefine ( p , curval ) ;
      else eqworddefine ( p , curval ) ;
    } 
    break ;
  case 75 : 
  case 76 : 
    {
      p = curchr ;
      n = curcmd ;
      scanoptionalequals () ;
      if ( n == 76 ) 
      scanglue ( 3 ) ;
      else scanglue ( 2 ) ;
      trapzeroglue () ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 117 , curval ) ;
      else eqdefine ( p , 117 , curval ) ;
    } 
    break ;
  case 85 : 
    {
      if ( curchr == 13631 ) 
      n = 15 ;
      else if ( curchr == 14655 ) 
      n = 32768L ;
      else if ( curchr == 14399 ) 
      n = 32767 ;
      else if ( curchr == 15485 ) 
      n = 16777215L ;
      else n = 255 ;
      p = curchr ;
      scancharnum () ;
      if ( p == 13580 ) 
      p = curval ;
      else if ( p == 13581 ) 
      p = curval + 256 ;
      else if ( p == 13582 ) 
      p = curval + 512 ;
      else p = p + curval ;
      scanoptionalequals () ;
      scanint () ;
      if ( ( ( curval < 0 ) && ( p < 15485 ) ) || ( curval > n ) ) 
      {
	{
	  if ( interaction == 3 ) 
	  ;
	  if ( filelineerrorstylep ) 
	  printfileline () ;
	  else printnl ( 262 ) ;
	  print ( 1227 ) ;
	} 
	printint ( curval ) ;
	if ( p < 15485 ) 
	print ( 1228 ) ;
	else print ( 1229 ) ;
	printint ( n ) ;
	{
	  helpptr = 1 ;
	  helpline [0 ]= 1230 ;
	} 
	error () ;
	curval = 0 ;
      } 
      if ( p < 256 ) 
      xord [p ]= curval ;
      else if ( p < 512 ) 
      xchr [p - 256 ]= curval ;
      else if ( p < 768 ) 
      xprn [p - 512 ]= curval ;
      else if ( p < 14655 ) 
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 120 , curval ) ;
      else eqdefine ( p , 120 , curval ) ;
      else if ( p < 15485 ) 
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 120 , curval ) ;
      else eqdefine ( p , 120 , curval ) ;
      else if ( ( a >= 4 ) ) 
      geqworddefine ( p , curval ) ;
      else eqworddefine ( p , curval ) ;
    } 
    break ;
  case 86 : 
    {
      p = curchr ;
      scanfourbitint () ;
      p = p + curval ;
      scanoptionalequals () ;
      scanfontident () ;
      if ( ( a >= 4 ) ) 
      geqdefine ( p , 120 , curval ) ;
      else eqdefine ( p , 120 , curval ) ;
    } 
    break ;
  case 89 : 
  case 90 : 
  case 91 : 
  case 92 : 
    doregistercommand ( a ) ;
    break ;
  case 98 : 
    {
      scaneightbitint () ;
      if ( ( a >= 4 ) ) 
      n = 256 + curval ;
      else n = curval ;
      scanoptionalequals () ;
      if ( setboxallowed ) 
      scanbox ( 1073741824L + n ) ;
      else {
	  
	{
	  if ( interaction == 3 ) 
	  ;
	  if ( filelineerrorstylep ) 
	  printfileline () ;
	  else printnl ( 262 ) ;
	  print ( 694 ) ;
	} 
	printesc ( 549 ) ;
	{
	  helpptr = 2 ;
	  helpline [1 ]= 1236 ;
	  helpline [0 ]= 1237 ;
	} 
	error () ;
      } 
    } 
    break ;
  case 79 : 
    alteraux () ;
    break ;
  case 80 : 
    alterprevgraf () ;
    break ;
  case 81 : 
    alterpagesofar () ;
    break ;
  case 82 : 
    alterinteger () ;
    break ;
  case 83 : 
    alterboxdimen () ;
    break ;
  case 84 : 
    {
      scanoptionalequals () ;
      scanint () ;
      n = curval ;
      if ( n <= 0 ) 
      p = -268435455L ;
      else {
	  
	p = getnode ( 2 * n + 1 ) ;
	mem [p ].hh .v.LH = n ;
	{register integer for_end; j = 1 ;for_end = n ; if ( j <= for_end) 
	do 
	  {
	    scandimen ( false , false , false ) ;
	    mem [p + 2 * j - 1 ].cint = curval ;
	    scandimen ( false , false , false ) ;
	    mem [p + 2 * j ].cint = curval ;
	  } 
	while ( j++ < for_end ) ;} 
      } 
      if ( ( a >= 4 ) ) 
      geqdefine ( 13057 , 118 , p ) ;
      else eqdefine ( 13057 , 118 , p ) ;
    } 
    break ;
  case 99 : 
    if ( curchr == 1 ) 
    {
	;
#ifdef INITEX
      if ( iniversion ) 
      {
	newpatterns () ;
	goto lab30 ;
      } 
#endif /* INITEX */
      {
	if ( interaction == 3 ) 
	;
	if ( filelineerrorstylep ) 
	printfileline () ;
	else printnl ( 262 ) ;
	print ( 1241 ) ;
      } 
      helpptr = 0 ;
      error () ;
      do {
	  gettoken () ;
      } while ( ! ( curcmd == 2 ) ) ;
      return ;
    } 
    else {
	
      newhyphexceptions () ;
      goto lab30 ;
    } 
    break ;
  case 77 : 
    {
      findfontdimen ( true ) ;
      k = curval ;
      scanoptionalequals () ;
      scandimen ( false , false , false ) ;
      fontinfo [k ].cint = curval ;
    } 
    break ;
  case 78 : 
    {
      n = curchr ;
      scanfontident () ;
      f = curval ;
      scanoptionalequals () ;
      scanint () ;
      if ( n == 0 ) 
      hyphenchar [f ]= curval ;
      else skewchar [f ]= curval ;
    } 
    break ;
  case 88 : 
    newfont ( a ) ;
    break ;
  case 100 : 
    newinteraction () ;
    break ;
    default: 
    confusion ( 1190 ) ;
    break ;
  } 
  lab30: if ( aftertoken != 0 ) 
  {
    curtok = aftertoken ;
    backinput () ;
    aftertoken = 0 ;
  } 
} 
#ifdef INITEX
void 
#ifdef HAVE_PROTOTYPES
storefmtfile ( void ) 
#else
storefmtfile ( ) 
#endif
{
  /* 41 42 31 32 */ storefmtfile_regmem 
  integer j, k, l  ;
  halfword p, q  ;
  integer x  ;
  ASCIIcode * formatengine  ;

#if defined(WORDS_BIGENDIAN)
  printf("WORDS_BIGENDIAN is defined\n");
#else
  printf("WORDS_BIGENDIAN is NOT defined\n");
#endif
#if defined(NO_DUMP_SHARE)
  printf("NO_DUMP_SHARE is defined\n");
#else
  printf("NO_DUMP_SHARE is NOT defined\n");
#endif
  printf("sizeof(mem[0]) = %d\n", sizeof(mem[0]));

  if ( saveptr != 0 ) 
  {
    {
      if ( interaction == 3 ) 
      ;
      if ( filelineerrorstylep ) 
      printfileline () ;
      else printnl ( 262 ) ;
      print ( 1283 ) ;
    } 
    {
      helpptr = 1 ;
      helpline [0 ]= 1284 ;
    } 
    {
      if ( interaction == 3 ) 
      interaction = 2 ;
      if ( logopened ) 
      error () ;
	;
#ifdef TEXMF_DEBUG
      if ( interaction > 0 ) 
      debughelp () ;
#endif /* TEXMF_DEBUG */
      history = 3 ;
      jumpout () ;
    } 
  } 
  selector = 21 ;
  print ( 1300 ) ;
  print ( jobname ) ;
  printchar ( 32 ) ;
  printint ( eqtb [15190 ].cint ) ;
  printchar ( 46 ) ;
  printint ( eqtb [15189 ].cint ) ;
  printchar ( 46 ) ;
  printint ( eqtb [15188 ].cint ) ;
  printchar ( 41 ) ;
  if ( interaction == 0 ) 
  selector = 18 ;
  else selector = 19 ;
  {
    if ( poolptr + 1 > poolsize ) 
    overflow ( 257 , poolsize - initpoolptr ) ;
  } 
  formatident = makestring () ;
  packjobname ( 797 ) ;
  while ( ! wopenout ( fmtfile ) ) promptfilename ( 1301 , 797 ) ;
  printnl ( 1302 ) ;
  slowprint ( wmakenamestring ( fmtfile ) ) ;
  {
    decr ( strptr ) ;
    poolptr = strstart [strptr ];
  } 
  printnl ( 335 ) ;
  slowprint ( formatident ) ;
  dumpint ( 1462916184L ) ;
  x = strlen ( enginename ) ;
  formatengine = xmallocarray ( ASCIIcode , x + 4 ) ;
  strcpy ( formatengine , enginename ) ;
  {register integer for_end; k = x ;for_end = x + 3 ; if ( k <= for_end) do 
    formatengine [k ]= 0 ;
  while ( k++ < for_end ) ;} 
  x = x + 4 - ( x % 4 ) ;
  dumpint ( x ) ;
  dumpthings ( formatengine [0 ], x ) ;
  libcfree ( formatengine ) ;
  dumpint ( 128540375L ) ;
  dumpthings ( xord [0 ], 256 ) ;
  dumpthings ( xchr [0 ], 256 ) ;
  dumpthings ( xprn [0 ], 256 ) ;
  dumpint ( 268435455L ) ;
  dumpint ( hashhigh ) ;
  dumpint ( membot ) ;
  dumpint ( memtop ) ;
  dumpint ( 16017 ) ;
  dumpint ( 8501 ) ;
  dumpint ( 607 ) ;
  dumpint ( 1296847960L ) ;
  if ( mltexp ) 
  dumpint ( 1 ) ;
  else dumpint ( 0 ) ;
  dumpint ( 1162040408L ) ;
  if ( ! enctexp ) 
  dumpint ( 0 ) ;
  else {
      
    dumpint ( 1 ) ;
    dumpthings ( mubyteread [0 ], 256 ) ;
    dumpthings ( mubytewrite [0 ], 256 ) ;
    dumpthings ( mubytecswrite [0 ], 128 ) ;
  } 
  dumpint ( poolptr ) ;
  dumpint ( strptr ) ;
  dumpthings ( strstart [0 ], strptr + 1 ) ;
  dumpthings ( strpool [0 ], poolptr ) ;
  println () ;
  printint ( strptr ) ;
  print ( 1285 ) ;
  printint ( poolptr ) ;
  sortavail () ;
  varused = 0 ;
  dumpint ( lomemmax ) ;
  dumpint ( rover ) ;
  p = membot ;
  q = rover ;
  x = 0 ;
  do {
      dumpthings ( mem [p ], q + 2 - p ) ;
    x = x + q + 2 - p ;
    varused = varused + q - p ;
    p = q + mem [q ].hh .v.LH ;
    q = mem [q + 1 ].hh .v.RH ;
  } while ( ! ( q == rover ) ) ;
  varused = varused + lomemmax - p ;
  dynused = memend + 1 - himemmin ;
  dumpthings ( mem [p ], lomemmax + 1 - p ) ;
  x = x + lomemmax + 1 - p ;
  dumpint ( himemmin ) ;
  dumpint ( avail ) ;
  dumpthings ( mem [himemmin ], memend + 1 - himemmin ) ;
  x = x + memend + 1 - himemmin ;
  p = avail ;
  while ( p != -268435455L ) {
      
    decr ( dynused ) ;
    p = mem [p ].hh .v.RH ;
  } 
  dumpint ( varused ) ;
  dumpint ( dynused ) ;
  println () ;
  printint ( x ) ;
  print ( 1286 ) ;
  printint ( varused ) ;
  printchar ( 38 ) ;
  printint ( dynused ) ;
  k = 1 ;
  do {
      j = k ;
    while ( j < 15166 ) {
	
      if ( ( eqtb [j ].hh .v.RH == eqtb [j + 1 ].hh .v.RH ) && ( eqtb [j 
      ].hh.b0 == eqtb [j + 1 ].hh.b0 ) && ( eqtb [j ].hh.b1 == eqtb [j + 
      1 ].hh.b1 ) ) 
      goto lab41 ;
      incr ( j ) ;
    } 
    l = 15167 ;
    goto lab31 ;
    lab41: incr ( j ) ;
    l = j ;
    while ( j < 15166 ) {
	
      if ( ( eqtb [j ].hh .v.RH != eqtb [j + 1 ].hh .v.RH ) || ( eqtb [j 
      ].hh.b0 != eqtb [j + 1 ].hh.b0 ) || ( eqtb [j ].hh.b1 != eqtb [j + 
      1 ].hh.b1 ) ) 
      goto lab31 ;
      incr ( j ) ;
    } 
    lab31: dumpint ( l - k ) ;
    dumpthings ( eqtb [k ], l - k ) ;
    k = j + 1 ;
    dumpint ( k - l ) ;
  } while ( ! ( k == 15167 ) ) ;
  do {
      j = k ;
    while ( j < 16017 ) {
	
      if ( eqtb [j ].cint == eqtb [j + 1 ].cint ) 
      goto lab42 ;
      incr ( j ) ;
    } 
    l = 16018 ;
    goto lab32 ;
    lab42: incr ( j ) ;
    l = j ;
    while ( j < 16017 ) {
	
      if ( eqtb [j ].cint != eqtb [j + 1 ].cint ) 
      goto lab32 ;
      incr ( j ) ;
    } 
    lab32: dumpint ( l - k ) ;
    dumpthings ( eqtb [k ], l - k ) ;
    k = j + 1 ;
    dumpint ( k - l ) ;
  } while ( ! ( k > 16017 ) ) ;
  if ( hashhigh > 0 ) 
  dumpthings ( eqtb [16018 ], hashhigh ) ;
  dumpint ( parloc ) ;
  dumpint ( writeloc ) ;
  dumpint ( hashused ) ;
  cscount = 10513 - hashused + hashhigh ;
  {register integer for_end; p = 514 ;for_end = hashused ; if ( p <= 
  for_end) do 
    if ( hash [p ].v.RH != 0 ) 
    {
      dumpint ( p ) ;
      dumphh ( hash [p ]) ;
      incr ( cscount ) ;
    } 
  while ( p++ < for_end ) ;} 
  dumpthings ( hash [hashused + 1 ], 12525 - hashused ) ;
  if ( hashhigh > 0 ) 
  dumpthings ( hash [16018 ], hashhigh ) ;
  dumpint ( cscount ) ;
  println () ;
  printint ( cscount ) ;
  print ( 1287 ) ;
  dumpint ( fmemptr ) ;
  dumpthings ( fontinfo [0 ], fmemptr ) ;
  dumpint ( fontptr ) ;
  {
    dumpthings ( fontcheck [0 ], fontptr + 1 ) ;
    dumpthings ( fontsize [0 ], fontptr + 1 ) ;
    dumpthings ( fontdsize [0 ], fontptr + 1 ) ;
    dumpthings ( fontparams [0 ], fontptr + 1 ) ;
    dumpthings ( hyphenchar [0 ], fontptr + 1 ) ;
    dumpthings ( skewchar [0 ], fontptr + 1 ) ;
    dumpthings ( fontname [0 ], fontptr + 1 ) ;
    dumpthings ( fontarea [0 ], fontptr + 1 ) ;
    dumpthings ( fontbc [0 ], fontptr + 1 ) ;
    dumpthings ( fontec [0 ], fontptr + 1 ) ;
    dumpthings ( charbase [0 ], fontptr + 1 ) ;
    dumpthings ( widthbase [0 ], fontptr + 1 ) ;
    dumpthings ( heightbase [0 ], fontptr + 1 ) ;
    dumpthings ( depthbase [0 ], fontptr + 1 ) ;
    dumpthings ( italicbase [0 ], fontptr + 1 ) ;
    dumpthings ( ligkernbase [0 ], fontptr + 1 ) ;
    dumpthings ( kernbase [0 ], fontptr + 1 ) ;
    dumpthings ( extenbase [0 ], fontptr + 1 ) ;
    dumpthings ( parambase [0 ], fontptr + 1 ) ;
    dumpthings ( fontglue [0 ], fontptr + 1 ) ;
    dumpthings ( bcharlabel [0 ], fontptr + 1 ) ;
    dumpthings ( fontbchar [0 ], fontptr + 1 ) ;
    dumpthings ( fontfalsebchar [0 ], fontptr + 1 ) ;
    {register integer for_end; k = 0 ;for_end = fontptr ; if ( k <= for_end) 
    do 
      {
	printnl ( 1291 ) ;
	printesc ( hash [10525 + k ].v.RH ) ;
	printchar ( 61 ) ;
	printfilename ( fontname [k ], fontarea [k ], 335 ) ;
	if ( fontsize [k ]!= fontdsize [k ]) 
	{
	  print ( 755 ) ;
	  printscaled ( fontsize [k ]) ;
	  print ( 402 ) ;
	} 
      } 
    while ( k++ < for_end ) ;} 
  } 
  println () ;
  printint ( fmemptr - 7 ) ;
  print ( 1288 ) ;
  printint ( fontptr - 0 ) ;
  if ( fontptr != 1 ) 
  print ( 1289 ) ;
  else print ( 1290 ) ;
  dumpint ( hyphcount ) ;
  if ( hyphnext <= 607 ) 
  hyphnext = hyphsize ;
  dumpint ( hyphnext ) ;
  {register integer for_end; k = 0 ;for_end = hyphsize ; if ( k <= for_end) 
  do 
    if ( hyphword [k ]!= 0 ) 
    {
      dumpint ( k + 65536L * hyphlink [k ]) ;
      dumpint ( hyphword [k ]) ;
      dumpint ( hyphlist [k ]) ;
    } 
  while ( k++ < for_end ) ;} 
  println () ;
  printint ( hyphcount ) ;
  if ( hyphcount != 1 ) 
  print ( 1292 ) ;
  else print ( 1293 ) ;
  if ( trienotready ) 
  inittrie () ;
  dumpint ( triemax ) ;
  dumpthings ( trietrl [0 ], triemax + 1 ) ;
  dumpthings ( trietro [0 ], triemax + 1 ) ;
  dumpthings ( trietrc [0 ], triemax + 1 ) ;
  dumpint ( trieopptr ) ;
  dumpthings ( hyfdistance [1 ], trieopptr ) ;
  dumpthings ( hyfnum [1 ], trieopptr ) ;
  dumpthings ( hyfnext [1 ], trieopptr ) ;
  printnl ( 1294 ) ;
  printint ( triemax ) ;
  print ( 1295 ) ;
  printint ( trieopptr ) ;
  if ( trieopptr != 1 ) 
  print ( 1296 ) ;
  else print ( 1297 ) ;
  print ( 1298 ) ;
  printint ( trieopsize ) ;
  {register integer for_end; k = 255 ;for_end = 0 ; if ( k >= for_end) do 
    if ( trieused [k ]> 0 ) 
    {
      printnl ( 812 ) ;
      printint ( trieused [k ]) ;
      print ( 1299 ) ;
      printint ( k ) ;
      dumpint ( k ) ;
      dumpint ( trieused [k ]) ;
    } 
  while ( k-- > for_end ) ;} 
  dumpint ( interaction ) ;
  dumpint ( formatident ) ;
  dumpint ( 69069L ) ;
  eqtb [15198 ].cint = 0 ;
  wclose ( fmtfile ) ;
} 
#endif /* INITEX */
boolean 
#ifdef HAVE_PROTOTYPES
loadfmtfile ( void ) 
#else
loadfmtfile ( ) 
#endif
{
  /* 6666 10 */ register boolean Result; loadfmtfile_regmem 
  integer j, k  ;
  halfword p, q  ;
  integer x  ;
  ASCIIcode * formatengine  ;
  ASCIIcode dummyxord  ;
  ASCIIcode dummyxchr  ;
  ASCIIcode dummyxprn  ;
	;
#ifdef INITEX
  if ( iniversion ) 
  {
    libcfree ( fontinfo ) ;
    libcfree ( strpool ) ;
    libcfree ( strstart ) ;
    libcfree ( yhash ) ;
    libcfree ( zeqtb ) ;
    libcfree ( yzmem ) ;
  } 
#endif /* INITEX */
  undumpint ( x ) ;
  if ( debugformatfile ) 
  {
    fprintf ( stderr , "%s%s",  "fmtdebug:" , "format magic number" ) ;
    fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
  } 
  if ( x != 1462916184L ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( debugformatfile ) 
  {
    fprintf ( stderr , "%s%s",  "fmtdebug:" , "engine name size" ) ;
    fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
  } 
  if ( ( x < 0 ) || ( x > 256 ) ) 
  goto lab6666 ;
  formatengine = xmallocarray ( ASCIIcode , x ) ;
  undumpthings ( formatengine [0 ], x ) ;
  formatengine [x - 1 ]= 0 ;
  if ( strcmp ( enginename , formatengine ) ) 
  {
    ;
    fprintf ( stdout , "%s%s%s%s\n",  "---! " , stringcast ( nameoffile + 1 ) ,     " was written by " , formatengine ) ;
    libcfree ( formatengine ) ;
    goto lab6666 ;
  } 
  libcfree ( formatengine ) ;
  undumpint ( x ) ;
  if ( debugformatfile ) 
  {
    fprintf ( stderr , "%s%s",  "fmtdebug:" , "string pool checksum" ) ;
    fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
  } 
  if ( x != 128540375L ) 
  {
    ;
    fprintf ( stdout , "%s%s%s%s\n",  "---! " , stringcast ( nameoffile + 1 ) ,     " doesn't match " , poolname ) ;
    goto lab6666 ;
  } 
  if ( translatefilename ) 
  {
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      undumpthings ( dummyxord , 1 ) ;
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      undumpthings ( dummyxchr , 1 ) ;
    while ( k++ < for_end ) ;} 
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      undumpthings ( dummyxprn , 1 ) ;
    while ( k++ < for_end ) ;} 
  } 
  else {
      
    undumpthings ( xord [0 ], 256 ) ;
    undumpthings ( xchr [0 ], 256 ) ;
    undumpthings ( xprn [0 ], 256 ) ;
    if ( eightbitp ) 
    {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
      xprn [k ]= 1 ;
    while ( k++ < for_end ) ;} 
  } 
  undumpint ( x ) ;
  if ( x != 268435455L ) 
  goto lab6666 ;
  undumpint ( hashhigh ) ;
  if ( ( hashhigh < 0 ) || ( hashhigh > suphashextra ) ) 
  goto lab6666 ;
  if ( hashextra < hashhigh ) 
  hashextra = hashhigh ;
  eqtbtop = 16017 + hashextra ;
  if ( hashextra == 0 ) 
  hashtop = 12526 ;
  else hashtop = eqtbtop ;
  yhash = xmallocarray ( twohalves , 1 + hashtop - hashoffset ) ;
  hash = yhash - hashoffset ;
  hash [514 ].v.LH = 0 ;
  hash [514 ].v.RH = 0 ;
  {register integer for_end; x = 515 ;for_end = hashtop ; if ( x <= for_end) 
  do 
    hash [x ]= hash [514 ];
  while ( x++ < for_end ) ;} 
  zeqtb = xmallocarray ( memoryword , eqtbtop + 1 ) ;
  eqtb = zeqtb ;
  eqtb [12526 ].hh.b0 = 101 ;
  eqtb [12526 ].hh .v.RH = -268435455L ;
  eqtb [12526 ].hh.b1 = 0 ;
  {register integer for_end; x = 16018 ;for_end = eqtbtop ; if ( x <= 
  for_end) do 
    eqtb [x ]= eqtb [12526 ];
  while ( x++ < for_end ) ;} 
  undumpint ( x ) ;
  if ( debugformatfile ) 
  {
    fprintf ( stderr , "%s%s",  "fmtdebug:" , "mem_bot" ) ;
    fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
  } 
  if ( x != membot ) 
  goto lab6666 ;
  undumpint ( memtop ) ;
  if ( debugformatfile ) 
  {
    fprintf ( stderr , "%s%s",  "fmtdebug:" , "mem_top" ) ;
    fprintf ( stderr , "%s%ld\n",  " = " , (long)memtop ) ;
  } 
  if ( membot + 1100 > memtop ) 
  goto lab6666 ;
  curlist .headfield = memtop - 1 ;
  curlist .tailfield = memtop - 1 ;
  pagetail = memtop - 2 ;
  memmin = membot - extramembot ;
  memmax = memtop + extramemtop ;
  yzmem = xmallocarray ( memoryword , memmax - memmin + 1 ) ;
  zmem = yzmem - memmin ;
  mem = zmem ;
  undumpint ( x ) ;
  if ( x != 16017 ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x != 8501 ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x != 607 ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x != 1296847960L ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x == 1 ) 
  mltexenabledp = true ;
  else if ( x != 0 ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x != 1162040408L ) 
  goto lab6666 ;
  undumpint ( x ) ;
  if ( x == 0 ) 
  enctexenabledp = false ;
  else if ( x != 1 ) 
  goto lab6666 ;
  else {
      
    enctexenabledp = true ;
    undumpthings ( mubyteread [0 ], 256 ) ;
    undumpthings ( mubytewrite [0 ], 256 ) ;
    undumpthings ( mubytecswrite [0 ], 128 ) ;
  } 
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > suppoolsize - poolfree ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "string pool size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "string pool size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    poolptr = x ;
  } 
  if ( poolsize < poolptr + poolfree ) 
  poolsize = poolptr + poolfree ;
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > supmaxstrings - stringsfree ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "sup strings" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "sup strings" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    strptr = x ;
  } 
  if ( maxstrings < strptr + stringsfree ) 
  maxstrings = strptr + stringsfree ;
  strstart = xmallocarray ( poolpointer , maxstrings ) ;
  undumpcheckedthings ( 0 , poolptr , strstart [0 ], strptr + 1 ) ;
  strpool = xmallocarray ( packedASCIIcode , poolsize ) ;
  undumpthings ( strpool [0 ], poolptr ) ;
  initstrptr = strptr ;
  initpoolptr = poolptr ;
  {
    undumpint ( x ) ;
    if ( ( x < membot + 1019 ) || ( x > memtop - 14 ) ) 
    goto lab6666 ;
    else lomemmax = x ;
  } 
  {
    undumpint ( x ) ;
    if ( ( x < membot + 20 ) || ( x > lomemmax ) ) 
    goto lab6666 ;
    else rover = x ;
  } 
  p = membot ;
  q = rover ;
  do {
      undumpthings ( mem [p ], q + 2 - p ) ;
    p = q + mem [q ].hh .v.LH ;
    if ( ( p > lomemmax ) || ( ( q >= mem [q + 1 ].hh .v.RH ) && ( mem [q + 
    1 ].hh .v.RH != rover ) ) ) 
    goto lab6666 ;
    q = mem [q + 1 ].hh .v.RH ;
  } while ( ! ( q == rover ) ) ;
  undumpthings ( mem [p ], lomemmax + 1 - p ) ;
  if ( memmin < membot - 2 ) 
  {
    p = mem [rover + 1 ].hh .v.LH ;
    q = memmin + 1 ;
    mem [memmin ].hh .v.RH = -268435455L ;
    mem [memmin ].hh .v.LH = -268435455L ;
    mem [p + 1 ].hh .v.RH = q ;
    mem [rover + 1 ].hh .v.LH = q ;
    mem [q + 1 ].hh .v.RH = rover ;
    mem [q + 1 ].hh .v.LH = p ;
    mem [q ].hh .v.RH = 268435455L ;
    mem [q ].hh .v.LH = membot - q ;
  } 
  {
    undumpint ( x ) ;
    if ( ( x < lomemmax + 1 ) || ( x > memtop - 13 ) ) 
    goto lab6666 ;
    else himemmin = x ;
  } 
  {
    undumpint ( x ) ;
    if ( ( x < -268435455L ) || ( x > memtop ) ) 
    goto lab6666 ;
    else avail = x ;
  } 
  memend = memtop ;
  undumpthings ( mem [himemmin ], memend + 1 - himemmin ) ;
  undumpint ( varused ) ;
  undumpint ( dynused ) ;
  k = 1 ;
  do {
      undumpint ( x ) ;
    if ( ( x < 1 ) || ( k + x > 16018 ) ) 
    goto lab6666 ;
    undumpthings ( eqtb [k ], x ) ;
    k = k + x ;
    undumpint ( x ) ;
    if ( ( x < 0 ) || ( k + x > 16018 ) ) 
    goto lab6666 ;
    {register integer for_end; j = k ;for_end = k + x - 1 ; if ( j <= 
    for_end) do 
      eqtb [j ]= eqtb [k - 1 ];
    while ( j++ < for_end ) ;} 
    k = k + x ;
  } while ( ! ( k > 16017 ) ) ;
  if ( hashhigh > 0 ) 
  undumpthings ( eqtb [16018 ], hashhigh ) ;
  {
    undumpint ( x ) ;
    if ( ( x < 514 ) || ( x > hashtop ) ) 
    goto lab6666 ;
    else parloc = x ;
  } 
  partoken = 4095 + parloc ;
  {
    undumpint ( x ) ;
    if ( ( x < 514 ) || ( x > hashtop ) ) 
    goto lab6666 ;
    else
    writeloc = x ;
  } 
  {
    undumpint ( x ) ;
    if ( ( x < 514 ) || ( x > 10514 ) ) 
    goto lab6666 ;
    else hashused = x ;
  } 
  p = 513 ;
  do {
      { 
      undumpint ( x ) ;
      if ( ( x < p + 1 ) || ( x > hashused ) ) 
      goto lab6666 ;
      else p = x ;
    } 
    undumphh ( hash [p ]) ;
  } while ( ! ( p == hashused ) ) ;
  undumpthings ( hash [hashused + 1 ], 12525 - hashused ) ;
  if ( debugformatfile ) 
  {
    printcsnames ( 514 , 12525 ) ;
  } 
  if ( hashhigh > 0 ) 
  {
    undumpthings ( hash [16018 ], hashhigh ) ;
    if ( debugformatfile ) 
    {
      printcsnames ( 16018 , hashhigh - ( 16018 ) ) ;
    } 
  } 
  undumpint ( cscount ) ;
  {
    undumpint ( x ) ;
    if ( x < 7 ) 
    goto lab6666 ;
    if ( x > supfontmemsize ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "font mem size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "font mem size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    fmemptr = x ;
  } 
  if ( fmemptr > fontmemsize ) 
  fontmemsize = fmemptr ;
  fontinfo = xmallocarray ( fmemoryword , fontmemsize ) ;
  undumpthings ( fontinfo [0 ], fmemptr ) ;
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > 2000 ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "font max" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "font max" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    fontptr = x ;
  } 
  {
    fontcheck = xmallocarray ( fourquarters , fontmax ) ;
    fontsize = xmallocarray ( scaled , fontmax ) ;
    fontdsize = xmallocarray ( scaled , fontmax ) ;
    fontparams = xmallocarray ( fontindex , fontmax ) ;
    fontname = xmallocarray ( strnumber , fontmax ) ;
    fontarea = xmallocarray ( strnumber , fontmax ) ;
    fontbc = xmallocarray ( eightbits , fontmax ) ;
    fontec = xmallocarray ( eightbits , fontmax ) ;
    fontglue = xmallocarray ( halfword , fontmax ) ;
    hyphenchar = xmallocarray ( integer , fontmax ) ;
    skewchar = xmallocarray ( integer , fontmax ) ;
    bcharlabel = xmallocarray ( fontindex , fontmax ) ;
    fontbchar = xmallocarray ( ninebits , fontmax ) ;
    fontfalsebchar = xmallocarray ( ninebits , fontmax ) ;
    charbase = xmallocarray ( integer , fontmax ) ;
    widthbase = xmallocarray ( integer , fontmax ) ;
    heightbase = xmallocarray ( integer , fontmax ) ;
    depthbase = xmallocarray ( integer , fontmax ) ;
    italicbase = xmallocarray ( integer , fontmax ) ;
    ligkernbase = xmallocarray ( integer , fontmax ) ;
    kernbase = xmallocarray ( integer , fontmax ) ;
    extenbase = xmallocarray ( integer , fontmax ) ;
    parambase = xmallocarray ( integer , fontmax ) ;
    undumpthings ( fontcheck [0 ], fontptr + 1 ) ;
    undumpthings ( fontsize [0 ], fontptr + 1 ) ;
    undumpthings ( fontdsize [0 ], fontptr + 1 ) ;
    undumpcheckedthings ( -268435455L , 268435455L , fontparams [0 ], 
    fontptr + 1 ) ;
    undumpthings ( hyphenchar [0 ], fontptr + 1 ) ;
    undumpthings ( skewchar [0 ], fontptr + 1 ) ;
    undumpuppercheckthings ( strptr , fontname [0 ], fontptr + 1 ) ;
    undumpuppercheckthings ( strptr , fontarea [0 ], fontptr + 1 ) ;
    undumpthings ( fontbc [0 ], fontptr + 1 ) ;
    undumpthings ( fontec [0 ], fontptr + 1 ) ;
    undumpthings ( charbase [0 ], fontptr + 1 ) ;
    undumpthings ( widthbase [0 ], fontptr + 1 ) ;
    undumpthings ( heightbase [0 ], fontptr + 1 ) ;
    undumpthings ( depthbase [0 ], fontptr + 1 ) ;
    undumpthings ( italicbase [0 ], fontptr + 1 ) ;
    undumpthings ( ligkernbase [0 ], fontptr + 1 ) ;
    undumpthings ( kernbase [0 ], fontptr + 1 ) ;
    undumpthings ( extenbase [0 ], fontptr + 1 ) ;
    undumpthings ( parambase [0 ], fontptr + 1 ) ;
    undumpcheckedthings ( -268435455L , lomemmax , fontglue [0 ], fontptr + 
    1 ) ;
    undumpcheckedthings ( 0 , fmemptr - 1 , bcharlabel [0 ], fontptr + 1 ) ;
    undumpcheckedthings ( 0 , 256 , fontbchar [0 ], fontptr + 1 ) ;
    undumpcheckedthings ( 0 , 256 , fontfalsebchar [0 ], fontptr + 1 ) ;
  } 
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > hyphsize ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "hyph_size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "hyph_size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    hyphcount = x ;
  } 
  {
    undumpint ( x ) ;
    if ( x < 607 ) 
    goto lab6666 ;
    if ( x > hyphsize ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "hyph_size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "hyph_size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    hyphnext = x ;
  } 
  j = 0 ;
  {register integer for_end; k = 1 ;for_end = hyphcount ; if ( k <= for_end) 
  do 
    {
      undumpint ( j ) ;
      if ( j < 0 ) 
      goto lab6666 ;
      if ( j > 65535L ) 
      {
	hyphnext = j / 65536L ;
	j = j - hyphnext * 65536L ;
      } 
      else hyphnext = 0 ;
      if ( ( j >= hyphsize ) || ( hyphnext > hyphsize ) ) 
      goto lab6666 ;
      hyphlink [j ]= hyphnext ;
      {
	undumpint ( x ) ;
	if ( ( x < 0 ) || ( x > strptr ) ) 
	goto lab6666 ;
	else hyphword [j ]= x ;
      } 
      {
	undumpint ( x ) ;
	if ( ( x < -268435455L ) || ( x > 268435455L ) ) 
	goto lab6666 ;
	else hyphlist [j ]= x ;
      } 
    } 
  while ( k++ < for_end ) ;} 
  incr ( j ) ;
  if ( j < 607 ) 
  j = 607 ;
  hyphnext = j ;
  if ( hyphnext >= hyphsize ) 
  hyphnext = 607 ;
  else if ( hyphnext >= 607 ) 
  incr ( hyphnext ) ;
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > triesize ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "trie size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "trie size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    j = x ;
  } 
	;
#ifdef INITEX
  triemax = j ;
#endif /* INITEX */
  if ( ! trietrl ) 
  trietrl = xmallocarray ( triepointer , j + 1 ) ;
  undumpthings ( trietrl [0 ], j + 1 ) ;
  if ( ! trietro ) 
  trietro = xmallocarray ( triepointer , j + 1 ) ;
  undumpthings ( trietro [0 ], j + 1 ) ;
  if ( ! trietrc ) 
  trietrc = xmallocarray ( quarterword , j + 1 ) ;
  undumpthings ( trietrc [0 ], j + 1 ) ;
  {
    undumpint ( x ) ;
    if ( x < 0 ) 
    goto lab6666 ;
    if ( x > trieopsize ) 
    {
      ;
      fprintf ( stdout , "%s%s\n",  "---! Must increase the " , "trie op size" ) ;
      goto lab6666 ;
    } 
    else if ( debugformatfile ) 
    {
      fprintf ( stderr , "%s%s",  "fmtdebug:" , "trie op size" ) ;
      fprintf ( stderr , "%s%ld\n",  " = " , (long)x ) ;
    } 
    j = x ;
  } 
	;
#ifdef INITEX
  trieopptr = j ;
#endif /* INITEX */
  undumpthings ( hyfdistance [1 ], j ) ;
  undumpthings ( hyfnum [1 ], j ) ;
  undumpuppercheckthings ( maxtrieop , hyfnext [1 ], j ) ;
	;
#ifdef INITEX
  {register integer for_end; k = 0 ;for_end = 255 ; if ( k <= for_end) do 
    trieused [k ]= 0 ;
  while ( k++ < for_end ) ;} 
#endif /* INITEX */
  k = 256 ;
  while ( j > 0 ) {
      
    {
      undumpint ( x ) ;
      if ( ( x < 0 ) || ( x > k - 1 ) ) 
      goto lab6666 ;
      else k = x ;
    } 
    {
      undumpint ( x ) ;
      if ( ( x < 1 ) || ( x > j ) ) 
      goto lab6666 ;
      else x = x ;
    } 
	;
#ifdef INITEX
    trieused [k ]= x ;
#endif /* INITEX */
    j = j - x ;
    opstart [k ]= j ;
  } 
	;
#ifdef INITEX
  trienotready = false 
#endif /* INITEX */
  ;
  {
    undumpint ( x ) ;
    if ( ( x < 0 ) || ( x > 3 ) ) 
    goto lab6666 ;
    else interaction = x ;
  } 
  if ( interactionoption != 4 ) 
  interaction = interactionoption ;
  {
    undumpint ( x ) ;
    if ( ( x < 0 ) || ( x > strptr ) ) 
    goto lab6666 ;
    else formatident = x ;
  } 
  undumpint ( x ) ;
  if ( ( x != 69069L ) || feof ( fmtfile ) ) 
  goto lab6666 ;
  Result = true ;
  return Result ;
  lab6666: ;
  fprintf ( stdout , "%s\n",  "(Fatal format file error; I'm stymied)" ) ;
  Result = false ;
  return Result ;
} 
void 
#ifdef HAVE_PROTOTYPES
finalcleanup ( void ) 
#else
finalcleanup ( ) 
#endif
{
  /* 10 */ finalcleanup_regmem 
  smallnumber c  ;
  c = curchr ;
  if ( jobname == 0 ) 
  openlogfile () ;
  while ( inputptr > 0 ) if ( curinput .statefield == 0 ) 
  endtokenlist () ;
  else endfilereading () ;
  while ( openparens > 0 ) {
      
    print ( 1304 ) ;
    decr ( openparens ) ;
  } 
  if ( curlevel > 1 ) 
  {
    printnl ( 40 ) ;
    printesc ( 1305 ) ;
    print ( 1306 ) ;
    printint ( curlevel - 1 ) ;
    printchar ( 41 ) ;
  } 
  while ( condptr != -268435455L ) {
      
    printnl ( 40 ) ;
    printesc ( 1305 ) ;
    print ( 1307 ) ;
    printcmdchr ( 105 , curif ) ;
    if ( ifline != 0 ) 
    {
      print ( 1308 ) ;
      printint ( ifline ) ;
    } 
    print ( 1309 ) ;
    ifline = mem [condptr + 1 ].cint ;
    curif = mem [condptr ].hh.b1 ;
    tempptr = condptr ;
    condptr = mem [condptr ].hh .v.RH ;
    freenode ( tempptr , 2 ) ;
  } 
  if ( history != 0 ) 
  if ( ( ( history == 1 ) || ( interaction < 3 ) ) ) 
  if ( selector == 19 ) 
  {
    selector = 17 ;
    printnl ( 1310 ) ;
    selector = 19 ;
  } 
  if ( c == 1 ) 
  {
	;
#ifdef INITEX
    if ( iniversion ) 
    {
      {register integer for_end; c = 0 ;for_end = 4 ; if ( c <= for_end) do 
	if ( curmark [c ]!= -268435455L ) 
	deletetokenref ( curmark [c ]) ;
      while ( c++ < for_end ) ;} 
      storefmtfile () ;
      return ;
    } 
#endif /* INITEX */
    printnl ( 1311 ) ;
    return ;
  } 
} 
#ifdef INITEX
void 
#ifdef HAVE_PROTOTYPES
initprim ( void ) 
#else
initprim ( ) 
#endif
{
  initprim_regmem 
  nonewcontrolsequence = false ;
  primitive ( 381 , 75 , 12527 ) ;
  primitive ( 382 , 75 , 12528 ) ;
  primitive ( 383 , 75 , 12529 ) ;
  primitive ( 384 , 75 , 12530 ) ;
  primitive ( 385 , 75 , 12531 ) ;
  primitive ( 386 , 75 , 12532 ) ;
  primitive ( 387 , 75 , 12533 ) ;
  primitive ( 388 , 75 , 12534 ) ;
  primitive ( 389 , 75 , 12535 ) ;
  primitive ( 390 , 75 , 12536 ) ;
  primitive ( 391 , 75 , 12537 ) ;
  primitive ( 392 , 75 , 12538 ) ;
  primitive ( 393 , 75 , 12539 ) ;
  primitive ( 394 , 75 , 12540 ) ;
  primitive ( 395 , 75 , 12541 ) ;
  primitive ( 396 , 76 , 12542 ) ;
  primitive ( 397 , 76 , 12543 ) ;
  primitive ( 398 , 76 , 12544 ) ;
  primitive ( 403 , 72 , 13058 ) ;
  primitive ( 404 , 72 , 13059 ) ;
  primitive ( 405 , 72 , 13060 ) ;
  primitive ( 406 , 72 , 13061 ) ;
  primitive ( 407 , 72 , 13062 ) ;
  primitive ( 408 , 72 , 13063 ) ;
  primitive ( 409 , 72 , 13064 ) ;
  primitive ( 410 , 72 , 13065 ) ;
  primitive ( 411 , 72 , 13066 ) ;
  primitive ( 425 , 73 , 15167 ) ;
  primitive ( 426 , 73 , 15168 ) ;
  primitive ( 427 , 73 , 15169 ) ;
  primitive ( 428 , 73 , 15170 ) ;
  primitive ( 429 , 73 , 15171 ) ;
  primitive ( 430 , 73 , 15172 ) ;
  primitive ( 431 , 73 , 15173 ) ;
  primitive ( 432 , 73 , 15174 ) ;
  primitive ( 433 , 73 , 15175 ) ;
  primitive ( 434 , 73 , 15176 ) ;
  primitive ( 435 , 73 , 15177 ) ;
  primitive ( 436 , 73 , 15178 ) ;
  primitive ( 437 , 73 , 15179 ) ;
  primitive ( 438 , 73 , 15180 ) ;
  primitive ( 439 , 73 , 15181 ) ;
  primitive ( 440 , 73 , 15182 ) ;
  primitive ( 441 , 73 , 15183 ) ;
  primitive ( 442 , 73 , 15184 ) ;
  primitive ( 443 , 73 , 15185 ) ;
  primitive ( 444 , 73 , 15186 ) ;
  primitive ( 445 , 73 , 15187 ) ;
  primitive ( 446 , 73 , 15188 ) ;
  primitive ( 447 , 73 , 15189 ) ;
  primitive ( 448 , 73 , 15190 ) ;
  primitive ( 449 , 73 , 15191 ) ;
  primitive ( 450 , 73 , 15192 ) ;
  primitive ( 451 , 73 , 15193 ) ;
  primitive ( 452 , 73 , 15194 ) ;
  primitive ( 453 , 73 , 15195 ) ;
  primitive ( 454 , 73 , 15196 ) ;
  primitive ( 455 , 73 , 15197 ) ;
  primitive ( 456 , 73 , 15198 ) ;
  primitive ( 457 , 73 , 15199 ) ;
  primitive ( 458 , 73 , 15200 ) ;
  primitive ( 459 , 73 , 15201 ) ;
  primitive ( 460 , 73 , 15202 ) ;
  primitive ( 461 , 73 , 15203 ) ;
  primitive ( 462 , 73 , 15204 ) ;
  primitive ( 463 , 73 , 15205 ) ;
  primitive ( 464 , 73 , 15206 ) ;
  primitive ( 465 , 73 , 15207 ) ;
  primitive ( 466 , 73 , 15208 ) ;
  primitive ( 467 , 73 , 15209 ) ;
  primitive ( 468 , 73 , 15210 ) ;
  primitive ( 469 , 73 , 15211 ) ;
  primitive ( 470 , 73 , 15212 ) ;
  primitive ( 471 , 73 , 15213 ) ;
  primitive ( 472 , 73 , 15214 ) ;
  primitive ( 473 , 73 , 15215 ) ;
  primitive ( 474 , 73 , 15216 ) ;
  primitive ( 475 , 73 , 15217 ) ;
  primitive ( 476 , 73 , 15218 ) ;
  primitive ( 477 , 73 , 15219 ) ;
  primitive ( 478 , 73 , 15220 ) ;
  primitive ( 479 , 73 , 15221 ) ;
  if ( mltexp ) 
  {
    mltexenabledp = true ;
    if ( false ) 
    primitive ( 480 , 73 , 15222 ) ;
    primitive ( 481 , 73 , 15223 ) ;
    primitive ( 482 , 73 , 15224 ) ;
  } 
  if ( enctexp ) 
  {
    enctexenabledp = true ;
    primitive ( 483 , 73 , 15225 ) ;
    primitive ( 484 , 73 , 15226 ) ;
    primitive ( 485 , 73 , 15227 ) ;
    primitive ( 486 , 73 , 15228 ) ;
  } 
  primitive ( 490 , 74 , 15741 ) ;
  primitive ( 491 , 74 , 15742 ) ;
  primitive ( 492 , 74 , 15743 ) ;
  primitive ( 493 , 74 , 15744 ) ;
  primitive ( 494 , 74 , 15745 ) ;
  primitive ( 495 , 74 , 15746 ) ;
  primitive ( 496 , 74 , 15747 ) ;
  primitive ( 497 , 74 , 15748 ) ;
  primitive ( 498 , 74 , 15749 ) ;
  primitive ( 499 , 74 , 15750 ) ;
  primitive ( 500 , 74 , 15751 ) ;
  primitive ( 501 , 74 , 15752 ) ;
  primitive ( 502 , 74 , 15753 ) ;
  primitive ( 503 , 74 , 15754 ) ;
  primitive ( 504 , 74 , 15755 ) ;
  primitive ( 505 , 74 , 15756 ) ;
  primitive ( 506 , 74 , 15757 ) ;
  primitive ( 507 , 74 , 15758 ) ;
  primitive ( 508 , 74 , 15759 ) ;
  primitive ( 509 , 74 , 15760 ) ;
  primitive ( 510 , 74 , 15761 ) ;
  primitive ( 32 , 64 , 0 ) ;
  primitive ( 47 , 44 , 0 ) ;
  primitive ( 520 , 45 , 0 ) ;
  primitive ( 521 , 90 , 0 ) ;
  primitive ( 522 , 40 , 0 ) ;
  primitive ( 523 , 41 , 0 ) ;
  primitive ( 524 , 61 , 0 ) ;
  primitive ( 525 , 16 , 0 ) ;
  primitive ( 516 , 107 , 0 ) ;
  primitive ( 526 , 15 , 0 ) ;
  primitive ( 527 , 92 , 0 ) ;
  primitive ( 517 , 67 , 0 ) ;
  if ( enctexp ) 
  {
    primitive ( 528 , 67 , 10 ) ;
  } 
  primitive ( 529 , 62 , 0 ) ;
  hash [10516 ].v.RH = 529 ;
  eqtb [10516 ]= eqtb [curval ];
  primitive ( 530 , 102 , 0 ) ;
  primitive ( 531 , 88 , 0 ) ;
  primitive ( 532 , 77 , 0 ) ;
  primitive ( 533 , 32 , 0 ) ;
  primitive ( 534 , 36 , 0 ) ;
  primitive ( 535 , 39 , 0 ) ;
  primitive ( 327 , 37 , 0 ) ;
  primitive ( 348 , 18 , 0 ) ;
  primitive ( 536 , 46 , 0 ) ;
  primitive ( 537 , 17 , 0 ) ;
  primitive ( 538 , 54 , 0 ) ;
  primitive ( 539 , 91 , 0 ) ;
  primitive ( 540 , 34 , 0 ) ;
  primitive ( 541 , 65 , 0 ) ;
  primitive ( 542 , 103 , 0 ) ;
  primitive ( 332 , 55 , 0 ) ;
  primitive ( 543 , 63 , 0 ) ;
  primitive ( 413 , 84 , 0 ) ;
  primitive ( 544 , 42 , 0 ) ;
  primitive ( 545 , 80 , 0 ) ;
  primitive ( 546 , 66 , 0 ) ;
  primitive ( 547 , 96 , 0 ) ;
  primitive ( 548 , 0 , 256 ) ;
  hash [10521 ].v.RH = 548 ;
  eqtb [10521 ]= eqtb [curval ];
  primitive ( 549 , 98 , 0 ) ;
  primitive ( 550 , 109 , 0 ) ;
  primitive ( 412 , 71 , 0 ) ;
  primitive ( 349 , 38 , 0 ) ;
  primitive ( 551 , 33 , 0 ) ;
  primitive ( 552 , 56 , 0 ) ;
  primitive ( 553 , 35 , 0 ) ;
  primitive ( 609 , 13 , 256 ) ;
  parloc = curval ;
  partoken = 4095 + parloc ;
  primitive ( 643 , 104 , 0 ) ;
  primitive ( 644 , 104 , 1 ) ;
  primitive ( 645 , 110 , 0 ) ;
  primitive ( 646 , 110 , 1 ) ;
  primitive ( 647 , 110 , 2 ) ;
  primitive ( 648 , 110 , 3 ) ;
  primitive ( 649 , 110 , 4 ) ;
  primitive ( 488 , 89 , 0 ) ;
  primitive ( 512 , 89 , 1 ) ;
  primitive ( 400 , 89 , 2 ) ;
  primitive ( 401 , 89 , 3 ) ;
  primitive ( 682 , 79 , 102 ) ;
  primitive ( 683 , 79 , 1 ) ;
  primitive ( 684 , 82 , 0 ) ;
  primitive ( 685 , 82 , 1 ) ;
  primitive ( 686 , 83 , 1 ) ;
  primitive ( 687 , 83 , 3 ) ;
  primitive ( 688 , 83 , 2 ) ;
  primitive ( 689 , 70 , 0 ) ;
  primitive ( 690 , 70 , 1 ) ;
  primitive ( 691 , 70 , 2 ) ;
  primitive ( 692 , 70 , 3 ) ;
  primitive ( 693 , 70 , 4 ) ;
  primitive ( 749 , 108 , 0 ) ;
  primitive ( 750 , 108 , 1 ) ;
  primitive ( 751 , 108 , 2 ) ;
  primitive ( 752 , 108 , 3 ) ;
  primitive ( 753 , 108 , 4 ) ;
  primitive ( 754 , 108 , 5 ) ;
  primitive ( 770 , 105 , 0 ) ;
  primitive ( 771 , 105 , 1 ) ;
  primitive ( 772 , 105 , 2 ) ;
  primitive ( 773 , 105 , 3 ) ;
  primitive ( 774 , 105 , 4 ) ;
  primitive ( 775 , 105 , 5 ) ;
  primitive ( 776 , 105 , 6 ) ;
  primitive ( 777 , 105 , 7 ) ;
  primitive ( 778 , 105 , 8 ) ;
  primitive ( 779 , 105 , 9 ) ;
  primitive ( 780 , 105 , 10 ) ;
  primitive ( 781 , 105 , 11 ) ;
  primitive ( 782 , 105 , 12 ) ;
  primitive ( 783 , 105 , 13 ) ;
  primitive ( 784 , 105 , 14 ) ;
  primitive ( 785 , 105 , 15 ) ;
  primitive ( 786 , 105 , 16 ) ;
  primitive ( 787 , 106 , 2 ) ;
  hash [10518 ].v.RH = 787 ;
  eqtb [10518 ]= eqtb [curval ];
  primitive ( 788 , 106 , 4 ) ;
  primitive ( 789 , 106 , 3 ) ;
  primitive ( 813 , 87 , 0 ) ;
  hash [10525 ].v.RH = 813 ;
  eqtb [10525 ]= eqtb [curval ];
  primitive ( 910 , 4 , 256 ) ;
  primitive ( 911 , 5 , 257 ) ;
  hash [10515 ].v.RH = 911 ;
  eqtb [10515 ]= eqtb [curval ];
  primitive ( 912 , 5 , 258 ) ;
  hash [10519 ].v.RH = 913 ;
  hash [10520 ].v.RH = 913 ;
  eqtb [10520 ].hh.b0 = 9 ;
  eqtb [10520 ].hh .v.RH = memtop - 11 ;
  eqtb [10520 ].hh.b1 = 1 ;
  eqtb [10519 ]= eqtb [10520 ];
  eqtb [10519 ].hh.b0 = 115 ;
  primitive ( 982 , 81 , 0 ) ;
  primitive ( 983 , 81 , 1 ) ;
  primitive ( 984 , 81 , 2 ) ;
  primitive ( 985 , 81 , 3 ) ;
  primitive ( 986 , 81 , 4 ) ;
  primitive ( 987 , 81 , 5 ) ;
  primitive ( 988 , 81 , 6 ) ;
  primitive ( 989 , 81 , 7 ) ;
  primitive ( 1036 , 14 , 0 ) ;
  primitive ( 1037 , 14 , 1 ) ;
  primitive ( 1038 , 26 , 4 ) ;
  primitive ( 1039 , 26 , 0 ) ;
  primitive ( 1040 , 26 , 1 ) ;
  primitive ( 1041 , 26 , 2 ) ;
  primitive ( 1042 , 26 , 3 ) ;
  primitive ( 1043 , 27 , 4 ) ;
  primitive ( 1044 , 27 , 0 ) ;
  primitive ( 1045 , 27 , 1 ) ;
  primitive ( 1046 , 27 , 2 ) ;
  primitive ( 1047 , 27 , 3 ) ;
  primitive ( 333 , 28 , 5 ) ;
  primitive ( 337 , 29 , 1 ) ;
  primitive ( 339 , 30 , 99 ) ;
  primitive ( 1065 , 21 , 1 ) ;
  primitive ( 1066 , 21 , 0 ) ;
  primitive ( 1067 , 22 , 1 ) ;
  primitive ( 1068 , 22 , 0 ) ;
  primitive ( 414 , 20 , 0 ) ;
  primitive ( 1069 , 20 , 1 ) ;
  primitive ( 1070 , 20 , 2 ) ;
  primitive ( 977 , 20 , 3 ) ;
  primitive ( 1071 , 20 , 4 ) ;
  primitive ( 979 , 20 , 5 ) ;
  primitive ( 1072 , 20 , 106 ) ;
  primitive ( 1073 , 31 , 99 ) ;
  primitive ( 1074 , 31 , 100 ) ;
  primitive ( 1075 , 31 , 101 ) ;
  primitive ( 1076 , 31 , 102 ) ;
  primitive ( 1091 , 43 , 1 ) ;
  primitive ( 1092 , 43 , 0 ) ;
  primitive ( 1101 , 25 , 12 ) ;
  primitive ( 1102 , 25 , 11 ) ;
  primitive ( 1103 , 25 , 10 ) ;
  primitive ( 1104 , 23 , 0 ) ;
  primitive ( 1105 , 23 , 1 ) ;
  primitive ( 1106 , 24 , 0 ) ;
  primitive ( 1107 , 24 , 1 ) ;
  primitive ( 45 , 47 , 1 ) ;
  primitive ( 346 , 47 , 0 ) ;
  primitive ( 1139 , 48 , 0 ) ;
  primitive ( 1140 , 48 , 1 ) ;
  primitive ( 878 , 50 , 16 ) ;
  primitive ( 879 , 50 , 17 ) ;
  primitive ( 880 , 50 , 18 ) ;
  primitive ( 881 , 50 , 19 ) ;
  primitive ( 882 , 50 , 20 ) ;
  primitive ( 883 , 50 , 21 ) ;
  primitive ( 884 , 50 , 22 ) ;
  primitive ( 885 , 50 , 23 ) ;
  primitive ( 887 , 50 , 26 ) ;
  primitive ( 886 , 50 , 27 ) ;
  primitive ( 1141 , 51 , 0 ) ;
  primitive ( 890 , 51 , 1 ) ;
  primitive ( 891 , 51 , 2 ) ;
  primitive ( 873 , 53 , 0 ) ;
  primitive ( 874 , 53 , 2 ) ;
  primitive ( 875 , 53 , 4 ) ;
  primitive ( 876 , 53 , 6 ) ;
  primitive ( 1159 , 52 , 0 ) ;
  primitive ( 1160 , 52 , 1 ) ;
  primitive ( 1161 , 52 , 2 ) ;
  primitive ( 1162 , 52 , 3 ) ;
  primitive ( 1163 , 52 , 4 ) ;
  primitive ( 1164 , 52 , 5 ) ;
  primitive ( 888 , 49 , 30 ) ;
  primitive ( 889 , 49 , 31 ) ;
  hash [10517 ].v.RH = 889 ;
  eqtb [10517 ]= eqtb [curval ];
  primitive ( 1183 , 93 , 1 ) ;
  primitive ( 1184 , 93 , 2 ) ;
  primitive ( 1185 , 93 , 4 ) ;
  primitive ( 1186 , 97 , 0 ) ;
  primitive ( 1187 , 97 , 1 ) ;
  primitive ( 1188 , 97 , 2 ) ;
  primitive ( 1189 , 97 , 3 ) ;
  primitive ( 1203 , 94 , 0 ) ;
  primitive ( 1204 , 94 , 1 ) ;
  if ( enctexp ) 
  {
    primitive ( 1205 , 94 , 10 ) ;
    primitive ( 1206 , 94 , 11 ) ;
  } 
  primitive ( 1212 , 95 , 0 ) ;
  primitive ( 1213 , 95 , 1 ) ;
  primitive ( 1214 , 95 , 2 ) ;
  primitive ( 1215 , 95 , 3 ) ;
  primitive ( 1216 , 95 , 4 ) ;
  primitive ( 1217 , 95 , 5 ) ;
  primitive ( 1218 , 95 , 6 ) ;
  if ( mltexp ) 
  {
    primitive ( 1219 , 95 , 7 ) ;
  } 
  primitive ( 420 , 85 , 13631 ) ;
  if ( enctexp ) 
  {
    primitive ( 1224 , 85 , 13580 ) ;
    primitive ( 1225 , 85 , 13581 ) ;
    primitive ( 1226 , 85 , 13582 ) ;
  } 
  primitive ( 424 , 85 , 14655 ) ;
  primitive ( 421 , 85 , 13887 ) ;
  primitive ( 422 , 85 , 14143 ) ;
  primitive ( 423 , 85 , 14399 ) ;
  primitive ( 489 , 85 , 15485 ) ;
  primitive ( 417 , 86 , 13583 ) ;
  primitive ( 418 , 86 , 13599 ) ;
  primitive ( 419 , 86 , 13615 ) ;
  primitive ( 953 , 99 , 0 ) ;
  primitive ( 965 , 99 , 1 ) ;
  primitive ( 1242 , 78 , 0 ) ;
  primitive ( 1243 , 78 , 1 ) ;
  primitive ( 272 , 100 , 0 ) ;
  primitive ( 273 , 100 , 1 ) ;
  primitive ( 274 , 100 , 2 ) ;
  primitive ( 1252 , 100 , 3 ) ;
  primitive ( 1253 , 60 , 1 ) ;
  primitive ( 1254 , 60 , 0 ) ;
  primitive ( 1255 , 58 , 0 ) ;
  primitive ( 1256 , 58 , 1 ) ;
  primitive ( 1262 , 57 , 13887 ) ;
  primitive ( 1263 , 57 , 14143 ) ;
  primitive ( 1264 , 19 , 0 ) ;
  primitive ( 1265 , 19 , 1 ) ;
  primitive ( 1266 , 19 , 2 ) ;
  primitive ( 1267 , 19 , 3 ) ;
  primitive ( 1313 , 59 , 0 ) ;
  primitive ( 606 , 59 , 1 ) ;
  writeloc = curval ;
  primitive ( 1314 , 59 , 2 ) ;
  primitive ( 1315 , 59 , 3 ) ;
  hash [10524 ].v.RH = 1315 ;
  eqtb [10524 ]= eqtb [curval ];
  primitive ( 1316 , 59 , 4 ) ;
  primitive ( 1317 , 59 , 5 ) ;
  nonewcontrolsequence = true ;
} 
#endif /* INITEX */
void 
#ifdef HAVE_PROTOTYPES
mainbody ( void ) 
#else
mainbody ( ) 
#endif
{
  mainbody_regmem 
  bounddefault = 0 ;
  boundname = "mem_bot" ;
  setupboundvariable ( addressof ( membot ) , boundname , bounddefault ) ;
  bounddefault = 250000L ;
  boundname = "main_memory" ;
  setupboundvariable ( addressof ( mainmemory ) , boundname , bounddefault ) ;
  bounddefault = 0 ;
  boundname = "extra_mem_top" ;
  setupboundvariable ( addressof ( extramemtop ) , boundname , bounddefault ) 
  ;
  bounddefault = 0 ;
  boundname = "extra_mem_bot" ;
  setupboundvariable ( addressof ( extramembot ) , boundname , bounddefault ) 
  ;
  bounddefault = 100000L ;
  boundname = "pool_size" ;
  setupboundvariable ( addressof ( poolsize ) , boundname , bounddefault ) ;
  bounddefault = 75000L ;
  boundname = "string_vacancies" ;
  setupboundvariable ( addressof ( stringvacancies ) , boundname , 
  bounddefault ) ;
  bounddefault = 5000 ;
  boundname = "pool_free" ;
  setupboundvariable ( addressof ( poolfree ) , boundname , bounddefault ) ;
  bounddefault = 15000 ;
  boundname = "max_strings" ;
  setupboundvariable ( addressof ( maxstrings ) , boundname , bounddefault ) ;
  bounddefault = 100 ;
  boundname = "strings_free" ;
  setupboundvariable ( addressof ( stringsfree ) , boundname , bounddefault ) 
  ;
  bounddefault = 100000L ;
  boundname = "font_mem_size" ;
  setupboundvariable ( addressof ( fontmemsize ) , boundname , bounddefault ) 
  ;
  bounddefault = 500 ;
  boundname = "font_max" ;
  setupboundvariable ( addressof ( fontmax ) , boundname , bounddefault ) ;
  bounddefault = 20000 ;
  boundname = "trie_size" ;
  setupboundvariable ( addressof ( triesize ) , boundname , bounddefault ) ;
  bounddefault = 659 ;
  boundname = "hyph_size" ;
  setupboundvariable ( addressof ( hyphsize ) , boundname , bounddefault ) ;
  bounddefault = 3000 ;
  boundname = "buf_size" ;
  setupboundvariable ( addressof ( bufsize ) , boundname , bounddefault ) ;
  bounddefault = 50 ;
  boundname = "nest_size" ;
  setupboundvariable ( addressof ( nestsize ) , boundname , bounddefault ) ;
  bounddefault = 15 ;
  boundname = "max_in_open" ;
  setupboundvariable ( addressof ( maxinopen ) , boundname , bounddefault ) ;
  bounddefault = 60 ;
  boundname = "param_size" ;
  setupboundvariable ( addressof ( paramsize ) , boundname , bounddefault ) ;
  bounddefault = 4000 ;
  boundname = "save_size" ;
  setupboundvariable ( addressof ( savesize ) , boundname , bounddefault ) ;
  bounddefault = 300 ;
  boundname = "stack_size" ;
  setupboundvariable ( addressof ( stacksize ) , boundname , bounddefault ) ;
  bounddefault = 16384 ;
  boundname = "dvi_buf_size" ;
  setupboundvariable ( addressof ( dvibufsize ) , boundname , bounddefault ) ;
  bounddefault = 79 ;
  boundname = "error_line" ;
  setupboundvariable ( addressof ( errorline ) , boundname , bounddefault ) ;
  bounddefault = 50 ;
  boundname = "half_error_line" ;
  setupboundvariable ( addressof ( halferrorline ) , boundname , bounddefault 
  ) ;
  bounddefault = 79 ;
  boundname = "max_print_line" ;
  setupboundvariable ( addressof ( maxprintline ) , boundname , bounddefault ) 
  ;
  bounddefault = 0 ;
  boundname = "hash_extra" ;
  setupboundvariable ( addressof ( hashextra ) , boundname , bounddefault ) ;
  {
    if ( membot < infmembot ) 
    membot = infmembot ;
    else if ( membot > supmembot ) 
    membot = supmembot ;
  } 
  {
    if ( mainmemory < infmainmemory ) 
    mainmemory = infmainmemory ;
    else if ( mainmemory > supmainmemory ) 
    mainmemory = supmainmemory ;
  } 
	;
#ifdef INITEX
  if ( iniversion ) 
  {
    extramemtop = 0 ;
    extramembot = 0 ;
  } 
#endif /* INITEX */
  if ( extramembot > supmainmemory ) 
  extramembot = supmainmemory ;
  if ( extramemtop > supmainmemory ) 
  extramemtop = supmainmemory ;
  memtop = membot + mainmemory - 1 ;
  memmin = membot ;
  memmax = memtop ;
  {
    if ( triesize < inftriesize ) 
    triesize = inftriesize ;
    else if ( triesize > suptriesize ) 
    triesize = suptriesize ;
  } 
  {
    if ( hyphsize < infhyphsize ) 
    hyphsize = infhyphsize ;
    else if ( hyphsize > suphyphsize ) 
    hyphsize = suphyphsize ;
  } 
  {
    if ( bufsize < infbufsize ) 
    bufsize = infbufsize ;
    else if ( bufsize > supbufsize ) 
    bufsize = supbufsize ;
  } 
  {
    if ( nestsize < infnestsize ) 
    nestsize = infnestsize ;
    else if ( nestsize > supnestsize ) 
    nestsize = supnestsize ;
  } 
  {
    if ( maxinopen < infmaxinopen ) 
    maxinopen = infmaxinopen ;
    else if ( maxinopen > supmaxinopen ) 
    maxinopen = supmaxinopen ;
  } 
  {
    if ( paramsize < infparamsize ) 
    paramsize = infparamsize ;
    else if ( paramsize > supparamsize ) 
    paramsize = supparamsize ;
  } 
  {
    if ( savesize < infsavesize ) 
    savesize = infsavesize ;
    else if ( savesize > supsavesize ) 
    savesize = supsavesize ;
  } 
  {
    if ( stacksize < infstacksize ) 
    stacksize = infstacksize ;
    else if ( stacksize > supstacksize ) 
    stacksize = supstacksize ;
  } 
  {
    if ( dvibufsize < infdvibufsize ) 
    dvibufsize = infdvibufsize ;
    else if ( dvibufsize > supdvibufsize ) 
    dvibufsize = supdvibufsize ;
  } 
  {
    if ( poolsize < infpoolsize ) 
    poolsize = infpoolsize ;
    else if ( poolsize > suppoolsize ) 
    poolsize = suppoolsize ;
  } 
  {
    if ( stringvacancies < infstringvacancies ) 
    stringvacancies = infstringvacancies ;
    else if ( stringvacancies > supstringvacancies ) 
    stringvacancies = supstringvacancies ;
  } 
  {
    if ( poolfree < infpoolfree ) 
    poolfree = infpoolfree ;
    else if ( poolfree > suppoolfree ) 
    poolfree = suppoolfree ;
  } 
  {
    if ( maxstrings < infmaxstrings ) 
    maxstrings = infmaxstrings ;
    else if ( maxstrings > supmaxstrings ) 
    maxstrings = supmaxstrings ;
  } 
  {
    if ( stringsfree < infstringsfree ) 
    stringsfree = infstringsfree ;
    else if ( stringsfree > supstringsfree ) 
    stringsfree = supstringsfree ;
  } 
  {
    if ( fontmemsize < inffontmemsize ) 
    fontmemsize = inffontmemsize ;
    else if ( fontmemsize > supfontmemsize ) 
    fontmemsize = supfontmemsize ;
  } 
  {
    if ( fontmax < inffontmax ) 
    fontmax = inffontmax ;
    else if ( fontmax > supfontmax ) 
    fontmax = supfontmax ;
  } 
  {
    if ( hashextra < infhashextra ) 
    hashextra = infhashextra ;
    else if ( hashextra > suphashextra ) 
    hashextra = suphashextra ;
  } 
  if ( errorline > 255 ) 
  errorline = 255 ;
  buffer = xmallocarray ( ASCIIcode , bufsize ) ;
  nest = xmallocarray ( liststaterecord , nestsize ) ;
  savestack = xmallocarray ( memoryword , savesize ) ;
  inputstack = xmallocarray ( instaterecord , stacksize ) ;
  inputfile = xmallocarray ( alphafile , maxinopen ) ;
  linestack = xmallocarray ( integer , maxinopen ) ;
  sourcefilenamestack = xmallocarray ( strnumber , maxinopen ) ;
  fullsourcefilenamestack = xmallocarray ( strnumber , maxinopen ) ;
  paramstack = xmallocarray ( halfword , paramsize ) ;
  dvibuf = xmallocarray ( eightbits , dvibufsize ) ;
  hyphword = xmallocarray ( strnumber , hyphsize ) ;
  hyphlist = xmallocarray ( halfword , hyphsize ) ;
  hyphlink = xmallocarray ( hyphpointer , hyphsize ) ;
	;
#ifdef INITEX
  if ( iniversion ) 
  {
    yzmem = xmallocarray ( memoryword , memtop - membot + 1 ) ;
    zmem = yzmem - membot ;
    eqtbtop = 16017 + hashextra ;
    if ( hashextra == 0 ) 
    hashtop = 12526 ;
    else hashtop = eqtbtop ;
    yhash = xmallocarray ( twohalves , 1 + hashtop - hashoffset ) ;
    hash = yhash - hashoffset ;
    hash [514 ].v.LH = 0 ;
    hash [514 ].v.RH = 0 ;
    {register integer for_end; hashused = 515 ;for_end = hashtop ; if ( 
    hashused <= for_end) do 
      hash [hashused ]= hash [514 ];
    while ( hashused++ < for_end ) ;} 
    zeqtb = xmallocarray ( memoryword , eqtbtop ) ;
    eqtb = zeqtb ;
    strstart = xmallocarray ( poolpointer , maxstrings ) ;
    strpool = xmallocarray ( packedASCIIcode , poolsize ) ;
    fontinfo = xmallocarray ( fmemoryword , fontmemsize ) ;
  } 
#endif /* INITEX */
  history = 3 ;
  if ( readyalready == 314159L ) 
  goto lab1 ;
  bad = 0 ;
  if ( ( halferrorline < 30 ) || ( halferrorline > errorline - 15 ) ) 
  bad = 1 ;
  if ( maxprintline < 60 ) 
  bad = 2 ;
  if ( dvibufsize % 8 != 0 ) 
  bad = 3 ;
  if ( membot + 1100 > memtop ) 
  bad = 4 ;
  if ( 8501 > 10000 ) 
  bad = 5 ;
  if ( maxinopen >= 128 ) 
  bad = 6 ;
  if ( memtop < 267 ) 
  bad = 7 ;
	;
#ifdef INITEX
  if ( ( memmin != membot ) || ( memmax != memtop ) ) 
  bad = 10 ;
#endif /* INITEX */
  if ( ( memmin > membot ) || ( memmax < memtop ) ) 
  bad = 10 ;
  if ( ( 0 > 0 ) || ( 255 < 127 ) ) 
  bad = 11 ;
  if ( ( -268435455L > 0 ) || ( 268435455L < 32767 ) ) 
  bad = 12 ;
  if ( ( 0 < -268435455L ) || ( 255 > 268435455L ) ) 
  bad = 13 ;
  if ( ( memmin < -268435455L ) || ( memmax >= 268435455L ) || ( membot - 
  memmin > 268435456L ) ) 
  bad = 14 ;
  if ( ( 2000 < -268435455L ) || ( 2000 > 268435455L ) ) 
  bad = 15 ;
  if ( fontmax > 2000 ) 
  bad = 16 ;
  if ( ( savesize > 268435455L ) || ( maxstrings > 268435455L ) ) 
  bad = 17 ;
  if ( bufsize > 268435455L ) 
  bad = 18 ;
  if ( 255 < 255 ) 
  bad = 19 ;
  if ( 20112 + hashextra > 268435455L ) 
  bad = 21 ;
  if ( ( hashoffset < 0 ) || ( hashoffset > 514 ) ) 
  bad = 42 ;
  if ( formatdefaultlength > maxint ) 
  bad = 31 ;
  if ( 2 * 268435455L < memtop - memmin ) 
  bad = 41 ;
  if ( bad > 0 ) 
  {
    fprintf ( stdout , "%s%s%ld\n",  "Ouch---my internal constants have been clobbered!" ,     "---case " , (long)bad ) ;
    goto lab9999 ;
  } 
  initialize () ;
	;
#ifdef INITEX
  if ( iniversion ) 
  {
    if ( ! getstringsstarted () ) 
    goto lab9999 ;
    initprim () ;
    initstrptr = strptr ;
    initpoolptr = poolptr ;
    dateandtime ( eqtb [15187 ].cint , eqtb [15188 ].cint , eqtb [15189 ]
    .cint , eqtb [15190 ].cint ) ;
  } 
#endif /* INITEX */
  readyalready = 314159L ;
  lab1: selector = 17 ;
  tally = 0 ;
  termoffset = 0 ;
  fileoffset = 0 ;
  if ( srcspecialsp || filelineerrorstylep || parsefirstlinep ) 
  Fputs ( stdout ,  "This is TeXk, Version 3.141592" ) ;
  else
  Fputs ( stdout ,  "This is TeX, Version 3.141592" ) ;
  Fputs ( stdout ,  versionstring ) ;
  if ( formatident > 0 ) 
  slowprint ( formatident ) ;
  println () ;
  if ( shellenabledp ) 
  {
    fprintf ( stdout , "%s\n",  " \\write18 enabled." ) ;
  } 
  if ( srcspecialsp ) 
  {
    fprintf ( stdout , "%s\n",  " Source specials enabled." ) ;
  } 
  if ( filelineerrorstylep ) 
  {
    fprintf ( stdout , "%s\n",  " file:line:error style messages enabled." ) ;
  } 
  if ( parsefirstlinep ) 
  {
    fprintf ( stdout , "%s\n",  " %&-line parsing enabled." ) ;
  } 
  if ( translatefilename ) 
  {
    Fputs ( stdout ,  " (" ) ;
    fputs ( translatefilename , stdout ) ;
    fprintf ( stdout , "%c\n",  ')' ) ;
  } 
  fflush ( stdout ) ;
  jobname = 0 ;
  nameinprogress = false ;
  logopened = false ;
  outputfilename = 0 ;
  {
    {
      inputptr = 0 ;
      maxinstack = 0 ;
      sourcefilenamestack [0 ]= 0 ;
      fullsourcefilenamestack [0 ]= 0 ;
      inopen = 0 ;
      openparens = 0 ;
      maxbufstack = 0 ;
      paramptr = 0 ;
      maxparamstack = 0 ;
      first = bufsize ;
      do {
	  buffer [first ]= 0 ;
	decr ( first ) ;
      } while ( ! ( first == 0 ) ) ;
      scannerstatus = 0 ;
      warningindex = -268435455L ;
      first = 1 ;
      curinput .statefield = 33 ;
      curinput .startfield = 1 ;
      curinput .indexfield = 0 ;
      line = 0 ;
      curinput .namefield = 0 ;
      forceeof = false ;
      alignstate = 1000000L ;
      if ( ! initterminal () ) 
      goto lab9999 ;
      curinput .limitfield = last ;
      first = last + 1 ;
    } 
    if ( ( formatident == 0 ) || ( buffer [curinput .locfield ]== 38 ) || 
    dumpline ) 
    {
      if ( formatident != 0 ) 
      initialize () ;
      if ( ! openfmtfile () ) 
      goto lab9999 ;
      if ( ! loadfmtfile () ) 
      {
	wclose ( fmtfile ) ;
	goto lab9999 ;
      } 
      wclose ( fmtfile ) ;
      eqtb = zeqtb ;
      while ( ( curinput .locfield < curinput .limitfield ) && ( buffer [
      curinput .locfield ]== 32 ) ) incr ( curinput .locfield ) ;
    } 
    if ( ( eqtb [15215 ].cint < 0 ) || ( eqtb [15215 ].cint > 255 ) ) 
    decr ( curinput .limitfield ) ;
    else buffer [curinput .limitfield ]= eqtb [15215 ].cint ;
    if ( mltexenabledp ) 
    {
      fprintf ( stdout , "%s\n",  "MLTeX v2.2 enabled" ) ;
    } 
    if ( enctexenabledp ) 
    {
      Fputs ( stdout ,  " encTeX v. Jun. 2004" ) ;
      fprintf ( stdout , "%s\n",  ", reencoding enabled." ) ;
      if ( translatefilename ) 
      {
	fprintf ( stdout , "%s\n",          " (\\xordcode, \\xchrcode, \\xprncode overridden by TCX)" ) ;
      } 
    } 
    dateandtime ( eqtb [15187 ].cint , eqtb [15188 ].cint , eqtb [15189 ]
    .cint , eqtb [15190 ].cint ) ;
	;
#ifdef INITEX
    if ( trienotready ) 
    {
      trietrl = xmallocarray ( triepointer , triesize ) ;
      trietro = xmallocarray ( triepointer , triesize ) ;
      trietrc = xmallocarray ( quarterword , triesize ) ;
      triec = xmallocarray ( packedASCIIcode , triesize ) ;
      trieo = xmallocarray ( trieopcode , triesize ) ;
      triel = xmallocarray ( triepointer , triesize ) ;
      trier = xmallocarray ( triepointer , triesize ) ;
      triehash = xmallocarray ( triepointer , triesize ) ;
      trietaken = xmallocarray ( boolean , triesize ) ;
      triel [0 ]= 0 ;
      triec [0 ]= 0 ;
      trieptr = 0 ;
      fontcheck = xmallocarray ( fourquarters , fontmax ) ;
      fontsize = xmallocarray ( scaled , fontmax ) ;
      fontdsize = xmallocarray ( scaled , fontmax ) ;
      fontparams = xmallocarray ( fontindex , fontmax ) ;
      fontname = xmallocarray ( strnumber , fontmax ) ;
      fontarea = xmallocarray ( strnumber , fontmax ) ;
      fontbc = xmallocarray ( eightbits , fontmax ) ;
      fontec = xmallocarray ( eightbits , fontmax ) ;
      fontglue = xmallocarray ( halfword , fontmax ) ;
      hyphenchar = xmallocarray ( integer , fontmax ) ;
      skewchar = xmallocarray ( integer , fontmax ) ;
      bcharlabel = xmallocarray ( fontindex , fontmax ) ;
      fontbchar = xmallocarray ( ninebits , fontmax ) ;
      fontfalsebchar = xmallocarray ( ninebits , fontmax ) ;
      charbase = xmallocarray ( integer , fontmax ) ;
      widthbase = xmallocarray ( integer , fontmax ) ;
      heightbase = xmallocarray ( integer , fontmax ) ;
      depthbase = xmallocarray ( integer , fontmax ) ;
      italicbase = xmallocarray ( integer , fontmax ) ;
      ligkernbase = xmallocarray ( integer , fontmax ) ;
      kernbase = xmallocarray ( integer , fontmax ) ;
      extenbase = xmallocarray ( integer , fontmax ) ;
      parambase = xmallocarray ( integer , fontmax ) ;
      fontptr = 0 ;
      fmemptr = 7 ;
      fontname [0 ]= 813 ;
      fontarea [0 ]= 335 ;
      hyphenchar [0 ]= 45 ;
      skewchar [0 ]= -1 ;
      bcharlabel [0 ]= 0 ;
      fontbchar [0 ]= 256 ;
      fontfalsebchar [0 ]= 256 ;
      fontbc [0 ]= 1 ;
      fontec [0 ]= 0 ;
      fontsize [0 ]= 0 ;
      fontdsize [0 ]= 0 ;
      charbase [0 ]= 0 ;
      widthbase [0 ]= 0 ;
      heightbase [0 ]= 0 ;
      depthbase [0 ]= 0 ;
      italicbase [0 ]= 0 ;
      ligkernbase [0 ]= 0 ;
      kernbase [0 ]= 0 ;
      extenbase [0 ]= 0 ;
      fontglue [0 ]= -268435455L ;
      fontparams [0 ]= 7 ;
      parambase [0 ]= -1 ;
      {register integer for_end; fontk = 0 ;for_end = 6 ; if ( fontk <= 
      for_end) do 
	fontinfo [fontk ].cint = 0 ;
      while ( fontk++ < for_end ) ;} 
    } 
#endif /* INITEX */
    fontused = xmallocarray ( boolean , fontmax ) ;
    {register integer for_end; fontk = 0 ;for_end = fontmax ; if ( fontk <= 
    for_end) do 
      fontused [fontk ]= false ;
    while ( fontk++ < for_end ) ;} 
    magicoffset = strstart [904 ]- 9 * 16 ;
    if ( interaction == 0 ) 
    selector = 16 ;
    else selector = 17 ;
    if ( ( curinput .locfield < curinput .limitfield ) && ( eqtb [13631 + 
    buffer [curinput .locfield ]].hh .v.RH != 0 ) ) 
    startinput () ;
  } 
  history = 0 ;
  maincontrol () ;
  finalcleanup () ;
  closefilesandterminate () ;
  lab9999: {
      
    fflush ( stdout ) ;
    readyalready = 0 ;
    if ( ( history != 0 ) && ( history != 1 ) ) 
    uexit ( 1 ) ;
    else uexit ( 0 ) ;
  } 
} 
