%%
%% This is file `pressrelease.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pressrelease.dtx  (with options: `pressrelease.cls,package')
%% 
%%  pressrelease.dtx
%%  Copyright 2014 Nicola Talbot
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license of (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status `maintained'.
%% 
%%  The Current Maintainer of this work is Nicola Talbot.
%% 
%%  This work consists of the files pressrelease.dtx and pressrelease.ins and the derived files pressrelease.cls, pressrelease-symbols.sty.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pressrelease}[2014/09/10 v1.0 (NLCT) Press Release Class]
\RequirePackage{xkeyval}
\RequirePackage{etoolbox}
\DeclareOptionX{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOptionX{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOptionX{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareOptionX{letterpaper}{\PassOptionsToClass{letterpaper}{article}}
\DeclareOptionX{a4paper}{\PassOptionsToClass{a4paper}{article}}
\define@boolkey{pressrelease.cls}[@PRload]{symbols}[true]{}
\@PRloadsymbolsfalse
\newif\ifPRheadabove
\PRheadabovetrue
\newcommand{\PRheadalign}[1]{%
 \begin{center}#1\end{center}%
}
\define@choicekey{pressrelease.cls}{head}[\val\nr]%
 {above,below,center,left,right,centre,%
  above center,above centre,above left,above right,%
  below center,below centre,below left,below right}%
 {%
 \ifcase\nr\relax
   \PRheadabovetrue
 \or
   \PRheadabovefalse
 \or
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or
  \renewcommand{\PRheadalign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or
  \renewcommand{\PRheadalign}[1]{\begin{flushright}##1\end{flushright}}%
 \or
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or % above center
  \PRheadabovetrue
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or % above centre
  \PRheadabovetrue
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or % above left
  \PRheadabovetrue
  \renewcommand{\PRheadalign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or % above right
  \PRheadabovetrue
  \renewcommand{\PRheadalign}[1]{\begin{flushright}##1\end{flushright}}%
 \or % below centre
  \PRheadabovefalse
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or % below center
  \PRheadabovefalse
  \renewcommand{\PRheadalign}[1]{\begin{center}##1\end{center}}%
 \or % below left
  \PRheadabovefalse
  \renewcommand{\PRheadalign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or % below right
  \PRheadabovefalse
  \renewcommand{\PRheadalign}[1]{\begin{flushright}##1\end{flushright}}%
 \fi
}
\newcommand*{\PRlogoformat}[1]{#1}
\define@choicekey{pressrelease.cls}{smashlogo}[\val\nr]{true,false}[true]{%
  \ifcase\nr\relax
    \renewcommand*{\PRlogoformat}[1]{\vbox to 0pt{##1}}%
  \or
    \renewcommand*{\PRlogoformat}[1]{##1}%
  \fi
}
\newif\ifPRlogoabove
\PRlogoabovetrue
\newcommand{\PRlogoalign}[1]{{\raggedleft\PRlogoformat{#1}\par}}
\define@choicekey{pressrelease.cls}{logo}[\val\nr]%
 {left,right,above,below,above left,above right,below left,below right}{%
  \ifcase\nr\relax
    \renewcommand{\PRlogoalign}[1]{{\raggedright\PRlogoformat{##1}\@@par}}%
  \or
    \renewcommand{\PRlogoalign}[1]{{\raggedleft\PRlogoformat{##1}\@@par}}%
  \or
    \PRlogoabovetrue
  \or
    \PRlogoabovefalse
  \or
    \PRlogoabovetrue
    \renewcommand{\PRlogoalign}[1]{{\raggedright\PRlogoformat{##1}\@@par}}%
  \or
    \PRlogoabovetrue
    \renewcommand{\PRlogoalign}[1]{{\raggedleft\PRlogoformat{##1}\@@par}}%
  \or
    \PRlogoabovefalse
    \renewcommand{\PRlogoalign}[1]{{\raggedright\PRlogoformat{##1}\@@par}}%
  \or
    \PRlogoabovefalse
    \renewcommand{\PRlogoalign}[1]{{\raggedleft\PRlogoformat{##1}\@@par}}%
  \fi
}
\newcommand{\PRreleasealign}[1]{%
 \begin{center}#1\end{center}%
}
\define@choicekey{pressrelease.cls}{releasealign}[\val\nr]{center,left,right,centre}{%
 \ifcase\nr\relax
  \renewcommand{\PRreleasealign}[1]{\begin{center}##1\end{center}}%
 \or
  \renewcommand{\PRreleasealign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or
  \renewcommand{\PRreleasealign}[1]{\begin{flushright}##1\end{flushright}}%
 \or
  \renewcommand{\PRreleasealign}[1]{\begin{center}##1\end{center}}%
 \fi
}
\define@boolkey{pressrelease.cls}[PR]{ruled}[true]{}
\PRruledtrue
\newcommand{\PRinfotopalign}[1]{%
 \begin{flushleft}#1\end{flushleft}%
}
\define@choicekey{pressrelease.cls}{topinfoalign}[\val\nr]{center,left,right,centre}{%
 \ifcase\nr\relax
  \renewcommand{\PRinfotopalign}[1]{\begin{center}##1\end{center}}%
 \or
  \renewcommand{\PRinfotopalign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or
  \renewcommand{\PRinfotopalign}[1]{\begin{flushright}##1\end{flushright}}%
 \or
  \renewcommand{\PRinfotopalign}[1]{\begin{center}##1\end{center}}%
 \fi
}
\newcommand{\PRinfobottomalign}[1]{%
 \begin{flushright}#1\end{flushright}%
}
\define@choicekey{pressrelease.cls}{bottominfoalign}[\val\nr]{center,left,right,centre}{%
 \ifcase\nr\relax
  \renewcommand{\PRinfobottomalign}[1]{\begin{center}##1\end{center}}%
 \or
  \renewcommand{\PRinfobottomalign}[1]{\begin{flushleft}##1\end{flushleft}}%
 \or
  \renewcommand{\PRinfobottomalign}[1]{\begin{flushright}##1\end{flushright}}%
 \or
  \renewcommand{\PRinfobottomalign}[1]{\begin{center}##1\end{center}}%
 \fi
}
\ProcessOptionsX
\LoadClass{article}
\RequirePackage{setspace}
\RequirePackage{geometry}
\RequirePackage{url}
\RequirePackage{refcount}
\geometry{hmargin=1in,vmargin=1in,hcentering}
\singlespacing
\newcommand*{\PRreleasetext}{For immediate release}
\newcommand*{\PRcontacttext}{Contact}
\newcommand*{\PRphonetext}{Telephone}
\newcommand*{\PRmobiletext}{Mobile}
\newcommand*{\PRemailtext}{Email}
\newcommand*{\PRurltext}{Website}
\newcommand*{\PRfaxtext}{Fax}
\newcommand*{\PRcompanytext}{Company}
\newcommand*{\PRdepartmenttext}{Department}
\newcommand*{\PRaddresstext}{Address}
\newcommand*{\PRhourstext}{Opening Times}
\newcommand*{\PRdatetext}{Date}
\newcommand*{\PRlocationtext}{Location}
\newcommand*{\PRabouttext}{About \PRusevar{company}}
\newcommand*{\PRencltext}{Encl.}
\newcommand*{\PRrelease}[1]{\renewcommand*{\@PRrelease}{#1}}
\newcommand*{\@PRrelease}{\PRreleasetext}
\newcommand*{\PRreleaseformat}[1]{\textbf{\Large\MakeUppercase{#1}}}
\newcommand{\PRdohrule}{\ifPRruled\par\noindent\hrulefill\par\noindent\fi}
\newcommand*{\PRtagformat}[1]{\textbf{#1:}}
\newcommand*{\PRcompany}[1]{\renewcommand*{\@PRcompany}{#1}}
\newcommand*{\@PRcompany}{}
\newcommand*{\PRdepartment}[1]{\renewcommand*{\@PRdepartment}{#1}}
\newcommand*{\@PRdepartment}{}
\newcommand*{\PRcontact}[1]{\renewcommand*{\@PRcontact}{#1}}
\newcommand*{\@PRcontact}{}
\newcommand*{\PRaddress}[1]{\renewcommand*{\@PRaddress}{#1}}
\newcommand*{\@PRaddress}{}
\newcommand*{\PRlocation}[1]{\renewcommand*{\@PRlocation}{#1}}
\newcommand*{\@PRlocation}{}
\newcommand*{\PRphone}[1]{\renewcommand*{\@PRphone}{#1}}
\newcommand*{\@PRphone}{}
\newcommand*{\PRmobile}[1]{\renewcommand*{\@PRmobile}{#1}}
\newcommand*{\@PRmobile}{}
\newcommand*{\PRfax}[1]{\renewcommand*{\@PRfax}{#1}}
\newcommand*{\@PRfax}{}
\newcommand*{\PRemail}[1]{\renewcommand*{\@PRemail}{\PRemailformat{#1}}}
\newcommand*{\@PRemail}{}
\newcommand*{\PRemailformat}[1]{\texttt{#1}}
\newcommand*{\PRurl}[1]{\renewcommand*{\@PRurl}{\protect\url{#1}}}
\newcommand*{\@PRurl}{}
\newcommand*{\PRhours}[1]{\renewcommand*{\@PRhours}{#1}}
\newcommand*{\@PRhours}{}
\newcommand*{\PRlogo}[1]{\renewcommand*{\@PRlogo}{#1}}
\newcommand*{\@PRlogo}{}
\newcommand*{\PRencl}[1]{\renewcommand*{\@PRencl}{#1}}
\newcommand*{\@PRencl}{}
\newcommand*{\PRusevar}[1]{\csuse{@PR#1}}
\newcommand*{\@PRdate}{\@date}
\newcommand{\PRinfotopblock}[9]{#1#2#3#9}
\newcommand{\PRinfobottomblock}[9]{#4#5#6#7#8}
\DeclareListParser*{\@PR@forslashlist}{/}
\newcommand*{\@PR@slashlistdo}[1]{%
  \ifstrequal{#1}{company}%
  {\appto\@PR@infoargs{##1}}%
  {%
    \ifstrequal{#1}{department}%
    {\appto\@PR@infoargs{##2}}%
    {%
      \ifstrequal{#1}{location}%
      {\appto\@PR@infoargs{##3}}%
      {%
        \ifstrequal{#1}{contact}%
        {\appto\@PR@infoargs{##4}}%
        {%
          \ifstrequal{#1}{address}%
          {\appto\@PR@infoargs{##5}}%
          {%
            \ifstrequal{#1}{hours}%
            {\appto\@PR@infoargs{##6}}%
            {%
              \ifstrequal{#1}{phone}%
              {\appto\@PR@infoargs{##7}}%
              {%
                \ifstrequal{#1}{email}%
                {\appto\@PR@infoargs{##8}}%
                {%
                  \ifstrequal{#1}{date}%
                  {\appto\@PR@infoargs{##9}}%
                  {%
                    \ClassError{pressrelease}%
                    {Unknown info block option `#1'}%
                    {Available options: `company', `department',
                    `location', `contact', `address', `hours', `phone',
                    `email', `date'}%
                  }%
                }%
              }%
            }%
          }%
        }%
      }%
    }%
  }%
}
\define@key{pressrelease.cls}{topinfo}{%
    \def\@PR@infoargs{}%
    \@PR@forslashlist\@PR@slashlistdo{#1}%
    \expandafter\renewcommand\expandafter\PRinfotopblock
     \expandafter[\expandafter9\expandafter]\expandafter{\@PR@infoargs}%
}
\define@key{pressrelease.cls}{bottominfo}{%
    \def\@PR@infoargs{}%
    \@PR@forslashlist\@PR@slashlistdo{#1}%
    \expandafter\renewcommand\expandafter\PRinfobottomblock
     \expandafter[\expandafter9\expandafter]\expandafter{\@PR@infoargs}%
}

\newcommand*{\PRset}[1]{\setkeys{pressrelease.cls}{#1}}
\newcommand*{\PR@infotopline}[2]{%
  \ifdefempty{#2}{}{\PRinfotopline{#1}{#2}}%
}
\newcommand*{\PR@infobottomline}[2]{%
  \ifdefempty{#2}{}{\PRinfobottomline{#1}{#2}}%
}
\newcommand{\PR@doinfotop}{%
  \PRinfotopalign{%
    \PR@doinfoblock\PR@infotopline\PRinfotopblock
       \PRinfotopbeginhook\PRinfotopendhook
  }%
}
\newcommand{\PR@doinfobottom}{%
  \PRinfobottomalign{%
    \PR@doinfoblock\PR@infobottomline\PRinfobottomblock
       \PRinfobottombeginhook\PRinfobottomendhook
  }%
}
\newcommand{\PR@doinfoblock}[4]{%
  \begin{tabular}{@{}ll@{}}%
    #3%
    #2%
    {%
      #1{\PRcompanytext}{\@PRcompany}%
    }%
    {%
      #1{\PRdepartmenttext}{\@PRdepartment}%
    }%
    {%
      #1{\PRlocationtext}{\@PRlocation}%
    }%
    {%
      #1{\PRcontacttext}{\@PRcontact}%
    }%
    {%
      #1{\PRaddresstext}{\@PRaddress}%
    }%
    {%
      #1{\PRhourstext}{\@PRhours}%
    }%
    {%
      #1{\PRphonetext}{\@PRphone}%
      #1{\PRmobiletext}{\@PRmobile}%
      #1{\PRfaxtext}{\@PRfax}%
    }%
    {%
      #1{\PRemailtext}{\@PRemail}%
    }%
    {%
      #1{\PRdatetext}{\@date}%
    }%
  #4%
  \end{tabular}%
}
\newcommand*{\PRinfoentry}[1]{\begin{tabular}[t]{@{}l@{}}#1\end{tabular}}
\newcommand*{\PRinfoline}[2]{%
  \PRtagformat{#1} & \PRinfoentry{#2}\tabularnewline
}
\newcommand*{\PRinfotopline}{\PRinfoline}
\newcommand*{\PRinfobottomline}{\PRinfoline}
\newcommand*{\PRinfotopbeginhook}{}
\newcommand*{\PRinfotopendhook}{}
\newcommand*{\PRinfobottombeginhook}{}
\newcommand*{\PRinfobottomendhook}{}

\newcommand*{\PRheadline}[1]{\renewcommand*{\@PRheadline}{#1}}
\newcommand*{\@PRheadline}{}
\newcommand*{\PRsubheadline}[1]{\renewcommand*{\@PRsubheadline}{#1}}
\newcommand*{\@PRsubheadline}{}
\newcommand*{\PRheadformat}[1]{\textbf{\Large #1}}
\newcommand*{\PRsubheadformat}[1]{\textit{#1}}
\newcounter{pressrelease}
\newcommand*{\PRthelastpage}{0}
\newenvironment{pressrelease}%
{%
  \refstepcounter{pressrelease}%
  \refused{pressreleaseend.\number\c@pressrelease}%
  \xdef\PRthelastpage{%
    \getpagerefnumber{pressreleaseend.\number\c@pressrelease}}%
  \pagestyle{pressrelease}%
  \ifPRlogoabove
    \ifdefempty\@PRlogo{}{\PRlogoalign{\@PRlogo}}%
  \fi
    \PRreleasealign{%
      \PRdohrule\mbox{}\par\noindent
      \PRreleaseformat{\@PRrelease}%
      \ifPRheadabove\else\PRdohrule\fi
    }%
  \ifPRlogoabove
  \else
    \ifdefempty\@PRlogo{}{\PRlogoalign{\@PRlogo}}%
  \fi
  \ifPRheadabove
    \PRheadalign
    {%
       \PRheadformat{\@PRheadline}%
       \ifdefempty\@PRsubheadline
       {}%
       {\par\PRsubheadformat{\@PRsubheadline}}%
      \PRdohrule
    }%
    \par\noindent\PR@doinfotop
  \else
    \par\noindent\PR@doinfotop
    \PRheadalign
    {%
      \PRdohrule\mbox{}\par\noindent
       \PRheadformat{\@PRheadline}%
       \ifdefempty\@PRsubheadline
       {}%
       {\par\PRsubheadformat{\@PRsubheadline}}%
      \PRdohrule
    }%
  \fi
  \par
  \doublespacing
  \@afterheading\@afterindentfalse
}%
{%
  \par\singlespacing
  \PR@doinfobottom
  \ifdefempty{\@PRencl}{}%
  {\par\noindent\PRenclformat{\PRencltext}{\@PRencl}}%
  \PRformatendsignal{\PRendsignal}%
  \label{pressreleaseend.\number\c@pressrelease}%
}%
\newcommand*{\PRenclformat}[2]{%
 \begin{tabular}{@{}ll}%
 \PRtagformat{#1}&\PRinfoentry{#2}%
 \end{tabular}}
\newcommand*{\PRheaderfont}[1]{\textit{#1}}
\newcommand*{\ps@pressrelease}{%
  \gdef\@oddhead{\hfill\ifnum\c@page>1\relax
    \PRheaderfont{\PRusevar{headline}}%
  \fi\hfill}%
  \global\let\@evenhead\@oddhead
  \gdef\@oddfoot{%
   \hfill
   \PRnOfm{\thepage}{\PRthelastpage}%
   \hfill}%
  \global\let\@evenfoot\@oddfoot
}
\newcommand*{\PRnOfm}[2]{#1 of #2}
\newcommand*{\PRendsignal}{\#\#\#}
\newcommand*{\PRformatendsignal}[1]{\begin{center}#1\end{center}}
\newenvironment{about}%
 {%
  \section*{\PRabouttext}%
 }%
 {%
   \ifdefempty\@PRurl
   {}%
   {%
     \PRurlformat{\PRurltext}{\@PRurl}\PRaboutposturlhook\par
   }%
 }
\newcommand{\PRurlformat}[2]{%
  \par\noindent\PRtagformat{#1} #2}
\newcommand*{\PRaboutposturlhook}{}
\if@PRloadsymbols
  \RequirePackage{pressrelease-symbols}
\fi
\disable@keys{pressrelease.cls}{symbols}
\endinput
%%
%% End of file `pressrelease.cls'.
