%%
%% This is file `uantwerpenletter.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uantwerpendocs.dtx  (with options: `le')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2013-2016  by Walter Daems <walter.daems@uantwerpen.be>
%% 
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Walter Daems.
%% 
\ProvidesClass{uantwerpenletter}
\def\fileversion{1.7}
\def\filedate{2016/05/01}

\newif\if@filled
\DeclareOption{filled}{\@filledtrue}
\ExecuteOptions{a4paper,10pt,final,oneside,openright}
\ProcessOptions
\LoadClassWithOptions{letter}
\newcommand\tat{\makeatletter @\makeatother}
\newcommand\tbs{\textbackslash}
\setlength{\parindent}{0pt}
\addtolength{\parskip}{0.75\baselineskip}
\setcounter{secnumdepth}{3}
\RequirePackage[top=1in, bottom=1in, left=1.34in, right=1in]{geometry}
\RequirePackage[normalem]{ulem}
\RequirePackage{atbegshi}
\RequirePackage{ifthen}
\newcommand{\@emptymacro}{}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\definecolor{uacorpbord}{cmyk}     {0.00,1.00,0.60,0.37}
\definecolor{uacorpblue}{cmyk}     {1.00,0.25,0.00,0.50}
\definecolor{uacorplightblue}{cmyk}{1.00,0.00,0.08,0.13}
\definecolor{uacorporange}{cmyk}   {0.00,0.32,1.00,0.09}
\definecolor{uaftifresh}{cmyk}     {0.34,1.00,0.00,0.00}
\definecolor{uaftisober}{cmyk}     {0.10,1.00,0.00,0.49}
\definecolor{lightgray}{cmyk}      {0.00,0.00,0.00,0.05}
\newcommand{\uaname}{University of Antwerp}
\newcommand{\logoname}{UA_HOR_ENG_CMYK}
\newcommand{\footername}{4E_PMS302_BR_ENG_RGB}
\newcommand{\orname}{of}
\newcommand{\domainname}{uantwerp.be}
\newcommand{\datename}{Date}
\newcommand{\subjectname}{Subject}
\newcommand{\academicyearname}{Academic year}
\newcommand{\masterthesisname}{Master's thesis}
\newcommand{\promotorsname}{Promoters}
\newcommand{\thesisname}{Thesis to obtain the degree of}
\AtBeginDocument{
  \@ifpackageloaded{babel}{
    \addto\captionsdutch{%
      \renewcommand{\uaname}{Universiteit Antwerpen}
      \renewcommand{\logoname}{UA_HOR_NED_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_NED_RGB}
      \renewcommand{\orname}{van}
      \renewcommand{\domainname}{uantwerpen.be}
      \renewcommand{\subjectname}{Onderwerp}%
      \renewcommand{\datename}{Datum}%
      \renewcommand{\academicyearname}{Academiejaar}
      \renewcommand{\masterthesisname}{Masterproef}
      \renewcommand{\promotorsname}{Promotoren}
      \renewcommand{\thesisname}{Proefschrift tot het behalen van de
        graad van}
    }
    \addto\captionsgerman{%
      \renewcommand{\uaname}{Universit\"at Antwerpen}
      \renewcommand{\logoname}{UA_HOR_DUI_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_NED_RGB}
      \renewcommand{\orname}{von}
      \renewcommand{\domainname}{uantwerpen.be}
      \renewcommand{\subjectname}{Betreff}%
      \renewcommand{\datename}{Datum}%
      \renewcommand{\academicyearname}{Akademisches Jahr}
      \renewcommand{\masterthesisname}{Masterdissertation}
      \renewcommand{\promotorsname}{Veranstalter}
      \renewcommand{\thesisname}{Dissertation zur Erreichung des
        Grades der}
    }
    \addto\captionsfrench{%
      \renewcommand{\uaname}{Universit\'e d'Anvers}
      \renewcommand{\logoname}{UA_HOR_FRA_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_ENG_RGB}
      \renewcommand{\orname}{de}
      \renewcommand{\domainname}{uanvers.be}
      \renewcommand{\subjectname}{Objet}%
      \renewcommand{\datename}{Date}%
      \renewcommand{\academicyearname}{Ann\'ee acad\'emique}
      \renewcommand{\masterthesisname}{Th\`ese de master}
      \renewcommand{\promotorsname}{Promoteurs}
      \renewcommand{\thesisname}{Th\`ese \`a l'atteinte du degr\'e de}
    }
    \addto\captionsspanish{%
      \renewcommand{\uaname}{Universidad de Amberes}
      \renewcommand{\logoname}{UA_HOR_SPA_CMYK}
      \renewcommand{\footername}{4E_PMS302_BR_ENG_RGB}
      \renewcommand{\orname}{de}
      \renewcommand{\domainname}{uantwerp.be}
      \renewcommand{\subjectname}{Asunto}%
      \renewcommand{\datename}{Fecha}%
      \renewcommand{\academicyearname}{A\~no acad\'emico}
      \renewcommand{\masterthesisname}{Tesis de maestr\'\i{}a}
      \renewcommand{\promotorsname}{Promotores}
      \renewcommand{\thesisname}{Disertaci\'on a la consecuci\'on del
        grado de}
    }
  }
  {}
}
\newcommand{\@facultyacronym}{}
\newcommand{\@faculty}{< Specify faculty using \tbs{}facultyacronym\{ABC\} >}
\newcommand{\facultyacronym}[1]{
  \renewcommand{\@facultyacronym}{#1}
  \ifthenelse{\equal{#1}{CPG}}{\renewcommand\@faculty{Centrum
      Pieter Gillis}}{
  \ifthenelse{\equal{#1}{FBD}}{\renewcommand\@faculty{Faculteit
      Farmaceutische, Biomedische en Diergeneeskundige Wetenschappen}}{
  \ifthenelse{\equal{#1}{GGW}}{\renewcommand\@faculty{Faculteit
      Geneeskunde en Gezondheidswetenschappen}}{
  \ifthenelse{\equal{#1}{IOB}}{\renewcommand\@faculty{Instituut
      voor Ontwikkelingsbeleid- en beheer}}{
  \ifthenelse{\equal{#1}{IOIW}}{\renewcommand\@faculty{Instituut
      voor Onderwijs- en Informatiewetenschappen}}{
  \ifthenelse{\equal{#1}{LW}}{\renewcommand\@faculty{Faculteit
      Letteren en Wijsbegeerte}}{
  \ifthenelse{\equal{#1}{OW}}{\renewcommand\@faculty{Faculteit
      Ontwerpwetenschappen}}{
  \ifthenelse{\equal{#1}{SW}}{\renewcommand\@faculty{Faculteit
      Sociale Wetenschappen}}{
  \ifthenelse{\equal{#1}{REC}}{\renewcommand\@faculty{Faculteit
      Rechten}}{
  \ifthenelse{\equal{#1}{TEW}}{\renewcommand\@faculty{Faculteit
      Toegepaste Economische Wetenschappen}}{
  \ifthenelse{\equal{#1}{TI}}{\renewcommand\@faculty{Faculteit
      Toegepaste Ingenieurswetenschappen}}{
  \ifthenelse{\equal{#1}{WET}}{\renewcommand\@faculty{Faculteit
      Wetenschappen}}{
    \errmessage{Error: wrong faculty acronym; choose one of FBD, GGW,
      LW, OW, PSW, REC, TEW, TI, WET}}}}}}}}}}}}}}
\newcommand{\@sender}{< Specify sender using
  \tbs{}sender\{name\}\{role\} >}
\newcommand{\@senderrole}{~}
\newcommand{\sender}[2]{\renewcommand{\@sender}{#1}\renewcommand{\@senderrole}{#2}}
\newcommand{\@logo}{\logoname}
\newcommand{\logo}[1]{\renewcommand{\@unit}{#1}}
\newcommand{\@unit}{}
\newcommand{\unit}[1]{\renewcommand{\@unit}{#1}}
\newcommand{\@emailuser}{}
\newcommand{\@emaildomain}{}
\newcommand{\email}[2]{\renewcommand{\@emailuser}{#1}\renewcommand{\@emaildomain}{#2}}
\newcommand{\@phone}{}
\newcommand{\phone}[1]{\renewcommand{\@phone}{#1}}
\newcommand{\@fax}{}
\newcommand{\fax}[1]{\renewcommand{\@fax}{#1}}
\newcommand{\@mobile}{}
\newcommand{\mobile}[1]{\renewcommand{\@mobile}{#1}}
\newcommand{\@returnaddress}{<specify return-address using \tbs\{single-line-return-address\}>}
\renewcommand{\returnaddress}[1]{\renewcommand{\@returnaddress}{#1}}
\newcommand{\@to}{<Specify addressee using \tbs to\{name\}>}
\renewcommand{\to}[1]{\renewcommand{\@to}{#1}}
\newcommand{\@toorganization}{<Specify organization using
  \tbs toorganization\{\}>}
\newcommand{\toorganization}[1]{\renewcommand{\@toorganization}{#1}}
\newcommand{\@toaddress}{<Specify (multiline) destination address\\using \tbs toaddress\{\}>}
\newcommand{\toaddress}[1]{\renewcommand{\@toaddress}{#1}}
\newcommand{\@subject}{-}
\newcommand*{\subject}[1]{\renewcommand{\@subject}{#1}}
\renewcommand*{\opening}[1]{#1}
\newcommand{\@closing}{<specify a closing formula using \tbs closing\{\}>}
\renewcommand*{\closing}[1]{\renewcommand{\@closing}{#1}}
\newcommand{\@carboncopy}{}
\newcommand{\carboncopy}[1]{\renewcommand{\@carboncopy}{#1}}
\newcommand{\@enclosed}{}
\newcommand{\enclosed}[1]{\renewcommand{\@enclosed}{#1}}
\newcommand{\@address}{< Put your multi-line address here\\using
  \tbs address\{\} >}
\renewcommand{\address}[1]{\renewcommand{\@address}{#1}}
\lhead[]{}
\chead[]{}
\rhead[]{}
\lfoot[\small\textcolor{gray}{\@date}]{\textcolor{gray}{\@date}}
\cfoot[]{}
\rfoot[\small\textcolor{gray}{\pagename~\thepage~\orname~\pageref{lastpage}}]{\small\textcolor{gray}{\pagename~\thepage~\orname~\pageref{lastpage}}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\if@filled\else
  \raggedright
\fi
\raggedbottom
\onecolumn
\newcommand\maketitle{%
  \pagestyle{fancy}
  \thispagestyle{empty}
  \begin{tikzpicture}[overlay,remember picture]
    \path (current page.north west) +(1.8cm,-1.2cm)
    node[anchor=north west] {
      \includegraphics[height=1.1cm]{\@logo}
    };
    \draw (current page.north west)
    +(1cm,-98mm) -- +(1.5cm,-98mm);
    % 90 x 45
    % pos: 20mm van kant, 15mm van onderkant
    \path (current page.north east) +(-100mm,-65mm)
    node[anchor=west,text width=80mm,align=left] {
      \scriptsize\textcolor{gray}{\uline{\@returnaddress}}\\*
      \normalsize\@to\\*
      \@toorganization\\*
      \@toaddress
    };
  \end{tikzpicture}
  \begin{tikzpicture}[overlay,remember picture]
    \path (current page.south west) +(0,-0.7cm)
    node[anchor=south west,inner sep=0pt, outer sep=0pt]
    {\includegraphics{\footername}};
  \end{tikzpicture}
  ~\\[3ex]
  \textcolor{uacorpblue}{\bf \@sender}\\*
  \@senderrole\\[1.75ex]
  \@faculty
  \ifx\@unit\@emptymacro\else\\* \@unit\fi~\\[1.75ex]
  \@address\\[1.75ex]
  \ifx\@email\@emptymacro\else E \@emailuser\tat{}\@emaildomain\\\fi
  \ifx\@phone\@emptymacro\else T \@phone\\\fi
  \ifx\@fax\@emptymacro\else F \@fax\\\fi
  \ifx\@mobile\@emptymacro\else M \@mobile\\\fi
  ~\\[4ex]
  \begin{tikzpicture}[anchor=north west,align=left,outer sep=0,inner sep=0]
    \path
    (0,0) node { \scriptsize \strut
      \textcolor{gray}{\uppercase\expandafter{\datename} } }
    (4cm,0) node { \scriptsize \strut
      \textcolor{gray}{\uppercase\expandafter{\subjectname} } }
    (0,-2.5ex) node { \strut \@date }
    (4cm,-2.5ex) node[align=left] { \strut \@subject };
  \end{tikzpicture}~\\[4ex]
}
\AtEndDocument{
  \@closing\\*[12ex]
  \@sender\\*
  \@senderrole
  \setlength{\parskip}{0em}
  \ifx\@carboncopy\@emptymacro\else ~\\[4ex] CC: \@carboncopy\fi
  \ifx\@enclosed\@emptymacro\else ~\\[4ex] ENCL: \@enclosed\fi
  \label{lastpage}
}
\endinput
%%
%% End of file `uantwerpenletter.cls'.
