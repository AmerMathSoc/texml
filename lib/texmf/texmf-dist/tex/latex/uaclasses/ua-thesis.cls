%%
%% This is file `ua-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ua-classes.dtx  (with options: `ua-thesis')
%% 
%% Except where otherwise indicated this code was originally written
%% by, and continues to be maintained by, Marcel Oliver. It is released
%% into the public domain.
%% Where otherwise indicated, code is covered by the licensing terms of
%% the original packages.
%% The above statement was added 2009/01/05 by Clea F. Rees on behalf
%% of the author.
%%
%% File ua-classes.dtx by Marcel Oliver
%%
%% Documentation can be obtained by running "latex labels.dtx"
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ua-thesis}
              [1997/03/08 UA Thesis Class]
\newif\iffinal@
\DeclareOption{final}{%
  \final@true
  \PassOptionsToClass{final}{report}}
\DeclareOption{draft}{%
  \final@false
  \PassOptionsToClass{draft}{report}}
\ExecuteOptions{draft}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[12pt]{report}
\RequirePackage[reqno]{amsmath}[1996/10/24]
\RequirePackage{amsfonts}[1996/10/24]
\RequirePackage{amsthm}[1996/10/24]
\RequirePackage{ua-title}
\def\contentsname{Table of Contents}
\def\bibname{References}
\def\dedicationname{Dedication}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\topmargin      0in
\headheight     \baselineskip
\headsep        0.6in
\addtolength{\headsep}{-\headheight}
\footskip       0in
\textheight     \paperheight
\addtolength{\textheight}{-2.7in}
\oddsidemargin  0.5in
\evensidemargin 0.5in
\marginparwidth 0in
\marginparsep   0in
\textwidth      \paperwidth
\addtolength{\textwidth}{-2.5in}
\def\singlespaced{\baselineskip=\normalbaselineskip}
\def\doublespaced{\iffinal@ \baselineskip=1.5\normalbaselineskip \fi}
\newlength{\@topskipsave}
\@topskipsave\topskip
\def\ps@topright{%
    \let\@mkboth\@gobbletwo
    \topskip\@topskipsave
    \def\@oddhead{\normalfont\hfil\thepage}
    \let\@evenhead\@oddhead
    \def\@evenfoot{}
    \def\@oddfoot{}}
\def\ps@continued{%
    \let\@mkboth\@gobbletwo
    \topskip 0.5in
    \def\@oddhead{\raisebox{-0.5in}{\@continued}%
                  \hfil\normalfont\thepage}
    \let\@evenhead\@oddhead
    \def\@evenfoot{}
    \def\@oddfoot{}}
\def\@notopskip{\topskip\z@ \hrule height\z@}
\def\maketitle{%
  \cleardoublepage
  \begingroup
    \@SetTitlePage
    \iffinal@
      \@SetApprovalForm
      \@SetAuthorStatement
    \fi
  \endgroup
  \let\maketitle\relax}
\def\@SetApprovalForm{%
  \pagestyle{topright}
  \@notopskip
  \vspace*{\fill}
  \begin{center}
    \Large
    Get the official approval page \\
    from the Graduate College \\
    \textsl{before} your final defense.
  \end{center}
  \vspace*{\fill}
  \vspace*{0.5in}
  \newpage}
\def\@SetAuthorStatement{%
   \begingroup
     \pagestyle{topright}
     \@notopskip
     \vspace*{1in}
     \begingroup
       \centering\large\scshape
       Statement by Author \\
     \endgroup
     \bigskip\bigskip
     \par
     This \MakeLowercase{\@thesis} has been submitted in partial
     fulfillment of requirements for an advanced degree at The
     University of Arizona and is deposited in the University
     Library to be made available to borrowers under rules
     of the Library.
     \bigskip
     \par
     Brief quotations from this \MakeLowercase{\@thesis} are
     allowable without special permission, provided that accurate
     acknowledgment of source is made. Requests for permission for
     extended quotation from or reproduction of this manuscript in
     whole or in part may be granted by the
     \ifx\@empty\@copyright
       head of the major department or the Dean of the Graduate
       College when in his or her judgment the proposed use of
       the material is in the interests of scholarship.
       In all other instances, however,
       permission must be obtained from the author.
     \else
       copyright holder.
     \fi
     \par
     \vspace*{3\baselineskip}
     \begin{flushright}
       \scshape
       Signed: \underline{\makebox[2.5in][r]{}}
     \end{flushright}
     \vspace*{\fill}
     \ifx\@empty\@directortitle
     \else
       \begingroup
          \centering
          \large\scshape
          Approval by \@thesis\ Director
       \endgroup
       \bigskip\bigskip\par
       This \MakeLowercase{\@thesis} has been approved
       on the date shown below:
       \vspace*{3\baselineskip}\par\noindent
       \begin{minipage}[t]{0.45\textwidth}
         \begin{center}
           \underline{\makebox[\textwidth][r]{}} \\
           \@director \\
           \@directortitle
         \end{center}
       \end{minipage}%
       \hfill%
       \begin{minipage}[t]{0.45\textwidth}
         \begin{center}
           \underline{\makebox[\textwidth][r]{}} \\
           Date
         \end{center}
       \end{minipage}
     \fi
     \vspace*{0.5in}
     \newpage
   \endgroup}
