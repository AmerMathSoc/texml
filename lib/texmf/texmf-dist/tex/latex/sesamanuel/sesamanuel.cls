%%
%% This is file `sesamanuel.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sesamanuel.dtx  (with options: `class')
%% 
%% sesamanuel.dtx
%% Copyright 2014-2015 Sesamath, J.-C. Charpentier, S. Mengin
%% Class `sesamanuel' to use with LaTeX 2e
%% Copyright (C) 2014-2015 Sesamath, Jean-C\^ome Charpentier, S\'ebastien
%% Mengin.
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
%%
\def\filedate{2015/03/03}
\let\smcfiledate\filedate
\def\fileversion{0.6}
\let\smcfileversion\fileversion
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{sesamanuel}[%
  \filedate\space v\fileversion\space
  Classe pour les cahiers Sesamath (SM/JCC/SM)%
]
\LoadClass{book}
\def\smc@enc@opt#1{\DeclareOption{#1}{\def\smc@encoding{#1}}}
\smc@enc@opt{ascii}
\smc@enc@opt{latin1}
\smc@enc@opt{latin2}
\smc@enc@opt{latin3}
\smc@enc@opt{latin4}
\smc@enc@opt{latin5}
\smc@enc@opt{latin9}
\smc@enc@opt{latin10}
\smc@enc@opt{decmulti}
\smc@enc@opt{cp850}
\smc@enc@opt{cp852}
\smc@enc@opt{cp858}
\smc@enc@opt{cp437}
\smc@enc@opt{cp437de}
\smc@enc@opt{cp865}
\smc@enc@opt{applemac}
\smc@enc@opt{macce}
\smc@enc@opt{next}
\smc@enc@opt{cp1250}
\smc@enc@opt{cp1252}
\smc@enc@opt{cp1257}
\smc@enc@opt{ansinew}
\smc@enc@opt{utf8}
\newif\ifsmc@crop
\smc@croptrue
\DeclareOption{crop}{\smc@croptrue}
\DeclareOption{nocrop}{\smc@cropfalse}
\newif\ifsmc@page
\smc@pagetrue
\DeclareOption{page}{\smc@pagetrue}
\DeclareOption{nopage}{\smc@pagefalse}
\newcommand*\smc@string@utfviii{utf8}
\ExecuteOptions{utf8}
\ProcessOptions
\newif\ifxetex
\begingroup\expandafter\expandafter\expandafter\endgroup
\expandafter\ifx\csname XeTeXrevision\endcsname\relax
  \xetexfalse
\else
  \xetextrue
\fi
\newif\ifpdftex
\newif\ifpdfdvi
\newif\ifluatex
\ifx\luatexversion\undefined
  \luatexfalse
  \ifx\pdfoutput\undefined
    \pdftexfalse
    \pdfdvifalse
  \else
    \pdftextrue
    \ifnum\pdfoutput=\z@
      \pdfdvitrue
    \else
      \pdfdvifalse
    \fi
  \fi
\else
  \luatextrue
\fi
\ifpdftex
  \unless\ifpdfdvi
    \ClassError{sesamanuel}{Vous ne pouvez pas compiler en mode pdflatex}
                        {Compilez en mode latex.}%
  \fi
\fi
\ifluatex
  \ClassError{sesamanuel}{Vous ne pouvez pas compiler en mode lualatex}
                      {Compilez en mode latex.}%
\fi
\RequirePackage{etex}
\ifxetex
  \RequirePackage{fontspec}
  \RequirePackage{xunicode}
  \defaultfontfeatures{Ligatures=TeX}
  \unless\ifx\smc@encoding\smc@string@utfviii
    \ClassError{sesamanuel}{Vous ne pouvez pas utiliser un codage autre
      que utf8 avec xelatex}{Changez les codages de tous vos fichiers
      pour les transformer en utf8.}%
  \fi
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[\smc@encoding]{inputenc}
\fi
\RequirePackage[scaled=0.87]{helvet}
\RequirePackage{mathpazo}
\renewcommand{\ttdefault}{lmtt}
\RequirePackage{mathrsfs}
\RequirePackage{pifont}
\RequirePackage[official]{eurosym}
%%%\newcommand*\scriptfamily{\fontfamily{fco}\selectfont}
\newcommand*\scriptfamily{\fontfamily{llcmss}\selectfont}
\newcommand*\smc@paperheight{27cm}
\newcommand*\smc@paperwidth{19.5cm}
\newcommand*\smc@marginleft{1.33cm}
\newcommand*\smc@marginright{1.33cm}
\newcommand*\ExtraMarginRight{1.8cm}
\newcommand*\smc@margintop{2.5cm}
\newcommand*\smc@headheight{14.4pt}
\newcommand*\smc@headsep{1.4cm}
\newcommand*\smc@marginbottom{2cm}
\newcommand*\smc@footskip{1.2cm}
\ifsmc@crop
  \newcommand*\smc@bleed{5mm}
  \RequirePackage[driver=none,
                  paperheight=\smc@paperheight,
                  paperwidth=\smc@paperwidth,
                  top=\smc@margintop,
                  headheight=\smc@headheight,
                  headsep=\smc@headsep,
                  bottom=\smc@marginbottom,
                  footskip=\smc@footskip,
                  left=\smc@marginleft,
                  right=\smc@marginright,
                  nomarginpar]{geometry}
  \RequirePackage[cam,a4,center]{crop}
\else
  \newcommand*\smc@bleed{0mm}
  \RequirePackage[driver=none,
                  paperheight=\smc@paperheight,
                  paperwidth=\smc@paperwidth,
                  top=\smc@margintop,
                  headheight=\smc@headheight,
                  headsep=\smc@headsep,
                  bottom=\smc@marginbottom,
                  footskip=\smc@footskip,
                  left=\smc@marginleft,
                  right=\smc@marginright,
                  nomarginpar]{geometry}
  \RequirePackage[off,a4,center]{crop}
\fi
\RequirePackage{ifmtarg}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{longtable, tabularx}
\RequirePackage{multirow}
\RequirePackage[table]{xcolor}
\RequirePackage{pst-all, pstricks-add}
\RequirePackage{fancyhdr}
\RequirePackage{fancyvrb}
\RequirePackage{multicol}
\RequirePackage[french]{babel}
\RequirePackage[autolanguage]{numprint}
\newbox\smc@boxa
\newbox\smc@boxb
\newdimen\smc@dima
\newdimen\smc@dimb
\setlength{\parindent}{0pt}
\newcommand*\cleardoubleoddpage{%
  \clearpage
  \pagestyle{empty}
  \cleardoublepage
}
\newcommand*\clearevendoublepage{%
  \clearpage
  \ifodd\c@page
    \hbox{}\newpage
  \fi
}
\newcommand*\cleardoubleevenpage{%
  \clearpage
  \pagestyle{empty}
  \clearevendoublepage
}
\renewcommand\normalsize{%
   \@setfontsize\normalsize{9.5}\@xivpt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small{8.5}{12}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize{7.5}{11}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\scriptsize{\@setfontsize\scriptsize{6.5}{9.5}}
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@viipt}
\renewcommand\large{\@setfontsize\large\@xiipt\@xviipt}
\renewcommand\Large{\@setfontsize\Large\@xivpt{22}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{25}}
\renewcommand\huge{\@setfontsize\huge\@xxpt{30}}
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{36}}
\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\newenvironment{smc@noitemize}{%
  \ClassError{sesamanuel}{Il est interdit d'utiliser itemize ici}
             {Consultez la documentation pour plus de renseignements.}%
  \let\item\relax
}{}
\let\itemize\smc@noitemize
\let\enditemize\endsmc@noitemize
\newcommand*\DeclareCorrItemize[2]{%
  \newenvironment{smc@corr#1itemize}{%
    \def\item{\par#2~}%
    \ignorespaces
  }
  {\par}
}
\def\smc@setalllist{%
  \setlength{\leftmargin}{\ListLabelWidth}%
  \setlength{\rightmargin}{0mm}%
  \setlength{\labelwidth}{\ListLabelWidth}%
  \setlength{\labelsep}{0mm}%
  \setlength{\itemindent}{0mm}%
  \setlength{\listparindent}{0mm}%
  \setlength{\topsep}{0mm}%
  \setlength{\partopsep}{\baselineskip}%
  \setlength{\itemsep}{0mm}%
  \setlength{\parsep}{0mm}%
  \def\makelabel##1{##1\hss}%
}
\let\smc@setallfirstlist\smc@setalllist
\def\smc@setallbiglist{%
  \setlength{\leftmargin}{\EnumerateLabelWidth}%
  \setlength{\rightmargin}{0mm}%
  \setlength{\labelwidth}{\EnumerateLabelWidth}%
  \setlength{\labelsep}{0mm}%
  \setlength{\itemindent}{0mm}%
  \setlength{\listparindent}{0mm}%
  \setlength{\topsep}{0mm}%
  \setlength{\partopsep}{\baselineskip}%
  \setlength{\itemsep}{0mm}%
  \setlength{\parsep}{0mm}%
  \def\makelabel##1{##1\hss}%
}
\newenvironment{smc@prerequisitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{PrerequisItemColor}{$\blacktriangleright$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{PrerequisItemColor}{$\blacktriangleright$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{prerequis}
                   {\textcolor{PrerequisItemColor}{$\blacktriangleright$}}
\newenvironment{smc@AEitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{AEItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{AEItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{AE}{\textcolor{AEItemColor}{$\bullet$}}
\newenvironment{smc@exappitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{ExAppItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{ExAppItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{exapp}{\textcolor{ExAppItemColor}{$\bullet$}}
\newenvironment{smc@defitemize}{%
  \ifnum\@listdepth=\z@
    \list{%
      \color{DefItemColor}%
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
      \relax}
         {\smc@setalllist}%
  \else
    \list{%
      \color{DefItemColor}%
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
      \relax}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{def}{%
  \textcolor{DefItemColor}{%
    \vrule width \ItemRuleWidth
           height \ItemRuleHeight
           depth \ItemRuleDepth
  }%
}
\newenvironment{smc@activiteitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{ActiviteItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{ActiviteItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{activite}{\textcolor{ActiviteItemColor}{$\bullet$}}
\newenvironment{smc@remitemize}{%
  \ifnum\@listdepth=\z@
    \list{%
      \color{RemItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \else
    \list{%
      \color{RemItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{rem}{%
  \textcolor{RemItemColor}{%
    \vrule width \ItemRuleWidth
           height \ItemRuleHeight
           depth \ItemRuleDepth
  }%
}
\newenvironment{smc@exempleitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{ExempleItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{ExempleItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{exemple}{\textcolor{ExempleItemColor}{$\bullet$}}
\newenvironment{smc@proofitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{ProofItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{ProofItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{proof}{\textcolor{ProofItemColor}{$\bullet$}}
\newenvironment{smc@exerciceitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{ExerciceItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{ExerciceItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{exercice}{\textcolor{ExerciceItemColor}{$\bullet$}}
\newenvironment{smc@acquisitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{AcquisItemColor}{\footnotesize$\blacktriangleright$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{AcquisItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{acquis}{\textcolor{AcquisItemColor}{$\bullet$}}
\newenvironment{smc@commentaireitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{CommentaireItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{CommentaireItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{commentaire}{\textcolor{CommentaireItemColor}{$\bullet$}}
\newenvironment{smc@recreationitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{RecreationItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{RecreationItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{recreation}{\textcolor{RecreationItemColor}{$\bullet$}}
\newenvironment{smc@annexeitemize}{%
  \ifnum\@listdepth=\z@
    \list{%
      \color{AnnexeItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \else
    \list{%
      \color{AnnexeItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\newenvironment{smc@lexiqueitemize}{%
  \ifnum\@listdepth=\z@
    \list{\textcolor{LexiqueItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \else
    \list{\textcolor{LexiqueItemColor}{$\bullet$}}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\newenvironment{smc@libreitemize}{%
  \ifnum\@listdepth=\z@
    \list{%
      \color{LibreItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \else
    \list{%
      \color{LibreItemColor}
      \vrule width \ItemRuleWidth
             height \ItemRuleHeight
             depth \ItemRuleDepth
             \relax}
         {\smc@setalllist}%
  \fi
}
{\endlist}
\DeclareCorrItemize{libre}{\textcolor{LibreItemColor}{$\bullet$}}
\newenvironment{smc@noenumerate}{%
  \ClassError{sesamanuel}{Il est interdit d'utiliser enumerate ici}
             {Consultez la documentation pour plus de renseignements.}%
  \let\item\relax
}{}
\let\enumerate\smc@noenumerate
\let\endenumerate\endsmc@noenumerate
\newenvironment{bigenumerate}
  {%
    \let\smc@setallfirstlist\smc@setallbiglist
    \begin{enumerate}
  }
  {\end{enumerate}}
\newcommand\DeclareEnumerate[3]{%
  \newenvironment{smc@#1enumerate}{%
    \gdef\smc@curr@itemcmd{#2}%
    \gdef\smc@curr@itemcolor{#3}%(
    \renewcommand\labelenumi{\textcolor{#3}{#2\theenumi)}}%(
    \renewcommand\labelenumii{\textcolor{#3}{#2\theenumii)}}%(
    \renewcommand\labelenumiii{\textcolor{#3}{#2\theenumiii)}}%
    \advance\@enumdepth \@ne
    \ifnum\@enumdepth>\thr@@
      \ClassError{sesamanuel}{Pas plus de 3 niveaux de liste}
                 {Consultez la documentation pour plus de renseignements.}
    \else\ifnum\@enumdepth=\@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {%
          \usecounter{\@enumctr}%
          \smc@setallfirstlist
        }%
    \else
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {%
          \usecounter{\@enumctr}%
          \smc@setalllist
        }%
    \fi\fi
  }
  {\endlist}
  \newenvironment{smc@corr#1enumerate}{%
    \gdef\smc@curr@itemcmd{#2}%
    \gdef\smc@curr@itemcolor{#3}%(
    \setcounter{enumi}{0}%
    \setcounter{enumii}{0}%
    \setcounter{enumiii}{0}%
    \renewcommand\labelenumi{\textcolor{#3}{#2\theenumi)}}%(
    \renewcommand\labelenumii{\textcolor{#3}{#2\theenumii)}}%(
    \renewcommand\labelenumiii{\textcolor{#3}{#2\theenumiii)}}%
    \advance\@enumdepth \@ne
    \ifnum\@enumdepth>\thr@@
      \ClassError{sesamanuel}{Pas plus de 3 niveaux de liste}
                 {Consultez la documentation pour plus de renseignements.}
    \else
      \def\smc@enum{%
        \refstepcounter{enum\romannumeral\@enumdepth}%
        \csname labelenum\romannumeral\@enumdepth\endcsname~
      }%
      \def\item{%
        \smc@enum
        \def\item{\par\smc@enum}%
      }%
    \fi
    \ignorespaces
  }
  {\par}
}
\DeclareEnumerate{prerequis}{}{PrerequisItemColor}
\DeclareEnumerate{exapp}{\bfseries}{ExAppItemColor}
\DeclareEnumerate{def}{\bfseries}{DefItemColor}
\DeclareEnumerate{AE}{\bfseries}{AEItemColor}
\DeclareEnumerate{activite}{\bfseries}{ActiviteItemColor}
\DeclareEnumerate{rem}{}{RemItemColor}
\DeclareEnumerate{exemple}{}{ExempleItemColor}
\DeclareEnumerate{proof}{}{ProofItemColor}
\DeclareEnumerate{exercice}{\bfseries}{ExerciceItemColor}
\DeclareEnumerate{acquis}{\bfseries}{AcquisItemColor}
\DeclareEnumerate{commentaire}{}{CommentaireItemColor}
\DeclareEnumerate{recreation}{\bfseries}{RecreationItemColor}
\DeclareEnumerate{annexe}{}{AnnexeItemColor}
\DeclareEnumerate{lexique}{}{LexiqueItemColor}
\DeclareEnumerate{libre}{}{LibreItemColor}
\newenvironment{smc@nocolitemize}{%
  \ClassError{sesamanuel}{Il est interdit d'utiliser colitemize ici}
             {Consultez la documentation pour plus de renseignements.}%
  \let\item\relax
}{}
\newcount\smc@nbitem
\newcount\smc@nbline
\newcommand*\DeclareColItemize[3]{%
  \newenvironment{#1}[1]{%
    \par
    \def\smc@nbcolumn{##1}%
    \smc@nbitem \z@
    \edef\StringColCurrent{\StringColitemize}%
    \toks@{}%
    \smc@getbody
  }%
  {%
    \expandafter\smc@splititem\the\toks@\item\@nil\item
    \smc@nbline \numexpr \smc@nbitem+\smc@nbcolumn-1
    \divide\smc@nbline \smc@nbcolumn
    \multido{\n=1+1}{\smc@nbline}{%
      \multido{\ni=\n+\the\smc@nbline}{\smc@nbcolumn}{%
        \unless\ifnum\ni>\smc@nbitem
          \makebox[\ListLabelWidth]{\textcolor{#2}{#3}\hss}%
          \begin{minipage}[t]{\dimexpr
              (\linewidth-\ListHSep*(\smc@nbcolumn-1))%
                /\smc@nbcolumn-\ListLabelWidth}
            \strut\@nameuse{smc@item\ni}\strut
          \end{minipage}%
          \hspace{\ListHSep}%
        \fi
      }%
      \ifnum\n=\smc@nbline
        \endgraf
      \else
        \\
      \fi
    }%
  }%
}
\long\def\smc@getbody#1\end{%
  \toks@\expandafter{\the\toks@#1}\smc@testend
}
\long\def\smc@testend#1{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\StringColCurrent
    \end{#1}%
  \else
    \toks@\expandafter{\the\toks@\end{#1}}%
    \expandafter\smc@getbody
  \fi
}
\long\def\smc@splititem#1\item{%
  \smc@@splititem
}
\long\def\smc@@splititem#1\item{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\@nnil
  \else
    \advance\smc@nbitem\@ne
    \@namedef{smc@item\the\smc@nbitem}{#1}%
    \expandafter\smc@@splititem
  \fi
}
\DeclareColItemize{smc@prerequiscolitemize}
                  {PrerequisItemColor}{$\blacktriangleright$}
\DeclareColItemize{smc@AEcolitemize}
                  {AEItemColor}{$\bullet$}
\DeclareColItemize{smc@exappcolitemize}
                  {ExAppItemColor}{$\bullet$}
\DeclareColItemize{smc@defcolitemize}
                  {DefItemColor}
                  {%
                    \vrule width \ItemRuleWidth
                           height \ItemRuleHeight
                           depth \ItemRuleDepth
                    \relax
                  }
\DeclareColItemize{smc@activitecolitemize}
                  {ActiviteItemColor}{$\bullet$}
\DeclareColItemize{smc@remcolitemize}
                  {RemItemColor}
                  {%
                    \vrule width \ItemRuleWidth
                           height \ItemRuleHeight
                           depth \ItemRuleDepth
                    \relax
                  }
\DeclareColItemize{smc@exemplecolitemize}
                  {ExempleItemColor}{$\bullet$}
\DeclareColItemize{smc@proofcolitemize}
                  {ProofItemColor}{$\bullet$}
\DeclareColItemize{smc@exercicecolitemize}
                  {ExerciceItemColor}{$\bullet$}
\DeclareColItemize{smc@acquiscolitemize}
                  {AcquisItemColor}{$\bullet$}
\DeclareColItemize{smc@commentairecolitemize}
                  {CommentaireItemColor}{$\bullet$}
\DeclareColItemize{smc@recreationcolitemize}
                  {RecreationItemColor}{$\bullet$}
\DeclareColItemize{smc@annexecolitemize}
                  {AnnexeItemColor}
                  {%
                    \vrule width \ItemRuleWidth
                           height \ItemRuleHeight
                           depth \ItemRuleDepth
                    \relax
                  }
\DeclareColItemize{smc@lexiquecolitemize}
                  {LexiqueItemColor}{$\bullet$}
\DeclareColItemize{smc@librecolitemize}
                  {LibreItemColor}
                  {%
                    \vrule width \ItemRuleWidth
                           height \ItemRuleHeight
                           depth \ItemRuleDepth
                    \relax
                  }
\newcommand*\DeclareColEnumerate[3]{%
  \newenvironment{#1}[1]{%
    \par\leavevmode
    \advance\@enumdepth \@ne
    \ifnum\@enumdepth>\thr@@
      \ClassError{sesamanuel}{Pas plus de 3 niveaux de liste}
                 {Consultez la documentation pour plus de renseignements.}
    \else
      \ifcase\@enumdepth
      \or %(
        \def\@enumlabel{\textcolor{#3}{#2\ni)}}%(
      \or
        \def\@enumlabel{\textcolor{#3}{#2{\@alph\ni})}}%(
      \or
        \def\@enumlabel{\textcolor{#3}{#2{\@roman\ni)}}}%
      \fi
    \fi
    \def\smc@nbcolumn{##1}%
    \smc@nbitem \z@
    \edef\StringColCurrent{\StringColenumerate}%
    \toks@{}%
    \smc@getbody
  }
  {%
    \expandafter\smc@splititem\the\toks@\item\@nil\item
    \smc@nbline \numexpr \smc@nbitem+\smc@nbcolumn-1
    \divide\smc@nbline \smc@nbcolumn
    \multido{\n=1+1}{\smc@nbline}{%
      \multido{\ni=\n+\the\smc@nbline}{\smc@nbcolumn}{%
        \unless\ifnum\ni>\smc@nbitem
          \makebox[\ListLabelWidth]{\@enumlabel\hss}%
          \begin{minipage}[t]{\dimexpr
              (\linewidth-\ListHSep*(\smc@nbcolumn-1))%
                /\smc@nbcolumn-\ListLabelWidth}
            \strut\@nameuse{smc@item\ni}\strut
          \end{minipage}%
          \hspace{\ListHSep}%
        \fi
      }%
      \ifnum\n=\smc@nbline
        \endgraf
      \else
        \\
      \fi
    }%
  }%
}
\DeclareColEnumerate{smc@prerequiscolenumerate}
                    {}{PrerequisItemColor}
\DeclareColEnumerate{smc@exappcolenumerate}
                    {\bfseries}{ExAppItemColor}
\DeclareColEnumerate{smc@defcolenumerate}
                    {\bfseries}{DefItemColor}
\DeclareColEnumerate{smc@AEcolenumerate}
                    {\bfseries}{AEItemColor}
\DeclareColEnumerate{smc@activitecolenumerate}
                    {}{ActiviteItemColor}
\DeclareColEnumerate{smc@remcolenumerate}
                    {}{RemItemColor}
\DeclareColEnumerate{smc@exemplecolenumerate}
                    {}{ExempleItemColor}
\DeclareColEnumerate{smc@proofcolenumerate}
                    {}{ProofItemColor}
\DeclareColEnumerate{smc@exercicecolenumerate}
                    {\bfseries}{ExerciceItemColor}
\DeclareColEnumerate{smc@acquiscolenumerate}
                    {\bfseries}{AcquisItemColor}
\DeclareColEnumerate{smc@commentairecolenumerate}
                    {\bfseries}{CommentaireItemColor}
\DeclareColEnumerate{smc@recreationcolenumerate}
                    {\bfseries}{RecreationItemColor}
\DeclareColEnumerate{smc@annexecolenumerate}
                    {\bfseries}{AnnexeItemColor}
\DeclareColEnumerate{smc@lexiquecolenumerate}
                    {\bfseries}{RecreationItemColor}
\DeclareColEnumerate{smc@librecolenumerate}
                    {\bfseries}{LibreItemColor}
\newenvironment{changemargin}[2]{%
  \begin{list}{}{%
    \setlength{\topsep}{0pt}%
    \setlength{\leftmargin}{0pt}%
    \setlength{\rightmargin}{0pt}%
    \setlength{\listparindent}{0pt}%
    \setlength{\itemindent}{0pt}%
    \setlength{\parsep}{\parskip}%
    \addtolength{\leftmargin}{#1}%
    \addtolength{\rightmargin}{#2}%
  }%
  \item\relax
}
{\strut \end{list}}
\newcommand*{\cadre}[1][]{%
  \ifx\relax#1\relax
    \colorlet{CurrCadreLineColor}{CadreLineColor}%
  \else
    \colorlet{CurrCadreLineColor}{#1}%
  \fi
  \@cadre
}
\newcommand\@cadre[1][]{%
  \ifx\relax#1\relax
    \colorlet{CurrCadreBkgColor}{CadreBkgColor}%
  \else
    \colorlet{CurrCadreBkgColor}{#1}%
  \fi
  \def\smc@cadre@color{#1}%
  \begin{lrbox}{\smc@boxa}%
    \minipage{\dimexpr \linewidth-\CadreSep*2-\CadreLineWidth*2}%
}
\def\endcadre
{%
    \endminipage
  \end{lrbox}%
  \par\addvspace{\BeforeCadreVSpace}
  \begin{pspicture}(0,\dimexpr\ht\smc@boxa+\CadreSep+\CadreLineWidth)
                   (\linewidth,-\dimexpr\dp\smc@boxa+\CadreSep+\CadreLineWidth)
    \pnode(0,\dimexpr\ht\smc@boxa+\CadreSep+\CadreLineWidth){A}
    \pnode(\linewidth,-\dimexpr\dp\smc@boxa+\CadreSep+\CadreLineWidth){C}
    \pnode(A|C){B}
    \pnode(C|A){D}
    \pnode([nodesep=-\SquareWidth]C){C1}
    \pnode([offset=\SquareWidth]C){C2}
    \pspolygon[linecolor=CurrCadreLineColor,
    linewidth=\CadreLineWidth, fillstyle=solid,
    fillcolor=CurrCadreBkgColor]
              (A)(B)(C1)(C2)(D)
    \rput[Bl](\dimexpr\CadreSep+\CadreLineWidth,0)
         {\usebox{\smc@boxa}}
  \end{pspicture}
  \par\addvspace{\AfterCadreVSpace}
}
\newcommand*\smc@cadre[2][0,0,0,0]{%
  \def\smc@framecorner{#1}%
  \def\smc@framebkgcolor{#2}%
  \smc@@cadre
}
\newcommand*\smc@@cadre[1][]{%
  \def\smc@framelinecolor{#1}%
  \ifx\smc@framelinecolor\empty
    \edef\smc@framehoffset{\the\dimexpr\FrameSep*2}%
    \edef\smc@framewidth
      {\the\dimexpr\linewidth-\smc@framehoffset}%
  \else
    \edef\smc@framehoffset{\the\dimexpr\FrameSep*2+\FrameLineWidth*2}%
    \edef\smc@framewidth
      {\the\dimexpr\linewidth-\smc@framehoffset}%
  \fi
  \setbox0=\hbox\bgroup
    \minipage{\smc@framewidth}%
      \ignorespaces
}
\def\endsmc@cadre{%
    \endminipage
  \egroup
  \ifx\smc@framelinecolor\empty
    \edef\smc@ymin{\the\dimexpr-\dp0-\FrameSep}%
    \edef\smc@ymax{\the\dimexpr\ht0+\FrameSep}%
    \psset{linewidth=0pt, linestyle=none,
           fillstyle=solid, fillcolor=\smc@framebkgcolor}
  \else
    \edef\smc@ymin{\the\dimexpr -\dp0-\FrameSep-\FrameLineWidth}%
    \edef\smc@ymax{\the\dimexpr\ht0+\FrameSep+\FrameLineWidth}%
    \psset{linewidth=\FrameLineWidth, linecolor=\smc@framelinecolor,
           fillstyle=solid, fillcolor=\smc@framebkgcolor}
    \def\FrameLineWidth{0pt}%
  \fi
  \smc@parse@corner{\smc@framecorner}%
  \begin{pspicture}(0,\smc@ymin)(\linewidth,\smc@ymax)
    \pscustom{%
      \psarc(\dimexpr \FrameArc/10*\smc@corner@dl,
             \dimexpr \smc@ymin+\FrameArc/10*\smc@corner@dl)
            {\dimexpr \FrameArc/10*\smc@corner@dl}{180}{270}
      \psline(\dimexpr \FrameArc/10*\smc@corner@dl,
              \smc@ymin)
             (\dimexpr \linewidth-\FrameArc/10*\smc@corner@dr,
              \smc@ymin)
      \psarc(\dimexpr \linewidth-\FrameArc/10*\smc@corner@dr,
             \dimexpr \smc@ymin+\FrameArc/10*\smc@corner@dr)
            {\dimexpr \FrameArc/10*\smc@corner@dr}{270}{360}
      \psline(\linewidth,
              \dimexpr \smc@ymin+\FrameArc/10*\smc@corner@dr)
             (\linewidth,
              \dimexpr \smc@ymax-\FrameArc/10*\smc@corner@ur)
      \psarc(\dimexpr \linewidth-\FrameArc/10*\smc@corner@ur,
             \dimexpr \smc@ymax-\FrameArc/10*\smc@corner@ur)
            {\dimexpr \FrameArc/10*\smc@corner@ur}{0}{90}
      \psline(\dimexpr \linewidth-\FrameArc/10*\smc@corner@ur,
              \smc@ymax)
             (\dimexpr \FrameArc/10*\smc@corner@ul,
              \smc@ymax)
      \psarc(\dimexpr \FrameArc/10*\smc@corner@ul,
             \dimexpr \smc@ymax-\FrameArc/10*\smc@corner@ul)
            {\dimexpr \FrameArc/10*\smc@corner@dr}{90}{180}
      \psline(0,
              \dimexpr \smc@ymax-\FrameArc/10*\smc@corner@ul)
             (0,
              \dimexpr \smc@ymin+\FrameArc/10*\smc@corner@dl)
    }
    \rput[Bl](\dimexpr \FrameSep+\FrameLineWidth,0){\box0}
  \end{pspicture}%
}
\newcommand*\smc@parse@corner[1]{%
  \expandafter\smc@@parse@corner#1,,,,\@nil
}
\def\smc@@parse@corner#1,#2,#3,#4,#5\@nil{%
  \def\smc@corner@dl{#1}%
  \ifx\smc@corner@dl\empty
    \def\smc@corner@dl{0}%
  \fi
  \def\smc@corner@dr{#2}%
  \ifx\smc@corner@dr\empty
    \def\smc@corner@dr{0}%
  \fi
  \def\smc@corner@ur{#3}%
  \ifx\smc@corner@ur\empty
    \def\smc@corner@ur{0}%
  \fi
  \def\smc@corner@ul{#4}%
  \ifx\smc@corner@ul\empty
    \def\smc@corner@ul{0}%
  \fi
}
\newcommand{\tableau}[1][c]{%
  \arrayrulecolor{FiletTableauColor}%
  \renewcommand\tabularxcolumn[1]{>{\centering\arraybackslash}m{##1}}%
  \ifcsname#1tableau\endcsname
    \expandafter\let\expandafter\smc@next\csname#1tableau\endcsname
    \expandafter\let\expandafter\endtableau\csname end#1tableau\endcsname
  \else
    \ClassError{sesamanuel}
              {Le type de tableau #1 n'existe pas}
              {Les types possibles sont 't', 'c', 'l', 'cl', 'T', 'C',
                'L', 'CL' et 'pr'.}%
    \let\smc@next\ctableau
    \let\endtableau\endctableau
  \fi
  \par\addvspace{\BeforeTableVSpace}
  \smc@next
}
\newenvironment{ttableau}[2]
{\tabularx{#1}{|*{#2}{X|}}}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{Ttableau}[3]
{\tabularx{#1}{|#3|*{\numexpr#2-1}{X|}}}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{ctableau}[2]
{%
  \tabularx{#1}{%
    |>{\columncolor{FondTableaux}[\dimexpr\tabcolsep-0.5pt]}X|
    *{\numexpr#2-1}{X|}}%
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{Ctableau}[3]
{%
  \tabularx{#1}{%
    |>{\columncolor{FondTableaux}[\dimexpr\tabcolsep-0.5pt]}#3|
    *{\numexpr#2-1}{X|}}%
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{ltableau}[2]
{%
  \tabularx{#1}{|*{#2}{X|}}
  \rowcolor{FondTableaux}
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{Ltableau}[3]
{%
  \tabularx{#1}{|#3|*{\numexpr#2-1}{X|}}
  \rowcolor{FondTableaux}
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{cltableau}[2]
{%
  \tabularx{#1}{%
    |>{\columncolor{FondTableaux}[\dimexpr\tabcolsep-0.5pt]}X|
    *{\numexpr#2-1}{X|}}%
  \rowcolor{FondTableaux}
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\newenvironment{CLtableau}[3]
{%
  \tabularx{#1}{%
    |>{\columncolor{FondTableaux}[\dimexpr\tabcolsep-0.5pt]}#3|
    *{\numexpr#2-1}{X|}}%
  \rowcolor{FondTableaux}
}
{\endtabularx\par\addvspace{\AfterTableVSpace}}
\let\lctableau\cltableau
\let\endlctableau\endcltableau
\let\LCtableau\CLtableau
\let\endLCtableau\endCLtableau
\newenvironment{prtableau}[1]
{%
  \def\propriete{%
    \refstepcounter{propriete}%
    \psframebox*[fillcolor=TablePropertyTitleBkgColor]{%
      \ProprieteFont
      \textcolor{TablePropertyTitleTextColor}{ \MakeUppercase{\StringPropriete}}
      \NumProprieteFont
      \textcolor{TablePropertyTitleTextColor}{\thepropriete}
    }
  }%
  \longtable{%
    >{\leavevmode\endgraf\vspace{-0.3\baselineskip}}
    m{0.24\dimexpr#1-6\tabcolsep}
    <{\endgraf\vspace{-0.3\baselineskip}}
    >{%
      \leavevmode\endgraf\vspace{-0.3\baselineskip}
      \columncolor{TablePropertyBkgColor}
    }
    m{0.46\dimexpr#1-6\tabcolsep}
    <{\endgraf\vspace{-0.3\baselineskip}}
    >{%
      \centering\arraybackslash
      \leavevmode\endgraf\vspace{-0.3\baselineskip}
    }
    m{0.30\dimexpr#1-6\tabcolsep}
    <{\endgraf\vspace{-0.3\baselineskip}}
  }%
}
{\endlongtable\par\addvspace{\AfterTableVSpace}}
\newcommand\tabX[1][\ht\@arstrutbox,\dp\@arstrutbox]{%
  \smc@GetVTabX#1,,\@nil
  \vrule width0pt height\smc@htTabX depth-\smc@dpTabX
  \pnode(-\tabcolsep,\smc@htTabX){ul}
  \pnode(-\tabcolsep,\smc@dpTabX){dl}
  \hspace*{\stretch{1}}%
  \pnode(\tabcolsep,\smc@htTabX){ur}
  \pnode(\tabcolsep,\smc@dpTabX){dr}
  \psline(ul)(dr)
  \psline(dl)(ur)
}
\def\smc@GetVTabX#1,#2,{%
  \edef\smc@htTabX{\the\dimexpr#1}%
  \edef\smc@dpTabX{-\the\dimexpr#2}%
  \smc@gobblenil
}
\def\smc@gobblenil#1\@nil{}
\newenvironment{debordedroite}{%
  \changemargin{0mm}{-\ExtraMarginRight}%
}
{\par\endchangemargin}
\newcommand*\habillage[1]{%
  \setbox\smc@boxb=\hbox{#1}%
  \smc@dimb = \dimexpr\wd\smc@boxb-\ExtraMarginRight\relax
  \ifdim \smc@dimb<\z@
    \smc@dimb = 0.1pt
  \fi
  \parpic[r]{\makebox[\smc@dimb][l]{{#1}}}
}
\let\uori\u
\let\Uori\U
\let\U\relax
\newcommand\U[1]{\ensuremath{#1}}
\renewcommand\u[1]{\ensuremath{\nombre{#1}}}
\newcommand\newunit[2]{%
  \expandafter\newcommand\csname u#1\endcsname[1]{%
    \@ifmtarg{##1}
      {\ensuremath{#2}}
      {\ensuremath{\nombre{##1}\,#2}}%
  }%
  \expandafter\newcommand\csname U#1\endcsname[1]{%
    \@ifmtarg{##1}
      {\ensuremath{#2}}
      {\ensuremath{##1\,#2}}%
  }%
}
\newcommand\renewunit[2]{%
  \expandafter\renewcommand\csname u#1\endcsname[1]{%
    \@ifmtarg{##1}
      {\ensuremath{#2}}
      {\ensuremath{\nombre{##1}\,#2}}%
  }%
  \expandafter\renewcommand\csname U#1\endcsname[1]{%
    \@ifmtarg{##1}
      {\ensuremath{#2}}
      {\ensuremath{##1\,#2}}%
  }%
}
\newunit{ym}{\text{ym}}
\newunit{zm}{\text{zm}}
\newunit{am}{\text{am}}
\newunit{fm}{\text{fm}}
\newunit{pm}{\text{pm}}
\newunit{nm}{\text{nm}}
\newunit{micron}{\mu\text{m}}
\newunit{mm}{\text{mm}}
\newunit{cm}{\text{cm}}
\newunit{dm}{\text{dm}}
\newunit{m}{\text{m}}
\newunit{dam}{\text{dam}}
\newunit{hm}{\text{hm}}
\newunit{km}{\text{km}}
\newunit{Mm}{\text{Mm}}
\newunit{Gm}{\text{Gm}}
\newunit{Tm}{\text{Tm}}
\newunit{Pm}{\text{Pm}}
\newunit{Em}{\text{Em}}
\newunit{Zm}{\text{Zm}}
\newunit{Ym}{\text{Ym}}
\newunit{mmq}{\text{mm}^2}
\newunit{cmq}{\text{cm}^2}
\newunit{dmq}{\text{dm}^2}
\newunit{mq}{\text{m}^2}
\newunit{damq}{\text{dam}^2}
\newunit{hmq}{\text{hm}^2}
\newunit{kmq}{\text{km}^2}
\newunit{ha}{\text{ha}}
\newunit{mmc}{\text{mm}^3}
\newunit{cmc}{\text{cm}^3}
\newunit{dmc}{\text{dm}^3}
\newunit{mc}{\text{m}^3}
\newunit{damc}{\text{dam}^3}
\newunit{hmc}{\text{hm}^3}
\newunit{kmc}{\text{km}^3}
\newunit{hl}{\text{hl}}
\newunit{dal}{\text{dal}}
\newunit{l}{\text{l}}
\newunit{dl}{\text{dl}}
\newunit{cl}{\text{cl}}
\newunit{ml}{\text{ml}}
\newunit{hel}{\text{h$\ell$}}
\newunit{dael}{\text{da$\ell$}}
\newunit{el}{\text{$\ell$}}
\newunit{del}{\text{d$\ell$}}
\newunit{cel}{\text{c$\ell$}}
\newunit{mel}{\text{m$\ell$}}
\newunit{s}{\text{s}}
\newunit{min}{\text{min}}
\newunit{h}{\text{h}}
\newunit{ms}{\text{m$\cdot$s}^{-1}}
\newunit{mh}{\text{m$\cdot$h}^{-1}}
\newunit{kms}{\text{km$\cdot$s}^{-1}}
\newunit{kmmin}{\text{km$\cdot$min}^{-1}}
\newunit{kmh}{\text{km$\cdot$h}^{-1}}
\newunit{ls}{\text{$\ell\cdot$s}^{-1}}
\newunit{mg}{\text{mg}}
\newunit{cg}{\text{cg}}
\newunit{dg}{\text{dg}}
\newunit{g}{\text{g}}
\newunit{dag}{\text{dag}}
\newunit{hg}{\text{hg}}
\newunit{kg}{\text{kg}}
\newunit{T}{\text{T}}
\newunit{pc}{\%}
\newunit{deg}{\text{\degre}}
\newunit{degc}{\text{\degre C}}
\newunit{euro}{\text{\euro}}
\newcommand*\algo{%
  \psframebox[framesep=1pt,linewidth=\LogoLineWidth,
              linecolor=AlgoLineColor, fillstyle=solid,
              fillcolor=AlgoBkgColor, framearc=0.6]{%
    \AlgoFont
    \textcolor{AlgoTextColor}{\StringALGO}%
  }
}
\newcommand*\tice{%
  \psframebox[framesep=1pt,linewidth=\LogoLineWidth,
              linecolor=TiceLineColor, fillstyle=solid,
              fillcolor=TiceBkgColor, framearc=0.6]{%
    \TiceFont
    \textcolor{TiceTextColor}{\StringTICE}%
  }
}
\newcounter{smc@line}
\newenvironment{oldalgorithme}{%
  \ttfamily
  \c@smc@line \z@
  \def\par{%
    \@@par
    \afterassignment\smc@displaynum\let\next=%
  }%
  \def\smc@displaynum{%
    \ifx\next\end
      \expandafter\end
    \else
      \global\advance\c@smc@line\@ne%
      \leavevmode\hb@xt@\AlgorithmeNumWidth{\the\c@smc@line.\hss}%
      \expandafter\next
    \fi%
  }%
  \shorthandoff{;:!?}%
  \@vobeyspaces
  \obeylines
  \begin{lrbox}{\smc@boxa}%
  \minipage{\dimexpr\linewidth-\AlgorithmeRuleWidth*2-\AlgorithmeSep*2}%
}
{%
  \endminipage
  \end{lrbox}%
  \@@par\addvspace{\BeforeAlgorithmeVSpace}
  \psframebox[linecolor=AlgorithmeRuleColor,
              linewidth=\AlgorithmeRuleWidth,
              fillstyle=solid,
              fillcolor=AlgorithmeBkgColor,
              framesep=\AlgorithmeSep,
              cornersize=absolute,
              linearc=\AlgorithmeSep]%
             {\usebox{\smc@boxa}}%
  \@@par\addvspace{\AfterAlgorithmeVSpace}
}
\newcount\smc@indent
\newcommand*\smc@inc@indent{%
  \advance\smc@indent\@ne
}
\newcommand*\smc@dec@indent{%
  \ifnum\smc@indent>\z@
    \advance\smc@indent\m@ne
  \fi
}
\newcommand*\smc@write@indent{%
  \par
  \refstepcounter{smc@line}%
  \dimen0 \dimexpr\AlgoIndent*\smc@indent
  \leavevmode\hb@xt@\AlgorithmeNumWidth{\texttt{\the\c@smc@line.}\hss}%
  \hspace*{\dimen0}%
}
\newcommand*\BlocVariables{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Liste des variables utilis\'ees}%
  \smc@inc@indent
}
\newcommand*\BlocEntrees{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Entr\'ees}%
  \smc@inc@indent
}
\newcommand*\BlocTraitements{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Traitements}
  \smc@inc@indent
}
\newcommand*\BlocAffichage{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Affichage}
  \smc@inc@indent
}
\newcommand\BlocTraitementsEtAffichage{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Traitements et affichage}
  \smc@inc@indent
}
\newcommand*\DeclareVar[3]{%
  \smc@write@indent
  \texttt{#1 \string: }%
  \textit{#2}\hfill
  \textcolor{CouleurAlgoCommentaire}{#3}%
}
\newcommand*\TantQue[2]{%
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoTantque}{\bfseries Tant que} (\texttt{#1})}
  \texttt{\bfseries faire}
  \smc@inc@indent
  #2
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoTantque}{\bfseries Fin Tant que}}%
}
\newcommand*\Pour[4]{%
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoPour}{\bfseries Pour}}
  \texttt{#1}
  \textcolor{CouleurAlgoPour}{\bfseries variant de}
  \texttt{#2}
  \textcolor{CouleurAlgoPour}{\bfseries \`a}
  \texttt{#3}
  \texttt{\bfseries faire}
  \smc@inc@indent
  #4
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoTantque}{\bfseries Fin Pour}}%
}
\newcommand*\PourAvecPas[5]{%
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoPour}{\bfseries Pour}}
  \texttt{#1}
  \textcolor{CouleurAlgoPour}{\bfseries variant de}
  \texttt{#2}
  \textcolor{CouleurAlgoPour}{\bfseries \`a}
  \texttt{#3}
  \textcolor{CouleurAlgoPour}{\bfseries avec un pas de}
  \texttt{#4}
  \texttt{faire}
  \smc@inc@indent
  #5
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoTantque}{\bfseries Fin Pour}}%
}
\newcommand*\SiAlors[2]{%
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Si}}
  {#1}
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries  Alors}}
  \smc@inc@indent
  #2
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Fin Si}}%
}
\newcommand*\SiAlorsSinon[3]{%
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Si}}
  {#1}
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Alors}}
  \smc@inc@indent
  #2
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Sinon}}
  \smc@inc@indent
  #3
  \smc@dec@indent
  \smc@write@indent
  \texttt{\textcolor{CouleurAlgoSi}{\bfseries Fin Si}}%
}
\newcommand*\AfficherVar[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoAffiche}{Afficher la valeur de}
  \texttt{#1}%
}
\newcommand*\Afficher[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoAffiche}{Afficher}
  #1%
}
\newcommand*\Calculer[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoCalcule}{Calculer}
  #1%
}
\newcommand*\Demander[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoDemander}{Demander}
  \texttt{#1}%
}
\newcommand*\Saisir[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoSaisir}{Saisir}
  \texttt{#1}%
}
\newcommand*\Stocker[1]{%
  \smc@write@indent
  \textcolor{CouleurAlgoStocker}{Stocker} la r\'eponse dans
  \texttt{#1}%
}
\newcommand*\DonnerValeur[2]{%
  \smc@write@indent
  \textcolor{CouleurAlgoDonnerValeur}{Donner} \`a \texttt{#1}
  la valeur de \texttt{#2}%
}
\newcommand*\TitreAlgo[1]{%
  \smc@write@indent
  \textit{Algorithme \string: }#1
}
\newcommand*\FinAlgo{%
  \smc@dec@indent
  \smc@write@indent
  \textit{Fin de l'algorithme}%
}
\newenvironment{algorithme}{%
  \c@smc@line\z@
  \shorthandoff{;:!?}%
  \begin{lrbox}{\smc@boxa}%
  \minipage{\dimexpr\linewidth-\AlgorithmeRuleWidth*2-\AlgorithmeSep*2}%
}
{%
  \endminipage
  \end{lrbox}%
  \par\addvspace{\BeforeAlgorithmeVSpace}
  \psframebox[linecolor=AlgorithmeRuleColor,
              linewidth=\AlgorithmeRuleWidth,
              fillstyle=solid,
              fillcolor=AlgorithmeBkgColor,
              framesep=\AlgorithmeSep,
              cornersize=absolute,
              linearc=\AlgorithmeSep]%
             {\usebox{\smc@boxa}}%
  \par\addvspace{\AfterAlgorithmeVSpace}
}
\newcommand*\Strut[1][1]{%
  \leavevmode
  \vrule \@height #1\ht\strutbox
         \@depth #1\dp\strutbox
         \@width\z@
}
\newcommand*\TopStrut[1][1]{%
  \leavevmode
  \vrule \@height #1\ht\strutbox
         \@depth \z@
         \@width \z@
}
\newcommand*\BotStrut[1][1]{%
  \leavevmode
  \vrule \@height \z@
         \@depth #1\dp\strutbox
         \@width \z@
}
\newcommand*\RefExercice{%
  \@ifstar{\smc@sRefExercice}{\smc@nsRefExercice}%
}
\newcommand*\smc@sRefExercice[1]{%
  \psframebox*[linewidth=0pt, fillcolor=ExerciceCorrigeNumFrameColor,
               framesep=2pt]{\textcolor{ExerciceNumColor}{\bfseries \ref{#1}}}%
}
\newcommand*\smc@nsRefExercice[1]{%
  \psframebox*[linewidth=0pt, fillcolor=ExerciceNumFrameColor, framesep=2pt]
              {\textcolor{ExerciceNumColor}{\bfseries \ref{#1}}}%
}
\newcommand*\MethodeRefExercice{%
  \@ifstar{\smc@sMethodeRefExercice}{\smc@nsMethodeRefExercice}%
}
\newcommand\smc@sMethodeRefExercice[1]{%
  \begingroup
  \normalcolor
  \normalfont
  \MethodeRefExerciceFont
  \hfill
  \begin{pspicture}(0,0)(0.8em,1.2ex)
    \pspolygon*[linewidth=0pt, linecolor=MethodeTitleFrameColor]
               (0,0)(0,1.2ex)(0.8em,0.6ex)
  \end{pspicture}~%
  Ex.~\RefExercice*{#1}~p.~\pageref{#1}%
  \endgroup
}
\newcommand\smc@nsMethodeRefExercice[1]{%
  \begingroup
  \normalcolor
  \normalfont
  \MethodeRefExerciceFont
  \hfill
  \begin{pspicture}(0,0)(0.8em,1.2ex)
    \pspolygon*[linewidth=0pt, linecolor=MethodeTitleFrameColor]
               (0,0)(0,1.2ex)(0.8em,0.6ex)
  \end{pspicture}~%
  Ex.~\RefExercice{#1}~p.~\pageref{#1}%
  \endgroup
}
\newcommand*\RefMethode[1]{%
  \textcolor{MethodeTitleFrameColor}{\bfseries \ref{#1}}%
}
\newcommand*\ExerciceRefMethode[1]{%
  \begingroup
  \quad
  \begin{pspicture}(0,0)(0.8em,1.2ex)
    \pspolygon*[linewidth=0pt, linecolor=MethodeTitleFrameColor]
               (0,0)(0,1.2ex)(0.8em,0.6ex)
  \end{pspicture}~%
  \psframebox*[fillcolor=ExerciceRefMethodeColor]
              {%
                \textcolor{Blanc}{%
                  {%
                    \ExerciceRefMethodeFont
                    \StringMETHODE~\ref{#1}%
                  }%
                }%
              }%
  \textcolor{Noir}{%
    {%
      \normalfont
      \ExercicePageRefMethodeFont
      ~p.~\pageref{#1}%
    }%
  }%
  \endgroup
}
\newcommand*\RefItem[1]{%
  \textcolor{\smc@curr@itemcolor}{\smc@curr@itemcmd\ref{#1}}%
}
\newcommand*\RefQCM[1]{%
  \begingroup
    \fboxsep \QCMRefHSep
    \colorbox{QCMFrameColor}{\textcolor{QCMTextFrameColor}{\ref{#1}}}%
  \endgroup
}
\newcommand*\RefPartie[1]{%
  \psframebox*[fillcolor=smc@curr@partiebkgcolor]
    {\textcolor{smc@curr@partiecolor}{\smc@curr@partiefont \ref{#1}}}%
}
\newcommand*\SudokuWidth{5mm}
\newcommand\sudoku[2][\SudokuWidth]{%
  \begingroup
    \psset{unit=#1, dimen=middle, linewidth=0.3pt, linecolor=FiletTableauColor}
    \begin{pspicture}(0,0)(10,10)
      \multido{\n=1+1}{9}{%
        \rput[B](\n.5,9.25){\symbol{\numexpr 96+\n}}
        \rput[B](0.5,\dimexpr\n\psyunit-0.75\psyunit){\symbol{\numexpr 74-\n}}
      }
      \def\x{1}\def\y{8}%
      \let\smc@next\smc@parsesudoku
      \smc@next#2\@nil\@@nil
      \psset{linewidth=1.2pt}
      \multido{\n=0+3,\nn=1+3}{4}{%
        \psline(1,\n)(10,\n)
        \psline(\nn,-0.5\pslinewidth)(\nn,\dimexpr 9\psyunit+0.5\pslinewidth)
      }
    \end{pspicture}%
  \endgroup
}
\def\smc@parsesudoku#1{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\@nnil
    \let\smc@next\smc@endsudoku
  \else
    \rput(\x,\y){%
      \if#1.%
        \psframe(0,0)(1,1)
      \else\if#1*%
        \psframe[fillstyle=solid, fillcolor=FondSudokuColor](0,0)(1,1)
      \else
        \psframe(0,0)(1,1)
        \rput[B](0.5,0.3\psyunit){#1}
      \fi\fi
    }
  \fi
  \edef\x{\the\numexpr\x+1}%
  \ifnum\x=10
    \def\x{1}%
    \edef\y{\the\numexpr\y-1}%
    \ifnum\y=-1
      \let\smc@next\smc@endsudoku
    \fi
  \fi
  \smc@next
}
\def\smc@endsudoku#1\@@nil{%
  \ifnum\y>-1
    \let\smc@next\smc@@endsudoku
    \smc@next
  \fi
}
\def\smc@@endsudoku{%
  \rput(\x,\y){\psframe(0,0)(1,1)}
  \edef\x{\the\numexpr\x+1}%
  \ifnum\x=10
    \def\x{1}%
    \edef\y{\the\numexpr\y-1}%
    \ifnum\y=-1
      \let\smc@next\relax
    \fi
  \fi
  \smc@next
}
\newcommand\smc@nobsbs[1]{%
  \begingroup
    \def\\{\space\ignorespaces}%
    \protected@edef\smc@tmp{#1}%
    \smc@tmp
  \endgroup
}
\newcommand*\smc@headeven[2]{%
  \begin{pspicture}(0,0)(\HeadFrameWidth,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#15Color]
      (\dimexpr -\smc@marginleft-\smc@bleed,-\HeadFrameDepth)
      (\HeadFrameWidth,\dimexpr \HeadFrameHeight+\smc@bleed)
    \smc@diagonal(\HeadFrameWidth-\SquareWidth*3,-\HeadFrameDepth){#1}
    \setbox0=\hbox{\textcolor{#10Color}{\HeadTitleFont #2}}%
    \ifdim\wd0>\HeadTitleMaxWidth
      \rput[Bl](0,0){%
        {%
          \HeadTitleFont\color{#10Color}%
          \resizebox{\HeadTitleMaxWidth}{\dimexpr\ht0+\dp0}{#2}%
        }%
      }
    \else
      \rput[Bl](0,0){\unhbox0}
    \fi
  \end{pspicture}
}
\newcommand\smc@headodd[2]{%
  \begin{pspicture}(0,0)(\HeadFrameWidth,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#15Color]
      (0,-\HeadFrameDepth)
      (\dimexpr \HeadFrameWidth+\smc@marginright+\smc@bleed,
       \dimexpr \HeadFrameHeight+\smc@bleed)
    \smc@antidiagonal(0pt,-\HeadFrameDepth){#1}
    \setbox0=\hbox{\textcolor{#10Color}{\HeadTitleFont #2}}%
    \ifdim\wd0>\HeadTitleMaxWidth
      \rput[Br](\HeadFrameWidth,0){%
        {%
          \HeadTitleFont\color{#10Color}%
          \resizebox{\HeadTitleMaxWidth}{\dimexpr\ht0+\dp0}{#2}%
        }%
      }
    \else
      \rput[Br](\HeadFrameWidth,0){\unhbox0}
    \fi
  \end{pspicture}
}
\newcommand*\smc@roundheadeven[3]{%
  \begin{pspicture}(0,0)(\RoundHeadFrameWidth,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#15Color]
      (\dimexpr -\smc@marginleft-\smc@bleed,-\HeadFrameDepth)
      (\RoundHeadFrameWidth,\dimexpr \HeadFrameHeight+\smc@bleed)
    \psframe[fillcolor=#2]
      (\dimexpr \RoundHeadFrameWidth-\SquareWidth/2,
       -\HeadFrameDepth)
      (\RoundHeadFrameWidth,
       \dimexpr -\HeadFrameDepth+\SquareWidth/2)
    \smc@rounddiagonal(\RoundHeadFrameWidth-\SquareWidth*3,-\HeadFrameDepth){#1}
    \setbox0=\hbox{\textcolor{#10Color}{\HeadTitleFont #3}}%
    \ifdim\wd0>\RoundHeadTitleMaxWidth
      \rput[Bl](0,0){%
        {%
          \HeadTitleFont\color{#10Color}%
          \resizebox{\RoundHeadTitleMaxWidth}{\dimexpr\ht0+\dp0}{#3}%
        }%
      }
    \else
      \rput[Bl](0,0){\unhbox0}
    \fi
  \end{pspicture}
}
\newcommand\smc@roundheadodd[3]{%
  \begin{pspicture}(0,0)(\RoundHeadFrameWidth,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#15Color]
      (0,-\HeadFrameDepth)
      (\dimexpr \RoundHeadFrameWidth+\smc@marginright+\smc@bleed,
       \dimexpr \HeadFrameHeight+\smc@bleed)
    \psframe[fillcolor=#2]
      (0, -\HeadFrameDepth)
      (\dimexpr \SquareWidth/2, \dimexpr -\HeadFrameDepth+\SquareWidth/2)
    \smc@roundantidiagonal(0pt,-\HeadFrameDepth){#1}
    \setbox0=\hbox{\textcolor{#10Color}{\HeadTitleFont #3}}%
    \ifdim\wd0>\RoundHeadTitleMaxWidth
      \rput[Br](\RoundHeadFrameWidth,0){%
        {%
          \HeadTitleFont\color{#10Color}%
          \resizebox{\RoundHeadTitleMaxWidth}{\dimexpr\ht0+\dp0}{#3}%
        }%
      }
    \else
      \rput[Br](\RoundHeadFrameWidth,0){\unhbox0}
    \fi
  \end{pspicture}%
}
\newcommand*\smc@footpage[1]{%
  \begin{pspicture}(0,0)(\FootFrameWidth,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \rput[B](.25,0){\FootPageFont \thepage}
    \psframe[fillcolor=#1](0,-\FootFrameSep)
            (\FootFrameWidth, \dimexpr \smc@footskip+\FootFrameSep
                         -\smc@marginbottom-\smc@bleed)
  \end{pspicture}%
}
\newcommand*\smc@foottitleeven{%
  {%
    \space
    {%
      \color{FootTitleHeadColor}%
      \FootTitleHeadFont \@chapapp\space
      \MakeUppercase{\smc@thema@init}\thechapter.
    }\space
    {%
      \FootTitleChapterFont \smc@nobsbs{\smc@chaptertitle}%
    }%
  }%
}
\newcommand*\smc@foottitleodd{%
  {%
    \leavevmode
    {%
      \color{FootTitleHeadColor}%
      \FootTitleHeadFont \@chapapp\space
      \MakeUppercase{\smc@thema@init}\thechapter.
    }\space
    {%
      \FootTitleChapterFont \smc@nobsbs{\smc@chaptertitle}%
    }%
  }%
  \space
}
\newcommand*\smc@bkgeven[1]{%
  \begin{pspicture}(0,0)(0,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#1]
            (\dimexpr -\smc@marginleft-\smc@bleed,
             \dimexpr \smc@margintop-\smc@headsep+\smc@bleed)
            (\dimexpr \linewidth+\smc@marginright+\smc@bleed,
             \dimexpr -\smc@headsep-\textheight-\smc@marginbottom-\smc@bleed)
  \end{pspicture}%
}
\newcommand*\smc@bkgodd[1]{%
  \begin{pspicture}(0,0)(0,0)
    \psset{linewidth=0pt, linestyle=none, fillstyle=solid}
    \psframe[fillcolor=#1]
            (\dimexpr -\smc@marginright-\smc@bleed,
             \dimexpr \smc@margintop-\smc@headsep+\smc@bleed)
            (\dimexpr \linewidth+\smc@marginleft+\smc@bleed,
             \dimexpr -\smc@headsep-\textheight-\smc@marginbottom-\smc@bleed)
  \end{pspicture}%
}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{firstchapter}{%
  \fancyhf{}
  \fancyhead[LE]{}
  \fancyhead[RO]{}
  \fancyfoot[LE]{\smc@footpage{FirstChapterFootColor}}
  \fancyfoot[RO]{\smc@footpage{FirstChapterFootColor}}
}
\fancypagestyle{activites}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{ActiviteHeadFrame}{\StringActivitesApproche}}
  \fancyhead[RO]{\smc@headodd{ActiviteHeadFrame}{\StringActivitesApproche}}
  \fancyfoot[LE]{\smc@footpage{ActiviteFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{ActiviteFootColor}}
}
\fancypagestyle{cours}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{CoursHeadFrame}{\StringCoursMethodes}}
  \fancyhead[RO]{\smc@headodd{CoursHeadFrame}{\StringCoursMethodes}}
  \fancyfoot[LE]{\smc@footpage{CoursFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{CoursFootColor}}
}
\fancypagestyle{exercicesbase}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{ExoBaseHeadFrame}{\StringExercicesBase}}
  \fancyhead[RO]{\smc@headodd{ExoBaseHeadFrame}{\StringExercicesBase}}
  \fancyfoot[LE]{\smc@footpage{ExoBaseFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{ExoBaseFootColor}}
}
\fancypagestyle{exercicesappr}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{ExoApprHeadFrame}{\StringExercicesAppr}}
  \fancyhead[RO]{\smc@headodd{ExoApprHeadFrame}{\StringExercicesAppr}}
  \fancyfoot[LE]{\smc@footpage{ExoApprFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{ExoApprFootColor}}
}
\fancypagestyle{connaissances}{%
  \fancyhf{}
  \fancyfoot[LE]{\smc@footpage{ConnFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{ConnFootColor}}
}
\fancypagestyle{firstconnaissances}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@roundheadeven{ConnHeadFrame}{Blanc}
                      {\StringTestConnaissances}%
  }
  \fancyhead[RO]{%
    \smc@roundheadodd{ConnHeadFrame}{Blanc}
                     {\StringTestConnaissances}%
  }
  \fancyfoot[LE]{\smc@footpage{ConnFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{ConnFootColor}}
}
\fancypagestyle{TP}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{TPHeadFrame}{\StringTravauxPratiques}}
  \fancyhead[RO]{\smc@headodd{TPHeadFrame}{\StringTravauxPratiques}}
  \fancyfoot[LE]{\smc@footpage{TPFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{TPFootColor}}
}
\fancypagestyle{recreation}{%
  \fancyhf{}
  \fancyhead[LE]{\smc@headeven{RecreationHeadFrame}{\StringRecreation}}
  \fancyhead[RO]{\smc@headodd{RecreationHeadFrame}{\StringRecreation}}
  \fancyfoot[LE]{\smc@footpage{RecreationFootColor}\smc@foottitleeven}
  \fancyfoot[RO]{\smc@foottitleodd\smc@footpage{RecreationFootColor}}
}
\newcommand*\smc@firstheadevenannexe[1]{%
  \begin{pspicture}(0,0)(0,0)
    \rput(-\smc@marginleft, \dimexpr \smc@margintop-\smc@headsep){%
      \pspolygon[linestyle=none, linewidth=0pt,
                 fillstyle=solid, fillcolor=#1]
                (-\smc@bleed, \smc@bleed)
                (-\smc@bleed, \dimexpr -\smc@paperheight-\smc@bleed)
                (\CorrigeHeadFrameWidth, \dimexpr -\smc@paperheight-\smc@bleed)
                (\CorrigeHeadFrameWidth, -\CorrigeHeadFrameWidth)
                (\dimexpr \CorrigeHeadFrameWidth*2, -\CorrigeHeadFrameWidth)
                (\dimexpr \CorrigeHeadFrameWidth*2, \smc@bleed)
    }
  \end{pspicture}%
}
\newcommand*\smc@firstheadoddannexe[1]{%
  \begin{pspicture}(0,0)(0,0)
    \rput(\smc@marginright,\dimexpr \smc@margintop-\smc@headsep){%
      \pspolygon[linestyle=none, linewidth=0pt, fillstyle=solid, fillcolor=#1]
        (\smc@bleed, \smc@bleed)
        (\smc@bleed, \dimexpr -\smc@paperheight-\smc@bleed)
        (-\CorrigeHeadFrameWidth, \dimexpr -\smc@paperheight-\smc@bleed)
        (-\CorrigeHeadFrameWidth, -\CorrigeHeadFrameWidth)
        (\dimexpr -\CorrigeHeadFrameWidth*2, -\CorrigeHeadFrameWidth)
        (\dimexpr -\CorrigeHeadFrameWidth*2, \smc@bleed)
    }
  \end{pspicture}%
}
\newcommand*\smc@headevenannexe[1]{%
  \begin{pspicture}(0,0)(0,0)
    \rput(-\smc@marginleft, \dimexpr \smc@margintop-\smc@headsep){%
      \pspolygon[linestyle=none, linewidth=0pt, fillstyle=solid, fillcolor=#1]
        (-\smc@bleed, \smc@bleed)
        (-\smc@bleed, \dimexpr -\smc@paperheight-\smc@bleed)
        (\CorrigeHeadFrameWidth, \dimexpr -\smc@paperheight-\smc@bleed)
        (\CorrigeHeadFrameWidth, \smc@bleed)
    }
  \end{pspicture}%
}
\newcommand*\smc@headoddannexe[1]{%
  \begin{pspicture}(0,0)(0,0)
    \rput(\smc@marginright,\dimexpr \smc@margintop-\smc@headsep){%
      \pspolygon[linestyle=none, linewidth=0pt,
                 fillstyle=solid, fillcolor=#1]
                (\smc@bleed,\smc@bleed)
                (\smc@bleed, \dimexpr -\smc@paperheight-\smc@bleed)
                (-\CorrigeHeadFrameWidth,
                 \dimexpr -\smc@paperheight-\smc@bleed)
                (-\CorrigeHeadFrameWidth, \smc@bleed)
    }
  \end{pspicture}%
}
\fancypagestyle{firstcorrige}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@firstheadevenannexe{CorrigeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@firstheadoddannexe{CorrigeHeadFrameColor}%
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringCorriges}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringCorriges}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{corrige}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@headevenannexe{CorrigeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@headoddannexe{CorrigeHeadFrameColor}
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringCorriges}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringCorriges}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{firstannexe}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@firstheadevenannexe{AnnexeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@firstheadoddannexe{AnnexeHeadFrameColor}%
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\smc@TitleAnnexe}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\smc@TitleAnnexe}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{annexe}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@headevenannexe{AnnexeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@headoddannexe{AnnexeHeadFrameColor}
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\smc@TitleAnnexe}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\smc@TitleAnnexe}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{firstlexique}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@firstheadevenannexe{LexiqueHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@firstheadoddannexe{LexiqueHeadFrameColor}%
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringLexique}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringLexique}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{lexique}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@headevenannexe{LexiqueHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@headoddannexe{LexiqueHeadFrameColor}
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringLexique}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringLexique}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{firstaffichemethode}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@firstheadevenannexe{ListeMethodeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@firstheadoddannexe{ListeMethodeHeadFrameColor}%
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringListeMethode}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringListeMethode}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{affichemethode}{%
  \fancyhf{}
  \fancyhead[LE]{%
    \smc@headevenannexe{ListeMethodeHeadFrameColor}%
  }
  \fancyhead[RO]{%
    \smc@headoddannexe{ListeMethodeHeadFrameColor}
  }
  \fancyfoot[LE]{%
    {\FootAnnexePageFont \thepage}
    {\FootAnnexeTxtFont \MakeUppercase{\StringListeMethode}}%
  }
  \fancyfoot[RO]{%
    {\FootAnnexeTxtFont \MakeUppercase{\StringListeMethode}}
    {\FootAnnexePageFont \thepage}%
  }
}
\fancypagestyle{firstlibre}{%
  \fancyhf{}
  \fancyfoot[LE]{%
    {\ifsmc@page\FootLibrePageFont \thepage\fi}
  }
  \fancyfoot[RO]{%
    {\ifsmc@page\FootLibrePageFont \thepage\fi}%
  }
}
\fancypagestyle{libre}{%
  \fancyhf{}
  \fancyfoot[LE]{%
    {\ifsmc@page\FootLibrePageFont \thepage\fi}
  }
  \fancyfoot[RO]{%
    {\ifsmc@page\FootLibrePageFont \thepage\fi}%
  }
}
\fancypagestyle{empty}{%
  \fancyhead{}
}
\definecolor{A1}                {cmyk}{1.00, 0.00, 0.00, 0.50}
\definecolor{A2}                {cmyk}{0.60, 0.00, 0.00, 0.10}
\definecolor{A3}                {cmyk}{0.30, 0.00, 0.00, 0.05}
\definecolor{A4}                {cmyk}{0.10, 0.00, 0.00, 0.00}
\definecolor{B1}                {cmyk}{0.00, 1.00, 0.60, 0.40}
\definecolor{B2}                {cmyk}{0.00, 0.85, 0.60, 0.15}
\definecolor{B3}                {cmyk}{0.00, 0.20, 0.15, 0.05}
\definecolor{B4}                {cmyk}{0.00, 0.05, 0.05, 0.00}
\definecolor{C1}                {cmyk}{0.00, 1.00, 0.00, 0.50}
\definecolor{C2}                {cmyk}{0.00, 0.60, 0.00, 0.20}
\definecolor{C3}                {cmyk}{0.00, 0.30, 0.00, 0.05}
\definecolor{C4}                {cmyk}{0.00, 0.10, 0.00, 0.05}
\definecolor{D1}                {cmyk}{0.00, 0.00, 1.00, 0.50}
\definecolor{D2}                {cmyk}{0.20, 0.20, 0.80, 0.00}
\definecolor{D3}                {cmyk}{0.00, 0.00, 0.20, 0.10}
\definecolor{D4}                {cmyk}{0.00, 0.00, 0.20, 0.05}
\definecolor{F1}                {cmyk}{0.00, 0.80, 0.50, 0.00}
\definecolor{F2}                {cmyk}{0.00, 0.40, 0.30, 0.00}
\definecolor{F3}                {cmyk}{0.00, 0.15, 0.10, 0.00}
\definecolor{F4}                {cmyk}{0.00, 0.07, 0.05, 0.00}
\definecolor{G1}                {cmyk}{1.00, 0.00, 0.50, 0.00}
\definecolor{G2}                {cmyk}{0.50, 0.00, 0.20, 0.00}
\definecolor{G3}                {cmyk}{0.20, 0.00, 0.10, 0.00}
\definecolor{G4}                {cmyk}{0.10, 0.00, 0.05, 0.00}
\definecolor{H1}                {cmyk}{0.40, 0.00, 1.00, 0.10}
\definecolor{H2}                {cmyk}{0.20, 0.00, 0.50, 0.05}
\definecolor{H3}                {cmyk}{0.10, 0.00, 0.20, 0.00}
\definecolor{H4}                {cmyk}{0.07, 0.00, 0.15, 0.00}
\definecolor{J1}                {cmyk}{0.00, 0.50, 1.00, 0.00}
\definecolor{J2}                {cmyk}{0.00, 0.20, 0.50, 0.00}
\definecolor{J3}                {cmyk}{0.00, 0.10, 0.20, 0.00}
\definecolor{J4}                {cmyk}{0.00, 0.07, 0.15, 0.00}
\definecolor{FondOuv}           {cmyk}{0.00, 0.05, 0.10, 0.00}
\definecolor{FondAutoEvaluation}{cmyk}{0.00, 0.03, 0.15, 0.00}
\definecolor{FondTableaux}      {cmyk}{0.00, 0.00, 0.20, 0.00}
\definecolor{FondAlgo}          {cmyk}{0.07, 0.00, 0.30, 0.00}
\definecolor{BleuOuv}           {cmyk}{1.00, 0.00, 0.00, 0.00}
\definecolor{PartieFonction}    {cmyk}{1.00, 0.00, 0.00, 0.00}
\definecolor{PartieGeometrie}   {cmyk}{0.80, 0.80, 0.00, 0.00}
\definecolor{PartieStatistique} {cmyk}{0.60, 0.95, 0.00, 0.20}
\definecolor{PartieStatistiqueOLD}{cmyk}{0.95, 0.60, 0.20, 0.00}
\definecolor{PartieStatistique*}{cmyk}{0.30, 1.00, 0.00, 0.00}
\definecolor{U1}                {cmyk}{0.50, 0.10, 0.00, 0.10}
\definecolor{U2}                {cmyk}{0.20, 0.15, 0.00, 0.00}
\definecolor{U3}                {cmyk}{0.50, 0.00, 1.00, 0.00}
\definecolor{U4}                {cmyk}{0.40, 0.00, 0.00, 0.00}
\definecolor{Blanc}             {cmyk}{0.00, 0.00, 0.00, 0.00}
\definecolor{Gris1}             {cmyk}{0.00, 0.00, 0.00, 0.20}
\definecolor{Gris2}             {cmyk}{0.00, 0.00, 0.00, 0.40}
\definecolor{Gris3}             {cmyk}{0.00, 0.00, 0.00, 0.50}
\definecolor{Noir}              {cmyk}{0.00, 0.00, 0.00, 1.00}
\AtBeginDocument{\def\default@color{cmyk 0 0 0 1}\normalcolor}
\colorlet{AlgoLineColor}{F3}
\colorlet{AlgoBkgColor}{F1}
\colorlet{AlgoTextColor}{Blanc}
\colorlet{TiceLineColor}{A3}
\colorlet{TiceBkgColor}{A1}
\colorlet{TiceTextColor}{Blanc}
\colorlet{CadreLineColor}{D3}
\colorlet{CadreBkgColor}{Blanc}
\colorlet{AlgorithmeRuleColor}{D2}
\colorlet{AlgorithmeBkgColor}{FondAlgo}
\colorlet{CouleurAlgoAffiche}{Noir}
\colorlet{CouleurAlgoDemander}{Noir}
\colorlet{CouleurAlgoSaisir}{Noir}
\colorlet{CouleurAlgoStocker}{Noir}
\colorlet{CouleurAlgoSi}{Noir}
\colorlet{CouleurAlgoTantque}{Noir}
\colorlet{CouleurAlgoPour}{Noir}
\colorlet{CouleurAlgoCalcule}{Noir}
\colorlet{CouleurAlgoInitialiser}{Noir}
\colorlet{CouleurAlgoIncrementer}{Noir}
\colorlet{CouleurAlgoCommentaire}{Noir}
\colorlet{CouleurAlgoDonnerValeur}{Noir}
\colorlet{CommentaireItemColor}{Noir}
\colorlet{FiletTableauColor}{Gris3}
\colorlet{FondSudokuColor}{FondTableaux}
\definecolor{FootFonctionColor}{cmyk}{0.50, 0.00, 0.00, 0.00}
\definecolor{FootGeometrieColor}{cmyk}{0.40, 0.40, 0.00, 0.00}
\definecolor{FootStatistiqueColor}{cmyk}{0.30, 0.48, 0.00, 0.10}
\definecolor{FootStatistiqueOLDColor}{cmyk}{0.48, 0.30, 0.10, 0.00}
\definecolor{FootStatistique*Color}{cmyk}{0.20, 0.00, 0.00, 0.00}
\colorlet{ChapterBottomFrameColor}{J4}
\colorlet{ThemaTopFrameColor}{J1}
\colorlet{ThemaBottomFrameColor}{J2}
\colorlet{ThemaTitleColor}{Blanc}
\colorlet{ChapterNumBkgColor}{H2}
\colorlet{ChapterNumSquare0Color}{Blanc}
\colorlet{ChapterNumSquare1Color}{H1}
\colorlet{ChapterNumSquare2Color}{H2}
\colorlet{ChapterNumSquare3Color}{H4}
\colorlet{ChapterTitleColor}{B1}
\colorlet{ChapAppColor}{Blanc}
\colorlet{ChapterNumColor}{Blanc}
\colorlet{PrerequisTitleColor}{B2}
\colorlet{PrerequisBkgColor}{A4}
\colorlet{PrerequisItemColor}{B2}
\colorlet{AEItemColor}{B2}
\colorlet{AETitleFrame0Color}{Blanc}
\colorlet{AETitleFrame1Color}{B2}
\colorlet{AETitleFrame2Color}{B3}
\colorlet{AETitleFrame3Color}{A4}
\colorlet{AETitleFrame4Color}{A3}
\colorlet{AETitleFrame5Color}{A2}
\colorlet{AETitleColor}{Blanc}
\colorlet{AEExoNumColor}{Blanc}
\colorlet{AEExoNumFrameColor}{J1}
\colorlet{AEFrameColor}{FondAutoEvaluation}
\colorlet{AECartoucheCorrBkgColor}{J2}
\colorlet{AECartoucheCorrArrowColor}{G2}
\colorlet{AECartoucheCorrVCPColor}{B2}
\colorlet{ActiviteHeadFrame0Color}{Blanc}
\colorlet{ActiviteHeadFrame1Color}{C1}
\colorlet{ActiviteHeadFrame2Color}{C2}
\colorlet{ActiviteHeadFrame3Color}{C3}
\colorlet{ActiviteHeadFrame4Color}{D3}
\colorlet{ActiviteHeadFrame5Color}{G1}
\definecolor{ActiviteFootColor}{cmyk}{0.50, 0.00, 0.25, 0.00}
\colorlet{FootChapterNumColor}{U1}
\colorlet{ActiviteSubtitleColor}{H1}
\colorlet{ActiviteNumColor}{Blanc}
\colorlet{ActiviteDebatTopColor}{G4}
\colorlet{ActiviteDebatBottomColor}{D4}
\colorlet{ActiviteActiviteTopColor}{D3}
\colorlet{ActiviteActiviteBottomColor}{G2}
\colorlet{ActiviteTitleColor}{C1}
\colorlet{ActiviteItemColor}{C1}
\colorlet{ActivitePartieColor}{A2}
\colorlet{CoursHeadFrame0Color}{Blanc}
\colorlet{CoursHeadFrame1Color}{J1}
\colorlet{CoursHeadFrame2Color}{J2}
\colorlet{CoursHeadFrame3Color}{J4}
\colorlet{CoursHeadFrame4Color}{A3}
\colorlet{CoursHeadFrame5Color}{A2}
\definecolor{CoursFootColor}{cmyk}{0.15, 0.00, 0.00, 0.03}
\colorlet{SectionFrame1Color}{J4}
\colorlet{SectionFrame2Color}{J2}
\colorlet{SectionFrame3Color}{J1}
\colorlet{SectionNumColor}{A1}
\colorlet{SectionTitleColor}{A1}
\colorlet{SubsectionNumColor}{B2}
\colorlet{SubsectionTitleColor}{J1}
\colorlet{DefSquareColor}{B2}
\colorlet{DefTitleColor}{A1}
\colorlet{DefSubtitleColor}{B2}
\colorlet{DefItemColor}{B2}
\colorlet{DefFrameColor}{J3}
\colorlet{RemTitleColor}{H1}
\colorlet{RemItemColor}{H1}
\colorlet{ExempleRuleColor}{J1}
\colorlet{ExempleEdgeFrameColor}{J2}
\colorlet{ExempleBkgFrameColor}{F4}
\colorlet{ExempleTitleColor}{A1}
\colorlet{ExempleItemColor}{J1}
\colorlet{MethodeTitleFrameColor}{A2}
\colorlet{MethodeTitleColor}{Blanc}
\colorlet{MethodeSubtitleColor}{B2}
\colorlet{MethodeIntroBkgFrameColor}{A4}
\colorlet{ExAppEdgeFrameColor}{A2}
\colorlet{ExAppBkgFrameColor}{H1}
\colorlet{ExAppTitleColor}{Blanc}
\colorlet{ExAppCorrEdgeFrameColor}{H1}
\colorlet{ExAppCorrBkgFrameColor}{A2}
\colorlet{ExAppCorrTitleColor}{Blanc}
\colorlet{ExAppItemColor}{A2}
\colorlet{MethodeRuleColor}{A3}
\colorlet{ProofRuleColor}{B1}
\colorlet{ProofTitleColor}{A1}
\colorlet{ProofTopFrameColor}{B4}
\colorlet{ProofBottomFrameColor}{B3}
\colorlet{ProofTriangleFrameColor}{B1}
\colorlet{ProofItemColor}{J2}
\colorlet{ExoBaseHeadFrame0Color}{Blanc}
\colorlet{ExoBaseHeadFrame1Color}{G1}
\colorlet{ExoBaseHeadFrame2Color}{G2}
\colorlet{ExoBaseHeadFrame3Color}{G4}
\colorlet{ExoBaseHeadFrame4Color}{J2}
\colorlet{ExoBaseHeadFrame5Color}{J1}
\definecolor{ExoBaseFootColor}{cmyk}{0.00, 0.25, 0.50, 0.00}
\colorlet{ExerciceColumnRuleColor}{J1}
\colorlet{ExercicesTitleColor}{C1}
\colorlet{ExercicesTitleVRuleColor}{G2}
\colorlet{ExercicesTitleSquareColor}{J1}
\colorlet{ExercicesTitleHRuleColor}{C3}
\colorlet{ExerciceNumColor}{Blanc}
\colorlet{ExerciceTitleColor}{F1}
\colorlet{ExerciceNumFrameColor}{G1}
\colorlet{ExerciceCorrigeNumFrameColor}{J1}
\colorlet{ExerciceItemColor}{G1}
\colorlet{ExercicePartieColor}{J1}
\colorlet{ExerciceRefMethodeColor}{A2}
\colorlet{ExoApprHeadFrame0Color}{Blanc}
\colorlet{ExoApprHeadFrame1Color}{G1}
\colorlet{ExoApprHeadFrame2Color}{G2}
\colorlet{ExoApprHeadFrame3Color}{G4}
\colorlet{ExoApprHeadFrame4Color}{J2}
\colorlet{ExoApprHeadFrame5Color}{J1}
\definecolor{ExoApprFootColor}{cmyk}{0.00, 0.25, 0.50, 0.00}
\colorlet{ConnHeadFrame0Color}{Blanc}
\colorlet{ConnHeadFrame1Color}{A2}
\colorlet{ConnHeadFrame2Color}{A3}
\colorlet{ConnHeadFrame3Color}{J2}
\colorlet{ConnHeadFrame4Color}{J1}
\colorlet{ConnHeadFrame5Color}{F1}
\colorlet{ConnFootColor}{F2}
\colorlet{AcquisTitleColor}{G1}
\colorlet{AcquisBkgColor}{A4}
\colorlet{AcquisItemColor}{F1}
\colorlet{QCMAEFrameColor}{G1}
\colorlet{QCMAETitleCircle1Color}{J1}
\colorlet{QCMAETitleCircle2Color}{J2}
\colorlet{QCMAETitleCircle3Color}{F1}
\colorlet{QCMAETitleColor}{Blanc}
\colorlet{QCMItemNumColor}{G1}
\colorlet{QCMFrameColor}{J1}
\colorlet{QCMTextFrameColor}{Blanc}
\colorlet{QCMExoNumColor}{Blanc}
\colorlet{QCMExoNumFrameColor}{J1}
\colorlet{QCMLineColor}{A4}
\colorlet{TPHeadFrame0Color}{Blanc}
\colorlet{TPHeadFrame1Color}{H1}
\colorlet{TPHeadFrame2Color}{H2}
\colorlet{TPHeadFrame3Color}{H3}
\colorlet{TPHeadFrame4Color}{C3}
\colorlet{TPHeadFrame5Color}{C2}
\definecolor{TPFootColor}{cmyk}{0.00, 0.30, 0.00, 0.10}
\colorlet{TPTopColor}{J3}
\colorlet{TPBottomColor}{C3}
\colorlet{TPTitleColor}{H1}
\colorlet{TPPartieColor}{J1}
\colorlet{TPPartieBkgColor}{C2}
\colorlet{TPPartieNumColor}{Blanc}
\colorlet{RecreationHeadFrame0Color}{Blanc}
\colorlet{RecreationHeadFrame1Color}{J1}
\colorlet{RecreationHeadFrame2Color}{J2}
\colorlet{RecreationHeadFrame3Color}{H4}
\colorlet{RecreationHeadFrame4Color}{H2}
\colorlet{RecreationHeadFrame5Color}{H1}
\definecolor{RecreationFootColor}{cmyk}{0.20, 0.00, 0.50, 0.05}
\colorlet{RecreationTitleColor}{H1}
\colorlet{RecreationItemColor}{U3}
\colorlet{RecreationPartieColor}{J1}
\colorlet{CorrigeHeadFrameColor}{J2}
\colorlet{CorrigeColumnRuleColor}{J1}
\colorlet{CorrigeAETitleColor}{F1}
\colorlet{CorrigeExercicesBaseTitleColor}{C2}
\colorlet{CorrigeExercicesApprTitleColor}{C2}
\colorlet{CorrigeConnaissancesTitleColor}{G1}
\colorlet{CorrigeQCMItemNumColor}{G1}
\colorlet{ListeMethodeHeadFrameColor}{G3}
\colorlet{ListeMethodeColumnRuleColor}{A1}
\colorlet{ListeMethodeTitleColor}{B2}
\colorlet{TablePropertyBkgColor}{J4}
\colorlet{TablePropertyTitleBkgColor}{PartieStatistique}
\colorlet{TablePropertyTitleTextColor}{Blanc}
\colorlet{AnnexePartieColor}{A1}
\colorlet{LexiqueHeadFrameColor}{F2}
\colorlet{LexiqueColumnRuleColor}{B2}
\colorlet{FirstLetterTxtColor}{B1}
\colorlet{FirstLetterBkgColor}{J3}
\colorlet{LexiqueEntreeColor}{B2}
\colorlet{LexiqueItemColor}{B2}
\colorlet{LibrePartieColor}{A1}
\newcommand*\AlgoFont{\fontsize{9.5}{9.5}\sffamily\bfseries}
\newcommand*\TiceFont{\fontsize{9.5}{9.5}\sffamily\bfseries}
\newcommand*\ThemaTitleFont{\fontsize{20}{24}\sffamily}
\newcommand*\ChapterTitleFont{\fontsize{40}{40}\sffamily\bfseries}
\newcommand*\ChapAppFont{\fontsize{15}{18}\sffamily}
\newcommand*\ChapterNumFont{\fontsize{88}{106}\sffamily}
\newcommand*\PrerequisTitleFont{\fontsize{14.4}{17.28}\sffamily\bfseries}
\newcommand*\PrerequisTextFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\AETitleFont{\fontsize{15}{18}\sffamily\bfseries}
\newcommand*\AEExoNumFont{\fontsize{9.5}{14.4}\sffamily\bfseries}
\newcommand*\AECartoucheCorrArrowFont{\fontsize{12}{14.4}}
\newcommand*\AECartoucheCorrVCPFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\AEManuelFont{\fontsize{9.5}{10.5}\sffamily}
\newcommand*\LogoManuelFont{\fontsize{9.5}{10.5}\sffamily\bfseries}
\newcommand*\LogoURLManuelFont{\fontsize{9.5}{10.5}\sffamily\bfseries}
\newcommand*\HeadTitleFont{\fontsize{24}{28.8}\sffamily\bfseries}
\newcommand*\RoundHeadTitleFont{\fontsize{24}{28.8}\sffamily\bfseries\itshape}
\newcommand*\FootChapterNumFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\FootTitleHeadFont{\fontsize{9.5}{12}\sffamily\bfseries}
\newcommand*\FootTitleChapterFont{\fontsize{9.5}{12}\sffamily}
\newcommand*\FootPageFont{\fontsize{9.5}{12}\sffamily\bfseries}
\newcommand*\ActiviteTitleFont{\fontsize{15}{18}\sffamily\bfseries}
\newcommand*\ActiviteNumFont{\fontsize{15}{18}\sffamily\bfseries}
\newcommand*\ActiviteSubtitleFont{\fontsize{15}{18}\sffamily\bfseries}
\newcommand*\ActivitePartieFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\SectionNumFont{\fontsize{21}{25}\sffamily\bfseries}
\newcommand*\SectionTitleFont{\fontsize{17.28}{21}\sffamily\bfseries}
\newcommand*\SubsectionNumFont{\fontsize{17.28}{21}\sffamily\bfseries}
\newcommand*\SubsectionTitleFont{\fontsize{14.4}{17.28}\sffamily\bfseries}
\newcommand*\DefTitleFont{\fontsize{12}{14.4}\sffamily}
\newcommand*\DefSubtitleFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\RemTitleFont{\fontsize{9.5}{14.4}\scshape\bfseries}
\newcommand*\ExempleTitleFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\MethodeTitleFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\MethodeSubtitleFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\MethodeRefExerciceFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\ExAppTitleFont{\normalsize\sffamily}
\newcommand*\ExAppCorrTitleFont{\normalsize\sffamily}
\newcommand*\ProofTitleFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\ExercicesTitleFont{\fontsize{14.4}{17.28}\sffamily\bfseries}
\newcommand*\ExerciceNumFont{\fontsize{10.5}{14.4}\sffamily\bfseries}
\newcommand*\ExerciceTitleFont{\fontsize{10.5}{14.4}\sffamily\bfseries}
\newcommand*\ExercicePartieFont{\fontsize{10.5}{14.4}\bfseries}
\newcommand*\ExerciceRefMethodeFont{\fontsize{9.5}{14.4}\sffamily\bfseries}
\newcommand*\ExercicePageRefMethodeFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\AcquisTitleFont{\fontsize{17.28}{17.28}\sffamily\bfseries}
\newcommand*\AcquisTextFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\QCMAETitleFont{\fontsize{20}{20}\sffamily\bfseries}
\newcommand*\QCMAEManuelFont{\fontsize{9.5}{10.5}\sffamily}
\newcommand*\QCMAETextAfterTitleFont{\bfseries}
\newcommand*\QCMExoNumFont{\fontsize{9.5}{14.4}\sffamily\bfseries}
\newcommand*\QCMItemNumFont{\fontsize{9.5}{14.4}\sffamily\bfseries}
\newcommand*\TPPartieFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\RecreationFont{\fontsize{20}{20}\scriptfamily\bfseries}
\newcommand*\RecreationTitleFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\RecreationPartieFont{\fontsize{10}{14.4}\scshape\bfseries}
\newcommand*\RecreationPartieTitleFont{\fontsize{10}{14.4}\bfseries}
\newcommand*\ListeMethodeChapterFont{\fontsize{40}{40}\sffamily}
\newcommand*\ListeMethodeTitleFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\ListeMethodePageFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\CorrigeTitleFont{\fontsize{40}{40}\sffamily}
\newcommand*\CorrigeChapterFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\CorrigePartieFont{\fontsize{11}{14.4}\sffamily\bfseries}
\newcommand*\CorrigeNumExerciceFont{\fontsize{9.5}{14.4}\sffamily\bfseries}
\newcommand*\CorrigeQCMItemNumFont{\fontsize{9.5}{14.4}\sffamily}
\newcommand*\FootAnnexeTxtFont{\fontsize{11}{14.4}\sffamily}
\newcommand*\FootAnnexePageFont{\fontsize{11}{14.4}\sffamily\bfseries}
\newcommand*\AnnexeTitleFont{\fontsize{35}{35}\sffamily}
\newcommand*\AnnexeSectionTitleFont{\fontsize{14.4}{14.4}\sffamily\bfseries}
\newcommand*\ProprieteFont{\fontsize{10}{14.4}\sffamily}
\newcommand*\NumProprieteFont{\fontsize{10}{14.4}\sffamily\bfseries}
\newcommand*\AnnexePartieFont{\fontsize{10.5}{14.4}\bfseries}
\newcommand*\LexiqueTitleFont{\fontsize{50}{50}\sffamily}
\newcommand*\FirstLetterFont{\fontsize{16}{16}\sffamily\bfseries}
\newcommand*\LexiqueEntreeFont{\fontsize{12}{14.4}\sffamily\bfseries}
\newcommand*\LexiqueFont{\sffamily\upshape\bfseries}
\newcommand*\FootLibrePageFont{\fontsize{11}{14.4}\sffamily\bfseries}
\newcommand*\LibreSectionTitleFont{\fontsize{14.4}{14.4}\sffamily\bfseries}
\newcommand*\LibrePartieFont{\fontsize{10.5}{14.4}\bfseries}
\def\SquareWidth{3mm}
\def\ItemRuleWidth{1.5mm}
\def\ItemRuleHeight{1.5mm}
\def\ItemRuleDepth{0mm}
\def\ListLabelWidth{4mm}
\def\EnumerateLabelWidth{5mm}
\def\ListHSep{2mm}
\def\AlgorithmeRuleWidth{1pt}
\def\AlgorithmeSep{2mm}
\def\AlgorithmeNumWidth{6mm}
\def\HeadFrameWidth{11cm}
\def\RoundHeadFrameWidth{12.8cm}
\def\HeadTitleSep{1cm}
\edef\HeadTitleMaxWidth
     {\the\dimexpr \HeadFrameWidth-\SquareWidth*3-\HeadTitleSep}
\edef\RoundHeadTitleMaxWidth
     {\the\dimexpr \RoundHeadFrameWidth-\SquareWidth*3-\HeadTitleSep}
\edef\HeadFrameHeight{\the\dimexpr \smc@margintop-\smc@headsep}
\def\HeadFrameDepth{3mm}
\def\FootFrameWidth{6mm}
\def\FootFrameSep{1mm}
\def\AlgoIndent{1em}
\def\CadreSep{2mm}
\def\CadreLineWidth{0.5mm}
\def\FrameSep{3mm}
\def\FrameLineWidth{1pt}
\edef\FrameArc{\the\dimexpr \SquareWidth/2}
\def\RuleWidth{1pt}
\def\BeforeCadreVSpace{1.5mm}
\def\AfterCadreVSpace{1.5mm}
\def\BeforeTableVSpace{1.5mm}
\def\AfterTableVSpace{1.5mm}
\def\HabillageGap{2mm}
\def\LogoLineWidth{1pt}
\def\BeforeAlgorithmeVSpace{1.5mm}
\def\AfterAlgorithmeVSpace{1.5mm}
\edef\ChapterTopFrameHeight{\the\dimexpr 2.1cm+\smc@bleed}
\def\ChapterBottomFrameHeight{6cm}
\edef\ChapterTotalFrameHeight{%
  \the\dimexpr\ChapterTopFrameHeight+\ChapterBottomFrameHeight}
\def\ChapterBottomPicture{5.5cm}
\def\ChapterNumLeftFrame{13.4cm}
\AtBeginDocument{%
  \edef\ChapterTitleThemaWidth{%
    \the\dimexpr\linewidth-\ChapterNumLeftFrame-6mm
  }%
}
\def\ChapterNumBase{3.6cm}
\def\ChapterNumBottomFrame{2.1cm}
\edef\ChapterNumTopFrame{\the\dimexpr 8.1cm+\smc@bleed}
\def\ChapterTitleBase{2.1cm}
\def\ChapterTitleSep{1cm}
\def\ThemaBottomFrame{5.7cm}
\def\ThemaTopFrame{6.6cm}
\def\PrerequisTitleVSpace{1mm}
\def\AETitleWidth{8cm}
\edef\AETitleHeight{\the\dimexpr \SquareWidth*3}
\def\AEFrameVSep{4mm}
\edef\AEFrameHSep{\SquareWidth}
\edef\AEFrameRuleWidth{\the\dimexpr\SquareWidth/2}
\edef\AEExoFrameWidth{\the\dimexpr \SquareWidth*2}
\def\AEExoFrameTopSep{1mm}
\def\AfterAEExoFrameHSpace{2mm}
\def\AECartoucheCorrSep{4mm}
\def\AECartoucheCorrHeight{6mm}
\def\AECartoucheCorrWidth{50mm}
\def\AEManuelWidth{55mm}
\def\AEManuelRightSpace{1mm}
\def\AELogoManuelWidth{9mm}
\def\AfterAEManuelVSpace{3mm}
\def\BeforeActiviteVSpace{5mm}
\newdimen\ActiviteTitleTopHeight
\ActiviteTitleTopHeight 6mm
\def\ActiviteTitleBottomHeight{1.5mm}
\def\ActiviteTitleLeftSpace{2mm}
\def\ActiviteTitleRightSpace{1mm}
\def\AfterActiviteTitleHSpace{2mm}
\def\AfterActiviteTitleVSpace{3mm}
\def\BeforeActivitePartieVSpace{1.5mm}
\def\AfterActivitePartieVSpace{1mm}
\def\BeforeSectionVSpace{10mm}
\def\AfterSectionVSpace{2mm}
\def\SectionNumTitleHSpace{3mm}
\def\SectionCorrectionChassePoint{-0.25pt}
\def\BeforeSubsectionVSpace{4mm}
\def\AfterSubsectionVSpace{1mm}
\def\BeforeDefVSpace{3mm}
\def\AfterDefVSpace{1.5mm}
\def\DefFrameHSep{3mm}
\def\DefFrameVSep{1mm}
\def\DefTitleFrameVSep{1mm}
\def\BeforeRemVSpace{3mm}
\def\AfterRemVSpace{1.5mm}
\def\BeforeExempleVSpace{4mm}
\def\ExempleVRuleWidthFrame{1.25mm}
\def\ExempleHRuleWidthFrame{0.75mm}
\def\ExempleWidthFrame{15mm}
\def\ExempleHeightFrame{3mm}
\def\BeforeMethodeVSpace{3mm}
\edef\MethodeTitleLeftSpace{\SquareWidth}
\edef\MethodeTitleRightSpace{\SquareWidth}
\def\MethodeSubtitleLeftSpace{2mm}
\def\AfterMethodeTitleVspace{1.5mm}
\def\MethodeFrameHSep{3mm}
\def\MethodeFrameTopSep{2mm}
\def\MethodeFrameBottomSep{1mm}
\def\ExAppWidthFrame{30mm}
\def\ExAppHeightFrame{3mm}
\def\ExAppDepthFrame{0.75mm}
\def\ExAppCorrWidthFrame{15mm}
\def\ExAppCorrHeightFrame{3mm}
\def\ExAppCorrDepthFrame{0.75mm}
\def\AfterCartoucheHSpace{1.5mm}
\def\AfterExAppMethodeVSpace{3mm}
\def\BeforeProofVSpace{3mm}
\def\AfterProofVSpace{1.5mm}
\def\ProofHeightFrame{3mm}
\def\ProofDepthFrame{0.75mm}
\def\ProofLeftSpace{1mm}
\def\ProofRightSpace{1.5mm}
\def\AfterProofTitleHSpace{1.5mm}
\def\BeforeExercicesTitleVSpace{3mm}
\def\AfterExercicesTitleVSpace{1.5mm}
\def\ExercicesTitleHSep{3mm}
\def\ExercicesTitleVSep{2mm}
\def\BeforeExerciceVSpace{1.5mm}
\def\ExerciceNumFrameWidth{6mm}
\def\ExerciceNumFrameHeight{3.25mm}
\def\ExerciceNumFrameDepth{0.75mm}
\def\ExerciceTextHSep{2mm}
\def\BeforeExercicePartieVSpace{1.5mm}
\def\AfterExercicePartieVSpace{1mm}
\def\AcquisTitleVSpace{1mm}
\def\BeforeQCMAEVSpace{6mm plus2mm minus2mm}
\def\QCMAETitleHeight{9mm}
\def\QCMAETitleWidth{110mm}
\def\QCMAETitleLeftSpace{17mm}
\def\QCMAEManuelWidth{40mm}
\def\QCMAEManuelRightSpace{1mm}
\def\QCMAELogoManuelWidth{9mm}
\def\AfterQCMAEManuelVSpace{0mm}
\def\AfterQCMAETitleVSpace{5mm plus2mm minus1mm}
\def\AfterQCMAETextVSpace{3mm plus1mm minus1mm}
\def\QCMRefHSep{1pt}
\edef\QCMExoFrameWidth{\the\dimexpr \SquareWidth*2}
\def\QCMExoFrameTopSep{1mm}
\def\AfterQCMExoFrameHSpace{2mm}
\def\QCMLabelWidth{6mm}
\def\BeforeQCMVSpace{2mm plus1mm minus1mm}
\def\AfterQCMVSpace{0mm plus1mm}
\def\QCMLineWidth{2mm}
\def\QCMFrameSep{1mm}
\edef\QCMLineArc{\SquareWidth}
\def\BeforeTPPartieVSpace{3mm plus1mm minus1mm}
\def\AfterTPPartieVSpace{0mm plus1mm}
\def\TPPartieHSep{2mm}
\def\BeforeRecreationVSpace{6mm}
\def\AfterRecreationVSpace{3mm}
\def\BeforeRecreationPartieVSpace{1.5mm minus 1mm}
\def\AfterRecreationPartieVSpace{1mm minus 0.5mm}
\def\ListeMethodeRuleWidth{0.2pt}
\def\AfterMethodeVSpace{3pt}
\def\TriangleMethodeSize{1ex}
\def\CorrigeRuleWidth{0.2pt}
\def\CorrigeHeadFrameWidth{9mm}
\def\CorrigeChapterFrameHeight{5mm}
\def\BeforeCorrigePartieTitleVSpace{1mm minus 0.5mm}
\def\BeforeCorrigeChapterVspace{3mm plus1mm minus1mm}
\def\QCMHSep{1mm}
\def\BeforeAnnexeTitleVSpace{-20mm}
\def\AfterAnnexeTitleVSpace{0mm plus0.5mm}
\edef\AnnexeSectionRuleWidth{\SquareWidth}
\def\AnnexeSectionRuleHSpace{1mm}
\def\BeforeAnnexeSectionVSpace{5mm}
\def\AfterAnnexeSectionVSpace{2mm}
\def\BeforeAnnexePartieVSpace{1.5mm}
\def\AfterAnnexePartieVSpace{1mm}
\def\LexiqueRuleWidth{0.2pt}
\def\AfterFirstLetterVSpace{2mm}
\def\BeforeFirstLetterVSpace{2mm}
\def\FirstLetterFrameHSep{1mm}
\def\AfterEntreeVSpace{5mm}
\edef\LibreSectionRuleWidth{\SquareWidth}
\def\LibreSectionRuleHSpace{1mm}
\def\BeforeLibreSectionVSpace{5mm}
\def\AfterLibreSectionVSpace{2mm}
\def\BeforeLibrePartieVSpace{1.5mm}
\def\AfterLibrePartieVSpace{1mm}
\newcommand*\StringColitemize{colitemize}
\newcommand*\StringColenumerate{colenumerate}
\newcommand*\StringPrerequis{Connaissances du coll\`ege
  n\'ecessaires \`a ce chapitre}
\newcommand*\StringActivitesApproche{Activit\'es d'approche}
\newcommand*\StringCoursMethodes{Cours~-~M\'ethodes}
\newcommand*\StringExercicesBase{S'entra\^iner}
\newcommand*\StringExercicesAppr{Approfondir}
\newcommand*\StringTestConnaissances{Je teste mes connaissances}
\newcommand*\StringConnaissances{Auto-\'evaluation QCM}
\newcommand*\StringTravauxPratiques{Travaux pratiques}
\newcommand*\StringAE{Auto-\'evaluation}
\newcommand*\StringVoirCorriges{Voir solutions p.}
\newcommand*\StringManuel{Des ressources num\'eriques pour pr\'eparer
  le chapitre sur
  \textcolor{U4}{\LogoURLManuelFont manuel.sesamath.net}}
\newcommand*\StringALGO{ALGO}
\newcommand*\StringTICE{INFO}
\newcommand*\StringRecreation{R\'ecr\'eation, \'enigmes}
\newcommand*\StringAcquisTitle{\`A la fin de ce chapitre, je dois
  \^etre capable de\,:}
\newcommand*\StringQCMAE{QCM d'auto-\'evaluation}
\newcommand*\StringQCM{QCM}
\newcommand*\StringChapitre{Chapitre}
\newcommand*\StringEnigme{\'Enigme}
\newcommand*\StringPropriete{Propri\'et\'e}
\newcommand*\StringPROPRIETE{PROPRI\'ET\'E}
\newcommand*\StringDEFINITION{D\'EFINITION}
\newcommand*\StringTHEOREME{TH\'EOR\`EME}
\newcommand*\StringLexique{Lexique}
\newcommand*\LogoManuel{\textcolor{U4}{\LogoManuelFont @}}
\newcommand\StringDEBAT{D\'EBAT}
\newcommand\StringACTIVITE{ACTIVIT\'E}
\newcommand\StringTP{TP}
\newcommand*\StringExemple{Exemple}
\newcommand*\StringCorrection{Correction}
\newcommand*\StringMETHODE{M\'ETHODE}
\newcommand*\StringPREUVE{PREUVE}
\newcommand*\StringMethode{M\'ethode}
\newcommand*\StringExApp{Exercice d'application}
\newcommand*\StringPartie{Partie}
\newcommand*\StringListeMethode{Liste des m\'ethodes}
\newcommand*\StringCorriges{Solutions}
\newcommand*\StringListeMethodeF{Fonctions}
\newcommand*\StringListeMethodeG{G\'eom\'etrie}
\newcommand*\StringListeMethodeSP{Stat. et probabilit\'es}
\def\smc@diagonal(#1,#2)#3{%
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1, \dimexpr #2)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#32Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#31Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#34Color]
          (\dimexpr #1, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#32Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#35Color]
          (\dimexpr #1, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*3)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#34Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*3)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth*3)
  \ignorespaces
}
\def\smc@antidiagonal(#1,#2)#3{%
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#31Color]
          (\dimexpr #1, \dimexpr #2)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#32Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#32Color]
          (\dimexpr #1, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#34Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth*2)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#33Color]
          (\dimexpr #1, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*3)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#34Color]
          (\dimexpr #1+\SquareWidth, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*3)
  \psframe[linewidth=0pt, linestyle=none, fillcolor=#35Color]
          (\dimexpr #1+\SquareWidth*2, \dimexpr #2+\SquareWidth*2)
          (\dimexpr #1+\SquareWidth*3, \dimexpr #2+\SquareWidth*3)
  \ignorespaces
}
\def\smc@rounddiagonal(#1,#2)#3{%
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#32Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#31Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#34Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#32Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#35Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#34Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \ignorespaces
}
\def\smc@roundantidiagonal(#1,#2)#3{%
  \pscircle*[linecolor=#31Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#32Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#32Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#34Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#33Color]
          (\dimexpr #1+\SquareWidth/2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#34Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \pscircle*[linecolor=#35Color]
          (\dimexpr #1+\SquareWidth/2+\SquareWidth*2,
           \dimexpr #2+\SquareWidth/2+\SquareWidth*2)
          {\dimexpr \SquareWidth/2}
  \ignorespaces
}
\newcommand*\themaF{%
  \cleardoubleoddpage
  \def\smc@thema{fonctions}%
  \def\smc@themacap{FONCTIONS}%
  \def\smc@thema@init{f}%
  \def\smc@thema@initcap{F}%
  \smc@themaFColor
  \setcounter{chapter}{0}%
}
\newcommand*\smc@themaFColor{%
  \def\CorrigeChapterFrameColor{PartieFonction}%
  \def\CorrigeChapterTextColor{Blanc}%
  \colorlet{ChapterNumFrameColor}{PartieFonction}%
  \colorlet{FootTitleHeadColor}{PartieFonction}%
  \colorlet{ChapterTopFrameColor}{A3}%
  \colorlet{ChapterNumSquare4Color}{A3}%
  \colorlet{ChapterNumSquare5Color}{PartieFonction}%
  \colorlet{FirstChapterFootColor}{FootFonctionColor}%
}
\newcommand*\themaG{%
  \cleardoubleoddpage
  \def\smc@thema{g\'eom\'etrie}%
  \def\smc@themacap{G\'EOM\'ETRIE}%
  \def\smc@thema@init{g}%
  \def\smc@thema@initcap{G}%
  \smc@themaGColor
  \setcounter{chapter}{0}%
}
\newcommand*\smc@themaGColor{%
  \def\CorrigeChapterFrameColor{PartieGeometrie}%
  \def\CorrigeChapterTextColor{Blanc}%
  \colorlet{ChapterNumFrameColor}{PartieGeometrie}%
  \colorlet{FootTitleHeadColor}{PartieGeometrie}%
  \colorlet{ChapterTopFrameColor}{G3}%
  \colorlet{ChapterNumSquare4Color}{G3}%
  \colorlet{ChapterNumSquare5Color}{PartieGeometrie}%
  \colorlet{FirstChapterFootColor}{FootGeometrieColor}%
}
\newcommand*\themaS{%
  \cleardoubleoddpage
  \def\smc@thema{statistiques\\probabilit\'es}%
  \def\smc@themacap{STATISTIQUES\\PROBABILIT\'ES}%
  \def\smc@thema@init{sp}%
  \def\smc@thema@initcap{SP}%
  \smc@themaSColor
  \setcounter{chapter}{0}%
}
\newcommand*\smc@themaSColor{%
  \def\CorrigeChapterFrameColor{PartieStatistique}%
  \def\CorrigeChapterTextColor{Blanc}%
  \colorlet{ChapterNumFrameColor}{PartieStatistique}%
  \colorlet{FootTitleHeadColor}{PartieStatistique}%
  \colorlet{ChapterTopFrameColor}{U2}%
  \colorlet{ChapterNumSquare4Color}{U2}%
  \colorlet{ChapterNumSquare5Color}{PartieStatistique}%
  \colorlet{FirstChapterFootColor}{FootStatistiqueColor}%
}
\newcommand*\themaL{%
  \def\smc@thema{}%
  \def\smc@themacap{}%
  \def\smc@thema@init{l}%
  \def\smc@thema@initcap{L}%
  \smc@themaLColor
  \setcounter{chapter}{0}%
}
\newcommand*\smc@themaLColor{%
  \def\CorrigeChapterFrameColor{Blanc}%
  \def\CorrigeChapterTextColor{Blanc}%
  \colorlet{ChapterNumFrameColor}{Blanc}%
  \colorlet{FootTitleHeadColor}{Blanc}%
  \colorlet{ChapterTopFrameColor}{Blanc}%
  \colorlet{ChapterNumSquare4Color}{Blanc}%
  \colorlet{ChapterNumSquare5Color}{Blanc}%
  \colorlet{FirstChapterFootColor}{Blanc}%
}
\newcommand*\NewThema[7]{%
  \ifcsname thema#1\endcsname
    \ClassError{sesamanuel}
               {le theme \string\thema#1 existe deja}
               {Vous ne pouvez pas creer un theme deja existant.}%
  \else
    \protected@write\@auxout{}
      {%
        \protect\expandafter
        \protect\newif \protect\csname ifsmc@lom#2\protect\endcsname
      }%
    \expandafter \newif \csname ifsmc@lom#2\endcsname
    \@namedef{smc@thema#1Color}{%
      \def\CorrigeChapterFrameColor{#6}%
      \def\CorrigeChapterTextColor{Blanc}%
      \colorlet{ChapterNumFrameColor}{#6}%
      \colorlet{FootTitleHeadColor}{#6}%
      \colorlet{ChapterTopFrameColor}{#7}%
      \colorlet{ChapterNumSquare4Color}{#7}%
      \colorlet{ChapterNumSquare5Color}{#6}%
      \colorlet{FirstChapterFootColor}{#7}%
    }%
    \expandafter\def\csname thema#1\endcsname{%
      \cleardoubleoddpage
      \def\smc@thema{#3}%
      \edef\smc@themacap{#5}%
      \def\smc@thema@init{#2}%
      \def\smc@thema@initcap{#1}%
      \def\CorrigeChapterFrameColor{#6}%
      \expandafter\def\csname StringListeMethode#1\endcsname{#4}%
      \def\CorrigeChapterTextColor{Blanc}%
      \colorlet{ChapterNumFrameColor}{#6}%
      \colorlet{FootTitleHeadColor}{#6}%
      \colorlet{ChapterTopFrameColor}{#7}%
      \colorlet{ChapterNumSquare4Color}{#7}%
      \colorlet{ChapterNumSquare5Color}{#6}%
      \colorlet{FirstChapterFootColor}{#7}%
    }%
  \fi
}
\newcommand\smc@fixwidth[2]{%
  \smc@dima=0pt
  \expandafter\smc@@width#2\\\@nil\\%
  \setbox0=\hbox{%
    \minipage[b]{\smc@dima}
      #2%
    \endminipage
  }%
  \smc@dima=\dimexpr\ht0+\dp0\relax
  \psscaleboxto(#1,\the\smc@dima){%
    \unhbox0
  }%
  \ignorespaces
}
\def\smc@@width#1\\{%
  \def\smc@arg{#1}%
  \unless\ifx\smc@arg\@nnil
    \setbox0=\hbox{#1}%
    \ifdim\wd0>\smc@dima
      \smc@dima=\wd0\relax
    \fi
    \expandafter\smc@@width
  \fi
}
\newcommand\smc@fixwidthcenter[2]{%
  \smc@dima=0pt
  \expandafter\smc@@width#2\\\@nil\\%
  \setbox0=\hbox{%
    \minipage[b]{\smc@dima}
      \centering
      #2%
    \endminipage
  }%
  \smc@dima=\dimexpr\ht0+\dp0\relax
  \psscaleboxto(#1,\the\smc@dima){%
    \unhbox0
  }%
  \ignorespaces
}
\renewcommand*\@makechapterhead[1]{%
  \def\smc@chaptertitle{#1}%
    \addtocontents{cor}{%
      \protect\smc@corrigechapter{%
        \StringChapitre{}
        \smc@thema@initcap\the\c@chapter}
      {\smc@chaptertitle}%
      {\CorrigeChapterFrameColor}%
      {\CorrigeChapterTextColor}%
    }%
  \begin{pspicture}(0,0)(\linewidth,\ChapterBottomPicture)
    \psset{linewidth=0pt,linestyle=none,fillstyle=solid}
    \psframe[fillcolor=ChapterTopFrameColor]
            (\dimexpr-\smc@bleed-\smc@marginleft,\ChapterBottomFrameHeight)
            (\dimexpr\linewidth+\smc@marginright+\smc@bleed,
             \ChapterTotalFrameHeight)
    \psframe[fillcolor=ChapterBottomFrameColor]
            (\dimexpr-\smc@bleed-\smc@marginleft,0)
            (\dimexpr\linewidth+\smc@marginright+\smc@bleed,
            \ChapterBottomFrameHeight)
    \psframe[fillcolor=ChapterNumBkgColor]
            (\ChapterNumLeftFrame,0)
            (\linewidth,\ChapterTotalFrameHeight)
    \psframe[fillcolor=ChapterNumFrameColor]
            (\ChapterNumLeftFrame,\ChapterNumBottomFrame)
            (\linewidth,\ChapterNumTopFrame)
    \smc@antidiagonal(\ChapterNumLeftFrame,\ChapterNumBottomFrame)
                     {ChapterNumSquare}
    \rput[B](\dimexpr \linewidth/2+\ChapterNumLeftFrame/2,
                       \ChapterBottomFrameHeight)
            {\textcolor{ThemaTitleColor}
                       {%
                         \ChapAppFont
                         \smc@fixwidthcenter{\ChapterTitleThemaWidth}
                                            {\smc@themacap}%
                       }%
                     }
    \rput[B](\dimexpr \linewidth/2+\ChapterNumLeftFrame/2,
                       \ChapterNumBase)
            {\textcolor{ChapterNumColor}
                       {\ChapterNumFont \thechapter}}
    \rput[Bl](0,\ChapterTitleBase){%
      \begin{minipage}[b]{\dimexpr\ChapterNumLeftFrame-\ChapterTitleSep}
        \ChapterTitleFont \color{ChapterTitleColor}#1%
      \end{minipage}
    }
  \end{pspicture}
  \thispagestyle{firstchapter}
}
\newenvironment{prerequis}[1][\StringPrerequis]
{%
  \par\vspace*{\stretch{1}}
  \let\itemize\smc@prerequisitemize
  \let\enditemize\endsmc@prerequisitemize
  \let\colitemize\smc@prerequiscolitemize
  \let\endcolitemize\endsmc@prerequiscolitemize
  \let\enumerate\smc@prerequisenumerate
  \let\endenumerate\endsmc@prerequisenumerate
  \let\colenumerate\smc@prerequiscolenumerate
  \let\endcolenumerate\endsmc@prerequiscolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Prerequis}%
  {%
    \PrerequisTitleFont
    \textcolor{PrerequisTitleColor}{#1}%
    \par\vspace{\PrerequisTitleVSpace}%
  }%
  \edef\FrameSep{\SquareWidth}%
  \smc@cadre{PrerequisBkgColor}
    \vspace*{-4.5pt}
    \begin{multicols}{2}
      \PrerequisTextFont
}
{%
    \end{multicols}%
  \endsmc@cadre
  \par
}
\newenvironment{autoeval}
{%
  \addtocontents{cor}{\protect\smc@corrigeautoeval}%
  \par\vspace{\stretch{1}}
  \begingroup
    \linewidth=\AETitleWidth
    \def\FrameSep{0pt}%
    \edef\FrameArc{\the\dimexpr \SquareWidth/2}%
    \def\FrameLineWidth{0pt}%
    \begin{smc@cadre}[0,0,10,10]{AETitleFrame1Color}%
      \minipage[b][\AETitleHeight]{\AETitleWidth}%
        \begin{pspicture}(0,0)(\dimexpr\SquareWidth*3,\dimexpr\SquareWidth*2)
          \smc@rounddiagonal(0mm,0mm){AETitleFrame}%
        \end{pspicture}%
        \hspace*{\stretch{1}}%
        \AETitleFont
        \raisebox{\dimexpr\SquareWidth*3/4}{\textcolor{AETitleColor}{\StringAE}}%
        \hspace*{\stretch{1}}%
      \endminipage
    \end{smc@cadre}
  \endgroup
  \hspace*{\stretch{1}}%
  \begin{minipage}[b]{\AEManuelWidth}
    \raggedright
    \AEManuelFont
    \StringManuel
    \par\vspace*{\AfterAEManuelVSpace}
  \end{minipage}%
  \hspace{\AEManuelRightSpace}%
  \raisebox{\AfterAEManuelVSpace}
           {\psscaleboxto(\AELogoManuelWidth,0){\LogoManuel}}%
  \\[-1pt]
  \let\itemize\smc@AEitemize
  \let\enditemize\endsmc@AEitemize
  \let\colitemize\smc@AEcolitemize
  \let\endcolitemize\endsmc@AEcolitemize
  \let\enumerate\smc@AEenumerate
  \let\endenumerate\endsmc@AEenumerate
  \let\colenumerate\smc@AEcolenumerate
  \let\endcolenumerate\endsmc@AEcolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@AEexercice
  \let\endexercice\endsmc@AEexercice
  \let\corrige\smc@AEcorrige
  \let\endcorrige\endsmc@AEcorrige
  \def\smc@currpart{AE}%
  \begin{lrbox}{\smc@boxa}
    \minipage[b]{\dimexpr\linewidth-\AEFrameHSep*2}%
    \ignorespaces
}
{%
      \par
      \vspace*{\dimexpr\AECartoucheCorrSep+\AECartoucheCorrHeight-\SquareWidth}
      \hspace*{\stretch{1}}%
    \endminipage
  \end{lrbox}%
  \psframebox[framesep=\the\dimexpr\AEFrameHSep-\AEFrameRuleWidth,
    linewidth=\AEFrameRuleWidth, linecolor=AEFrameColor]{\box\smc@boxa}%
  \hspace*{-\AECartoucheCorrWidth}%
  \raisebox{-\SquareWidth}{%
    \begin{pspicture}(0,0)(\AECartoucheCorrWidth,0)
      \psframe*[linecolor=AECartoucheCorrBkgColor,
                cornersize=absolute, linearc=\dimexpr\SquareWidth/2]
               (0,0)(\AECartoucheCorrWidth,\AECartoucheCorrHeight)
      \psframe*[linecolor=AECartoucheCorrBkgColor]
               (0,0)(\AECartoucheCorrWidth,3mm)
      \psframe*[linecolor=AECartoucheCorrBkgColor]
               (3mm,0)(\AECartoucheCorrWidth,\AECartoucheCorrHeight)
      \rput(\dimexpr\AECartoucheCorrWidth/2,\dimexpr\AECartoucheCorrHeight/2)
      {%
        \AECartoucheCorrArrowFont
        \textcolor{AECartoucheCorrArrowColor}
                  {\ding{228}\ding{228}\ding{228}}
        \AECartoucheCorrVCPFont
        \textcolor{AECartoucheCorrVCPColor}
                  {\StringVoirCorriges\space\pageref{toutes-solutions}}%
      }%
    \end{pspicture}%
  }%
}
\newcounter{AEexo}[chapter]
\newenvironment{smc@AEexercice}{%
  \par
  \refstepcounter{AEexo}%
  \psframebox*[linestyle=none, linewidth=0pt,
               fillcolor=AEExoNumFrameColor, framesep=\AEExoFrameTopSep]{%
    \hbox to\dimexpr\AEExoFrameWidth-\AEExoFrameTopSep*2{%
      \hss
      \AEExoNumFont
      \textcolor{AEExoNumColor}{\theAEexo}%
      \hss
    }%
  }%
  \hspace{\AfterAEExoFrameHSpace}%
  \ignorespaces
}
{\par}
\newcommand*\activites{%
  \clearpage
  \pagestyle{activites}
  \addtocontents{cor}{\protect\smc@corrigeactivite}%
  \let\itemize\smc@noitemize
  \let\enditemize\endsmc@noitemize
  \let\colitemize\smc@nocolitemize
  \let\endcolitemize\endsmc@nocolitemize
  \let\enumerate\smc@noenumerate
  \let\endenumerate\endsmc@noenumerate
  \let\colenumerate\smc@nocolenumerate
  \let\endcolenumerate\endsmc@nocolenumerate
  \let\exercice\smc@noexercice
  \let\correction\smc@nocorrection
  \let\partie\smc@activite@partie
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@activitecorrige
  \let\endcorrige\endsmc@activitecorrige
  \def\smc@currpart{Activite}%
}
\newcounter{activite}[chapter]
\newcounter{partie}[activite]
\newcommand*\DeclareActivityLike[5]{%
  \expandafter\newcommand\csname#1\endcsname[1][]{%
    \def\smc@activite@title{##1}%
    \csname#1@aux\endcsname
  }%
  \expandafter\newcommand\csname#1@aux\endcsname[1][]{%
    \par
    \addvspace{\BeforeActiviteVSpace}
    \refstepcounter{activite}
    \setbox\smc@boxa=\hbox{%
      \ActiviteTitleFont
      #2%
    }%
    \begin{pspicture}(0,0)
      (\dimexpr \ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+1.4142\ActiviteTitleTopHeight,\ActiviteTitleTopHeight)
      \psframe*[linewidth=0, linecolor= #3]
        (0,0)(\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+0.7071\ActiviteTitleTopHeight,
              \ActiviteTitleTopHeight)
      \psframe*[linewidth=0, linecolor= #4]
        (0,0)(\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+0.7071\ActiviteTitleTopHeight,
              -\ActiviteTitleBottomHeight)
      \rput[l](\ActiviteTitleLeftSpace,
               0.5\dimexpr\ActiviteTitleTopHeight-\ActiviteTitleBottomHeight){%
        \ActiviteTitleFont
        \textcolor{#5}{#2}%
      }
      \rput
        (\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace,
         0.5\dimexpr\ActiviteTitleTopHeight-\ActiviteTitleBottomHeight)
      {%
        \pspolygon*[linewidth=0, linecolor=#5]
          (0,0)
          (0.7071\ActiviteTitleTopHeight,0.7071\ActiviteTitleTopHeight)
          (1.4142\ActiviteTitleTopHeight,0)
          (0.7071\ActiviteTitleTopHeight,-0.7071\ActiviteTitleTopHeight)
        \rput(0.7071\ActiviteTitleTopHeight,0){%
          \ActiviteNumFont
          \textcolor{ActiviteNumColor}{\theactivite}%
        }
      }
    \end{pspicture}%
    \hspace*{\AfterActiviteTitleHSpace}%
    \@ifmtarg{##1}
      {\setbox0=\hbox{}}
      {\setbox0=\hbox{##1\ }}%
    \minipage[t]{\dimexpr\linewidth-\ActiviteTitleLeftSpace-\wd\smc@boxa-\ActiviteTitleRightSpace-1.4142\ActiviteTitleTopHeight-\AfterActiviteTitleHSpace-\wd0}
      \ActiviteSubtitleFont
      \textcolor{ActiviteSubtitleColor}{\smc@activite@title}%
    \endminipage
    \@ifnotmtarg{##1}{\hfill##1}%
    \par\vspace{\AfterActiviteTitleVSpace}
    \let\itemize\smc@activiteitemize
    \let\enditemize\endsmc@activiteitemize
    \let\colitemize\smc@activitecolitemize
    \let\endcolitemize\endsmc@activitecolitemize
    \let\enumerate\smc@activiteenumerate
    \let\endenumerate\endsmc@activiteenumerate
    \let\colenumerate\smc@activitecolenumerate
    \let\endcolenumerate\endsmc@activitecolenumerate
    \let\partie\smc@activite@partie
    \let\exercice\smc@noexercice
    \let\endexercice\endsmc@noexercice
    \let\corrige\smc@nocorrige
    \let\endcorrige\endsmc@nocorrige
    \def\smc@currpart{Activite}%
    \begin{changemargin}{\dimexpr\SquareWidth*4}{\ExtraMarginRight}
  }%
  \expandafter\def\csname end#1\endcsname{%
    \end{changemargin}
  }%
}
\DeclareActivityLike{debat}{\StringDEBAT}
                    {ActiviteDebatTopColor}
                    {ActiviteDebatBottomColor}
                    {ActiviteTitleColor}
\DeclareActivityLike{activite}{\StringACTIVITE}
                    {ActiviteActiviteTopColor}
                    {ActiviteActiviteBottomColor}
                    {ActiviteTitleColor}
\newcommand*\cours{%
  \clearpage
  \pagestyle{cours}
  \let\itemize\smc@noitemize
  \let\enditemize\endsmc@noitemize
  \let\colitemize\smc@nocolitemize
  \let\endcolitemize\endsmc@nocolitemize
  \let\enumerate\smc@noenumerate
  \let\endenumerate\endsmc@noenumerate
  \let\colenumerate\smc@nocolenumerate
  \let\endcolenumerate\endsmc@nocolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@nopartie
  \def\smc@currpart{Cours}%
}
\renewcommand\thesection{\arabic{section}}
\renewcommand*\section{\@ifstar{\smc@sec}{\smc@sec}}
\newcommand*\smc@sec[2][]{%
  \ifx\relax#1\relax
    \smc@@sec{#2}{#2}%
  \else
    \smc@@sec{#1}{#2}%
  \fi
}
\newcommand*\smc@@sec[2]{%
  \par\goodbreak\addvspace{\BeforeSectionVSpace}%
  \refstepcounter{section}%
  \relax
  \setbox\smc@boxa=\hbox{%
    \begin{pspicture}[shift=-\SquareWidth]
                     (0,0)(\dimexpr\SquareWidth*3,\dimexpr\SquareWidth*3)
      \psframe*[linecolor=SectionFrame1Color,linewidth=0pt]
               (0,0)(\dimexpr\SquareWidth*3,\dimexpr\SquareWidth*3)
      \psframe*[linecolor=SectionFrame2Color,linewidth=0pt]
               (0,0)(\SquareWidth,\dimexpr\SquareWidth*3)
      \psframe*[linecolor=SectionFrame2Color,linewidth=0pt]
               (0,0)(\dimexpr\SquareWidth*3,\SquareWidth)
      \psframe*[linecolor=SectionFrame3Color,linewidth=0pt]
               (0,0)(\SquareWidth,\SquareWidth)
      \rput[Br](\dimexpr\SquareWidth*3,\SquareWidth){%
        \SectionNumFont
        \textcolor{SectionNumColor}{\thesection}%
        \SectionNumFont
        \textcolor{SectionNumColor}{.}%
        \hspace*{\SectionCorrectionChassePoint}%
      }
    \end{pspicture}%
    \hspace{\SectionNumTitleHSpace}%
    \begin{minipage}[t]{\dimexpr\linewidth-\SectionNumTitleHSpace-\SquareWidth*3}
      \SectionTitleFont
      \textcolor{SectionTitleColor}{#2}%
    \end{minipage}%
  }%
  \smc@dima=\dimexpr \ht\smc@boxa-\SquareWidth
  \ht\smc@boxa \smc@dima
  \leavevmode\box\smc@boxa
  \par\nobreak\addvspace{\AfterSectionVSpace}
}
\let\smc@normalsection\section
\newcommand*\RestoreSection{\let\section\smc@normalsection}
\renewcommand{\thesubsection}{\Alph{subsection}}
\renewcommand\subsection{\@ifstar{\smc@subsec}{\smc@subsec}}
\newcommand*\smc@subsec[2][]{%
  \ifx\relax#1\relax
    \smc@@subsec{#2}{#2}%
  \else
    \smc@@subsec{#1}{#2}%
  \fi
}
\newcommand*\smc@@subsec[2]{%
  \ifdim\lastskip=\AfterSectionVSpace
  \par\nobreak
  \else
  \par\goodbreak\addvspace{\BeforeSubsectionVSpace}
  \fi
  \refstepcounter{subsection}%
  \relax
  \setbox\smc@boxa=\hbox{%
    \SubsectionNumFont
    \textcolor{SubsectionNumColor}{\thesubsection.~}%
  }%
  \leavevmode\copy\smc@boxa
  \begin{minipage}[t]{\dimexpr\linewidth-\wd\smc@boxa}
    \SubsectionTitleFont
    \textcolor{SubsectionTitleColor}{#2}%
  \end{minipage}
  \par\nobreak\addvspace{\AfterSubsectionVSpace}
}
\newcommand*\smc@error@section[1]{%
  \ClassError{sesamanuel}{La commande \string#1 n'existe pas}{Les seules
    commandes disponibles sont \string\chapter\space
    \string\section\space et \string\subsection.}%
}
\renewcommand\part{%
  \@ifstar{\smc@part}{\smc@part}%
}
\newcommand\smc@part[2][]{%
  \smc@error@section{\part}%
}
\renewcommand\subsubsection{%
  \@ifstar{\smc@subsubsection}{\smc@subsubsection}%
}
\newcommand\smc@subsubsection[2][]{%
  \smc@error@section{\subsubsection}%
}
\renewcommand\paragraph{%
  \@ifstar{\smc@paragraph}{\smc@paragraph}%
}
\newcommand\smc@paragraph[2][]{%
  \smc@error@section{\paragraph}%
}
\renewcommand\subparagraph{%
  \@ifstar{\smc@subparagraph}{\smc@subparagraph}%
}
\newcommand\smc@subparagraph[2][]{%
  \smc@error@section{\subparagraph}%
}
\newcommand*\DeclareDefLike[2]{%
  \newenvironment{#1}[1][]{%
    \par\addvspace{\BeforeDefVSpace}
    \let\itemize\smc@defitemize
    \let\enditemize\endsmc@defitemize
    \let\colitemize\smc@defcolitemize
    \let\endcolitemize\endsmc@defcolitemize
    \let\enumerate\smc@defenumerate
    \let\endenumerate\endsmc@defenumerate
    \let\colenumerate\smc@defcolenumerate
    \let\endcolenumerate\endsmc@defcolenumerate
    \let\partie\smc@nopartie
    \let\exercice\smc@noexercice
    \let\endexercice\endsmc@noexercice
    \let\corrige\smc@nocorrige
    \let\endcorrige\endsmc@nocorrige
    \def\smc@currpart{#1}%
    \hspace*{\dimexpr\SquareWidth*2}%
    \textcolor{DefSquareColor}{\rule{\SquareWidth}{\SquareWidth}}%
    \space
    \ifx\relax##1\relax
      {%
        \DefTitleFont
        \textcolor{DefTitleColor}{#2}%
      }%
    \else
      {%
        \DefTitleFont
        \textcolor{DefTitleColor}{#2 : }%
      }%
      {%
        \DefSubtitleFont
        \textcolor{DefSubtitleColor}{##1}%
      }%
    \fi
    \par\nobreak\addvspace{\DefTitleFrameVSep}
    \begin{lrbox}{\smc@boxa}
      \minipage{\dimexpr\linewidth-\SquareWidth*3-\DefFrameHSep*2-\ExtraMarginRight}
        \par\vspace{\DefFrameVSep}
        \ignorespaces
  }
  {%
        \par\vspace{\DefFrameVSep}
      \endminipage
    \end{lrbox}
    {%
      \setlength{\fboxsep}{0pt}%
      \hspace*{\dimexpr\SquareWidth*3}%
      \colorbox{DefFrameColor}{%
        \hspace*{\DefFrameHSep}%
        \usebox{\smc@boxa}%
        \hspace*{\DefFrameHSep}%
      }
    }%
    \par
  }
}
\DeclareDefLike{definition}{\StringDEFINITION}
\DeclareDefLike{propriete}{\StringPROPRIETE}
\DeclareDefLike{theoreme}{\StringTHEOREME}
\newcommand*\DeclareRemLike[2]{%
  \newenvironment{#1}{%
    \par\addvspace{\BeforeRemVSpace}
    \hspace*{\dimexpr\SquareWidth*3+\DefFrameHSep}%
    \let\itemize\smc@remitemize
    \let\enditemize\endsmc@remitemize
    \let\colitemize\smc@remcolitemize
    \let\endcolitemize\endsmc@remcolitemize
    \let\enumerate\smc@remenumerate
    \let\endenumerate\endsmc@remenumerate
    \let\colenumerate\smc@remcolenumerate
    \let\endcolenumerate\endsmc@remcolenumerate
    \let\partie\smc@nopartie
    \let\exercice\smc@noexercice
    \let\endexercice\endsmc@noexercice
    \let\corrige\smc@nocorrige
    \let\endcorrige\endsmc@nocorrige
    \def\smc@currpart{#1}%
    \minipage{\dimexpr\linewidth-\SquareWidth*3-\DefFrameHSep*2-\ExtraMarginRight}
      \strut
      {\RemTitleFont \textcolor{RemTitleColor}{#2 : }}%
      \ignorespaces
  }
  {%
    \endminipage
    \par\addvspace{\AfterRemVSpace}
  }
}
\DeclareRemLike{remarque}{Remarque}
\DeclareRemLike{remarques}{Remarques}
\DeclareRemLike{notation}{Notation}
\DeclareRemLike{notations}{Notations}
\DeclareRemLike{vocabulaire}{Vocabulaire}
\newcommand*\DeclareProofLike[2]{%
  \newenvironment{#1}
  {%
    \par\addvspace{\BeforeProofVSpace}
    \hspace*{\dimexpr\SquareWidth*3}%
    {%
      \color{ProofRuleColor}%
      \vrule width \RuleWidth
    }
    \hspace*{\dimexpr \SquareWidth-\RuleWidth}%
    \let\itemize\smc@proofitemize
    \let\enditemize\endsmc@proofitemize
    \let\colitemize\smc@proofcolitemize
    \let\endcolitemize\endsmc@proofcolitemize
    \let\enumerate\smc@proofenumerate
    \let\endenumerate\endsmc@proofenumerate
    \let\colenumerate\smc@proofcolenumerate
    \let\endcolenumerate\endsmc@proofcolenumerate
    \let\partie\smc@nopartie
    \let\exercice\smc@noexercice
    \let\endexercice\endsmc@noexercice
    \let\corrige\smc@nocorrige
    \let\endcorrige\endsmc@nocorrige
    \def\smc@currpart{#1}%
    \minipage{\dimexpr\linewidth-\SquareWidth*4-\ExtraMarginRight}
      \setbox\smc@boxa=\hbox{%
        \hspace*{\dimexpr\ProofHeightFrame+\ProofLeftSpace}%
        \ProofTitleFont
        \textcolor{ProofTitleColor}{#2}%
        \hspace*{\ProofRightSpace}%
      }%
      \begin{pspicture}(0,0)(\wd\smc@boxa,\ProofHeightFrame)
        \psframe*[linestyle=none,linecolor=ProofBottomFrameColor]
                 (0,-\ProofDepthFrame)(\wd\smc@boxa,0)
        \psframe*[linestyle=none,linecolor=ProofTopFrameColor]
                 (0,0)(\wd\smc@boxa,\ProofHeightFrame)
        \pspolygon*[linestyle=none,linecolor=ProofTriangleFrameColor]
                 (0,0)(0,\ProofHeightFrame)(\ProofHeightFrame,\ProofHeightFrame)
        \rput[Bl](\dimexpr\ProofHeightFrame+\ProofLeftSpace,0){%
          \ProofTitleFont
          \textcolor{ProofTitleColor}{#2}%
        }
      \end{pspicture}%
      \hspace{\AfterProofTitleHSpace}%
      \ignorespaces
  }
  {%
    \endminipage
    \par\addvspace{\AfterProofVSpace}
  }
}
\DeclareProofLike{preuve}{\StringPREUVE}
\newcommand*\smc@cartoucheexemple{%
  \begin{pspicture}(-\ExempleVRuleWidthFrame,0)
                 (\ExempleWidthFrame,\ExempleHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExempleEdgeFrameColor]
             (-\ExempleVRuleWidthFrame,-\ExempleHRuleWidthFrame)
             (\ExempleWidthFrame,\ExempleHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExempleBkgFrameColor]
             (0mm,-0mm)(\ExempleWidthFrame,\ExempleHeightFrame)
    \rput[B](\dimexpr\ExempleWidthFrame/2,0){%
      \ExempleTitleFont
      \textcolor{ExempleTitleColor}{\StringExemple}%
    }
  \end{pspicture}%
}
\newcommand*\smc@cartouchecorrection{%
  \begin{pspicture}(-\ExempleVRuleWidthFrame,0)
                   (\ExempleWidthFrame,\ExempleHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExempleEdgeFrameColor]
             (-\ExempleVRuleWidthFrame,-\ExempleHRuleWidthFrame)
             (\ExempleWidthFrame,\ExempleHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExempleBkgFrameColor]
             (0mm,-0mm)(\ExempleWidthFrame,\ExempleHeightFrame)
    \rput[B](\dimexpr\ExempleWidthFrame/2,0){%
      \ExempleTitleFont
      \textcolor{ExempleTitleColor}{\StringCorrection}%
    }
  \end{pspicture}%
}
\newenvironment{exemple}[1][0.4]{%
  \par\addvspace{\BeforeExempleVSpace}
  \let\correction\smc@exemplecorrection
  \let\itemize\smc@exempleitemize
  \let\enditemize\endsmc@exempleitemize
  \let\colitemize\smc@exemplecolitemize
  \let\endcolitemize\endsmc@exemplecolitemize
  \let\enumerate\smc@exempleenumerate
  \let\endenumerate\endsmc@exempleenumerate
  \let\colenumerate\smc@exemplecolenumerate
  \let\endcolenumerate\endsmc@exemplecolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Exemple}%
  \let\partie\smc@nopartie
  \def\smc@ratio{#1}%
  \hspace*{\dimexpr \SquareWidth*3}%
  \color{ExempleRuleColor}%
  \vrule width \RuleWidth
  \hspace*{\dimexpr \SquareWidth-\RuleWidth}%
  \minipage[t]{\smc@ratio\dimexpr\linewidth-\SquareWidth*6}
    \smc@cartoucheexemple
    \par
    \color{Noir}%
    \ignorespaces
}
{%
  \endminipage
  \par
}
\newenvironment{exemple*1}[1][]{%
  \par\addvspace{\BeforeExempleVSpace}
  \let\correction\smc@one@exemplecorrection
  \let\itemize\smc@exempleitemize
  \let\enditemize\endsmc@exempleitemize
  \let\colitemize\smc@exemplecolitemize
  \let\endcolitemize\endsmc@exemplecolitemize
  \let\enumerate\smc@exempleenumerate
  \let\endenumerate\endsmc@exempleenumerate
  \let\colenumerate\smc@exemplecolenumerate
  \let\endcolenumerate\endsmc@exemplecolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Exemple}%
  \hspace*{\dimexpr \SquareWidth*3}%
  \color{ExempleRuleColor}%
  \vrule width \RuleWidth
  \hspace*{\dimexpr \SquareWidth-\RuleWidth}%
  \minipage[t]{\dimexpr\linewidth-\SquareWidth*4-\ExtraMarginRight}
    \smc@cartoucheexemple
    \space
    \color{Noir}%
    \ignorespaces
}
{%
  \strut
  \endminipage
  \par
}
\newcommand*\smc@nocorrection{%
  \ClassError{sesamanuel}{Vous ne pouvez pas utilisez la macro
    \string\correction\space ici}{Reportez-vous à la documentation
    pour l'utilisation de la macro \string\correction.}%
}
\newcommand*\smc@exemplecorrection{%
  \endminipage
  \hspace{\SquareWidth}%
  \color{ExempleRuleColor}%
  \vrule width \RuleWidth
  \hspace*{\dimexpr \SquareWidth-\RuleWidth}%
  \dimen0=\dimexpr\linewidth-\SquareWidth*6
  \minipage[t]{\dimen0-\smc@ratio\dimen0}%
    \smc@cartouchecorrection
    \par
    \color{Noir}%
    \ignorespaces
}
\newcommand*\smc@one@exemplecorrection{%
  \par
  \smc@cartouchecorrection
  \space
}
\newcounter{methode}[chapter]
\newcommand*\smc@titremethode[1][]{%
  \smc@addtolom{#1}%
  \refstepcounter{methode}%
  {%
    \setlength{\fboxsep}{0pt}%
    \colorbox{MethodeTitleFrameColor}{%
      \hspace*{\MethodeTitleLeftSpace}%
      \textcolor{MethodeTitleColor}{%
        \MethodeTitleFont
        \vrule width0pt height\ht\strutbox depth 1pt
        \StringMETHODE\space \themethode
      }%
      \hspace*{\MethodeTitleRightSpace}%
    }%
  }%
  \ifx\relax#1\relax
  \else
    \hspace{\MethodeSubtitleLeftSpace}%
    \textcolor{MethodeSubtitleColor}{\MethodeSubtitleFont #1}%
  \fi
  \par\vspace{\AfterMethodeTitleVspace}
}
\newcommand*\smc@cartoucheexapp{%
  \begin{pspicture}(0,-\ExAppDepthFrame)
                   (\ExAppWidthFrame,\ExAppHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExAppEdgeFrameColor]
             (0,-\ExAppDepthFrame)
             (\ExAppWidthFrame,\ExAppHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExAppBkgFrameColor]
             (0mm,-0mm)(\ExAppWidthFrame,\ExAppHeightFrame)
    \rput[B](\dimexpr\ExAppWidthFrame/2,0){%
      \ExAppTitleFont
      \textcolor{ExAppTitleColor}{\StringExApp}%
    }
  \end{pspicture}%
}
\newcommand*\smc@cartouchecorr{%
  \begin{pspicture}(0,-\ExAppCorrDepthFrame)
                   (\ExAppCorrWidthFrame,\ExAppCorrHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExAppCorrEdgeFrameColor]
             (0,-\ExAppCorrDepthFrame)
             (\ExAppCorrWidthFrame,\ExAppCorrHeightFrame)
    \psframe*[linewidth=0pt,linecolor=ExAppCorrBkgFrameColor]
             (0mm,-0mm)(\ExAppCorrWidthFrame,\ExAppCorrHeightFrame)
    \rput[B](\dimexpr\ExAppCorrWidthFrame/2,0){%
      \ExAppCorrTitleFont
      \textcolor{ExAppCorrTitleColor}{\StringCorrection}%
    }
  \end{pspicture}%
}
\newenvironment{methode}[1][]{%
  \par\addvspace{\BeforeMethodeVSpace}
  \let\itemize\smc@exappitemize
  \let\enditemize\endsmc@exappitemize
  \let\colitemize\smc@exappcolitemize
  \let\endcolitemize\endsmc@exappcolitemize
  \let\enumerate\smc@exappenumerate
  \let\endenumerate\endsmc@exappenumerate
  \let\colenumerate\smc@exappcolenumerate
  \let\endcolenumerate\endsmc@exappcolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@exappexercice
  \let\correction\smc@exappcorrection
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Methode}%
  \hspace*{\dimexpr\SquareWidth*2}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \SquareWidth
  }%
  \hspace{\SquareWidth}%
  \minipage{\dimexpr\linewidth-\SquareWidth*4}%
    \hspace*{\dimexpr-\SquareWidth*2}%
    \smc@titremethode[#1]%
    \par
    \begin{lrbox}{\smc@boxa}%
      \minipage{\dimexpr\linewidth-\SquareWidth*5-\MethodeFrameHSep*2}%
        \ignorespaces
}
{%
      \endminipage
    \endminipage
  \par
}
\newcommand*\smc@exappexercice[1][0.4]{%
    \endminipage
  \end{lrbox}%
  \def\smc@ratio{#1}%
  \ifdim\dimexpr\ht\smc@boxa+\dp\smc@boxa > 2.4pt
    {%
      \setlength{\fboxsep}{0pt}%
      \ht\smc@boxa=\dimexpr\ht\smc@boxa+\MethodeFrameTopSep
      \dp\smc@boxa=\dimexpr\dp\smc@boxa+\MethodeFrameBottomSep
      \hspace*{-\SquareWidth}%
      \colorbox{MethodeIntroBkgFrameColor}{%
        \hspace*{\MethodeFrameHSep}%
        \usebox{\smc@boxa}%
        \hspace*{\MethodeFrameHSep}%
      }%
      \par\vspace{5mm}
    }%
  \fi
  \minipage[t]{\smc@ratio\dimexpr\linewidth-\SquareWidth*2-\RuleWidth}%
  \smc@cartoucheexapp
  \par
}
\newcommand*\smc@exappcorrection{%
  \endminipage
  \hspace{\SquareWidth}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \RuleWidth
  }%
  \hspace{\SquareWidth}%
  \dimen0=\dimexpr\linewidth-\SquareWidth*2-\RuleWidth
  \minipage[t]{\dimen0-\smc@ratio\dimen0}%
  \smc@cartouchecorr
  \par
}
\newenvironment{methode*1}[1][]{%
  \par\addvspace{\BeforeMethodeVSpace}
  \let\itemize\smc@exappitemize
  \let\enditemize\endsmc@exappitemize
  \let\colitemize\smc@exappcolitemize
  \let\endcolitemize\endsmc@exappcolitemize
  \let\enumerate\smc@exappenumerate
  \let\endenumerate\endsmc@exappenumerate
  \let\colenumerate\smc@exappcolenumerate
  \let\endcolenumerate\endsmc@exappcolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@one@exappexercice
  \let\correction\smc@one@exappcorrection
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Methode}%
  \hspace*{\dimexpr\SquareWidth*2}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \SquareWidth
  }%
  \hspace{\SquareWidth}%
  \minipage{\dimexpr\linewidth-\SquareWidth*4}%
  \hspace*{\dimexpr-\SquareWidth*2}%
  \smc@titremethode[#1]%
  \par
  \begin{lrbox}{\smc@boxa}%
    \minipage{\dimexpr\linewidth-\SquareWidth*5-\MethodeFrameHSep*2}%
    \ignorespaces
}
{%
  \end{changemargin}
  \endminipage
  \par
}
\newcommand*\smc@one@exappexercice[1][]{%
    \endminipage
  \end{lrbox}%
  \ifdim\dimexpr\ht\smc@boxa+\dp\smc@boxa > 2.4pt
    {%
      \setlength{\fboxsep}{0pt}%
      \ht\smc@boxa=\dimexpr\ht\smc@boxa+\MethodeFrameTopSep
      \dp\smc@boxa=\dimexpr\dp\smc@boxa+\MethodeFrameBottomSep
      \hspace*{-\SquareWidth}%
      \colorbox{MethodeIntroBkgFrameColor}{%
        \hspace*{\MethodeFrameHSep}%
        \usebox{\smc@boxa}%
        \hspace*{\MethodeFrameHSep}%
      }%
      \par\vspace{5mm}
    }%
  \fi
  \let\exercice\smc@one@@exappexercice
  \begin{changemargin}{0mm}{\dimexpr\ExtraMarginRight}%
  \smc@cartoucheexapp
  \hspace{\AfterCartoucheHSpace}%
}
\newcommand*\smc@one@exappcorrection{%
  \par\vspace{\AfterExAppMethodeVSpace}
  \smc@cartouchecorr
  \hspace{\AfterCartoucheHSpace}%
}
\newcommand\smc@one@@exappexercice[1][]{%
  \par\vspace{\AfterExAppMethodeVSpace}
  \smc@cartoucheexapp
  \hspace{\AfterCartoucheHSpace}%
}
\newenvironment{methode*2*2}[1][]{%
  \par\addvspace{\BeforeMethodeVSpace}
  \let\itemize\smc@exappitemize
  \let\enditemize\endsmc@exappitemize
  \let\colitemize\smc@exappcolitemize
  \let\endcolitemize\endsmc@exappcolitemize
  \let\enumerate\smc@exappenumerate
  \let\endenumerate\endsmc@exappenumerate
  \let\colenumerate\smc@exappcolenumerate
  \let\endcolenumerate\endsmc@exappcolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@@exappexercice
  \let\correction\smc@@exappcorrection
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Methode}%
  \hspace*{\dimexpr\SquareWidth*2}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \SquareWidth
  }%
  \hspace{\SquareWidth}%
  \minipage{\dimexpr\linewidth-\SquareWidth*4}%
  \hspace*{\dimexpr-\SquareWidth*2}%
  \smc@titremethode[#1]%
  \par
  \begin{lrbox}{\smc@boxa}%
    \minipage{\dimexpr\linewidth-\SquareWidth*5-\MethodeFrameHSep*2}%
    \ignorespaces
}
{%
  \endminipage
  \endminipage
  \par
}
\newcommand*\smc@@exappexercice[1][0.5]{%
    \endminipage
  \end{lrbox}%
  \def\smc@ratio{#1}%
  \ifdim\dimexpr\ht\smc@boxa+\dp\smc@boxa > 2.4pt
    {%
      \setlength{\fboxsep}{0pt}%
      \ht\smc@boxa=\dimexpr\ht\smc@boxa+\MethodeFrameTopSep
      \dp\smc@boxa=\dimexpr\dp\smc@boxa+\MethodeFrameBottomSep
      \hspace*{-\SquareWidth}%
      \colorbox{MethodeIntroBkgFrameColor}{%
        \hspace*{\MethodeFrameHSep}%
        \usebox{\smc@boxa}%
        \hspace*{\MethodeFrameHSep}%
      }%
      \par\vspace{5mm}
    }%
  \fi
  \let\exercice\smc@@@exappexercice
  \minipage[t]{\smc@ratio\dimexpr\linewidth-\SquareWidth*3}%
  \smc@cartoucheexapp
  \hspace{\AfterCartoucheHSpace}%
}
\newcommand\smc@@exappcorrection{%
  \par\vspace{\AfterExAppMethodeVSpace}
  \smc@cartouchecorr
  \hspace{\AfterCartoucheHSpace}%
  \let\correction\smc@@@exappcorrection
}
\newcommand\smc@@@exappexercice{%
  \endminipage
  \hspace{\SquareWidth}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \SquareWidth
  }%
  \hspace{\SquareWidth}%
  \dimen0=\dimexpr\linewidth-\SquareWidth*3
  \minipage[t]{\dimen0-\smc@ratio\dimen0}%
  \smc@cartoucheexapp
  \hspace{\AfterCartoucheHSpace}%
}
\newcommand\smc@@@exappcorrection{%
  \par\vspace{\AfterExAppMethodeVSpace}
  \smc@cartouchecorr
  \hspace{\AfterCartoucheHSpace}%
}
\newenvironment{methode*2}[1][]{%
  \par\addvspace{\BeforeMethodeVSpace}
  \let\itemize\smc@exappitemize
  \let\enditemize\endsmc@exappitemize
  \let\colitemize\smc@exappcolitemize
  \let\endcolitemize\endsmc@exappcolitemize
  \let\enumerate\smc@exappenumerate
  \let\endenumerate\endsmc@exappenumerate
  \let\colenumerate\smc@exappcolenumerate
  \let\endcolenumerate\endsmc@exappcolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@@@@exappexercice
  \let\correction\smc@@@exappcorrection
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Methode}%
  \hspace*{\dimexpr\SquareWidth*2}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \SquareWidth
  }%
  \hspace{\SquareWidth}%
  \minipage{\dimexpr\linewidth-\SquareWidth*4}%
  \hspace*{\dimexpr-\SquareWidth*2}%
  \smc@titremethode[#1]%
  \par
  \begin{lrbox}{\smc@boxa}%
    \minipage{\dimexpr\linewidth-\SquareWidth*5-\MethodeFrameHSep*2}%
    \ignorespaces
}
{%
  \egroup
  \dimen0=\dimexpr (\ht\smc@boxa+\dp\smc@boxa)/2
  \setbox\smc@boxb = \vsplit\smc@boxa to \dimen0
  \hsize \smc@hsize
  \linewidth \smc@linewidth
  \usebox{\smc@boxb}
  \hspace{\SquareWidth}%
  {%
    \color{MethodeRuleColor}%
    \vrule width \RuleWidth
  }%
  \hspace{\SquareWidth}%
  \usebox{\smc@boxa}
  \endminipage
  \par
}
\newcommand*\smc@@@@exappexercice{%
    \endminipage
  \end{lrbox}%
  \ifdim\dimexpr\ht\smc@boxa+\dp\smc@boxa > 2.4pt
    {%
      \setlength{\fboxsep}{0pt}%
      \ht\smc@boxa=\dimexpr\ht\smc@boxa+\MethodeFrameTopSep
      \dp\smc@boxa=\dimexpr\dp\smc@boxa+\MethodeFrameBottomSep
      \hspace*{-\SquareWidth}%
      \colorbox{MethodeIntroBkgFrameColor}{%
        \hspace*{\MethodeFrameHSep}%
        \usebox{\smc@boxa}%
        \hspace*{\MethodeFrameHSep}%
      }%
      \par\vspace{5mm}
    }%
  \fi
  \edef\smc@hsize{\the\hsize}%
  \edef\smc@linewidth{\the\linewidth}%
  \hsize = \dimexpr (\linewidth-\SquareWidth*3-\RuleWidth)/2
  \linewidth = \hsize
  \setbox\smc@boxa = \vbox\bgroup
    \smc@cartoucheexapp
    \hspace{\AfterCartoucheHSpace}%
}
\newenvironment{commentaire}{%
  \let\itemize\smc@commentaireitemize
  \let\enditemize\endsmc@commentaireitemize
  \let\colitemize\smc@commentairecolitemize
  \let\endcolitemize\endsmc@commentairecolitemize
  \let\enumerate\smc@commentaireenumerate
  \let\endenumerate\endsmc@commentaireenumerate
  \let\colenumerate\smc@commentairecolenumerate
  \let\endcolenumerate\endsmc@commentairecolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \begin{changemargin}{\dimexpr\SquareWidth*4}
                      {\dimexpr\ExtraMarginRight+\SquareWidth}
}
{\end{changemargin}}
\newcommand*\exercicesbase{%
  \clearpage
  \pagestyle{exercicesbase}
  \addtocontents{cor}{\protect\smc@corrigeexercicesbase}%
  \let\itemize\smc@exerciceitemize
  \let\enditemize\endsmc@exerciceitemize
  \let\colitemize\smc@exercicecolitemize
  \let\endcolitemize\endsmc@exercicecolitemize
  \let\enumerate\smc@exerciceenumerate
  \let\endenumerate\endsmc@exerciceenumerate
  \let\colenumerate\smc@exercicecolenumerate
  \let\endcolenumerate\endsmc@exercicecolenumerate
  \let\exercice\smc@exobaseexercice
  \let\endexercice\endsmc@exobaseexercice
  \let\corrige\smc@exobasecorrige
  \let\endcorrige\endsmc@exobasecorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@exercice@partie
  \def\smc@currpart{ExoBase}%
}
\newenvironment{colonne*exercice}{%
  \columnsep \dimexpr \SquareWidth*2
  \columnseprule \RuleWidth
  \def\columnseprulecolor{\color{ExerciceColumnRuleColor}}%
  \begin{multicols}{2}%
    \ignorespaces
}
{\end{multicols}}
\newcommand*\serie[1]{%
  \par\addvspace{\BeforeExercicesTitleVSpace}
  \begin{pspicture}(0,-\SquareWidth)
                   (\linewidth,\dimexpr\SquareWidth*2)
    \psframe*[linewidth=0pt,linecolor=ExercicesTitleHRuleColor]
             (0,-\SquareWidth)(\linewidth,0)
    \psframe*[linewidth=0pt,linecolor=ExercicesTitleVRuleColor]
             (0,-\SquareWidth)(\SquareWidth,\dimexpr \SquareWidth*2)
    \psframe*[linewidth=0pt,linecolor=ExercicesTitleSquareColor]
             (0,-\SquareWidth)(\SquareWidth,0)
    \rput[Bl](\dimexpr \SquareWidth+\ExercicesTitleHSep,
              \ExercicesTitleVSep)
      {\ExercicesTitleFont \textcolor{ExercicesTitleColor}{#1}}
  \end{pspicture}%
}
\newcommand\smc@noexercice{%
  \ClassError{sesamanuel}{Vous ne pouvez pas utiliser la macro
    \string\exercice\space ici}{Reportez-vous à la documentation pour
    l'utilisation de la macro \string\exercice.}
}
\let\exercice\smc@noexercice
\let\correction\smc@nocorrection
\newif\ifsmc@exercicecorrige
\newcounter{exercice}[chapter]
\newcommand*\smc@exobaseexercice{%
  \@ifstar
    {%
      \smc@exercicecorrigetrue
      \smc@@exercice
    }
    {%
      \smc@exercicecorrigefalse
      \smc@@exercice
    }
}
\newcommand*\smc@@exercice[1][]{%
  \def\smc@exercicetitle{#1}%
  \smc@@@exercice
}
\newcommand*\smc@@@exercice[1][]{%
  \par\addvspace{\BeforeExerciceVSpace}
  \setcounter{partie}{0}
  \@ifnotmtarg{#1}{%
    \setbox0=\hbox{#1}%
    \parpic[r]{\makebox[\wd0][l]{{#1}}}
  }%
  \refstepcounter{exercice}%
  \begin{pspicture}(0,0)(\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \ifsmc@exercicecorrige
      \psframe*[linewidth=0pt, linecolor=ExerciceCorrigeNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \else
      \psframe*[linewidth=0pt, linecolor=ExerciceNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \fi
    \rput[B](\dimexpr\ExerciceNumFrameWidth/2,0){%
      \textcolor{ExerciceNumColor}{\ExerciceNumFont \theexercice}%
    }
  \end{pspicture}%
  \ifx\smc@exercicetitle\empty
    \hspace{\ExerciceTextHSep}%
  \else
    \hspace{\ExerciceTextHSep}%
    \textcolor{ExerciceTitleColor}
              {\ExerciceTitleFont \smc@exercicetitle}%
    \par\nobreak
  \fi
}
\def\endsmc@exercice{\par}
\newenvironment{exercice*}
{%
  \smc@exercicecorrigetrue
  \smc@@exercice
}
{\par}
\let\smc@exoapprexercice\smc@exobaseexercice
\let\endsmc@exoapprexercice\endsmc@exobaseexercice
\newcommand\killienc{}
\count@128
\@whilenum\count@<\@cclvi\do{%
  \edef\killienc{\killienc\catcode\the\count@=12}%
  \advance\count@\@ne}
\newenvironment{smc@nocorrige}
{%
  \ClassError{sesamanuel}{Il est interdit d'utiliser corrige ici}
             {Consultez la documentation pour plus de renseignements.}%
}
{}
\newenvironment{smc@AEcorrige}
{%
  \addtocontents{cor}{%
    \protect\inputcor{\smc@currpart}{\smc@thema@initcap\thechapter}
                     {\the\c@AEexo}%
  }%
  \killienc
  \VerbatimEnvironment
  \begin{VerbatimOut}{\PrefixeCorrection corr-\smc@currpart-\smc@thema@initcap\thechapter-\the\c@AEexo}}
{%
  \end{VerbatimOut}
}
\newenvironment{smc@exobasecorrige}
{%
  \addtocontents{cor}{%
    \protect\inputcor{\smc@currpart}{\smc@thema@initcap\thechapter}
                     {\the\c@exercice}%
  }%
  \killienc
  \VerbatimEnvironment
  \begin{VerbatimOut}{\PrefixeCorrection corr-\smc@currpart-\smc@thema@initcap\thechapter-\the\c@exercice}}
{%
  \end{VerbatimOut}
}
\let\smc@exoapprcorrige\smc@exobasecorrige
\let\endsmc@exoapprcorrige\endsmc@exobasecorrige
\let\smc@recreationcorrige\smc@exobasecorrige
\let\endsmc@recreationcorrige\endsmc@exobasecorrige
\let\smc@QCMcorrige\smc@exobasecorrige
\let\endsmc@QCMcorrige\endsmc@exobasecorrige
\let\smc@librecorrige\smc@exobasecorrige
\let\endsmc@librecorrige\endsmc@exobasecorrige
\newenvironment{smc@enigmecorrige}
{%
  \addtocontents{cor}{%
    \protect\inputcor{\smc@currpart}{\smc@thema@initcap\thechapter}{}%
  }%
  \killienc
  \VerbatimEnvironment
  \begin{VerbatimOut}{\PrefixeCorrection corr-\smc@currpart-\smc@thema@initcap\thechapter}}
{%
  \end{VerbatimOut}
}
\newenvironment{smc@TPcorrige}
{%
  \addtocontents{cor}{%
    \protect\inputcor{\smc@currpart}{\smc@thema@initcap\thechapter}
                     {\the\c@activite}%
  }%
  \killienc
  \VerbatimEnvironment
  \begin{VerbatimOut}{\PrefixeCorrection corr-\smc@currpart-\smc@thema@initcap\thechapter-\the\c@activite}}
{%
  \end{VerbatimOut}
}
\newcommand*\exercicesappr{%
  \clearpage
  \pagestyle{exercicesappr}
  \addtocontents{cor}{\protect\smc@corrigeexercicesappr}%
  \let\itemize\smc@exerciceitemize
  \let\enditemize\endsmc@exerciceitemize
  \let\colitemize\smc@exercicecolitemize
  \let\endcolitemize\endsmc@exercicecolitemize
  \let\enumerate\smc@exerciceenumerate
  \let\endenumerate\endsmc@exerciceenumerate
  \let\colenumerate\smc@exercicecolenumerate
  \let\endcolenumerate\endsmc@exercicecolenumerate
  \let\exercice\smc@exoapprexercice
  \let\endexercice\endsmc@exoapprexercice
  \let\corrige\smc@exoapprcorrige
  \let\endcorrige\endsmc@exoapprcorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@exercice@partie
  \def\smc@currpart{ExoAppr}%
}
\newcommand*\recreation{%
  \par\addvspace{\BeforeRecreationVSpace}
  \begin{pspicture}(0,0)(\linewidth,\dimexpr\SquareWidth*3)
    \psframe*[linewidth=0pt,linecolor=RecreationHeadFrame5Color]
             (0,0)(\linewidth,\dimexpr\SquareWidth*3)
    \psset{fillstyle=solid}
    \smc@antidiagonal(0mm,0mm){RecreationHeadFrame}
    \rput[Bl](\dimexpr \SquareWidth*4,\SquareWidth){%
      \textcolor{RecreationHeadFrame0Color}{\RecreationFont \StringRecreation}%
    }
    \psset{linewidth=0pt}
    \smc@putsquare(32,2){J1}
    \smc@putsquare(33,0){H4}
    \smc@putsquare(34,1){H2}
    \smc@putsquare(37,1){F3}
    \smc@putsquare(39,0){H2}
    \smc@putsquare(42,2){J2}
    \smc@putsquare(46,1){H4}
  \end{pspicture}
  \par\addvspace{\AfterRecreationVSpace}
}
\def\smc@putsquare(#1,#2)#3{%
  \rput(\dimexpr \SquareWidth*#1,\dimexpr \SquareWidth*#2)
       {\psframe*[linecolor=#3](0,0)(\SquareWidth,\SquareWidth)}
  \ignorespaces
}
\newcommand*\Recreation{%
  \clearpage
  \pagestyle{recreation}
}
\newcommand*\connaissances{%
  \clearpage
  \pagestyle{connaissances}
  \thispagestyle{firstconnaissances}
  \addtocontents{cor}{\protect\smc@corrigeconnaissances}%
  \let\itemize\smc@noitemize
  \let\enditemize\endsmc@noitemize
  \let\colitemize\smc@nocolitemize
  \let\endcolitemize\endsmc@nocolitemize
  \let\enumerate\smc@noenumerate
  \let\endenumerate\endsmc@noenumerate
  \let\colenumerate\smc@nocolenumerate
  \let\endcolenumerate\endsmc@nocolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@nopartie
  \def\smc@currpart{Connaissances}%
}
\newenvironment{acquis}{%
  \par
  \let\itemize\smc@acquisitemize
  \let\enditemize\endsmc@acquisitemize
  \let\colitemize\smc@acquiscolitemize
  \let\endcolitemize\endsmc@acquiscolitemize
  \let\enumerate\smc@acquisenumerate
  \let\endenumerate\endsmc@acquisenumerate
  \let\colenumerate\smc@acquiscolenumerate
  \let\endcolenumerate\endsmc@acquiscolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@nopartie
  \def\smc@currpart{Acquis}%
  {%
    \AcquisTitleFont
    \textcolor{AcquisTitleColor}{\StringAcquisTitle}%
    \par\vspace{\AcquisTitleVSpace}%
  }%
  \smc@cadre{AcquisBkgColor}
    \vspace*{-4.5pt}
    \begin{multicols}{2}
      \AcquisTextFont
}
{%
    \end{multicols}%
  \endsmc@cadre
  \par
}
\newcommand*\QCMautoevaluation[1]{%
  \def\smc@currpart{QCM}%
  \par\addvspace{\BeforeQCMAEVSpace}
  \begingroup
    \def\FrameSep{0pt}%
    \edef\FrameArc{\QCMAETitleHeight}%
    \minipage[b][\QCMAETitleHeight]{\QCMAETitleWidth}%
      \begin{smc@cadre}[5,0,5,5]{QCMAEFrameColor}%
        \minipage[b][\QCMAETitleHeight]{\QCMAETitleWidth}%
          \begin{pspicture}(1pt,0)(\QCMAETitleHeight,\QCMAETitleHeight)
            \pscircle*[linecolor=QCMAETitleCircle1Color]
                      (\dimexpr\QCMAETitleHeight/2,
                       \dimexpr\QCMAETitleHeight/2)
                      {\dimexpr\QCMAETitleHeight/2}
            \pscircle*[linecolor=QCMAETitleCircle2Color]
                      (\dimexpr\QCMAETitleHeight*5/12,
                       \dimexpr\QCMAETitleHeight*7/12)
                      {\dimexpr\QCMAETitleHeight*5/12}
            \pscircle*[linecolor=QCMAETitleCircle3Color]
                      (\dimexpr\QCMAETitleHeight/3,
                       \dimexpr\QCMAETitleHeight*2/3)
                      {\dimexpr\QCMAETitleHeight/3}
            \rput[Bl](\QCMAETitleLeftSpace,\dimexpr\QCMAETitleHeight/6)
                    {\textcolor{QCMAETitleColor}{\QCMAETitleFont\StringQCMAE}}
          \end{pspicture}%
        \endminipage
      \end{smc@cadre}
    \endminipage
  \endgroup
  \hspace*{\stretch{1}}%
  \begin{minipage}[b]{\QCMAEManuelWidth}
    \raggedright
    \QCMAEManuelFont
    \StringManuel
    \par\vspace*{\AfterQCMAEManuelVSpace}
  \end{minipage}%
  \hspace{\QCMAEManuelRightSpace}%
  \raisebox{\AfterQCMAEManuelVSpace}
           {\psscaleboxto(\AELogoManuelWidth,0){\LogoManuel}}%
  \par\nobreak\vspace{\AfterQCMAETitleVSpace}
  {\QCMAETextAfterTitleFont #1\par\nobreak}
  \par\nobreak\addvspace{\AfterQCMAETextVSpace}
}
\newenvironment{QCM}{%
  \begin{lrbox}{\smc@boxa}
    \minipage{\dimexpr\linewidth-\QCMLineWidth*2-\QCMFrameSep*2}
      \par\null
      \pnode(\dimexpr -\QCMFrameSep-\QCMLineWidth/2,
             \dimexpr \QCMFrameSep+\QCMLineWidth/2){A}
      \pnode(\dimexpr \linewidth+\QCMFrameSep+\QCMLineWidth/2,
             \dimexpr +\QCMFrameSep+\QCMLineWidth/2){B}
      \par
}
{%
      \par\vspace{-\baselineskip}
      \pnode(\dimexpr -\QCMFrameSep-\QCMLineWidth/2,
             \dimexpr -\QCMFrameSep-\QCMLineWidth/2){C}
      \pnode(\dimexpr \linewidth+\QCMFrameSep+\QCMLineWidth/2,
             \dimexpr -\QCMFrameSep-\QCMLineWidth/2){D}
      \psRelNode(A)(C){0.5}{AC}
      \psRelNode(B)(D){0.5}{BD}
    \endminipage
  \end{lrbox}
  \par\addvspace{\BeforeQCMVSpace}
  \vspace{\dimexpr\QCMLineWidth+\QCMFrameSep}
  \hspace*{\dimexpr\QCMLineWidth+\QCMFrameSep}%
  \copy\smc@boxa
  \psline[linewidth=\QCMLineWidth, linecolor=QCMLineColor](AC)(C)(D)(BD)
  \psline[linewidth=\QCMLineWidth, linecolor=QCMLineColor,
          linearc=\QCMLineArc](C)(A)(B)(D)
  \par\vspace{\dimexpr\QCMLineWidth+\QCMFrameSep}
  \addvspace{\AfterQCMVSpace}
}
\newenvironment{EnonceCommunQCM}{%
}
{%
}
\newenvironment{GroupeQCM}{%
  \let\exercice\smc@QCMexercice
  \let\endexercice\endsmc@QCMexercice
  \let\corrige\smc@QCMcorrige
  \let\endcorrige\endsmc@QCMcorrige
}
{%
}
\newenvironment{smc@QCMexercice}{%
  \par
  \refstepcounter{exercice}%
  \psframebox*[linestyle=none, linewidth=0pt,
               fillcolor=QCMExoNumFrameColor, framesep=\QCMExoFrameTopSep]{%
    \hbox to\dimexpr\QCMExoFrameWidth-\QCMExoFrameTopSep*2{%
      \hss
      \QCMExoNumFont
      \textcolor{QCMExoNumColor}{\theexercice}%
      \hss
    }%
  }%
  \hspace{\AfterQCMExoFrameHSpace}%
  \ignorespaces
}
{\par}
\newcounter{QCM}
\newcommand*\QCMLabel[1]{%
  \textcolor{QCMItemNumColor}
            {%
              \QCMItemNumFont
              \pscirclebox[linewidth=0.4pt, framesep=1pt,
                           linecolor=QCMItemNumColor, boxsep=true]
                          {\vphantom{dp}\@alph{#1}}
            }%
}%
\newenvironment{ChoixQCM}[1]{%
  \par\leavevmode
  \def\smc@nbcolumn{#1}%
  \smc@nbitem \z@
  \def\StringColCurrent{ChoixQCM}%
  \toks@{}%
  \smc@getbody
}
{%
  \expandafter\smc@splititem\the\toks@\item\@nil\item
  \smc@nbline \numexpr \smc@nbitem+\smc@nbcolumn-1
  \divide\smc@nbline \smc@nbcolumn
  \multido{\n=1+1}{\smc@nbline}{%
    \multido{\ni=\n+\the\smc@nbline}{\smc@nbcolumn}{%
      \unless\ifnum\ni>\smc@nbitem
        \makebox[\QCMLabelWidth]{\QCMLabel{\ni}\hss}%
        \begin{minipage}[t]{\dimexpr
            (\linewidth-\ListHSep*(\smc@nbcolumn-1))%
              /\smc@nbcolumn-\QCMLabelWidth}
          \strut\@nameuse{smc@item\ni}\strut
        \end{minipage}%
        \hspace{\ListHSep}%
      \fi
    }%
    \\
  }%
}
\newcommand*\TravauxPratiques{%
  \clearpage
  \pagestyle{TP}
  \def\smc@currpart{TP}%
  \setcounter{activite}{0}%
  \let\partie\smc@TP@partie
}
\newcommand*\DeclareTPLike[5]{%
  \expandafter\newcommand\csname#1\endcsname[1][]{%
    \def\smc@activite@title{##1}%
    \csname#1@aux\endcsname
  }%
  \expandafter\newcommand\csname#1@aux\endcsname[1][]{%
    \par
    \addvspace{\BeforeActiviteVSpace}
    \refstepcounter{activite}
    \setbox\smc@boxa=\hbox{%
      \ActiviteTitleFont
      #2%
    }%
    \begin{pspicture}(0,0)
      (\dimexpr \ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+1.4142\ActiviteTitleTopHeight,\ActiviteTitleTopHeight)
      \psframe*[linewidth=0, linecolor= #3]
        (0,0)(\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+0.7071\ActiviteTitleTopHeight,
              \ActiviteTitleTopHeight)
      \psframe*[linewidth=0, linecolor= #4]
        (0,0)(\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace+0.7071\ActiviteTitleTopHeight,
              -\ActiviteTitleBottomHeight)
      \rput[l](\ActiviteTitleLeftSpace,
               0.5\dimexpr\ActiviteTitleTopHeight-\ActiviteTitleBottomHeight){%
        \ActiviteTitleFont
        \textcolor{#5}{#2}%
      }
      \rput
        (\dimexpr\ActiviteTitleLeftSpace+\wd\smc@boxa+\ActiviteTitleRightSpace,
         0.5\dimexpr\ActiviteTitleTopHeight-\ActiviteTitleBottomHeight)
      {%
        \pspolygon*[linewidth=0, linecolor=#5]
          (0,0)
          (0.7071\ActiviteTitleTopHeight,0.7071\ActiviteTitleTopHeight)
          (1.4142\ActiviteTitleTopHeight,0)
          (0.7071\ActiviteTitleTopHeight,-0.7071\ActiviteTitleTopHeight)
        \rput(0.7071\ActiviteTitleTopHeight,0){%
          \ActiviteNumFont
          \textcolor{ActiviteNumColor}{\theactivite}%
        }
      }
    \end{pspicture}%
    \hspace*{\AfterActiviteTitleHSpace}%
    \@ifmtarg{##1}
      {\setbox0=\hbox{}}
      {\setbox0=\hbox{##1\ }}%
    \minipage[t]{\dimexpr\linewidth-\ActiviteTitleLeftSpace-\wd\smc@boxa-\ActiviteTitleRightSpace-1.4142\ActiviteTitleTopHeight-\AfterActiviteTitleHSpace-\wd0}
      \ActiviteSubtitleFont
      \textcolor{ActiviteSubtitleColor}{\smc@activite@title}%
    \endminipage
    \@ifnotmtarg{##1}{\hfill##1}%
    \par\vspace{\AfterActiviteTitleVSpace}
    \let\itemize\smc@activiteitemize
    \let\enditemize\endsmc@activiteitemize
    \let\colitemize\smc@activitecolitemize
    \let\endcolitemize\endsmc@activitecolitemize
    \let\enumerate\smc@activiteenumerate
    \let\endenumerate\endsmc@activiteenumerate
    \let\colenumerate\smc@activitecolenumerate
    \let\endcolenumerate\endsmc@activitecolenumerate
    \let\partie\smc@TP@partie
    \let\exercice\smc@noexercice
    \let\endexercice\endsmc@noexercice
    \let\corrige\smc@nocorrige
    \let\endcorrige\endsmc@nocorrige
    \def\smc@currpart{Activite}%
    \begin{changemargin}{\dimexpr\SquareWidth*4}{\ExtraMarginRight}
  }%
  \expandafter\def\csname end#1\endcsname{%
    \end{changemargin}
  }%
}
\DeclareTPLike{TP}{\StringTP}
              {TPTopColor}
              {TPBottomColor}
              {TPTitleColor}
\newenvironment{enigme}[1][]{%
  \addtocontents{cor}{\protect\smc@corrigeenigme}%
  \let\itemize\smc@recreationitemize
  \let\enditemize\endsmc@recreationitemize
  \let\colitemize\smc@recreationcolitemize
  \let\endcolitemize\endsmc@recreationcolitemize
  \let\enumerate\smc@recreationenumerate
  \let\endenumerate\endsmc@recreationenumerate
  \let\colenumerate\smc@recreationcolenumerate
  \let\endcolenumerate\endsmc@recreationcolenumerate
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\correction\smc@nocorrection
  \let\partie\smc@recreation@partie
  \def\smc@currpart{Enigme}%
  \par
  \@ifmtarg{#1}{}{%
    {\RecreationTitleFont \textcolor{RecreationTitleColor}{#1}\par}%
  }
  \setcounter{partie}{0}
}
{\par}
\newcommand*\smc@nopartie{%
  \ClassError{sesamanuel}
             {La commande \string\partie\space est interdite ici.}
             {Reportez-vous à la documentation pour
               l'utilisation de la macro \string\partie.}%
}
\let\partie\smc@nopartie
\newcommand*\smc@activite@partie[1][]{%
  \colorlet{smc@curr@partiecolor}{ActivitePartieColor}%
  \colorlet{smc@curr@partiebkgcolor}{Blanc}%
  \let\smc@curr@partiefont\ActivitePartieFont
  \par\addvspace{\BeforeActivitePartieVSpace}
  \refstepcounter{partie}%
  \@ifmtarg{#1}
    {%
      \textcolor{ActivitePartieColor}
                {\ActivitePartieFont \StringPartie{} \thepartie}
    }
    {%
      \textcolor{ActivitePartieColor}
                {\ActivitePartieFont \StringPartie{} \thepartie{} : #1}
    }
  \par\nobreak\addvspace{\AfterActivitePartieVSpace}
}
\newcommand*\smc@exercice@partie[1][]{%
  \colorlet{smc@curr@partiecolor}{ExercicePartieColor}%
  \colorlet{smc@curr@partiebkgcolor}{Blanc}%
  \let\smc@curr@partiefont\ExercicePartieFont
  \par\addvspace{\BeforeExercicePartieVSpace}
  \refstepcounter{partie}%
  \@ifmtarg{#1}
    {%
      \textcolor{ExercicePartieColor}
                {\ExercicePartieFont \textsc{\StringPartie} \Alph{partie}}
    }
    {%
      \textcolor{ExercicePartieColor}
                {\ExercicePartieFont \textsc{\StringPartie} \Alph{partie} : #1}
    }
  \par\nobreak\addvspace{\AfterExercicePartieVSpace}
}
\newcommand*\smc@TP@partie[1]{%
  \colorlet{smc@curr@partiecolor}{TPPartieNumColor}%
  \colorlet{smc@curr@partiebkgcolor}{TPPartieBkgColor}%
  \let\smc@curr@partiefont\TPPartieFont
  \par\addvspace{\BeforeTPPartieVSpace}
  \refstepcounter{partie}%
  \leavevmode
  \hbox to\z@{%
    \hss
    \psframebox[linestyle=none, linewidth=0pt, fillstyle=solid,
                fillcolor=TPPartieBkgColor]
               {\textcolor{TPPartieNumColor}{\TPPartieFont \thepartie}}%
    \hspace*{\TPPartieHSep}%
  }%
  \textcolor{TPPartieColor}{\TPPartieFont #1}
  \par\nobreak\addvspace{\AfterTPPartieVSpace}
}
\newcommand*\smc@recreation@partie[1][]{%
  \colorlet{smc@curr@partiecolor}{RecreationPartieColor}%
  \colorlet{smc@curr@partiebkgcolor}{Blanc}%
  \let\smc@curr@partiefont\RecreationPartieFont
  \par\addvspace{\BeforeRecreationPartieVSpace}
  \refstepcounter{partie}%
  \@ifmtarg{#1}
    {%
      \textcolor{RecreationPartieColor}
                {\RecreationPartieFont \StringPartie{} \Alph{partie}}
    }
    {%
      \textcolor{RecreationPartieColor}
                {\RecreationPartieFont \StringPartie{} \Alph{partie} :}
      \textcolor{RecreationPartieColor}{\RecreationPartieTitleFont #1}
    }
  \par\nobreak\addvspace{\AfterRecreationPartieVSpace}
}
\newcommand\smc@annexe@partie[1][]{%
  \colorlet{smc@curr@partiecolor}{AnnexePartieColor}%
  \colorlet{smc@curr@partiebkgcolor}{Blanc}%
  \let\smc@curr@partiefont\AnnexePartieFont
  \par\addvspace{\BeforeAnnexePartieVSpace}
  \refstepcounter{partie}%
  \@ifmtarg{#1}
    {%
      \textcolor{AnnexePartieColor}
                {\AnnexePartieFont \textsc{\StringPartie} \Alph{partie}}
    }
    {%
      \textcolor{AnnexePartieColor}
                {\AnnexePartieFont \textsc{\StringPartie} \Alph{partie} : #1}
    }
  \par\nobreak\addvspace{\AfterAnnexePartieVSpace}
}
\newcommand\smc@libre@partie[1][]{%
  \colorlet{smc@curr@partiecolor}{LibrePartieColor}%
  \colorlet{smc@curr@partiebkgcolor}{Blanc}%
  \let\smc@curr@partiefont\LibrePartieFont
  \par\addvspace{\BeforeLibrePartieVSpace}
  \refstepcounter{partie}%
  \@ifmtarg{#1}
    {%
      \textcolor{LibrePartieColor}
                {\LibrePartieFont \textsc{\StringPartie} \Alph{partie}}
    }
    {%
      \textcolor{LibrePartieColor}
                {\LibrePartieFont \textsc{\StringPartie} \Alph{partie} : #1}
    }
  \par\nobreak\addvspace{\AfterLibrePartieVSpace}
}
\newcommand*\NombreColonnesCorriges{3}
\newcommand*\PrefixeCorrection{}
\newcommand*\AfficheCorriges[1][\NombreColonnesCorriges]{%
  \clearpage
  \label{toutes-solutions}
  \pagestyle{corrige}
  \thispagestyle{firstcorrige}
  \rput[Bl](0,9mm){\CorrigeTitleFont \MakeUppercase{\StringCorriges}}
  \vspace*{-5mm}
  \begingroup
  \columnsep \dimexpr \SquareWidth*2
  \columnseprule \CorrigeRuleWidth
  \def\columnseprulecolor{\color{ExerciceColumnRuleColor}}%
  \xdef\smc@NbColonneCorrige{#1}%
  \ifnum#1>\@ne
    \begin{multicols}{#1}%
      \@starttoc{cor}
    \end{multicols}
    \vfill~\par
  \else
    \@starttoc{cor}
    \vfill~\par
  \fi
  \endgroup
}
\newcommand*\smc@corrigechapter[4]{%
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\correction\smc@nocorrection
  \par\addvspace{\BeforeCorrigeChapterVspace}
  \begin{pspicture}(0,0)(\linewidth,4.5mm)
    \psframe[linestyle=none, linewidth=0pt,
             fillstyle=solid, fillcolor=#3]
            (0,0)(\linewidth,4.5mm)
    \rput[B](0.5\linewidth,1mm){%
      \textcolor{#4}{\CorrigeChapterFont #1}%
    }
  \end{pspicture}%
  \\[-1mm]
  {%
    \centering
    \color{#3}
    \CorrigeChapterFont \smc@nobsbs{#2}
    \par\nobreak
  }%
}
\newcommand\smc@corrigeautoeval{%
  \let\itemize\smc@corrAEitemize
  \let\enditemize\endsmc@corrAEitemize
  \let\colitemize\smc@AEcolitemize
  \let\endcolitemize\endsmc@AEcolitemize
  \let\enumerate\smc@corrAEenumerate
  \let\endenumerate\endsmc@corrAEenumerate
  \let\colenumerate\smc@AEcolenumerate
  \let\endcolenumerate\endsmc@AEcolenumerate
  \let\partie\smc@nopartie
  \def\smc@currpart{CorrigeAE}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeAETitleColor}
              {\CorrigePartieFont \StringAE}
    \par\nobreak
    \def\smc@BeforeCorrige{\par}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigeactivite{%
  \let\itemize\smc@noitemize
  \let\enditemize\endsmc@noitemize
  \let\colitemize\smc@nocolitemize
  \let\endcolitemize\endsmc@nocolitemize
  \let\enumerate\smc@noenumerate
  \let\endenumerate\endsmc@noenumerate
  \let\colenumerate\smc@nocolenumerate
  \let\endcolenumerate\endsmc@nocolenumerate
  \def\smc@currpart{CorrectionActivite}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeActiviteTitleColor}
              {\CorrigePartieFont \StringACTIVITE}
    \par\nobreak
    \def\smc@BeforeCorrige{\par}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigeexercicesbase{%
  \let\itemize\smc@correxerciceitemize
  \let\enditemize\endsmc@correxerciceitemize
  \let\colitemize\smc@exercicecolitemize
  \let\endcolitemize\endsmc@exercicecolitemize
  \let\enumerate\smc@correxerciceenumerate
  \let\endenumerate\endsmc@correxerciceenumerate
  \let\colenumerate\smc@exercicecolenumerate
  \let\endcolenumerate\endsmc@exercicecolenumerate
  \let\partie\smc@exercice@partie
  \def\smc@currpart{CorrigeExoBase}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeExercicesBaseTitleColor}
              {\CorrigePartieFont \StringExercicesBase}
    \par\nobreak
    \def\smc@BeforeCorrige{\par}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigeexercicesappr{%
  \let\itemize\smc@correxerciceitemize
  \let\enditemize\endsmc@correxerciceitemize
  \let\colitemize\smc@exercicecolitemize
  \let\endcolitemize\endsmc@exercicecolitemize
  \let\enumerate\smc@correxerciceenumerate
  \let\endenumerate\endsmc@correxerciceenumerate
  \let\colenumerate\smc@exercicecolenumerate
  \let\endcolenumerate\endsmc@exercicecolenumerate
  \let\partie\smc@exercice@partie
  \def\smc@currpart{CorrigeExoAppr}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeExercicesApprTitleColor}
              {\CorrigePartieFont \StringExercicesAppr}
    \par\nobreak
    \def\smc@BeforeCorrige{\par}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigeconnaissances{%
  \let\itemize\smc@noitemize
  \let\enditemize\endsmc@noitemize
  \let\colitemize\smc@nocolitemize
  \let\endcolitemize\endsmc@nocolitemize
  \let\enumerate\smc@noenumerate
  \let\endenumerate\endsmc@noenumerate
  \let\colenumerate\smc@nocolenumerate
  \let\endcolenumerate\endsmc@nocolenumerate
  \let\partie\smc@nopartie
  \def\smc@currpart{CorrigeConnaissances}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeConnaissancesTitleColor}
              {\CorrigePartieFont \StringConnaissances}
    \par\nobreak
    \def\smc@BeforeCorrige{}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigeenigme{%
  \let\itemize\smc@corrrecreationitemize
  \let\enditemize\endsmc@corrrecreationitemize
  \let\colitemize\smc@recreationcolitemize
  \let\endcolitemize\endsmc@recreationcolitemize
  \let\enumerate\smc@corrrecreationenumerate
  \let\endenumerate\endsmc@corrrecreationenumerate
  \let\colenumerate\smc@recreationcolenumerate
  \let\endcolenumerate\endsmc@recreationcolenumerate
  \let\partie\smc@recreation@partie
  \def\smc@currpart{CorrigeEnigme}%
  \def\smc@BeforeCorrige{%
    \par\addvspace{\BeforeCorrigePartieTitleVSpace}
    \textcolor{CorrigeEnigmeTitleColor}
              {\CorrigePartieFont \StringEnigme}
    \par\nobreak
    \def\smc@BeforeCorrige{\par}%
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand\smc@corrigelibre{%
  \let\itemize\smc@corrlibreitemize
  \let\enditemize\endsmc@corrlibreitemize
  \let\colitemize\smc@librecolitemize
  \let\endcolitemize\endsmc@librecolitemize
  \let\enumerate\smc@corrlibreenumerate
  \let\endenumerate\endsmc@corrlibreenumerate
  \let\colenumerate\smc@librecolenumerate
  \let\endcolenumerate\endsmc@librecolenumerate
  \let\partie\smc@exercice@partie
  \def\smc@currpart{Libre}%
  \def\smc@BeforeCorrige{%
    \par
  }%
  \colorlet{CorrigeNumExerciceFrameBkg}{J1}%
  \colorlet{CorrigeNumExerciceFrameTxt}{Blanc}%
}
\newcommand*\inputcor[3]{%
  \smc@BeforeCorrige
  \def\smc@arg{#1}%
  \ifx\smc@arg\StringQCM
    \ifnum\smc@NbColonneCorrige=2
      \edef\smc@LargeurColonneCorrige
        {\the\dimexpr \linewidth/3-\QCMHSep}%
    \else
      \edef\smc@LargeurColonneCorrige
        {\the\dimexpr \linewidth/2-\QCMHSep}%
    \fi
    \minipage[t]{\smc@LargeurColonneCorrige}%
  \fi
  \@ifmtarg{#3}{}{%
    \begin{pspicture}(0,0)(5mm,2.5mm)
      \psframe[linestyle=none, linewidth=0pt,
               fillstyle=solid, fillcolor=CorrigeNumExerciceFrameBkg]
              (0,-0.5mm)(5mm,2.5mm)
      \rput[B](2.5mm,0){%
        \textcolor{CorrigeNumExerciceFrameTxt}
                  {\CorrigeNumExerciceFont #3}%
      }
    \end{pspicture}
  }%
  \hfill\begin{minipage}[t]{\linewidth-6.5mm}
    \raggedright
    \@ifmtarg{#3}
             {\input{\PrefixeCorrection corr-#1-#2}\strut}
             {\input{\PrefixeCorrection corr-#1-#2-#3}\strut}%
  \end{minipage}
  \def\smc@arg{#1}%
  \ifx\smc@arg\StringQCM
    \endminipage
    \hspace{\QCMHSep}%
  \else
    \par\vfil
  \fi
}
\newcommand\Coupe{%
  \strut
  \end{minipage}
  \par\hfill
  \begin{minipage}[t]{\linewidth-6.5mm}
}
\newcommand\reponseQCM[1]{%
  \smc@reponseQCM#1\@nil
}
\def\smc@reponseQCM#1{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\@nnil
  \else
    \textcolor{CorrigeQCMItemNumColor}
              {%
                \CorrigeQCMItemNumFont
                \pscirclebox[linewidth=0.4pt, framesep=1pt,
                             linecolor=CorrigeQCMItemNumColor, boxsep=true]
                            {\vphantom{dp}#1}%
              }
    \expandafter\smc@reponseQCM
  \fi
}
\newcommand*\ChangeAnnexe[4]{%
  \colorlet{AnnexeHeadFrameColor}{#1}%
  \colorlet{AnnexeSectionRuleColor}{#2}%
  \colorlet{AnnexeItemColor}{#2}%
  \colorlet{AnnexeExerciceCorrigeNumFrameColor}{#2}%
  \colorlet{AnnexeExerciceNumFrameColor}{#2}%
  \colorlet{AnnexeSectionTitleColor}{#3}%
  \colorlet{AnnexeExerciceTitleColor}{#3}
  \colorlet{AnnexeExerciceNumColor}{#4}
}
\ChangeAnnexe{G3}{A1}{G1}{Blanc}
\newcounter{propriete}
\newcommand*\annexe[1]{%
  \let\itemize\smc@annexeitemize
  \let\enditemize\endsmc@annexeitemize
  \let\colitemize\smc@annexecolitemize
  \let\endcolitemize\endsmc@annexecolitemize
  \let\enumerate\smc@annexeenumerate
  \let\endenumerate\endsmc@annexeenumerate
  \let\colenumerate\smc@annexecolenumerate
  \let\endcolenumerate\endsmc@annexecolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@annexeexercice
  \let\endexercice\endsmc@annexeexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \let\section\smc@annexesection
  \def\smc@currpart{Annexe}%
  \setcounter{propriete}{0}%
  \setcounter{exercice}{0}%
  \clearpage
  \pagestyle{annexe}
  \thispagestyle{firstannexe}
  \vspace*{\BeforeAnnexeTitleVSpace}
  {\raggedright \AnnexeTitleFont \MakeUppercase{#1}\par}
  \addvspace{\AfterAnnexeTitleVSpace}
  \def\smc@TitleAnnexe{#1}%
}
\newcommand*\ListeProprietes[1]{%
  \psframebox*[fillcolor=TablePropertyTitleBkgColor]{%
    \ProprieteFont
    \textcolor{TablePropertyTitleTextColor}
              {\MakeUppercase{\StringPropriete}~#1}%
  }%
}
\newcommand*\smc@annexeexercice{%
  \@ifstar
    {%
      \smc@exercicecorrigetrue
      \smc@@annexeexercice
    }
    {%
      \smc@exercicecorrigefalse
      \smc@@annexeexercice
    }
}
\newcommand*\smc@@annexeexercice[1][]{%
  \def\smc@exercicetitle{#1}%
  \smc@@@annexeexercice
}
\newcommand*\smc@@@annexeexercice[1][]{%
  \par\addvspace{\BeforeExerciceVSpace}
  \let\partie\smc@annexe@partie
  \setcounter{partie}{0}
  \@ifnotmtarg{#1}{%
    \setbox0=\hbox{#1}%
    \parpic[r]{\makebox[\wd0][l]{{#1}}}
  }%
  \refstepcounter{exercice}%
  \begin{pspicture}(0,0)(\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \ifsmc@exercicecorrige
      \psframe*[linewidth=0pt,
                linecolor=AnnexeExerciceCorrigeNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \else
      \psframe*[linewidth=0pt,
                linecolor=AnnexeExerciceNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \fi
    \rput[B](\dimexpr\ExerciceNumFrameWidth/2,0){%
      \textcolor{AnnexeExerciceNumColor}{\ExerciceNumFont \theexercice}%
    }
  \end{pspicture}%
  \ifx\smc@exercicetitle\empty
    \hspace{\ExerciceTextHSep}%
  \else
    \hspace{\ExerciceTextHSep}%
    \textcolor{AnnexeExerciceTitleColor}
              {\ExerciceTitleFont \smc@exercicetitle}%
    \par\nobreak
  \fi
}
\def\endsmc@annexeexercice{\par}
\newcommand*\smc@annexesection{%
  \@ifstar{\smc@annexesec}{\smc@annexesec}%
}
\newcommand*\smc@annexesec[2][]{%
  \ifx\relax#1\relax
    \smc@@annexesec{#2}{#2}%
  \else
    \smc@@annexesec{#1}{#2}%
  \fi
}
\newcommand*\smc@@annexesec[2]{%
  \par\goodbreak\addvspace{\BeforeAnnexeSectionVSpace}%
  \@ifmtarg{#1}{}{}%
  \begin{pspicture}(0,0)(\AnnexeSectionRuleWidth,\AnnexeSectionRuleWidth)
    \psframe*[linecolor=AnnexeSectionRuleColor]
             (0,0)(\AnnexeSectionRuleWidth,\AnnexeSectionRuleWidth)
  \end{pspicture}%
  \hspace{\AnnexeSectionRuleHSpace}%
  \begin{minipage}[t]{\dimexpr\linewidth-\AnnexeSectionRuleWidth-\AnnexeSectionRuleHSpace}
    \AnnexeSectionTitleFont
    \textcolor{AnnexeSectionTitleColor}{#2}%
  \end{minipage}
  \par\nobreak\addvspace{\AfterAnnexeSectionVSpace}
}
\newcommand*\MotDefinition[2][]{%
  \def\smc@MDlexique{#1}%
  \def\smc@MDentree{#2}%
  \smc@MotDefinition
}
\newcommand*\smc@MotDefinition[2][]{%
  \@ifmtarg{#2}{%
    \textbf{\smc@MDentree}%
    \ifx\smc@MDlexique\empty
      \smc@noprotectaddtolexique{#1}{\smc@MDentree}{\thepage}%
    \else
      \smc@noprotectaddtolexique{#1}{\smc@MDlexique}{\thepage}%
    \fi
  }
  {%
    \ifx\smc@MDlexique\empty
      \smc@addtolexique{#1}{\smc@MDentree}{%
        \par\nobreak
        #2%
        \par\addvspace{\AfterEntreeVSpace}%
      }%
    \else
      \smc@addtolexique{#1}{\smc@MDlexique}{%
        \par\nobreak
        #2%
        \par\addvspace{\AfterEntreeVSpace}%
      }%
    \fi
  }%
}
\newcommand*\Lexique[1]{%
  \textcolor{LexiqueEntreeColor}{\LexiqueFont #1}%
}
\long\def\smc@addtolexique#1#2#3{%
  \protected@write\@auxout{}
  {%
    \string\@writefile{lex}{%
      \protect\smc@insertlexique[#1]{#2}{\unexpanded{\unexpanded{#3}}}%
    }%
  }%
}
\long\def\smc@noprotectaddtolexique#1#2#3{%
  \protected@write\@auxout{}
  {%
    \string\@writefile{lex}{%
      \protect\smc@preinsertlexique[#1]{#2}{#3}%
    }%
  }%
}
\long\def\smc@addtolom#1{%
  \protected@write\@auxout{}
  {%
    \protect\expandafter\global\protect\csname smc@lom\smc@thema@init
      true\protect\endcsname
    \string\@writefile{lom\smc@thema@init}{%
      \protect\l@methode{\unexpanded{\unexpanded{#1}}}{\thepage}%
    }%
  }%
}
\newcommand*\NombreColonnesLexique{2}
\newcommand*\AfficheLexique[1][\NombreColonnesLexique]{%
  \clearpage
  \pagestyle{lexique}
  \thispagestyle{firstlexique}
  \let\itemize\smc@lexiqueitemize
  \let\enditemize\endsmc@lexiqueitemize
  \let\colitemize\smc@lexiquecolitemize
  \let\endcolitemize\endsmc@lexiquecolitemize
  \let\enumerate\smc@lexiqueenumerate
  \let\endenumerate\endsmc@lexiqueenumerate
  \let\colenumerate\smc@lexiquecolenumerate
  \let\endcolenumerate\endsmc@lexiquecolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@noexercice
  \let\endexercice\endsmc@noexercice
  \let\corrige\smc@nocorrige
  \let\endcorrige\endsmc@nocorrige
  \def\smc@currpart{Lexique}%
  \rput[Bl](0,9mm){\LexiqueTitleFont \MakeUppercase{\StringLexique}}
  \vspace*{-5mm}
  \begingroup
  \columnsep \dimexpr \SquareWidth*2
  \columnseprule \LexiqueRuleWidth
  \def\columnseprulecolor{\color{LexiqueColumnRuleColor}}%
  \smc@numlexique \z@
  \begin{multicols}{#1}%
    \let\smc@insertlexique\smc@insertlexiqueinitial
    \let\smc@preinsertlexique\smc@preinsertlexiqueinitial
    \begingroup
      \makeatletter
      \@input{\jobname.lex}%
    \endgroup
    \let\smc@insertlexique\smc@insertlexiquefinal
    \let\smc@preinsertlexique\smc@preinsertlexiquefinal
    \@starttoc{lex}%
    \multido{\n=1+1}{\smc@numlexique}{%
      \expandafter\xdef\csname index\n\endcsname{\n}%
    }%
    \ifnum\smc@numlexique>\z@
      \smc@trifusion{1}{\the\smc@numlexique}%
      \def\smc@currentletter{A}%
      \multido{\n=1+1}{\smc@numlexique}{%
        \smc@afficheentree{\n}%
      }%
    \fi
  \end{multicols}
  \endgroup
}
\newcommand*\smc@afficheentree[1]{%
  \edef\smc@arg{\csname tri\csname index#1\endcsname\endcsname}%
  \expandafter\smc@testfirstletter\smc@arg\@nil
  \csname lexique\csname index#1\endcsname\endcsname\endgraf
}
\def\smc@testfirstletter#1#2\@nil{%
  \def\smc@arg{#1}%
  \unless\ifx\smc@arg\smc@currentletter
    \def\smc@currentletter{#1}%
    \par\addvspace{\BeforeFirstLetterVSpace}
    \setbox0=\hbox{%
      \textcolor{FirstLetterTxtColor}{\FirstLetterFont \MakeUppercase{#1}}%
    }%
    \begin{pspicture}(0,\dimexpr\ht0+\FirstLetterFrameHSep)
      \psframe[linewidth=0pt, linestyle=none, fillstyle=solid,
               fillcolor=FirstLetterBkgColor]
              (0,\dimexpr\ht0+\FirstLetterFrameHSep)
              (\linewidth,-\FirstLetterFrameHSep)
      \rput[B](0.5\linewidth,0){\box0}
    \end{pspicture}
    \par\addvspace{\AfterFirstLetterVSpace}
    \nobreak
  \fi
}
\newcount\smc@firsttable
\newcount\smc@endfirsttable
\newcount\smc@secondtable
\newcount\smc@endsecondtable
\newcount\smc@writetable
\newcommand*\smc@trifusion[2]{%
  \ifnum#1=#2
  \else
    \edef\smc@arg{{#1}{\the\numexpr(#1+#2-1)/2}}%
    \expandafter\smc@trifusion\smc@arg
    \edef\smc@arg{{\the\numexpr(#1+#2+1)/2}{#2}}%
    \expandafter\smc@trifusion\smc@arg
    \smc@fusion{#1}{#2}%
  \fi
}
\newcommand*\smc@fusion[2]{%
  \smc@firsttable=#1
  \smc@endfirsttable=\numexpr(#1+#2+1)/2
  \smc@secondtable=\numexpr(#1+#2+1)/2
  \smc@endsecondtable=\numexpr #2+1
  \smc@writetable=\numexpr #1-1
  \let\smc@next\smc@fusionrec
  \smc@next
  \multido{\n=#1+1}{\numexpr #2-#1+1}{%
    \edef\smc@tmp{\csname tmp\n\endcsname}%
    \expandafter\xdef\csname index\n\endcsname{\smc@tmp}%
  }
}
\newcommand*\smc@fusionrec{%
  \advance\smc@writetable \@ne
  \ifnum \pdfstrcmp{%
    \csname tri\csname index\the\smc@firsttable\endcsname\endcsname
  }{%
    \csname tri\csname index\the\smc@secondtable\endcsname\endcsname
  }=-1
    \edef\smc@tmp{\csname index\the\smc@firsttable\endcsname}%
    \expandafter\let\csname tmp\the\smc@writetable\endcsname\smc@tmp
    \advance\smc@firsttable \@ne
    \ifnum\smc@firsttable=\smc@endfirsttable
      \let\smc@next\smc@fusionsecond
    \fi
  \else
    \edef\smc@tmp{\csname index\the\smc@secondtable\endcsname}%
    \expandafter\let\csname tmp\the\smc@writetable\endcsname\smc@tmp
    \advance\smc@secondtable \@ne
    \ifnum\smc@secondtable=\smc@endsecondtable
      \let\smc@next\smc@fusionfirst
    \fi
  \fi
  \smc@next
}
\newcommand*\smc@fusionfirst{%
  \advance\smc@writetable \@ne
  \edef\smc@tmp{\csname index\the\smc@firsttable\endcsname}%
  \expandafter\let\csname tmp\the\smc@writetable\endcsname\smc@tmp
  \advance\smc@firsttable \@ne
  \ifnum\smc@firsttable=\smc@endfirsttable
    \let\smc@next\relax
  \fi
  \smc@next
}
\newcommand*\smc@fusionsecond{%
  \advance\smc@writetable \@ne
  \edef\smc@tmp{\csname index\the\smc@secondtable\endcsname}%
  \expandafter\let\csname tmp\the\smc@writetable\endcsname\smc@tmp
  \advance\smc@secondtable \@ne
  \ifnum\smc@secondtable=\smc@endsecondtable
    \let\smc@next\relax
  \fi
  \smc@next
}
\newcommand\smc@insertlexiqueinitial[3][]{}
\newcount\smc@numlexique
\newcommand\smc@insertlexiquefinal[3][]{%
  \global\advance\smc@numlexique \@ne
  \@ifmtarg{#1}%
    {\smc@@FirstUppercase#2\@nil#3\@nil}%
    {\expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
      {%
        \protect\textcolor{LexiqueEntreeColor}
          {%
            \protect\LexiqueEntreeFont #2%
          }%
        \unexpanded{#3}%
      }%
    }%
  \@ifmtarg{#1}%
    {\smc@sansdiacritique{#2}}%
    {\smc@sansdiacritique{#1}}%
  \expandafter\xdef\csname tri\the\smc@numlexique\endcsname{\smc@tri}%
}
\newcommand\smc@preinsertlexiqueinitial[3][]{%
  \@ifmtarg{#1}%
    {\smc@sansdiacritique{#2}}%
    {\smc@sansdiacritique{#1}}%
  \ifcsname nb-\smc@tri\endcsname
    \unless\ifnum\csname lastpage-\smc@tri\endcsname=#3
      \expandafter\gdef\csname lastpage-\smc@tri\endcsname{#3}%
      \expandafter\xdef\csname nb-\smc@tri\endcsname{%
        \the\numexpr\csname nb-\smc@tri\endcsname+1
      }%
      \edef\smc@tmp{\csname pages-\smc@tri\endcsname}%
      \expandafter\xdef\csname pages-\smc@tri\endcsname{\smc@tmp, #3}%
    \fi
  \else
    \expandafter\gdef\csname lastpage-\smc@tri\endcsname{#3}%
    \expandafter\gdef\csname nb-\smc@tri\endcsname{1}%
    \expandafter\gdef\csname pages-\smc@tri\endcsname{#3}%
  \fi
}
\newcommand\smc@preinsertlexiquefinal[3][]{%
  \@ifmtarg{#1}%
    {\smc@sansdiacritique{#2}}%
    {\smc@sansdiacritique{#1}}%
  \ifcsname affiche-\smc@tri\endcsname
  \else
    \expandafter\gdef\csname affiche-\smc@tri\endcsname{true}%
    \@ifmtarg{#1}%
      {\smc@sansdiacritique{#2}}%
      {\smc@sansdiacritique{#1}}%
    \global\advance\smc@numlexique \@ne
    \@ifmtarg{#1}%
      {\smc@@preFirstUppercase#2\@nil#3\@nil}%
      {\expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
        {%
          \protect\textcolor{LexiqueEntreeColor}{%
            \protect\LexiqueEntreeFont #2%
          }%
          \space\hbox to4.4em{\rdotfill}\kern-0.44em\rdotfill
          \ifnum\csname nb-\smc@tri\endcsname>\@ne
            \protect\emph{ Pages \csname pages-\smc@tri\endcsname}%
          \else
            \protect\emph{ Page \csname pages-\smc@tri\endcsname}%
          \fi
        }%
      }%
    \expandafter\xdef\csname tri\the\smc@numlexique\endcsname
      {\smc@tri}%
  \fi
}
\def\smc@IeC{\IeC}
\def\smcl@Ag{\`A}
\def\smcl@Aa{\'A}
\def\smcl@Ac{\^A}
\def\smcl@At{\~A}
\def\smcl@Au{\"A}
\def\smcl@Ar{\r A}
\def\smcl@AE{\AE}
\def\smcl@Cc{\c C}
\def\smcl@Eg{\`E}
\def\smcl@Ea{\'E}
\def\smcl@Ec{\^E}
\def\smcl@Eu{\"E}
\def\smcl@Ig{\`I}
\def\smcl@Ia{\'I}
\def\smcl@Ic{\^I}
\def\smcl@Iu{\"I}
\def\smcl@Nn{\~N}
\def\smcl@Og{\`O}
\def\smcl@Oa{\'O}
\def\smcl@Oc{\^O}
\def\smcl@Ot{\~O}
\def\smcl@Ou{\"O}
\def\smcl@Oo{\O}
\def\smcl@OE{\OE}
\def\smcl@Ug{\`U}
\def\smcl@Ua{\'U}
\def\smcl@Uc{\^U}
\def\smcl@Uu{\"U}
\def\smcl@Yt{\"Y}
\def\smcl@ss{\ss}
\def\smcl@ag{\`a}
\def\smcl@aa{\'a}
\def\smcl@ac{\^a}
\def\smcl@at{\~a}
\def\smcl@au{\"a}
\def\smcl@ar{\r a}
\def\smcl@ae{\ae}
\def\smcl@cc{\c c}
\def\smcl@eg{\`e}
\def\smcl@ea{\'e}
\def\smcl@ec{\^e}
\def\smcl@eu{\"e}
\def\smcl@ig{\`i}
\def\smcl@ia{\'i}
\def\smcl@ic{\^i}
\def\smcl@iu{\"i}
\def\smcl@nn{\~n}
\def\smcl@og{\`o}
\def\smcl@oa{\'o}
\def\smcl@oc{\^o}
\def\smcl@ot{\~o}
\def\smcl@ou{\"o}
\def\smcl@oo{\o}
\def\smcl@oe{\oe}
\def\smcl@ug{\`u}
\def\smcl@ua{\'u}
\def\smcl@uc{\^u}
\def\smcl@uu{\"u}
\def\smcl@yt{\"y}
\long\def\smc@@FirstUppercase#1#2#3\@nil#4\@nil{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\smc@IeC
    \expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
      {%
        \protect\textcolor{LexiqueEntreeColor}
          {%
            \protect\LexiqueEntreeFont
            \MakeUppercase{#1#2}%
            \MakeLowercase{#3}%
          }%
        \unexpanded{#4}%
      }%
  \else
    \expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
      {%
        \protect\textcolor{LexiqueEntreeColor}
          {%
            \protect\LexiqueEntreeFont
            \MakeUppercase{#1}%
            \MakeLowercase{#2#3}%
          }%
        \unexpanded{#4}%
      }%
  \fi
}
\long\def\smc@@preFirstUppercase#1#2#3\@nil#4\@nil{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\smc@IeC
    \expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
      {%
        \protect\textcolor{LexiqueEntreeColor}
          {%
            \protect\LexiqueEntreeFont
            \MakeUppercase{#1#2}%
            \MakeLowercase{#3}%
          }%
        \space\hbox to4.4em{\rdotfill}\kern-0.44em\rdotfill
        \ifnum\csname nb-\smc@tri\endcsname>\@ne
          \protect\emph{ Pages \csname pages-\smc@tri\endcsname}%
        \else
          \protect\emph{ Page \csname pages-\smc@tri\endcsname}%
        \fi
      }%
  \else
    \expandafter\protected@xdef\csname lexique\the\smc@numlexique\endcsname
      {%
        \protect\textcolor{LexiqueEntreeColor}
          {%
            \protect\LexiqueEntreeFont
            \MakeUppercase{#1}%
            \MakeLowercase{#2#3}%
          }%
        \space\hbox to4.4em{\rdotfill}\kern-0.44em\rdotfill
        \ifnum\csname nb-\smc@tri\endcsname>\@ne
          \protect\emph{ Pages \csname pages-\smc@tri\endcsname}%
        \else
          \protect\emph{ Page \csname pages-\smc@tri\endcsname}%
        \fi
      }%
  \fi
}
\def\smc@sansdiacritique#1{%
  \def\smc@tri{}%
  \protected@edef\smc@arg{#1}%
  \let\smc@next\smc@sd
  \expandafter\smc@next\smc@arg\@nil
}
\def\smc@sd#1{%
  \def\smc@arg{#1}%
  \ifx\smc@arg\@nnil
    \let\smc@next\relax
  \else
    \ifx\smc@arg\smc@IeC
      \let\smc@next\smc@@sd
    \else
      \def\smc@arg{#1}%
      \ifnum`#1<`A
        \edef\smc@tri{\smc@tri#1}%
      \else\ifnum`#1>`Z
        \edef\smc@tri{\smc@tri#1}%
      \else
        \edef\smc@tri{\smc@tri\smc@bdc{\numexpr`#1-`A}}%
      \fi\fi
    \fi
  \fi
  \smc@next
}
\newcommand*\smc@bdc[1]{%
  \ifcase#1
    a%
    \or b%
    \or c%
    \or d%
    \or e%
    \or f%
    \or g%
    \or h%
    \or i%
    \or j%
    \or k%
    \or l%
    \or m%
    \or n%
    \or o%
    \or p%
    \or q%
    \or r%
    \or s%
    \or t%
    \or u%
    \or v%
    \or w%
    \or x%
    \or y%
    \or z%
    \else ???%
  \fi
}
\def\smc@@sd#1{%
  \def\smc@arg{#1}
  \ifx\smc@arg\smcl@Ag
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@Aa
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@Ac
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@At
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@Au
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@Ar
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@AE
    \edef\smc@tri{\smc@tri ae}%
  \else\ifx\smc@arg\smcl@Cc
    \edef\smc@tri{\smc@tri c}%
  \else\ifx\smc@arg\smcl@Eg
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@Ea
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@Ec
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@Eu
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@Ig
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@Ia
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@Ic
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@Iu
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@Nn
    \edef\smc@tri{\smc@tri n}%
  \else\ifx\smc@arg\smcl@Og
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@Oa
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@Oc
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@Ot
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@Ou
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@Oo
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@OE
    \edef\smc@tri{\smc@tri oe}%
  \else\ifx\smc@arg\smcl@Ug
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@Ua
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@Uc
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@Uu
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@Yt
    \edef\smc@tri{\smc@tri y}%
  \else\ifx\smc@arg\smcl@ss
    \edef\smc@tri{\smc@tri s}%
  \else\ifx\smc@arg\smcl@ag
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@aa
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@ac
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@at
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@au
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@ar
    \edef\smc@tri{\smc@tri a}%
  \else\ifx\smc@arg\smcl@ae
    \edef\smc@tri{\smc@tri ae}%
  \else\ifx\smc@arg\smcl@cc
    \edef\smc@tri{\smc@tri c}%
  \else\ifx\smc@arg\smcl@eg
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@ea
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@ec
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@eu
    \edef\smc@tri{\smc@tri e}%
  \else\ifx\smc@arg\smcl@ig
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@ia
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@ic
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@iu
    \edef\smc@tri{\smc@tri i}%
  \else\ifx\smc@arg\smcl@nn
    \edef\smc@tri{\smc@tri n}%
  \else\ifx\smc@arg\smcl@og
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@oa
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@oc
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@ot
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@ou
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@oo
    \edef\smc@tri{\smc@tri o}%
  \else\ifx\smc@arg\smcl@oe
    \edef\smc@tri{\smc@tri oe}%
  \else\ifx\smc@arg\smcl@ug
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@ua
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@uc
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@uu
    \edef\smc@tri{\smc@tri u}%
  \else\ifx\smc@arg\smcl@yt
    \edef\smc@tri{\smc@tri y}%
  \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  \let\smc@next\smc@sd
  \smc@next
}
\newcommand*\rdotfill{%
  \leavevmode
  \leaders \hb@xt@ .44em{\hss.}\hfill
  \kern\z@
}
\newcommand*\l@methode[2]{%
  \begin{minipage}[b]{\linewidth-1.5cm}
    \raggedright
    \ListeMethodeTitleFont
    \begin{pspicture}(0,0)(\TriangleMethodeSize,\TriangleMethodeSize)
      \pspolygon*[linecolor=\CorrigeChapterFrameColor]
                 (0,0)(0,\TriangleMethodeSize)
                 (\TriangleMethodeSize,\dimexpr\TriangleMethodeSize/2)
    \end{pspicture}
    \textcolor{ListeMethodeTitleColor}{#1}%
    \rdotfill
  \end{minipage}\kern-0.44em
  {\ListeMethodePageFont \rdotfill#2\strut}%
  \par\addvspace{\AfterMethodeVSpace}
}
\newcommand\ListeMethodesThemes{{sp}{SP},{f}{F},{g}{G}}
\newcommand*\smc@bandeaulistemethodes[1]{%
  \par\addvspace{\BeforeRecreationVSpace}
  \begin{pspicture}(0,0)(\linewidth,\dimexpr\SquareWidth*3)
    \psframe*[linewidth=0pt,linecolor=ChapterNumSquare5Color]
             (0,0)(\linewidth,\dimexpr\SquareWidth*3)
    \psset{fillstyle=solid}
    \smc@antidiagonal(0mm,0mm){ChapterNumSquare}
    \rput[Bl](\dimexpr \SquareWidth*4,\SquareWidth){%
      \textcolor{ChapterNumSquare0Color}{\RecreationFont #1}%
    }
    \psset{linewidth=0pt}
    \smc@putsquare(32,2){J1}
    \smc@putsquare(33,0){H4}
    \smc@putsquare(34,1){H2}
    \smc@putsquare(37,1){F3}
    \smc@putsquare(39,0){H2}
    \smc@putsquare(42,2){J2}
    \smc@putsquare(46,1){H4}
  \end{pspicture}
  \par\nobreak\addvspace{\AfterRecreationVSpace}
}
\newif\ifsmc@lomsp
\newif\ifsmc@lomf
\newif\ifsmc@lomg
\newcommand*\NombreColonnesListeMethodes{2}
\newcommand*\AfficheListeMethodes[1][\NombreColonnesListeMethodes]{%
  \clearpage
  \pagestyle{affichemethode}
  \thispagestyle{firstaffichemethode}
  \rput[Bl](0,9mm){\ListeMethodeChapterFont \MakeUppercase{\StringListeMethode}}
  \vspace*{-5mm}
  \begingroup
    \columnsep \dimexpr \SquareWidth*2
    \columnseprule \ListeMethodeRuleWidth
    \def\columnseprulecolor{\color{ListeMethodeColumnRuleColor}}%
    \renewcommand*\MethodeRefExercice{\@ifstar{\@gobble}{\@gobble}}
    \def\smc@NombreColonnesListeMethodes{#1}%
    \tracingifs=1
    \@for\smc@currtheme:=\ListeMethodesThemes\do{%
      \expandafter\smc@AfficheListeMethodesTheme\smc@currtheme
    }%
  \endgroup
}
\newcommand\smc@AfficheListeMethodesTheme[2]{%
  \expandafter\ifx\csname ifsmc@lom#1\endcsname\iftrue
    \csname smc@thema#2Color\endcsname
    \expandafter\smc@bandeaulistemethodes
      \expandafter{\csname StringListeMethode#2\endcsname}
    \ifnum \smc@NombreColonnesListeMethodes=\@ne
      \@starttoc{lom#1}
    \else
      \begin{multicols}{\smc@NombreColonnesListeMethodes}
        \@starttoc{lom#1}
      \end{multicols}
    \fi
  \fi
}
\newcommand*\ChangeLibre[4]{%
  \colorlet{LibreHeadFrameColor}{#1}%
  \colorlet{LibreSectionRuleColor}{#2}%
  \colorlet{LibreItemColor}{#2}%
  \colorlet{LibreExerciceCorrigeNumFrameColor}{#2}%
  \colorlet{LibreExerciceNumFrameColor}{#2}%
  \colorlet{LibreSectionTitleColor}{#3}%
  \colorlet{LibreExerciceTitleColor}{#3}
  \colorlet{LibreExerciceNumColor}{#4}
}
\ChangeLibre{G3}{A1}{G1}{Blanc}
\newcommand*\libre{%
  \let\itemize\smc@libreitemize
  \let\enditemize\endsmc@libreitemize
  \let\colitemize\smc@librecolitemize
  \let\endcolitemize\endsmc@librecolitemize
  \let\enumerate\smc@libreenumerate
  \let\endenumerate\endsmc@libreenumerate
  \let\colenumerate\smc@librecolenumerate
  \let\endcolenumerate\endsmc@librecolenumerate
  \let\partie\smc@nopartie
  \let\exercice\smc@libreexercice
  \let\endexercice\endsmc@libreexercice
  \let\corrige\smc@librecorrige
  \let\endcorrige\endsmc@librecorrige
  \let\section\smc@libresection
  \def\smc@currpart{Libre}%
  \setcounter{propriete}{0}%
  \setcounter{exercice}{0}%
  \addtocontents{cor}{\protect\smc@corrigelibre}%
  \clearpage
  \pagestyle{libre}
  \thispagestyle{firstlibre}
  \themaL
}
\newcommand*\smc@libreexercice{%
  \@ifstar
    {%
      \smc@exercicecorrigetrue
      \smc@@libreexercice
    }
    {%
      \smc@exercicecorrigefalse
      \smc@@libreexercice
    }
}
\newcommand*\smc@@libreexercice[1][]{%
  \def\smc@exercicetitle{#1}%
  \smc@@@libreexercice
}
\newcommand*\smc@@@libreexercice[1][]{%
  \par\addvspace{\BeforeExerciceVSpace}
  \let\partie\smc@exercice@partie
  \setcounter{partie}{0}
  \@ifnotmtarg{#1}{%
    \setbox0=\hbox{#1}%
    \parpic[r]{\makebox[\wd0][l]{{#1}}}
  }%
  \refstepcounter{exercice}%
  \begin{pspicture}(0,0)(\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \ifsmc@exercicecorrige
      \psframe*[linewidth=0pt,
                linecolor=LibreExerciceCorrigeNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \else
      \psframe*[linewidth=0pt,
                linecolor=LibreExerciceNumFrameColor]
               (0,-\ExerciceNumFrameDepth)
               (\ExerciceNumFrameWidth,\ExerciceNumFrameHeight)
    \fi
    \rput[B](\dimexpr\ExerciceNumFrameWidth/2,0){%
      \textcolor{LibreExerciceNumColor}{\ExerciceNumFont \theexercice}%
    }
  \end{pspicture}%
  \ifx\smc@exercicetitle\empty
    \hspace{\ExerciceTextHSep}%
  \else
    \hspace{\ExerciceTextHSep}%
    \textcolor{LibreExerciceTitleColor}
              {\ExerciceTitleFont \smc@exercicetitle}%
    \par\nobreak
  \fi
}
\def\endsmc@libreexercice{\par}
\newcommand*\smc@libresection{%
  \@ifstar{\smc@libresec}{\smc@libresec}%
}
\newcommand*\smc@libresec[2][]{%
  \ifx\relax#1\relax
    \smc@@libresec{#2}{#2}%
  \else
    \smc@@libresec{#1}{#2}%
  \fi
}
\newcommand*\smc@@libresec[2]{%
  \par\goodbreak\addvspace{\BeforeLibreSectionVSpace}%
  \@ifmtarg{#1}{}{}%
  \begin{pspicture}(0,0)(\LibreSectionRuleWidth,\LibreSectionRuleWidth)
    \psframe*[linecolor=LibreSectionRuleColor]
             (0,0)(\LibreSectionRuleWidth,\LibreSectionRuleWidth)
  \end{pspicture}%
  \hspace{\LibreSectionRuleHSpace}%
  \begin{minipage}[t]{\dimexpr\linewidth-\LibreSectionRuleWidth-\LibreSectionRuleHSpace}
    \LibreSectionTitleFont
    \textcolor{LibreSectionTitleColor}{#2}%
  \end{minipage}
  \par\nobreak\addvspace{\AfterLibreSectionVSpace}
}
\newbox\@BILD
\newbox\@TEXT
\newdimen\d@breite
\newdimen\d@hoehe
\newdimen\d@xoff
\newdimen\d@yoff
\newdimen\d@shad
\newdimen\d@dash
\newdimen\d@boxl
\newdimen\d@pichskip
\newdimen\d@tmp
\newdimen\d@tmpa
\newdimen\d@bskip
\newdimen\hsiz@
\newdimen\p@getot@l
\newcount\c@breite
\newcount\c@hoehe
\newcount\c@xoff
\newcount\c@yoff
\newcount\c@pos
\newcount\c@shad
\newcount\c@dash
\newcount\c@boxl
\newcount\c@zeilen
\newcount\@changemode
\newcount\c@piccaption
\newcount\c@piccaptionpos
\newcount\c@picpos
\newcount\c@whole
\newcount\c@half
\newcount\c@tmp
\newcount\c@tmpa
\newcount\c@tmpb
\newcount\c@tmpc
\newcount\c@tmpd
\newskip\d@leftskip
\newif\if@list \@listfalse
\newif\if@offset
\c@piccaptionpos=1
\c@picpos=0
\d@shad=4pt
\d@dash=4pt
\d@boxl=10pt
\d@pichskip=1em
\@changemode=0
\def\@captype{figure}
\let\old@par=\par
\def\pichskip#1{\d@pichskip #1\relax}
\def\shadowthickness#1{\d@shad #1\relax}
\def\dashlength#1{\d@dash #1\relax}
\def\boxlength#1{\d@boxl #1\relax}
\def\picchangemode{\@changemode=1}
\def\nopicchangemode{\@changemode=0}
\def\piccaptionoutside{\c@piccaptionpos=1}
\def\piccaptioninside{\c@piccaptionpos=2}
\def\piccaptionside{\c@piccaptionpos=3}
\def\piccaptiontopside{\c@piccaptionpos=4}
\def\piccaption{\@ifnextchar [{\@piccaption}{\@piccaption[]}}
\def\@piccaption[#1]#2{\c@piccaption=1\def\sh@rtf@rm{#1}\def\capti@nt@xt{#2}}
\def\make@piccaption{%
  \hsiz@\d@breite
  \ifnum\c@piccaptionpos=2
    \advance\hsiz@ -2\fboxsep
  \fi
  \ifnum\c@piccaptionpos>2
    \hsiz@\hsize\advance\hsiz@-\d@breite\advance\hsiz@-\d@pichskip
  \fi
  \setbox\@TEXT=\vbox{\hsize\hsiz@\caption[\sh@rtf@rm]{\capti@nt@xt}}%
}
\def\newcaption{\refstepcounter\@captype\@dblarg{\@newcaption\@captype}}
\long\def\@newcaption#1[#2]#3{%
  \old@par
  \addcontentsline{\csname ext@#1\endcsname }{#1}
    {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \normalsize
    \@newmakecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}%
    \old@par
  \endgroup
}
\long\def\@newmakecaption#1#2{%
  \vskip 10pt%
  \setbox\@tempboxa \hbox {#1: #2}%
  \ifdim \wd\@tempboxa >\hsize%
    \setbox0=\hbox{#1: }\dimen0=\hsize\advance\dimen0 by-\wd0
    \setbox1=\vtop{\hsize=\dimen0 #2}
    \hbox{\box0 \box1}
    \par
  \else \hbox to\hsize {\hfil \box \@tempboxa \hfil}
  \fi
}
\def\parpic{%
  \@ifnextchar ({\iparpic}{\iparpic(0pt,0pt)}
}
\def\iparpic(#1,#2){%
  \@ifnextchar ({\@offsettrue\iiparpic(#1,#2)}%
                {\@offsetfalse\iiparpic(#1,#2)(0pt,0pt)}
}
\def\iiparpic(#1,#2)(#3,#4){%
  \@ifnextchar [{\iiiparpic(#1,#2)(#3,#4)}{\iiiparpic(#1,#2)(#3,#4)[l]}
}
\def\iiiparpic(#1,#2)(#3,#4)[#5]{%
  \@ifnextchar [{\ivparpic(#1,#2)(#3,#4)[#5]}{\ivparpic(#1,#2)(#3,#4)[#5][]}
}
\def\ivparpic(#1,#2)(#3,#4)[#5][#6]#7{%
 \let\par=\old@par\par%
 \hangindent0pt\hangafter1%
 \setbox\@BILD=\hbox{#7}%
 \d@breite=#1\d@breite=\the\d@breite%
 \ifdim\d@breite=0pt\d@breite=\wd\@BILD\fi%
 \c@breite=\d@breite\divide\c@breite by65536%
 \multiply\c@piccaption\c@piccaptionpos%
 \d@hoehe=#2\d@hoehe=\the\d@hoehe%
 \ifdim\d@hoehe=0pt\d@hoehe=\ht\@BILD\advance\d@hoehe by\dp\@BILD\fi%
 \c@hoehe=\d@hoehe\divide\c@hoehe by65536%
 \d@xoff=#3\c@xoff=\d@xoff\divide\c@xoff by65536%
 \d@yoff=\d@hoehe%
 \advance\d@yoff by-#4\c@yoff=\d@yoff\divide\c@yoff by65536%
 \c@pos=1\unitlength1pt%
 \if@offset%
   \setbox\@BILD=\hbox{%
     \begin{picture}(\c@breite,\c@hoehe)%
       \put(0,0){\makebox(\c@breite,\c@hoehe){}}%
       \put(\c@xoff,\c@yoff){\box\@BILD}%
     \end{picture}%
   }%
 \else%
   \setbox\@BILD=\hbox{%
     \begin{picture}(\c@breite,\c@hoehe)%
       \put(0,0){\makebox(\c@breite,\c@hoehe)[#6]{\box\@BILD}}%
     \end{picture}%
   }%
 \fi%
 \ifnum\c@piccaption=2%
   \make@piccaption%
   \advance\d@hoehe\ht\@TEXT\advance\d@hoehe\dp\@TEXT%
   \c@hoehe=\d@hoehe\divide\c@hoehe by65536%
   \setbox\@BILD=\vbox{\box\@BILD\vspace{-5pt}%
                       \hbox{\hspace{\fboxsep}\box\@TEXT}%
                       \vspace{4pt}}%
 \fi%
 \@tfor\@tempa := #5\do{%
   \if\@tempa f\setbox\@BILD=\hbox{\Rahmen(\c@breite,\c@hoehe){\box\@BILD}}\fi%
   \if\@tempa s\setbox\@BILD=\hbox{\Schatten(\c@breite,\c@hoehe){\box\@BILD}}\fi%
   \if\@tempa o\setbox\@BILD=\hbox{\Oval(\c@breite,\c@hoehe){\box\@BILD}}\fi%
   \if\@tempa d\setbox\@BILD=\hbox{\Strich(\c@breite,\c@hoehe){\box\@BILD}}\fi%
   \if\@tempa x\setbox\@BILD=\hbox{\Kasten(\c@breite,\c@hoehe){\box\@BILD}}\fi%
   \if\@tempa l\c@pos=1\fi%
   \if\@tempa r\c@pos=2\fi%
 }%
 \ifnum\c@piccaption=1%
   \make@piccaption%
   \advance\d@hoehe\ht\@TEXT\advance\d@hoehe\dp\@TEXT%
   \c@hoehe=\d@hoehe\divide\c@hoehe by65536%
   \setbox\@BILD=\vbox{\box\@BILD\vspace{-5pt}\hbox{\box\@TEXT}\vspace{4pt}}%
 \fi%
 \ifodd\count0\c@picpos=0\else\c@picpos=\@changemode\fi%
 \pagetotal=\the\pagetotal%
 \d@tmp=\pagegoal\advance\d@tmp by-\pagetotal\advance\d@tmp by-\baselineskip%
 \ifdim\d@hoehe>\d@tmp%
   \vskip 0pt plus\d@hoehe\relax\pagebreak[3]\vskip 0pt plus-\d@hoehe\relax%
   \ifnum\c@picpos=1\c@picpos=0\else\c@picpos=\@changemode\fi%
 \fi%
 \ifnum\c@picpos=1\ifnum\c@pos=1\c@pos=2\else\c@pos=1\fi\fi%
 \ifnum\@listdepth>0
   \@listtrue\parshape 0%
   \advance\hsize -\rightmargin%
   \d@leftskip \leftskip%
   \leftskip \@totalleftmargin%
   \if@inlabel\rule{\linewidth}{0pt}\vskip-\baselineskip\relax\fi%
 \else\@listfalse\medskip%
 \fi%
 \if@list\d@tmpa=\linewidth\else\d@tmpa=\hsize\fi%
 \ifnum\c@piccaption=3%
   \make@piccaption%
   \d@tmp\ht\@TEXT\advance\d@tmp\dp\@TEXT%
   \ifdim\d@hoehe>\d@tmp%
     \setbox\@TEXT=\vbox to\d@hoehe{\vfill\box\@TEXT\vspace{.2\baselineskip}\vfill}%
   \else%
     \setbox\@BILD=\vbox to\d@tmp{\vfill\box\@BILD\vfill}%
     \d@hoehe\d@tmp%
   \fi%
 \fi%
 \ifnum\c@piccaption=4%
   \make@piccaption%
   \d@tmp\ht\@TEXT\advance\d@tmp\dp\@TEXT%
   \setbox\@TEXT=\vbox to\d@hoehe{\vspace{-10pt}\box\@TEXT\vfil}%
   \advance\d@hoehe-\d@tmp%
 \fi%
 \ifnum\c@pos=1\d@tmpa=0pt%
   \ifnum\c@piccaption>2%
      \setbox\@BILD=\hbox{\box\@BILD\hspace{\d@pichskip}\hbox{\box\@TEXT}}%
   \fi%
 \else\advance\d@tmpa by-\wd\@BILD\d@breite=-\d@breite%
   \ifnum\c@piccaption>2%
      \d@tmpa=0pt%
      \setbox\@BILD=\hbox{\hbox{\box\@TEXT}\hspace{\d@pichskip}\box\@BILD}%
   \fi%
 \fi%
 \p@getot@l\the\pagetotal%
 \d@bskip\d@hoehe\advance\d@bskip by\parskip\advance\d@bskip by.3\baselineskip%
 {\noindent\hspace*{\d@tmpa}\relax%
  \box\@BILD\nopagebreak\vskip-\d@bskip\relax\nopagebreak}%
 \d@tmp=-\d@hoehe\divide\d@tmp by\baselineskip%
 \c@zeilen=\d@tmp\advance\c@zeilen by-1%
 \ifdim\d@breite<0pt\advance\d@breite by-\d@pichskip%
 \else\advance\d@breite by\d@pichskip%
 \fi%
 \hangindent=\d@breite%
 \hangafter=\c@zeilen%
 \let\par=\x@par%
 \ifnum\c@piccaption=3%
    \hangindent0pt\hangafter1\let\par=\old@par%
    \vskip\d@hoehe\vskip.2\baselineskip%
 \fi%
 \c@piccaption=0%
}
\newdimen\ptoti
\newdimen\ptotii
\def\x@par{%
 \ptoti\pagetotal
 \old@par
 \ptotii\pagetotal
 \ifdim\ptoti=\ptotii
   \d@tmp\d@hoehe
 \else
   \d@tmp\baselineskip
   \multiply\d@tmp by\prevgraf
   \advance\d@tmp by\parskip
   \global\advance\d@hoehe by-\d@tmp\d@tmp=\d@hoehe
 \fi
 \ifdim\d@hoehe>0pt
   \divide\d@tmp by\baselineskip\c@zeilen=-\d@tmp\advance\c@zeilen by-1
   \c@zeilen=\the\c@zeilen
 \else\c@zeilen=0
 \fi
 \ifnum\c@zeilen<0\hangafter=\c@zeilen\hangindent=\d@breite
 \else\let\par=\old@par
   \hangindent 0pt
   \leftskip \d@leftskip
   \if@list\parshape \@ne \@totalleftmargin \linewidth
     \advance\hsize \rightmargin
   \fi
 \fi
}
\def\picskip#1{%
 \let\par=\old@par
 \par
 \pagetotal\the\pagetotal
 \c@tmp=#1\relax
 \ifnum\c@tmp=0
   \d@tmp\baselineskip\multiply\d@tmp by\prevgraf\advance\d@tmp\parskip
   \ifdim\p@getot@l<\pagetotal
     \advance\d@hoehe by-\d@tmp\advance\d@hoehe by1ex
     \ifdim\d@hoehe>0pt\vspace*{\d@hoehe}\fi
   \fi
   \ifdim\p@getot@l=\pagetotal
     \advance\d@hoehe by-\d@tmp\advance\d@hoehe by1ex
     \ifdim\d@hoehe>0pt\vspace*{\d@hoehe}\fi
   \fi
 \else\hangafter=-\c@tmp\hangindent=\d@breite
 \fi
 \leftskip \d@leftskip
 \if@list\parshape \@ne \@totalleftmargin \linewidth
   \advance\hsize \rightmargin
 \fi
}
\def\hpic{%
  \@ifnextchar ({\ihpic}{\ihpic(0pt,0pt)}%)
}
\def\ihpic(#1,#2){%
  \@ifnextchar ({\@offsettrue\iihpic(#1,#2)}%)
                {\@offsetfalse\iihpic(#1,#2)(0pt,0pt)}%
}
\def\iihpic(#1,#2)(#3,#4){%
  \@ifnextchar [{\iiihpic(#1,#2)(#3,#4)}{\iiihpic(#1,#2)(#3,#4)[l]}%]
}
\def\iiihpic(#1,#2)(#3,#4)[#5]{%
  \@ifnextchar [{\ivhpic(#1,#2)(#3,#4)[#5]}{\ivhpic(#1,#2)(#3,#4)[#5][]}%]
}
\def\ivhpic(#1,#2)(#3,#4)[#5][#6]#7{%
  \setbox\@BILD=\hbox{#7}%
  \d@breite=#1\d@breite=\the\d@breite%
  \ifdim\d@breite=0pt\d@breite=\wd\@BILD\fi%
  \c@breite=\d@breite\divide\c@breite by65536%
  \d@hoehe=#2\d@hoehe=\the\d@hoehe%
  \ifdim\d@hoehe=0pt\d@hoehe=\ht\@BILD\advance\d@hoehe by\dp\@BILD\fi%
  \c@hoehe=\d@hoehe\divide\c@hoehe by65536%
  \d@xoff=#3\c@xoff=\d@xoff\divide\c@xoff by65536%
  \d@yoff=\d@hoehe%
  \advance\d@yoff by-#4\c@yoff=\d@yoff\divide\c@yoff by65536%
  \c@pos=0\d@tmpa=\parindent\parindent=0pt\unitlength1pt%
  \if@offset
    \setbox\@BILD=\hbox{%
      \begin{picture}(\c@breite,\c@hoehe)%
        \put(0,0){\makebox(\c@breite,\c@hoehe){}}%
        \put(\c@xoff,\c@yoff){\box\@BILD}%
      \end{picture}%
    }%
  \else%
    \setbox\@BILD=\hbox{%
      \begin{picture}(\c@breite,\c@hoehe)%
        \put(0,0){\makebox(\c@breite,\c@hoehe)[#6]{\box\@BILD}}%
      \end{picture}%
    }%
  \fi%
  \@tfor\@tempa := #5\do{%
    \if\@tempa f\setbox\@BILD=\hbox{\Rahmen(\c@breite,\c@hoehe){\box\@BILD}}\fi%
    \if\@tempa s\setbox\@BILD=\hbox{\Schatten(\c@breite,\c@hoehe){\box\@BILD}}\fi%
    \if\@tempa o\setbox\@BILD=\hbox{\Oval(\c@breite,\c@hoehe){\box\@BILD}}\fi%
    \if\@tempa d\setbox\@BILD=\hbox{\Strich(\c@breite,\c@hoehe){\box\@BILD}}\fi%
    \if\@tempa x\setbox\@BILD=\hbox{\Kasten(\c@breite,\c@hoehe){\box\@BILD}}\fi%
    \if\@tempa t\c@pos=1\fi%
    \if\@tempa b\c@pos=2\fi%
  }%
 \ifnum\c@pos=0\parbox{\d@breite}{\makebox[0cm]{}\\\box\@BILD\smallskip}\fi%
 \ifnum\c@pos=1\parbox[t]{\d@breite}{\makebox[0cm]{}\\\box\@BILD\smallskip}\fi%
 \ifnum\c@pos=2\parbox[b]{\d@breite}{\makebox[0cm]{}\\\box\@BILD\smallskip}\fi%
 \parindent=\d@tmpa%
}
\def\Rahmen(#1,#2)#3{%
  \c@whole=\@wholewidth\divide\c@whole by65536%
  \c@half=\@halfwidth\divide\c@half by65536%
  \c@tmpa=#1\advance\c@tmpa by\c@whole\advance\c@tmpa by\c@whole%
  \c@tmpb=#2\advance\c@tmpb by\c@whole\advance\c@tmpb by\c@whole%
  \begin{picture}(\c@tmpa,\c@tmpb)%
    \put(\c@whole,\c@half){\framebox(#1,#2){#3}}%
  \end{picture}%
  \global\advance\d@breite by2\@wholewidth%
  \global\advance\d@hoehe by2\@wholewidth%
}
\def\Schatten(#1,#2)#3{%
  \c@whole=\@wholewidth\divide\c@whole by65536%
  \c@half=\@halfwidth\divide\c@half by65536%
  \c@shad=\d@shad\divide\c@shad by65536%
  \c@tmp=\c@whole\advance\c@tmp by\c@whole\c@tmpd=\c@tmp%
  \advance\c@tmp by\c@shad%
  \advance\c@tmpd by#1%
  \advance\c@half by\c@shad%
  \c@tmpa=#1\advance\c@tmpa by\c@tmp%
  \c@tmpb=#2\advance\c@tmpb by\c@tmp%
  \begin{picture}(\c@tmpa,\c@tmpb)%
    \put(\c@whole,\c@half){\framebox(#1,#2){#3}}%
    \put(\c@shad,0){\rule{\c@tmpd pt}{\c@shad pt}}%
    \put(\c@tmpd,0){\rule{\c@shad pt}{#2 pt}}%
  \end{picture}%
  \global\advance\d@breite by2\@wholewidth\global\advance\d@breite by\d@shad%
  \global\advance\d@hoehe by2\@wholewidth\global\advance\d@hoehe by\d@shad%
}
\def\Oval(#1,#2)#3{%
  \@wholewidth=0.4pt%
  \c@tmpa=\the#1\divide\c@tmpa by2%
  \c@tmpb=\the#2\divide\c@tmpb by2%
  \begin{picture}(#1,#2)%
    \put(\c@tmpa,\c@tmpb){\oval(#1,#2)}%
    \put(0.4,0.4){#3}%
  \end{picture}%
  \global\advance\d@breite by1pt\global\advance\d@hoehe by1pt%
}
\def\Strich(#1,#2)#3{%
  \c@whole=\@wholewidth\divide\c@whole by65536%
  \c@half=\@halfwidth\divide\c@half by65536%
  \c@dash=\d@dash\divide\c@dash by65536%
  \c@tmp=\c@whole\advance\c@tmp by\c@whole%
  \c@tmpa=#1\advance\c@tmpa by\c@tmp%
  \c@tmpb=#2\advance\c@tmpb by\c@tmp%
  \c@tmpc=#1\advance\c@tmpc by\c@whole%
  \c@tmpd=#2\advance\c@tmpd by\c@whole%
  \begin{picture}(\c@tmpa,\c@tmpb)%
    \put(\c@half,\c@half){\dashbox{\c@dash}(\c@tmpc,\c@tmpd){#3}}%
  \end{picture}%
  \global\advance\d@breite by2\@wholewidth%
  \global\advance\d@hoehe by2\@wholewidth%
}
\def\Kasten(#1,#2)#3{%
  \@wholewidth=0.4pt%
  \c@boxl=\d@boxl\divide\c@boxl by65536\c@boxl=\the\c@boxl%
  \c@tmpa=#1\advance\c@tmpa by\c@boxl%
  \c@tmpb=#2\advance\c@tmpb by\c@boxl%
  \c@tmp=#2%
  \begin{picture}(\c@tmpa,\c@tmpb)%
    \put(0,\c@boxl){\framebox(#1,#2){#3}}%
    \put(\c@boxl,0){\line(-1,1){\c@boxl}}%
    \put(\c@boxl,0){\line(1,0){#1}\line(-1,1){\c@boxl}}%
    \put(\c@boxl,0){\put(#1,0){\line(0,1){\c@tmp}%
         \put(0,\c@tmp){\line(-1,1){\c@boxl}}}}%
  \end{picture}%
  \global\advance\d@breite by\d@boxl%
  \global\advance\d@hoehe by\d@boxl%
}
\newbox\env@box%
\newdimen\d@envdp
\newcount\c@hsize
\newcount\c@envdp
\newdimen\d@envb
\long\def\frameenv{\@ifnextchar [{\@frameenv}{\@frameenv[\textwidth]}}
\long\def\@frameenv[#1]{%
 \hsiz@=\textwidth  \textwidth=#1  \d@envb=#1
 \advance\textwidth by-2\@wholewidth
 \advance\textwidth by-2\fboxsep
 \hsize=\textwidth   \linewidth=\textwidth
 \setbox\env@box=\vbox\bgroup}%
\def\endframeenv{%
 \egroup%
 \hsize=\hsiz@  \textwidth=\hsiz@  \linewidth=\hsiz@
 \c@breite=\d@envb   \divide\c@breite by65536
 \advance\d@envb by-2\@wholewidth
 \c@hsize=\d@envb  \divide\c@hsize by65536%
 \d@envdp=\dp\env@box  \advance\d@envdp by\ht\env@box%
 \advance\d@envdp by2\fboxsep%
 \d@hoehe=\d@envdp   \advance\d@hoehe by2\@wholewidth
 \c@hoehe=\d@hoehe   \divide\c@hoehe by65536
 \c@envdp=\d@envdp   \divide\c@envdp by65536%
 \c@tmp=\@wholewidth \divide\c@tmp by65536
 \vskip\@wholewidth%
 \unitlength 1pt\noindent%
 \begin{picture}(\c@breite,\c@hoehe)(0,0)
   \put(\c@tmp,\c@tmp){\framebox(\c@hsize,\c@envdp){\box\env@box}}
 \end{picture}%
}
\long\def\shadowenv{\@ifnextchar [{\@shadowenv}{\@shadowenv[\textwidth]}}
\long\def\@shadowenv[#1]{%
 \hsiz@=\textwidth  \textwidth=#1  \d@envb=#1
 \advance\textwidth by-2\@wholewidth
 \advance\textwidth by-2\fboxsep
 \advance\textwidth by-\d@shad%
 \hsize=\textwidth   \linewidth=\textwidth
 \setbox\env@box=\vbox\bgroup}%
\def\endshadowenv{%
 \egroup
 \hsize=\hsiz@  \textwidth=\hsiz@  \linewidth=\hsiz@
 \d@tmpa=\d@envb
 \c@breite=\d@envb   \divide\c@breite by65536
 \advance\d@envb by-2\@wholewidth  \advance\d@envb by-\d@shad
 \c@hsize=\d@envb  \divide\c@hsize by65536%
 \d@envdp=\dp\env@box  \advance\d@envdp by\ht\env@box%
 \advance\d@envdp by2\fboxsep%
 \c@envdp=\d@envdp   \divide\c@envdp by65536%
 \d@hoehe=\d@envdp
 \advance\d@hoehe by2\@wholewidth  \advance\d@hoehe by\d@shad
 \c@hoehe=\d@hoehe    \divide\c@hoehe by65536
 \c@shad =\d@shad     \divide\c@shad  by65536
 \c@tmp=\@wholewidth  \divide\c@tmp by65536
 \advance\d@tmpa by-2\d@shad
 \c@xoff =\d@tmpa     \divide\c@xoff by65536
 \advance\c@xoff by\c@shad  \advance\c@xoff by-1
 \advance\d@envdp by\@wholewidth
 \vskip\@halfwidth
 \unitlength 1pt\noindent%
 \begin{picture}(\c@breite,\c@hoehe)(0,0)
    \put(\c@tmp,\c@shad){\framebox(\c@hsize,\c@envdp){\box\env@box}}
    \put(\c@shad,0){\rule{\d@tmpa}{\d@shad}}%
    \put(\c@xoff,0){\rule{\d@shad}{\d@envdp}}%
 \end{picture}%
 \vskip\@halfwidth
}
\long\def\dashenv{\@ifnextchar [{\@dashenv}{\@dashenv[\textwidth]}}
\long\def\@dashenv[#1]{%
 \hsiz@=\textwidth  \textwidth=#1  \d@envb=#1
 \advance\textwidth by-2\@wholewidth  \advance\textwidth by-2\fboxsep
 \hsize=\textwidth   \linewidth=\textwidth
 \setbox\env@box=\vbox\bgroup}%
\long\def\enddashenv{%
 \egroup
 \hsize=\hsiz@  \textwidth=\hsiz@  \linewidth=\hsiz@
 \c@breite=\d@envb   \divide\c@breite by65536
 \advance\d@envb by-\@wholewidth
 \c@hsize=\d@envb  \divide\c@hsize by65536%
 \d@envdp=\dp\env@box  \advance\d@envdp by\ht\env@box%
 \advance\d@envdp by2\fboxsep%
 \advance\d@envdp by\@wholewidth
 \d@hoehe=\d@envdp   \advance\d@hoehe by2\@wholewidth
 \c@hoehe=\d@hoehe   \divide\c@hoehe by65536
 \c@envdp=\d@envdp   \divide\c@envdp by65536%
 \c@dash=\d@dash     \divide\c@dash  by65536%
 \c@whole=\@wholewidth  \divide\c@whole by65536
 \c@half=\@halfwidth  \divide\c@half by 65536
 \noindent\unitlength 1pt
 \begin{picture}(\c@breite,\c@hoehe)(0,0)
   \put(\c@half,\c@whole){\dashbox{\c@dash}(\c@hsize,\c@envdp){\box\env@box}}
 \end{picture}%
}
\long\def\ovalenv{\@ifnextchar [{\@ovalenv}{\@ovalenv[\textwidth]}}%
\long\def\@ovalenv[#1]{%
 \hsiz@=\textwidth  \textwidth=#1  \d@envb=#1
 \advance\textwidth by-4\fboxsep
 \hsize=\textwidth   \linewidth=\textwidth
 \setbox\env@box=\vbox\bgroup}%
\long\def\endovalenv{%
 \egroup
 \hsize=\hsiz@  \textwidth=\hsiz@  \linewidth=\hsiz@
 \@wholewidth=0.4pt
 \c@breite=\d@envb   \divide\c@breite by65536
 \advance\d@envb by-2\@wholewidth
 \c@hsize=\d@envb  \divide\c@hsize by65536%
 \d@envdp=\dp\env@box  \advance\d@envdp by\ht\env@box%
 \advance\d@envdp by4\fboxsep%
 \c@envdp=\d@envdp   \divide\c@envdp by65536%
 \d@hoehe=\d@envdp   \advance\d@hoehe by2\@wholewidth
 \c@hoehe=\d@hoehe   \divide\c@hoehe by65536
 \c@tmpa=\c@hsize   \divide\c@tmpa by2%
 \c@tmpb=\c@envdp   \divide\c@tmpb by2%
 \d@tmpa=2\fboxsep   \advance\d@tmpa by\@wholewidth
 \c@xoff=\d@tmpa     \divide\c@xoff  by65536%
 \advance\d@tmpa by\dp\env@box
 \c@yoff=\d@tmpa     \divide\c@yoff  by65536%
 \unitlength 1pt\noindent
 \begin{picture}(\c@breite,\c@hoehe)(0,0)
   \put(\c@tmpa,\c@tmpb){\oval(\c@hsize,\c@envdp)}
   \put(\c@xoff,\c@yoff){\box\env@box}%
 \end{picture}%
}
\let\set@op\relax
\newif\if@op
\def\overprint{%
  \@optrue
  \set@op
  \ignorespaces
}
\def\knockout{%
  \@opfalse
  \set@op
  \ignorespaces
}
\def\testname{pdftex.def}
\ifx \Gin@driver \testname
  \AtBeginDocument{
    \immediate\pdfobj{<< /Type /ExtGState /op false /OP false /OPM 0 >>}
    \edef\op@off{\the\pdflastobj}
    \immediate\pdfobj{<< /Type /ExtGState /op true /OP true /OPM 1 >>}
    \edef\op@on{\the\pdflastobj}
    \immediate\pdfobj{ << %
      /GSko \op@off\space 0 R %
      /GSop \op@on\space 0 R >>}
    \edef\@extgs{\the\pdflastobj}
    \edef\next{\global\noexpand\pdfpageresources={\the\pdfpageresources
      \space /ExtGState \@extgs\space 0 R }}
    \next
  }
  \def\set@op{%
    \if@op
      \pdfliteral direct {/GSop gs}%
    \else
      \pdfliteral direct {/GSko gs}%
    \fi
    \aftergroup\reset@op}
  \def\reset@op{%
    \if@op
      \pdfliteral direct {/GSop gs}%
    \else
      \pdfliteral direct {/GSko gs}%
    \fi
  }
\fi
\def\testname{dvips.def}
\ifx \Gin@driver \testname
  \def\set@op{%
    \if@op
      \special{ps:true setoverprint}%
    \else
      \special{ps:false setoverprint}%
    \fi
    \aftergroup\reset@op}
  \def\reset@op{%
    \if@op
      \special{ps:true setoverprint}%
    \else
      \special{ps:false setoverprint}%
    \fi
  }
\fi
\@opfalse
\overprint
\endinput
%%
%% End of file `sesamanuel.cls'.
