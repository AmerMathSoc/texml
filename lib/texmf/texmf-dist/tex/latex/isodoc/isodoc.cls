%%
%% This is file `isodoc.cls ',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% isodoc.dtx  (with options: `class')
%% 
%% Copyright (C) 2006 by Wybo Dekker <wybo@dekkerdocumenten.nl>
%% 
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{isodoc}%
   [2016/01/16 v1.09 isodoc class for letters and invoices]
\ifx\pdfoutput\undefined\else%
  \ifnum\pdfoutput=1\else%
    \ClassError{isodoc}{Compile me with pdflatex, lualatex or xelatex!}{}
  \fi
\fi
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}
\RequirePackage{ctable,xcolor,tabularx,graphicx,xstring,calc}
\RequirePackage{forarray,longtable}
\RequirePackage[head=\baselineskip,foot=\f@size pt]{geometry}
\RequirePackage[absolute,overlay]{textpos}
\geometry{papersize={210mm,297mm},margin=35mm,bottom=25mm}
\TPGrid{210}{297}
\definecolor{headcolor}{gray}{0}
\definecolor{headingcolor}{gray}{0}
\definecolor{markercolor}{gray}{0}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\AtBeginDocument{\addtolength{\headheight}{\baselineskip}}
\definecolor{isodocpink}{rgb}{1,.7,.7}
\def\Undefined#1{\fboxsep1pt\colorbox{isodocpink}{\strut Undefined #1}}
\def\@hft{\footnotesize\sffamily\color{headcolor}}
\def\@xyshift#1,#2@@@{\def\@xshift{#1}\def\@yshift{#2}}
\define@key{isodoc}{shift}{%
  \@xyshift#1@@@
  \AtBeginDocument{\textblockorigin{\@xshift mm}{\@yshift mm}}
}
\define@key{isodoc}{vertical}[\verticaltrue]{\verticaltrue}
\define@key{isodoc}{novertical}[\verticaltrue]{\verticalfalse}
                                           \newif\ifvertical\verticaltrue
\define@key{isodoc}{foreign}[\foreigntrue]{\foreigntrue}
                                           \newif\ifforeign\foreignfalse
\define@key{isodoc}{cityzip}[\cityziptrue]{\cityziptrue}
                                           \newif\ifcityzip\cityzipfalse
\define@key{isodoc}{dutch}   []{\isodoc@nlNL
  \ClassWarning{isodoc}{the option dutch is obsolete: use language=nl-NL}}
\define@key{isodoc}{english} []{\isodoc@enGB
  \ClassWarning{isodoc}{the option english is obsolete: use language=en-GB}}
\define@key{isodoc}{german}  []{\isodoc@deDE
  \ClassWarning{isodoc}{the option german is obsolete: use language=de-DE}}
\define@key{isodoc}{american}[]{\isodoc@enUS
  \ClassWarning{isodoc}{the option american is obsolete: use language=en-US}}
\define@key{isodoc}{french}  []{\isodoc@frFR
  \ClassWarning{isodoc}{the option french is obsolete: use language=fr-FR}}