\long\def\Addto@envbody#1{\@envbody\@xp{\the\@envbody#1}}
\def\Collect@body#1{%
    \@envbody{}%
    \def\process@envbody{%
        \@xp#1\@xp{\the\@envbody}%
    }%
    \@xp\let\csname\@currenvir\endcsname\Collect@@body
    \csname\@currenvir\endcsname
}
\long\def\Collect@@body#1\end#2{%
    \def\@tempa{#2}%
    \ifx\@tempa\@currenvir
        \Addto@envbody{#1}%
        \@xp\edef\csname\@currenvir\endcsname{%
            \@nx\process@envbody\@nx\end{\@tempa}%
            }%
    \else
        \Addto@envbody{#1\end{#2}}%
    \fi
    \csname\@currenvir\endcsname
}
\renewenvironment{abstract}{%
  \Collect@body\@SetAbstract}{}
\long\def\@SetAbstract#1{%
  \chapter*{Abstract}
  #1
  \clearpage
  \iffinal@
  \begingroup
    \clearpage
    \newcounter{s@avepageno}
    \setcounter{s@avepageno}{\value{page}}
    \setcounter{page}{1}
    \thispagestyle{empty}
    \@notopskip
    \begingroup
      \centering
      \large\textsc
      \@title \\
      \bigskip
      \normalfont\normalsize
      \@author, \@degreeabbrev \\
      The University of Arizona, \@date \\
    \endgroup
    \bigskip
    \noindent Director: \@director \par
    \bigskip\bigskip
    #1
  \endgroup
  \clearpage
  \setcounter{page}{\value{s@avepageno}}
  \fi}
\def\chapter{%
  \clearpage
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@chapterstar}
\def\@chapter[#1]#2{%
  \pagestyle{topright}
  \refstepcounter{chapter}%
  \typeout{\@chapapp \space \thechapter}
  \addcontentsline{toc}{chapter}%
    {\protect\chapterline{\@chapapp\ \thechapter}#1}
  \addtocontents{lof}{\protect\addvspace{\medskipamount}}
  \addtocontents{lot}{\protect\addvspace{\medskipamount}}
  \begingroup
    \@notopskip
    \centering
    \vspace*{0.25in}
    \textbf{\@chapapp\ \thechapter} \\
    \medskip
    \Large\textsc{#2} \par
  \endgroup
  \vspace*{2\normalbaselineskip}
  \@afterheading
  \doublespaced}
\def\@chapterstar#1{%
  \typeout{#1}
  \edef\1{#1}
  \ifx \dedicationname\1
       \doublespaced
  \else
  \ifx \contentsname\1
       \@specialhead\1
       \singlespaced
       \let\tableofcontents\relax
  \else
  \ifx \listfigurename\1
       \@specialhead\1
       \@tocentry\1
       \singlespaced
  \else
  \ifx \listtablename\1
       \@specialhead\1
       \@tocentry\1
       \singlespaced
  \else
  \pagestyle{topright}
  \ifx \tableofcontents\relax
       \@tocentry\1
       \ifx \bibname\1 \singlespaced \else \doublespaced \fi
  \fi\fi\fi\fi\fi
  \begingroup
    \@notopskip
    \centering
    \Large\textsc{#1} \par
  \endgroup
  \vspace*{2\normalbaselineskip}
  \@afterheading}
\def\@tocentry#1{%
  \addcontentsline{toc}{chapter}{#1}
  \addtocontents{lof}{\protect\addvspace{\medskipamount}}
  \addtocontents{lof}{\protect\addvspace{\medskipamount}}}
\def\@specialhead#1{%
  \gdef\@continued{\normalsize\scshape#1---\slshape Continued}
  \pagestyle{continued}
  \thispagestyle{topright}}
\def\section{\@startsection{section}{1}%
  \z@{-1\baselineskip\@plus-.75\baselineskip}{.5\baselineskip}%
  {\large\bfseries}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{-.75\baselineskip\@plus-.5\baselineskip}{.5\baselineskip}%
  {\normalfont\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}%
   \z@{.5\baselineskip\@plus.5\baselineskip}{-5\p@}%
   {\normalfont\itshape}}
\def\th@plain{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \itshape
}
\def\th@remark{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}
\def\th@definition{%
  \let\thm@indent\noindent
  \thm@headfont{\bfseries}% heading font bold
  \thm@notefont{\mdseries\upshape}%
  \thm@preskip.5\baselineskip\@plus.2\baselineskip
                                    \@minus.2\baselineskip
  \thm@postskip\thm@preskip
  \upshape
}
\renewenvironment{proof}[1][\proofname]{\par \normalfont
  \topsep6\p@\@plus6\p@ \trivlist \itemindent\z@
  \item[\hskip\labelsep\bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \qed\endtrivlist
}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\textsc{#1}. #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textsc{#1}. #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\newlength{\@auxlength}
\AtBeginDocument{%
  \settowidth{\@auxlength}{\textbf{999}}
  \renewcommand{\@pnumwidth}{\@auxlength}}
\def\numberline#1{\hb@xt@\@tempdima{#1.\hfil}}
\def\chapterline#1{%
  \advance\hangindent\@tempdima
  \hbox{#1.\space\space\hfil}}
\renewcommand*\l@chapter[2]{%
  \addpenalty{-\@highpenalty}%
  \vskip 1.0em \@plus\p@
  \begingroup
    \advance\hangindent 1.5em
    \@dottedtocline{0}{0pt}{0pt}{\scshape #1}{\bfseries #2}
  \endgroup
  \penalty\@highpenalty}
\renewcommand*\l@figure[2]{%
  \@dottedtocline{1}{0pt}{30pt}{\textsc{Figure} #1}{#2}}
\renewcommand*\l@table[2]{%
  \@dottedtocline{1}{0pt}{30pt}{\textsc{Table} #1}{#2}}
\endinput
%%
%% End of file `ua-thesis.cls'.