\define@key{isodoc}{language}{
  \StrSubstitute{#1}{-}{}[\@iso]\csname isodoc@\@iso\endcsname}
\define@key{isodoc}{ordinalss}[\@isodocordinalsstrue]{%
 \ifx\yourlettertext\undefined%
   \@isodocordinalsstrue
 \else
   \ClassError{isodoc}{
     You must use the ordinalss option before any language option}
 \fi}
 \newif\if@isodocordinalss\@isodocordinalssfalse
\define@key{isodoc}{fill}  []{\rightskip=1\rightskip}
\define@key{isodoc}{nofill}[]{\rightskip=0mm plus 35mm}
                              \rightskip=0mm plus 35mm
\define@key{isodoc}{logo}[\@isodoclogotrue]{\@isodoclogotrue}
\define@key{isodoc}{nologo}[\@isodoclogofalse]{\@isodoclogofalse}
                                 \newif\if@isodoclogo\@isodoclogotrue
\define@key{isodoc}{company}    {\def\company{#1}}
                                 \def\company{\Undefined{company}}
\define@key{isodoc}{logoaddress}{\def\logoaddress{#1}}
				 \def\logoaddress{}
\define@key{isodoc}{who}        {\def\who{#1}}
                                 \def\who{\Undefined{who}}
\define@key{isodoc}{street}     {\def\street{#1}}
                                 \def\street{\Undefined{street}}
\define@key{isodoc}{city}       {\def\city{#1}}
                                 \def\city{\Undefined{city}}
\define@key{isodoc}{country}    {\def\country{#1}}
                                 \def\country{\Undefined{country}}
\define@key{isodoc}{countrycode}{\def\countrycode{#1}}
                                 \def\countrycode{\Undefined{countrycode}}
\define@key{isodoc}{zip}        {\def\zip{#1}}
                                 \def\zip{\Undefined{zip}}
\def\prezip{\ifforeign\countrycode\else\fi}
\define@key{isodoc}{leftaddress} []{\def\xaddress{35}}
                                    \def\xaddress{35}
\define@key{isodoc}{rightaddress}[]{\def\xaddress{105}}
\define@key{isodoc}{addresscenter} {\def\@addresscenter{#1}}
                                    \def\@addresscenter{63.5}
\define@key{isodoc}{addresswidth}  {\def\@addresswidth{#1}}
                                    \def\@addresswidth{70}
\define@key{isodoc}{to}{\processto{#1}}\def\toname{Various people}
                                       \def\toaddress{\Undefined{to}}
\long\def\processto#1{\xproc #1\\@@@\ifx\toaddress\empty
    \else \yproc #1@@@\fi}
\long\def\xproc #1\\#2@@@{\gdef\toname{#1}\gdef\toaddress{#2}}
\long\def\yproc #1\\#2@@@{\gdef\toaddress{#2}}
\define@key{isodoc}{return}     []{\returntrue}
                    \newif\ifreturn\returnfalse
\define@key{isodoc}{noreturn}   []{\returnfalse}
\define@key{isodoc}{returnaddress}{\def\returnaddress{#1}}
\define@key{isodoc}{header}  []{\headertrue}
                 \newif\ifheader\headertrue
\define@key{isodoc}{noheader}[]{\headerfalse}
\define@key{isodoc}{bodyshift} {\advance\headerpos#1}
\newcount\headerpos\headerpos=98
\newcount\footerpos\footerpos=275
\newcount\subjectpos
\newcount\openingpos
\newcount\textskip
\define@key{isodoc}{paymentorder} {\def\isodoc@paymentorder{#1}}
\def\isodoc@paymentorder{term;bankname;bic;routingno;iban;accountno;accountname;%
payref;vatno;chamber}
\define@key{isodoc}{footorder} {\def\isodoc@footorder{#1}}
                            \def\isodoc@footorder{website;phone;cellphone;email}
\define@key{isodoc}{footer}  []{\footertrue}
                 \newif\iffooter\footerfalse
\define@key{isodoc}{nofooter}[]{\footerfalse}
\define@key{isodoc}{areacode}   {\def\areacode{#1}}
                                 \def\areacode{\Undefined{areacode}}
\define@key{isodoc}{phoneprefix}{\def\phoneprefix{#1}}
                                 \def\phoneprefix{0}
\define@key{isodoc}{phone}      {\def\phone{#1}}
                                 \def\phone{}
                                 \def\@phone{\Undefined{phone}}
\define@key{isodoc}{cellphone}  {\def\cellphone{#1}}
                                 \def\cellphone{}
                                 \def\@cellphone{\Undefined{cellphone}}
\define@key{isodoc}{fax}        {\def\fax{#1}}
                                 \def\fax{}
                                 \def\@fax{\Undefined{fax}}
\define@key{isodoc}{website}    {\def\website{#1}}
                                 \def\website{}
                                 \def\@website{\Undefined{website}}
\define@key{isodoc}{email}      {\def\email{#1}}
                                 \def\email{}
                                 \def\@email{\Undefined{email}}
\define@key{isodoc}{creditorid} {\def\creditorid{#1}}
                                 \def\creditorid{}
                                 \def\@creditorid{\Undefined{creditorid}}
\define@key{isodoc}{nofold}[]{\yfold=-1mm}
               \newdimen\yfold\yfold=-1mm
\define@key{isodoc}{foldleft}[]{\xfold=9mm}
               \newdimen\xfold\xfold=201mm
\define@key{isodoc}{foldright}[]{\xfold=201mm}
\define@key{isodoc}{fold2}[]{\yfold=158mm}
\define@key{isodoc}{fold3}[]{\yfold=107mm}
\define@key{isodoc}{fold}{\yfold=#1mm}
\define@key{isodoc}{ourref}  {\def\ourref{#1}}
                              \def\ourref{}
\define@key{isodoc}{yourref}   {\def\yourref{#1}}
                              \def\yourref{}
\define@key{isodoc}{yourletter}{\def\yourletter{#1}}
                              \def\yourletter{}
\define@key{isodoc}{date}{\@isomakedate{#1}}
\define@key{isodoc}{forcedate}{\def\@forcedate{#1}}\def\@forcedate{}
\define@key{isodoc}{subject}{\def\subject{#1}}
                             \def\subject{}
\define@key{isodoc}{opening}     {\def\opening{#1}}
                                  \def\opening{\Undefined{opening}}
\define@key{isodoc}{openingcomma}{\def\@openingcomma{#1}}
                                  \def\@openingcomma{,}
\define@key{isodoc}{closing}     {\def\closing{#1}}
                                 \def\closing{\Undefined{closing}}
\define@key{isodoc}{closingcomma}{\def\@closingcomma{#1}}
                                  \def\@closingcomma{,}
\define@key{isodoc}{closingskip}{\ClassError{isodoc}{
  The closingskip option has been removed
  in version 1.04; instead set the signatureskip length,
  preferably in a style file}}
            \newdimen\closingskip\closingskip=\baselineskip
            \newdimen\signatureskip\signatureskip=2\baselineskip
            \newdimen\copytoskip\copytoskip=\baselineskip
            \newdimen\enclosureskip\enclosureskip=\baselineskip
            \newif\ifencldown\encldownfalse
\define@key{isodoc}{autograph}[2]{\def\autographversion{#1}}
                                  \def\autographversion{0}
\define@key{isodoc}{signature}{\def\signature{#1}}
                               \def\signature{\Undefined{signature}}
\define@key{isodoc}{enclosures} {\def\enclosures{#1}}
                                 \def\enclosures{}
\define@key{isodoc}{copyto} {\def\copyto{#1}}
                             \def\copyto{}
\define@key{isodoc}{term}[30 \daystext]{\def\term{#1 \daystext}}
                                 \def\term{}
\define@key{isodoc}{accountno}  {\def\accountno{#1}}
                                 \def\accountno{}
\define@key{isodoc}{mandateid}  {\def\mandateid{#1}}
                                 \def\mandateid{}
\define@key{isodoc}{routingno}  {\def\routingno{#1}}
                                 \def\routingno{}
\define@key{isodoc}{bankname}   {\def\bankname{#1}}
                                 \def\bankname{}
\define@key{isodoc}{accountname}{\def\accountname{#1}}
                                 \def\accountname{}
\define@key{isodoc}{iban}       {\def\iban{#1}}
                                 \def\iban{}
\define@key{isodoc}{bic}        {\def\bic{#1}}
                                 \def\bic{}
\define@key{isodoc}{payref}     {\def\payref{#1}}
                                 \def\payref{}
\define@key{isodoc}{vatno}      {\def\vatno{#1}}
                                 \def\vatno{}
\define@key{isodoc}{chamber}    {\def\chamber{#1}}
                                 \def\chamber{}
\define@key{isodoc}{currency}   {\def\currency{#1}}
                                 \def\currency{\EuroSymbol}
\define@key{isodoc}{accept}[E05]{\def\accepttype{#1}
                                 \newfont\ocrb{ocrb10}
                                }
\define@key{isodoc}{acceptaccount}    {\def\acceptaccount{#1}}
                                       \def\acceptaccount{}
\define@key{isodoc}{acceptaddress}    {\def\acceptaddress{#1}}
                                       \def\acceptaddress{}
\define@key{isodoc}{acceptcents}      {\def\acceptcents{#1}}
                                       \def\acceptcents{\Undefined{}}
\define@key{isodoc}{acceptdescription}{\def\acceptdescription{#1}}
                                       \def\acceptdescription{}
\define@key{isodoc}{acceptdesc}       {\def\acceptdesc{#1}}
                                       \def\acceptdesc{}
\define@key{isodoc}{accepteuros}      {\def\accepteuros{#1}}
                                       \def\accepteuros{\Undefined{}}
\define@key{isodoc}{acceptreference}  {\def\acceptreference{#1}}
                                       \def\acceptreference{\Undefined{ref}}
\def\wacceptaccount{65}      \def\wacceptdesc{26}
\def\xacceptaccount{75}      \def\xacceptdesc{7}
\def\yacceptaccount{231.5}   \def\yacceptdesc{241}
\def\wacceptaddress{90}      \def\waccepteuros{32}
\def\xacceptaddress{58}      \def\xaccepteuros{60}
\def\yacceptaddress{241}     \def\yaccepteuros{219}
\def\wacceptcents{13}        \def\waccepteur{21}
\def\xacceptcents{89}        \def\xaccepteur{14.4}
\def\yacceptcents{219}       \def\yaccepteur{231.5}
\def\wacceptct{9}            \def\wacceptreference{55}
\def\xacceptct{32}           \def\xacceptreference{125}
\def\yacceptct{231.5}        \def\yacceptreference{219}
\def\wacceptdescription{100} \def\wacceptref{30}
\def\xacceptdescription{105} \def\xacceptref{7}
\def\yacceptdescription{200} \def\yacceptref{212}
\newdimen\acceptreferenceskip\acceptreferenceskip=5.15mm
\newcommand{\@isodocsym}{%
  \fontfamily{mvs}\fontencoding{U}%
  \fontseries{m}\fontshape{n}\selectfont
}
\def\EuroSymbol   {{\@isodocsym\char164}}
\def\EUROSymbol   {{\@isodocsym\char99 }}
\def\LetterSymbol {{\@isodocsym\char66 }}
\def\EmailSymbol  {{\@isodocsym\char107}}
\def\PhoneSymbol  {{\@isodocsym\char84 }}
\def\MobileSymbol {{\@isodocsym\char72 }}
\let\EUR\EuroSymbol
\newdimen\iso@outdent
\newdimen\iso@signpos
\newdimen\iso@down
\newdimen\iso@closingpos
\def\iso@isNum#1#2{%
  \sbox\z@{\@tempcnta=0#1\relax}
  \ifdim\wd0>\z@\relax\ClassError{isodoc}%
    {Argument #2 of autograph must be a number!}%
    {You are probably using the oldstyle autograph arguments}\fi
}
\def\autograph#1#2#3#4#5#6{%
  \iso@isNum{#3}{3}\iso@isNum{#4}{4}\iso@isNum{#5}{5}
  \ifnum #1<2
    \ClassError{isodoc}{autograph #1 cannot be changed (first arg must be 2..9)}{}
  \fi
  \ifnum #1>9
    \ClassError{isodoc}{autograph #1 cannot be changed (first arg must be 2..9)}{}
  \fi
  \bgroup
  \lccode`2=`A \lccode`6=`E
  \lccode`3=`B \lccode`7=`F
  \lccode`4=`C \lccode`8=`G
  \lccode`5=`D \lccode`9=`H
  \lowercase{\def\temp{#1}}%
  \expandafter\egroup\expandafter\def\csname autograph\temp\endcsname{%
    \vskip-2\baselineskip%
    \setlength{\iso@down}{#2*#3/100-#2-2\baselineskip}
    \setlength{\iso@outdent}{-#2*#5/100}
    \setlength{\iso@signpos}{#2*(#4-#3)/100}
    \hspace*{\iso@outdent}%
       \raisebox{\iso@down}[0pt][0pt]{\includegraphics[height=#2]{#6}}%
    \\[\baselineskip]%
    \closing\@closingcomma\\[\iso@signpos]\\[-2\baselineskip]%
    \signature%
  }
}
\newcommand{\zippedcity}{%
  \ifcityzip\city\ \prezip\ \zip\else
  \prezip\ \zip\ \city\fi
}
\newcommand{\logo}{\if@isodoclogo%
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{140}[0,1](35,20)%
        \textsf{\LARGE\company}\\[-1.7ex] % large company name
        \rule{\hsize}{.3pt}               % on top a rule
    \end{textblock}
  }
  \isodoc@Tbox{140}{22}{35}{\noindent
     \footnotesize\sffamily
     \ifx\empty\logoaddress%
       \ifx\who\empty\else\who\\\fi
       \ifx\street\empty\else\street\\\fi
       \zippedcity
       \ifforeign\\\country\fi
     \else\logoaddress\fi
  }\fi
}
\def\returnaddress{%
  \company\\
  \street\\
  \zippedcity
  \ifforeign\\\country\fi
}
\newcommand{\setupdocument}[1]{
  \setkeys{isodoc}{#1}
}
\newcount\@isoyear   \@isoyear=\year  \year=0
\newcount\@isomonth \@isomonth=\month
\newcount\@isoday     \@isoday=\day
\def\@isomakedate#1{
  \StrSubstitute[2]{#1}{-}{}[\@iso@arg]
  \IfStrEq{\@iso@arg}{today}{
     \year=\@isoyear
    \month=\@isomonth
      \day=\@isoday
  }{\IfInteger{\@iso@arg}{}{\ClassError{isodoc}{
        Illegal date: not yyyymmdd | yyyy-mm-dd | today}{}\fi}
    \StrLeft{\@iso@arg}{4}[\@iso]\year=\@iso
    \StrRight{\@iso@arg}{2}[\@iso]\day=\@iso
    \StrMid{\@iso@arg}{5}{6}[\@iso]\month=\@iso
  }
  \ifnum\month > 12 \ClassError{isodoc}{Illegal date: month>12}{}\fi
  \ifnum\day   > 31 \ClassError{isodoc}{Illegal date: day>31}{}\fi
}
\def\date{%
  \ifx\@forcedate\empty%
    \ifnum\year=0\Undefined{date}\else\@isodate\fi
  \else\@forcedate\fi
}
\newcommand{\isodoc@paymentbody}{%
  \gdef\isodoc@body{}%
  \ForEachX{;}{%
    \setbox0=\hbox{\csname\thislevelitem\endcsname}%
    \ifdim\wd0=0pt\else%
      \protected@xdef\isodoc@body{%
        \isodoc@body
        \csname\thislevelitem text\endcsname: &
        \csname\thislevelitem\endcsname \protect\\
      }%
    \fi%
  }{\isodoc@paymentorder}
  \isodoc@body%
}
\def\paymentdata{
  \textbf{\paymentdatatext:}\\
  \begin{tabular}{@{}rl@{}}
    \isodoc@paymentbody
  \end{tabular}
}
\newcommand{\accountdata}{%
  \ClassWarning{isodoc}{%
     Instead of the obsolete command \protect\accountdata,
     please use \protect\paymentdata.
  }%
  \paymentdata
}
\def\@isodocmp#1{
  \begin{minipage}[t]{\hsize}
    \mbox{}
    #1\\[-1.8ex]
    \mbox{}
  \end{minipage}
}
\def\showkeys{%
  \begin{longtable}{rl}
       acceptaccount & \acceptaccount\NN
       acceptaddress & \acceptaddress\NN
         acceptcents & \acceptcents\NN
          acceptdesc & \@isodocmp{\acceptdesc}\NN
   acceptdescription & \acceptdescription\NN
         accepteuros & \accepteuros\NN
     acceptreference & \acceptreference\NN
         accountname & \accountname\NN
           accountno & \accountno\NN
            areacode & \areacode\NN
            bankname & \bankname\NN
                 bic & \bic\NN
           cellphone & \cellphone\NN
             chamber & \chamber\NN
                city & \city\NN
             closing & \closing\NN
             company & \company\NN
              copyto & \@isodocmp{\copyto}\NN
             country & \country\NN
         countrycode & \countrycode\NN
            currency & \currency\NN
               email & \email\NN
          enclosures & \@isodocmp{\enclosures}\NN
                 fax & \fax\NN
                iban & \iban\NN
         logoaddress & \logoaddress\NN
             opening & \opening\NN
              ourref & \ourref\NN
              payref & \payref\NN
               phone & \phone\NN
         phoneprefix & \phoneprefix\NN
       returnaddress & \@isodocmp{\returnaddress}\NN
           routingno & \routingno\NN
           signature & \@isodocmp{\signature}\NN
              street & \street\NN
             subject & \subject\NN
                term & \term\NN
               vatno & \vatno\NN
             website & \website\NN
                 who & \who\NN
          yourletter & \yourletter\NN
             yourref & \yourref\NN
                 zip & \zip\NN
  \end{longtable}
}
\AtEndOfClass{%
  \usepackage{hyperref}
}
\def\@isodocheadL{\totext:{} \toname{} (\date)}
\def\@isodocheadC{}
\def\@isodocheadR{\pagetext\ \thepage\ \oftext{}
    \begin{NoHyper}\pageref{LastPageOf\thelettercount}\end{NoHyper}
}
\def\@isodocheadbox#1{\mbox{\color{headingcolor}#1}}
\def\@isodocfootL{}
\def\@isodocfootC{}
\def\@isodocfootR{}
\def\isodoc@bara{\raisebox{-1ex}{\rule{0pt}{3ex}}}
\def\isodoc@barb{\rule{0pt}{2.7ex}}
\def\isodoc@barc{\rule{0pt}{1ex}}
\def\itable#1{\arrayrulewidth0.05em%
  \ifvertical
    \begin{tabularx}{\hsize}{@{}X|r@{}}%
      \sffamily\descriptiontext &
      \sffamily \amounttext\,(\currency)\isodoc@bara\\\hline\\[-5.4ex]
      \isodoc@barb #1%
    \end{tabularx}
  \else
    \begin{tabularx}{\hsize}{@{}Xr@{}}%
      \sffamily\descriptiontext &
      \sffamily \amounttext\,(\currency)\isodoc@bara\\\hline\\[-5.6ex]
      \isodoc@barb #1%
    \end{tabularx}
  \fi
}
\def\iitem#1#2{\\#1&#2\ignorespaces}
\newcommand{\itotal}[2][\totaltext]{%
  \isodoc@barc\\\cline{2-2}#1&\textbf{#2}\isodoc@barb
}
\newcounter{lettercount}\setcounter{lettercount}{0}
\newif\ifclosing\closingtrue
\newcount\footcount
\newcommand{\invoice}[2][]{%
  \closingfalse
  \ifx\payref\empty\def\payref{\ourref}\fi
  \letter[#1,
    opening={\scshape\Large\invoicetext},
    openingcomma={},
    closing={},
    signature={}]{\isodoc@Tbox{35}{127}{140}{\ignorespaces#2}}
}
\newcommand{\letter}[2][]{{%
  \clearpage{\pagestyle{empty}\cleardoublepage}
  \setcounter{section}{0}
  \setkeys{isodoc}{#1}
  \def\isodoc@lead{\ifforeign+\areacode\,\else\phoneprefix\fi}
  \ifx\phone     \empty\else\def\@phone     {\isodoc@lead\phone}    \fi
  \ifx\cellphone \empty\else\def\@cellphone {\isodoc@lead\cellphone}\fi
  \ifx\fax       \empty\else\def\@fax       {\isodoc@lead\fax}      \fi
  \ifx\website   \empty\else\def\@website   {\website}              \fi
  \ifx\email     \empty\else\def\@email     {\email}                \fi
  \ifx\creditorid\empty\else\def\@creditorid{\creditorid}           \fi
  \ifx\yourlettertext\undefined%
    \ClassWarning{isodoc}{
      You did not use the language option; using the default: en-GB}
    \isodoc@enGB%
  \fi
  \ifnum\value{lettercount}=0%
    \hypersetup{pdftitle={letter to \toname\ dated \today},
                pdfsubject={\subject},
                pdfauthor={\who},
                pdfcreator={LaTeX with isodoc class},
    }
  \fi
  \addtocounter{lettercount}{1}
  \setcounter{page}{1}
  \setcounter{footnote}{0}
  \fancyhf{}
  \if@twoside
    \fancyhead[LE,RO]{\@isodocheadbox{\@isodocheadR}}
    \fancyhead[RE,LO]{\@isodocheadbox{\@isodocheadL}}
    \fancyfoot[LE,RO]{\@isodocheadbox{\@isodocfootR}}
    \fancyfoot[RE,LO]{\@isodocheadbox{\@isodocfootL}}
  \else
    \fancyhead[L]{\@isodocheadbox{\@isodocheadL}}
    \fancyhead[R]{\@isodocheadbox{\@isodocheadR}}
    \fancyfoot[L]{\@isodocheadbox{\@isodocfootL}}
    \fancyfoot[R]{\@isodocheadbox{\@isodocfootR}}
  \fi
  \fancyhead[C]{\@isodocheadbox{\@isodocheadC}}
  \fancyfoot[C]{\@isodocheadbox{\@isodocfootC}}
  \logo
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{\@addresswidth}[0,.5](\xaddress,\@addresscenter)%
        \ifreturn
          {\def\\{\unskip\enspace{\rmfamily\mdseries\textbullet}%
                  \enspace\ignorespaces}%
            \sffamily\bfseries\scriptsize\returnaddress
          }\\[-.8\baselineskip]
          \rule{\hsize}{.2pt}\\
        \fi
        \toname\\\toaddress
    \end{textblock}
  }
  \subjectpos=\headerpos
  \textskip=\headerpos\advance\textskip-12
  \ifx\subject\empty\advance\textskip-10\else\advance\subjectpos10\fi
  \openingpos=\subjectpos
  \ifheader
    \openingpos=\subjectpos\advance\openingpos12
    \isodoc@Tbox{35}{\headerpos}{35}{\noindent
      {\@hft\yourlettertext}\\
      \yourletter
    }
    \isodoc@Tbox{70}{\headerpos}{35}{\noindent
      {\@hft\yourreftext}\\
      \raggedright\yourref
    }
    \isodoc@Tbox{105}{\headerpos}{35}{\noindent
      {\@hft\ourreftext}\\
      \raggedright\ourref
    }
    \isodoc@Tbox{140}{\headerpos}{35}{\noindent
      {\@hft\datetext}\\
      \date
    }
    \ifx\subject\empty\else%
      \isodoc@Tbox{35}{\subjectpos}{140}{\noindent
        \ifx\subjecttext\empty{\bfseries\subject}\else%
          \begin{tabularx}{\hsize}{@{}l>{\raggedright}X@{}}
            \@hft\subjecttext&\subject
          \end{tabularx}
        \fi
      }
    \fi
  \else
    \advance\textskip-12
  \fi
  \iffooter
    \isodocFootFields
  \fi
  { \parskip=0pt\parindent=0pt
    \begin{textblock*}{3mm}(\xfold,\yfold)%
       {\color{markercolor}\rule{\hsize}{.2pt}}
    \end{textblock*}
  }
  \ifx\undefined\accepttype\else\accept\fi
  \noindent\isodoc@Tbox{35}{\openingpos}{140}{\opening\@openingcomma}
  \vspace{\textskip mm}
  \thispagestyle{empty}
  \noindent\ignorespaces#2
  \ifclosing{\vskip\closingskip\vskip-\baselineskip
    \parindent=0pt\parskip=\baselineskip\noindent
    \begin{minipage}[t]{\hsize}
        \ifcase\autographversion
          \par\closing\@closingcomma\\\signature   % 0: closing on the next line
        \or\par\closing\@closingcomma\\[\signatureskip]\signature % 1: whiteskip
        \or\autographA
        \or\autographB
        \or\autographC
        \or\autographD
        \or\autographE
        \or\autographF
        \or\autographG
        \or\autographH
        \else
          \par\Undefined{autograph: \autographversion}\\
        \fi
    \end{minipage}
  }\fi
  \ifencldown\vspace*{\fill}\fi
  \ifx\enclosures\empty\else{\\[\enclosureskip]
    \noindent
    \begin{minipage}[t]{\hsize}
        \setbox1=\vbox{\enclosures}%
        \textbf{\ifdim\ht1>\baselineskip\enclosurestext\else\enclosuretext\fi}\\
        \enclosures
    \end{minipage}
  }\fi
  \ifx\copyto\empty\else{\\[\copytoskip]
    \noindent
    \begin{minipage}[t]{\hsize}
        \textbf{\copytotext}\\
        \copyto
    \end{minipage}
  }\fi
  \label{LastPageOf\thelettercount}
}}
  \newcommand{\isodocFootFields}{%
    \footcount=35
    \enlargethispage{-10mm}
    \ForEachX{;}{%
      \setbox0=\hbox{\csname @\thislevelitem\endcsname}
      \ifdim\wd0=0pt\else
        \isodoc@Tbox{\footcount}{\footerpos}{35}{\noindent
          {\@hft\csname\thislevelitem text\endcsname}\\
            \csname @\thislevelitem\endcsname
        }
      \fi
        \advance\footcount35
    }{\isodoc@footorder}
  }
\def\isodoc@Cbox#1#2#3#4{%
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{#3}[.5,.5](#1,#2)%
        \begin{center}
          #4
        \end{center}
    \end{textblock}
  }
}
\long\def\isodoc@Tbox#1#2#3#4{%
  { \parskip0pt\parindent=0pt
    \begin{textblock}{#3}(#1,#2)%
        \begin{minipage}[t]{\hsize}
          \noindent#4
        \end{minipage}
    \end{textblock}
  }
}
\def\accept{
  \isodoc@Tbox{\xacceptdescription}
       {\yacceptdescription}
       {\wacceptdescription}
       {\acceptdescription}
  \isodoc@Tbox{\xacceptdesc}
       {\yacceptdesc}
       {\wacceptdesc}
       {\acceptdesc}
  \isodoc@Tbox{\xacceptaddress}
       {\yacceptaddress}
       {\wacceptaddress}
       {\ifx\acceptaddress\empty\toname\\\toaddress\else\acceptaddress\fi}
  \isodoc@Cbox{\xacceptreference}
       {\yacceptreference}
       {\wacceptreference}
       {\ocrb\acceptreference}
  \isodoc@Tbox{\xacceptref}
       {\yacceptref}
       {\wacceptref}
       {\baselineskip=\acceptreferenceskip\ocrb\acceptreference}
  \isodoc@Cbox{\xaccepteuros}
       {\yaccepteuros}
       {\waccepteuros}
       {\ocrb\accepteuros}
  \isodoc@Cbox{\xacceptaccount}
       {\yacceptaccount}
       {\wacceptaccount}
       {\ocrb\acceptaccount}
  \isodoc@Cbox{\xacceptcents}
       {\yacceptcents}
       {\wacceptcents}
       {\ocrb\acceptcents}
  \isodoc@Cbox{\xaccepteur}
       {\yaccepteur}
       {\waccepteur}
       {\ocrb\accepteuros}
  \isodoc@Cbox{\xacceptct}
       {\yacceptct}
       {\wacceptct}
       {\ocrb\acceptcents}
}
\def\isodoc@caES{%
  \gdef\paymentdatatext {Detalls del pagament}
  \gdef\accountnametext {a nom de}
  \gdef\accountnotext   {N\'um. de compte}
  \gdef\amounttext      {Quantitat}
  \gdef\banknametext    {banc}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {M\`obil}
  \gdef\chambertext     {Cambra de comer\c{c}}
  \gdef\copytotext      {cc}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Data}
  \gdef\daystext        {dies}
  \gdef\descriptiontext {Descripci\'o}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Annexos:}
  \gdef\enclosuretext   {Annex:}
  \gdef\faxtext         {Fax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {factura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {de}
  \gdef\ourreftext      {La nostra refer\`encia}
  \gdef\pagetext        {P\`agina}
  \gdef\phonetext       {Tel\`efon}
  \gdef\payreftext      {Refer\`encia}
  \gdef\routingnotext   {Nombre de ruta}
  \gdef\subjecttext     {Assumpte}
  \gdef\termtext        {Termini del pagament}
  \gdef\totaltext       {Total}
  \gdef\totext          {A}
  \gdef\vatnotext       {N\'um. IVA}
  \gdef\vattext		{IVA}
  \gdef\websitetext     {Web}
  \gdef\yourlettertext  {La seva carta del}
  \gdef\yourreftext     {La seva refer\`encia}
  \gdef\@isodate        {\number\day\space\ifcase\month\or
    gener\or febrer\or mar\c{c}\or abril\or maig\or juny\or
    juliol\or agost\or setembre\or octubre\or novembre\or desembre\fi
    \space \number\year
  }
}
\def\isodoc@deDE{%
  \gdef\paymentdatatext {Zahlungsdaten}
  \gdef\accountnametext {Name}
  \gdef\accountnotext   {Konto-Nr.}
  \gdef\amounttext      {Betrag}
  \gdef\banknametext    {Bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {Handy}
  \gdef\chambertext     {Register-Nr.}
  \gdef\copytotext      {Kopien an}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Datum}
  \gdef\daystext        {Tage}
  \gdef\descriptiontext {Bezeichnung}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Anlagen:}
  \gdef\enclosuretext   {Anlage:}
  \gdef\faxtext         {Fax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {Rechnung}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {von}
  \gdef\ourreftext      {Unser Zeichen}
  \gdef\pagetext        {Seite}
  \gdef\phonetext       {Telefon}
  \gdef\payreftext      {Referenz-Nr.}
  \gdef\routingnotext   {\scshape blz}
  \gdef\subjecttext     {}
  \gdef\termtext        {Zahlungstermin}
  \gdef\totaltext       {Insgesamt}
  \gdef\totext          {An}
  \gdef\vatnotext       {USt-IdNr.}
  \gdef\vattext		{MwSt}
  \gdef\websitetext     {Webseite}
  \gdef\yourlettertext  {Ihr Brief vom}
  \gdef\yourreftext     {Ihr Zeichen}
  \gdef\@isodate        {\number\day.\space\ifcase\month\or
    Januar\or Februar\or M\"arz\or April\or Mai\or Juni\or
    Juli\or August\or September\or Oktober\or November\or Dezember\fi
    \space\number\year}
}
\def\isodoc@german{%
  \isodoc@deDE%
  \ClassWarning{isodoc}{
    language name german is obsolete: use de-DE
  }
}
\def\isodoc@enGB{%
  \if@isodocordinalss
    \gdef\@st{\textsuperscript{st}}
    \gdef\@nd{\textsuperscript{nd}}
    \gdef\@rd{\textsuperscript{rd}}
    \gdef\@th{\textsuperscript{th}}
  \else
    \gdef\@st{st}
    \gdef\@nd{nd}
    \gdef\@rd{rd}
    \gdef\@th{th}
  \fi
  \gdef\paymentdatatext {Payment details}
  \gdef\accountnametext {in the name of}
  \gdef\accountnotext   {Account no.}
  \gdef\amounttext      {Amount}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {cellphone}
  \gdef\chambertext     {ch.comm.}
  \gdef\copytotext      {Copy to}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Date}
  \gdef\daystext        {days}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Enclosures:}
  \gdef\enclosuretext   {Enclosure:}
  \gdef\faxtext         {telefax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {invoice}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {of}
  \gdef\ourreftext      {Our reference}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {telephone}
  \gdef\payreftext      {Reference}
  \gdef\routingnotext   {Sort code}
  \gdef\subjecttext     {Subject:}
  \gdef\termtext        {term of payment}
  \gdef\totaltext       {Total}
  \gdef\totext          {To}
  \gdef\vatnotext       {vat no.}
  \gdef\vattext		{Vat}
  \gdef\websitetext     {website}
  \gdef\yourlettertext  {Your letter of}
  \gdef\yourreftext     {Your reference}
  \gdef\@isodate        {\ifcase\day\or
     1\@st\or  2\@nd\or  3\@rd\or  4\@th\or  5\@th\or
     6\@th\or  7\@th\or  8\@th\or  9\@th\or 10\@th\or
    11\@th\or 12\@th\or 13\@th\or 14\@th\or 15\@th\or
    16\@th\or 17\@th\or 18\@th\or 19\@th\or 20\@th\or
    21\@st\or 22\@nd\or 23\@rd\or 24\@th\or 25\@th\or
    26\@th\or 27\@th\or 28\@th\or 29\@th\or 30\@th\or
    31\@st\fi\space\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space \number\year}
}
\def\isodoc@english{%
  \isodoc@enGB%
  \ClassWarning{isodoc}{
    language name english is obsolete: use en-GB
  }
}
\def\isodoc@enUS{%
  \gdef\paymentdatatext {Payment details}
  \gdef\accountnametext {in the name of}
  \gdef\accountnotext   {Account no.}
  \gdef\amounttext      {Amount}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {cellphone}
  \gdef\chambertext     {ch.comm.}
  \gdef\copytotext      {cc}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Date}
  \gdef\daystext        {days}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Enclosures:}
  \gdef\enclosuretext   {Enclosure:}
  \gdef\faxtext         {telefax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {invoice}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {of}
  \gdef\ourreftext      {Our reference}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {telephone}
  \gdef\payreftext      {Reference}
  \gdef\routingnotext   {Routing no}
  \gdef\subjecttext     {Subject:}
  \gdef\termtext        {term of payment}
  \gdef\totaltext       {Total}
  \gdef\totext          {To}
  \gdef\vatnotext       {vat no.}
  \gdef\vattext		{Vat}
  \gdef\websitetext     {website}
  \gdef\yourlettertext  {Your letter of}
  \gdef\yourreftext     {Your reference}
  \gdef\@isodate        {\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day, \number\year}
}
\def\isodoc@american{%
  \isodoc@enUS%
  \ClassWarning{isodoc}{
    language name american is obsolete: use en-US
  }
}
\def\isodoc@esES{%
  \def\openingcomma     {:}
  \gdef\paymentdatatext {Detalles de pago}
  \gdef\accountnametext {a nombre de}
  \gdef\accountnotext   {N\'um. de cuenta}
  \gdef\amounttext      {Cantidad}
  \gdef\banknametext    {banco}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {M\'ovil}
  \gdef\chambertext     {C\'amara de comercio}
  \gdef\copytotext      {cc}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Fecha}
  \gdef\daystext        {d\'{\i}as}
  \gdef\descriptiontext {Descripci\'on}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Anexos:}
  \gdef\enclosuretext   {Anexo:}
  \gdef\faxtext         {Fax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {factura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {de}
  \gdef\ourreftext      {Nuestra referencia}
  \gdef\pagetext        {P\'agina}
  \gdef\phonetext       {Tel\'efono}
  \gdef\payreftext      {Referencia}
  \gdef\routingnotext   {n\'umero de ruta}
  \gdef\subjecttext     {Asunto}
  \gdef\termtext        {Plazo de pago}
  \gdef\totaltext       {Total}
  \gdef\totext          {A}
  \gdef\vatnotext       {N\'um. IVA}
  \gdef\vattext		{IVA}
  \gdef\websitetext     {Web}
  \gdef\yourlettertext  {Su carta de}
  \gdef\yourreftext     {Su referencia}
  \gdef\@isodate        {\number\day\space\ifcase\month\or
    enero\or febrero\or marzo\or abril\or mayo\or junio\or
    julio\or agosto\or septiembre\or octubre\or noviembre\or diciembre\fi
    \space \number\year
  }
}
\def\isodoc@frFR{%
  \gdef\paymentdatatext {Détails de paiement}
  \gdef\accountnametext {au nom de}
  \gdef\accountnotext   {no. compte}
  \gdef\amounttext      {Montant}
  \gdef\banknametext    {banque}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {portable}
  \gdef\chambertext     {c.c.i.}
  \gdef\copytotext      {Copie à}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Date:}
  \gdef\daystext        {jours}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Pièces jointes:}
  \gdef\enclosuretext   {Pièce jointe:}
  \gdef\faxtext         {téléfax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {facture}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {de}
  \gdef\ourreftext      {Nos références:}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {téléphone}
  \gdef\payreftext      {référence}
  \gdef\routingnotext   {numéro d'acheminement}
  \gdef\subjecttext     {Objet:}
  \gdef\termtext        {terme}
  \gdef\totaltext       {Total}
  \gdef\totext          {À l'attention de}
  \gdef\vatnotext       {no. T.V.A.}
  \gdef\vattext         {T.V.A.}
  \gdef\websitetext     {site Web}
  \gdef\yourlettertext  {Votre lettre du}
  \gdef\yourreftext     {Vos références:}
  \gdef\@isodate        {\number\day\ifnum\day=1$^{er}$\fi\space\ifcase\month\or
    janvier\or février\or mars\or avril\or mai\or juin\or
    juillet\or ao\^ut\or septembre\or octobre\or
    novembre\or décembre\fi \space \number\year}
}
\def\isodoc@french{%
  \isodoc@frFR%
  \ClassWarning{isodoc}{
    language name french is obsolete: use fr-FR
  }
}
\def\isodoc@itIT{%
  \gdef\paymentdatatext {Dettagli di pagamento}
  \gdef\accountnametext {intestato a}
  \gdef\accountnotext   {n$^o$~del conto}
  \gdef\amounttext      {Prezzo}
  \gdef\banknametext    {banca}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {cellulare:}
  \gdef\chambertext     {}
  \gdef\copytotext      {Per conoscenza a:}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Data:}
  \gdef\daystext        {giorni}
  \gdef\descriptiontext {Descrizione}
  \gdef\emailtext       {e-mail:}
  \gdef\enclosurestext  {Allegati:}
  \gdef\enclosuretext   {Allegato:}
  \gdef\faxtext         {fax:}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {fattura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {di}
  \gdef\ourreftext      {Nostro riferimento:}
  \gdef\pagetext        {Pagina}
  \gdef\phonetext       {telefono:}
  \gdef\payreftext      {riferimento}
  \gdef\routingnotext   {numero di routing}
  \gdef\subjecttext     {Oggetto:}
  \gdef\termtext        {scadenza}
  \gdef\totaltext       {Totale}
  \gdef\totext          {All'attenzione di:}
  \gdef\vatnotext       {Partita I.V.A.}
  \gdef\vattext         {I.V.A.}
  \gdef\websitetext     {sito Web:}
  \gdef\yourlettertext  {Vostra lettera del:}
  \gdef\yourreftext     {Vostro riferimento:}
  \gdef\@isodate        {\number\day\ifnum\day=1\fi
    ~\ifcase\month\or
    Gennaio\or Febbraio\or Marzo\or Aprile\or Maggio\or Giugno\or
    Luglio\or Agosto\or Settembre\or Ottobre\or Novembre\or Dicembre\fi
    \space \number\year}
}
\def\isodoc@nbNO{%
  \gdef\paymentdatatext {Betalingsdetaljer}
  \gdef\accountnametext {til}
  \gdef\accountnotext   {faktura nr}
  \gdef\amounttext      {Bel\o{}p}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {mobil}
  \gdef\chambertext     {}
  \gdef\copytotext      {kopi til:}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Dato}
  \gdef\daystext        {dager}
  \gdef\descriptiontext {Beskrivelse}
  \gdef\emailtext       {e-post}
  \gdef\enclosurestext  {Vedlegg:}
  \gdef\enclosuretext   {Vedlegg:}
  \gdef\faxtext         {telefaks}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {faktura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {av}
  \gdef\ourreftext      {V\aa{}r ref:}
  \gdef\pagetext        {Side}
  \gdef\phonetext       {telefon}
  \gdef\payreftext      {referanse}
  \gdef\routingnotext   {routing-nummer}
  \gdef\subjecttext     {Vedr:}
  \gdef\termtext        {betalingsfrist}
  \gdef\totaltext       {Total}
  \gdef\totext          {Til}
  \gdef\vatnotext       {Org. nr.}
  \gdef\vattext         {Mva}
  \gdef\websitetext     {hjemmeside}
  \gdef\yourlettertext  {Deres brev av}
  \gdef\yourreftext     {Deres ref:}
  \gdef\@isodate        {\number\day.\space\ifcase\month\or
    januar\or februar\or mars\or april\or mai\or juni\or
    juli\or august\or september\or oktober\or november\or desember\fi
   \space \number\year}
}
\def\isodoc@nlBE{%
  \gdef\paymentdatatext {Betaalgegevens}
  \gdef\accountnametext {op naam van}
  \gdef\accountnotext   {rekeningnummer}
  \gdef\amounttext      {Bedrag}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {mobiel}
  \gdef\chambertext     {ondernemingsnummer}
  \gdef\copytotext      {Kopie aan:}
  \gdef\creditoridtext  {Incassant ID}
  \gdef\datetext        {Datum}
  \gdef\daystext        {dagen}
  \gdef\descriptiontext {Omschrijving}
  \gdef\emailtext       {e-mail}
  \gdef\enclosurestext  {Bijlagen:}
  \gdef\enclosuretext   {Bijlage:}
  \gdef\faxtext         {fax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {factuur}
  \gdef\mandateidtext   {Kenmerk machtiging}
  \gdef\oftext          {van}
  \gdef\ourreftext      {Ons kenmerk}
  \gdef\pagetext        {Pagina}
  \gdef\phonetext       {telefoon}
  \gdef\payreftext      {kenmerk}
  \gdef\routingnotext   {routenummer}
  \gdef\subjecttext     {Betreft:}
  \gdef\termtext        {betalingstermijn}
  \gdef\totaltext       {Totaal}
  \gdef\totext          {Aan}
  \gdef\vatnotext       {ondernemingsnummer}
  \gdef\vattext         {btw}
  \gdef\websitetext     {webstek}
  \gdef\yourlettertext  {Uw brief van}
  \gdef\yourreftext     {Uw kenmerk}
  \gdef\@isodate        {\number\day\space\ifcase\month\or
    januari\or februari\or maart\or april\or mei\or juni\or juli\or
    augustus\or september\or oktober\or november\or december\fi
    \space \number\year}
}
\def\isodoc@nlNL{%
  \gdef\paymentdatatext {Betaalgegevens}
  \gdef\accountnametext {ten name van}
  \gdef\accountnotext   {rekeningnummer}
  \gdef\amounttext      {Bedrag}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {mobiel}
  \gdef\chambertext     {kvk}
  \gdef\copytotext      {Kopie aan:}
  \gdef\creditoridtext  {Incassant ID}
  \gdef\datetext        {Datum}
  \gdef\daystext        {dagen}
  \gdef\descriptiontext {Omschrijving}
  \gdef\emailtext       {e-mail}
  \gdef\enclosurestext  {Bijlagen:}
  \gdef\enclosuretext   {Bijlage:}
  \gdef\faxtext         {fax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {rekening}
  \gdef\mandateidtext   {Kenmerk machtiging}
  \gdef\oftext          {van}
  \gdef\ourreftext      {Ons kenmerk}
  \gdef\pagetext        {Bladnummer}
  \gdef\phonetext       {telefoon}
  \gdef\payreftext      {kenmerk}
  \gdef\routingnotext   {banknummer}
  \gdef\subjecttext     {Onderwerp:}
  \gdef\termtext        {betalingstermijn}
  \gdef\totaltext       {Totaal}
  \gdef\totext          {Aan}
  \gdef\vatnotext       {btwnummer}
  \gdef\vattext         {btw}
  \gdef\websitetext     {webstek}
  \gdef\yourlettertext  {Uw brief van}
  \gdef\yourreftext     {Uw kenmerk}
  \gdef\@isodate        {\number\day\space\ifcase\month\or
    januari\or februari\or maart\or april\or mei\or juni\or juli\or
    augustus\or september\or oktober\or november\or december\fi
    \space \number\year}
}
\def\isodoc@dutch{%
  \isodoc@nlNL%
  \ClassWarning{isodoc}{
    language name dutch is obsolete: use nl-NL
  }
}
\def\isodoc@srRS{%
  \gdef\paymentdatatext {Podaci o bankarskom sektoru}
  \gdef\accountnametext {na ime}
  \gdef\accountnotext   {Ra\v cun br.}
  \gdef\amounttext      {Iznos}
  \gdef\banknametext    {banka}
  \gdef\bictext         {undefined}
  \gdef\cellphonetext   {Mobilni}
  \gdef\chambertext     {Spisak br.}
  \gdef\copytotext      {Kopije}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Datum}
  \gdef\daystext        {dana}
  \gdef\descriptiontext {Opis}
  \gdef\emailtext       {Email}
  \gdef\enclosurestext  {Prilozi:}
  \gdef\enclosuretext   {Prilog:}
  \gdef\faxtext         {Telefax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {faktura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {od}
  \gdef\ourreftext      {Na\v s broj}
  \gdef\pagetext        {Strana}
  \gdef\phonetext       {Telefon}
  \gdef\payreftext      {Dokumet br.}
  \gdef\routingnotext   {BLZ}
  \gdef\subjecttext     {Predmet:}
  \gdef\termtext        {rok pla\' canja}
  \gdef\totaltext       {Ukupno}
  \gdef\totext          {U}
  \gdef\vatnotext       {porez br.}
  \gdef\vattext         {PDV}
  \gdef\websitetext     {Website}
  \gdef\yourlettertext  {Va\v se pismo od}
  \gdef\yourreftext     {Va\v s broj}
  \gdef\@isodate        {\number\day.~\ifcase\month\or
    Januar\or Februar\or Mart\or April\or Maj\or Jun\or
    Jul\or Avgust\or Septembar\or Oktobar\or Novembar\or Decembar\fi
    \space\number\year}
}
\def\isodoc@svSE{%
  \gdef\paymentdatatext {Betalningsdetaljer}
  \gdef\accountnametext {Konto\"agare}
  \gdef\accountnotext   {Kontonummer}
  \gdef\amounttext      {Summa}
  \gdef\banknametext    {bank}
  \gdef\bictext         {\scshape bic}
  \gdef\cellphonetext   {Mobil}
  \gdef\chambertext     {ch.comm.}
  \gdef\copytotext      {cc}
  \gdef\creditoridtext  {Creditor ID}
  \gdef\datetext        {Datum}
  \gdef\daystext        {dagar}
  \gdef\descriptiontext {Beskrivning}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Bifogat:}
  \gdef\enclosuretext   {Bifogat:}
  \gdef\faxtext         {telefax}
  \gdef\ibantext        {\scshape iban}
  \gdef\invoicetext     {Faktura}
  \gdef\mandateidtext   {Mandate ID}
  \gdef\oftext          {av}
  \gdef\ourreftext      {V\r{a}r referens}
  \gdef\pagetext        {Sida}
  \gdef\phonetext       {Telefon}
  \gdef\payreftext      {Faktura}
  \gdef\routingnotext   {Routing no}
  \gdef\subjecttext     {\"Arende:}
  \gdef\termtext        {Betalningsvillkor}
  \gdef\totaltext       {Total}
  \gdef\totext          {Till}
  \gdef\vatnotext       {Momsregistrering.}
  \gdef\vattext		{Moms}
  \gdef\websitetext     {Web}
  \gdef\yourlettertext  {Ert brev}
  \gdef\yourreftext     {Er Referens}
  \gdef\@isodate        {\ifcase\month\or
    Januari\or Februari\or Mars\or April\or Maj\or Juni\or
    Juli\or Augusti\or September\or Oktober\or November\or December\fi
    \space\number\day, \number\year}
}
\endinput
%%
%% End of file `isodoc.cls '.
