%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
% This is file 'skeyval-testclass.cls', version 1.3, 2013/05/15.           %
%                                                                          %
% This package and accompanying files may be distributed and/or            %
% modified under the conditions of the LaTeX Project Public License,       %
% either version 1.3 of this license or any later version. The latest      %
% version of this license is in http://www.latex-project.org/lppl.txt      %
% and version 1.3 or later is part of all distributions of LaTeX           %
% version 2005/12/01 or later.                                             %
%                                                                          %
% The LPPL maintenance status of this software is 'author-maintained'.     %
%                                                                          %
% This software is provided 'as it is', without warranty of any kind,      %
% either expressed or implied, including, but not limited to, the          %
% implied warranties of merchantability and fitness for a particular       %
% purpose.                                                                 %
%                                                                          %
% The following files constitute the skeyval bundle and must be            %
% distributed as a whole:                                                  %
%                                                                          %
%  README, skeyval.sty, skeyval-core.tex, skeyval-for.tex,                 %
%  skeyval-view.sty, skeyval-ltxpatch.sty, skeyval-ltxcmds.tex,            %
%  skeyval-pstkey.sty, skeyval-pstkey.tex, skeyval-testclass.cls,          %
%  skeyval-testpkg.sty, skeyval-pokayoke1, skeyval-pokayoke2,              %
%  skeyval-view-pokayoke1.                                                 %
%                                                                          %
% Copyright (c) 2010-2013 Ahmed Musa (amusa22@gmail.com).                  %
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%

\ProvidesClass{skeyval-testclass}[2013/05/15 v1.3 skeyval test class (AM)]
\NeedsTeXFormat{LaTeX2e}[2011/06/27]
\@ifpackageloaded{skeyval}{}{\RequirePackage{skeyval}}
\@ifpackageloaded{xcolor}{}{\RequirePackage{xcolor}}
\@ifpackageloaded{pifont}{}{\RequirePackage{pifont}}
\@ifpackageloaded{tikz}{}{\RequirePackage{tikz}}

\ifdefined\skvtestcnt\else\newcount\skvtestcnt\fi
\skvatbegineverypage{\skvcl@maybewm}
\let\skvcl@maybewm\relax
\def\skvcl@watermark{%
  \tikz[overlay,remember picture]{%
    \node [\skvcl@watermarkcolor,inner sep=0pt,rotate=45,align=center,
      scale=\skvcl@watermarkscale,font=\fontseries{b}\fontfamily{bch}%
      \fontsize{\skvcl@fontsize@a}{\skvcl@fontsize@b}\selectfont] at
      ([shift={(\skvcl@watermarkxshift,-\skvcl@watermarkyshift)}]%
      current page.north west){%
      \skvcl@watermarktext
    };
  }%
}

\skvrobustdef*\skvcl@titlecmds{%
  \setcounter{footnote}{0}%
  \def\do##1{\global\let##1\@empty}%
  \do\@thanks\do\@author\do\@date\do\@title
  \def\do##1{\global\let##1\relax}%
  \do\thanks\do\maketitle\do\@maketitle\do\title\do\author\do
  \date\do\and\let\do\relax
  \let\@fnsymbol\orig@fnsymbol
}
\let\orig@fnsymbol\@fnsymbol

\skvrobustredef*\skv@fnsymbol#1{%
  \unskip\ifcase#1\or\ding{'106}\or\ding{'110}\or\ding{'111}\or
  \ding{'112}\or\ding{'113}\or\ding{'114}\or\ding{'121}\or
  \ding{'122}\else\@ctrerr\fi
}
\skvrobustdef*\skvcl@newfootnotestyle{%
  \def\@makefnmark{%
    \rlap{\@textsuperscript{\normalfont\skv@fnsymbol\@thefnmark}}%
  }%
  \long\def\@makefntext##1{%
    \parindent1em\relax\noindent
    \hb@xt@1.8em{\hss\@textsuperscript{%
      \normalfont\skv@fnsymbol\@thefnmark}%
    }%
    ##1%
  }%
}
\skvnewlet\skv@sav@footnote\footnote
\skvnewlet\skv@sav@thanks\thanks
\AtEndOfPackage{%
  \skvdisablekeys[SKVC]{title}{insertwatermark}%
}
\AtBeginDocument{%
  \def\footnote{\unskip\skv@sav@footnote}%
  \def\thanks{\unskip\skv@sav@thanks}%
  \skvdisablekeys[SKVC]{textemphasis}{dummy-option}%
  \skvdisablekeys[SKVC]{title}{%
    maketitlepage,firstpagenumber,pagenumberstyle
  }%
}
\let\skvcl@settitlepageno\@gobble

% Example of option and nonoption keys:
\skvordkeys[KV]{fam}{testkey1,testkey2}[value]{}
\skvoptionkeys[KV]{fam}{testkey1}
\skvnonoptionkeys[KV]{fam}{testkey2}

% LaTeX will zap spaces in key name, anyway. So our options don't have
% spaces within themselves.

\directkeys*{%
  .every unknown option={
    \PassOptionsToClass{\CurrentOption}{article}
  },
  .message type when disabled option is invoked=error,
  .prefix=SKVC,
  % Extended text emphasis:
  .family=textemphasis,
  .hp=xem@,
  .new options={
    .initialize keys after define,
    .ord/{testkey1,testkey2,testkey3}/default,
    .bool/useitalic/true,
    .bool/usebold/true,
    .bool/usecolor/true,
    .cmd/color/red,
    .bool/make-textemphasis-inactive/true/
      \ifskvindef\else
        \skvifbool xem@make-textemphasis-inactive\then
          \PackageInfo{skeyval-testclass}
            {Extended text emphasis has been made inactive}
          \let\xem\emph
        \fi
      \fi
    ,
    .ord/dummy-option/\@nil,
  },
  .links={
    useitalics/useitalic,
    usecolour/usecolor,
    colour/color,
  },
  .option keys = {testkey1},
  .nonoption keys = {testkey2,testkey3},
  % Modifying the article title:
  .change family=title,
  .hp=skvcl@,
  .new options={
    .bool/putdate/true,
    .cmd/datefont/\large,
    .bool/clearpage/true,
    .bool/maketitlepage/true/
      \skvifbool skvcl@maketitlepage\then
        \ifskvindef\else
          \PassOptionsToClass{titlepage}{article}
        \fi
      \fi
    ,
    .cmd/firstpagenumber/\@nil/
      \ifx\skvcl@firstpagenumber\@nnil\else
        \skvensureinteger{page number}\skvcl@firstpagenumber
        \AtBeginDocument{%
          \gdef\pagenumbering##1{%
            \global\c@page\skvcl@firstpagenumber\relax
            \gdef\thepage{\csname @##1\endcsname\c@page}%
          }%
          % Default:
          \pagenumbering{arabic}%
          \let\skvcl@settitlepageno\@iden
        }%
      \fi
    ,
    .cmd/pagenumberstyle/\@nil/
      \ifx\skvcl@pagenumberstyle\@nnil\else
        \skvafterbegindocument{\pagenumbering{#1}}%
      \fi
    ,
    .cmd/pretitleskip/10pt,
    .cmd/posttitleskip/10pt,
    .cmd/authorfont/\large,
    .cmd/titlefont/\huge,
    .bool/insertwatermark/true/
      \skvifbool skvcl@insertwatermark\then
        \ifskvindef\else
          \let\skvcl@maybewm\skvcl@watermark
        \fi
      \fi
    ,
    .cmd/watermarkxshift/.5\paperwidth,
    .cmd/watermarkyshift/.5\paperheight,
    .cmd/watermarktext/DRAFT/
      \skvstripouterbraces{2}\skvcl@watermarktext
    ,
    .cmd/fontsize/{14.4,17}/
      \def\skvcl@fontsize@a{#1}\def\skvcl@fontsize@b{#2}
    ,
    .arg/fontsize/{#1,#2},
    .cmd/watermarkscale/5,
    .cmd/watermarkcolor/gray!55,
  },
  .slots={
    showdate/putdate=#1,
    first-page-number/firstpagenumber=#1,
    titlepage/maketitlepage=#1,
  },
  % Ececute the options in the current family. If any of the options
  % isn't found, report error (ie, don't save the key to the list of
  % 'remaining keys'). Unknown options should be flagged immediately.
  % Use '.execute options+' or '.execute options in all families' to
  % execute options in multiple families.
  .execute options={
    putdate,datefont,clearpage=false,pretitleskip,posttitleskip,
    authorfont,titlefont,watermarkscale,firstpagenumber,
    insertwatermark=false,watermarkxshift,watermarkyshift,
    watermarktext,watermarkcolor,fontsize
  },
  .families={textemphasis,title},
  .process options in all families,
}
%\show\skvcurrentpoxkeys

% testkey1 is an option key: don't set it outside option list:
% \skvsetkeys[SKVC]{textemphasis}{testkey1}

\skvrobustdef*\setupskvtestclass{%
  \skvsetkeys*+[SKVC]{textemphasis,title}%
}

% Setting up extended text emphasis:
\skvrobustdef*\setuptextemphasis#1{\skvsetkeys[SKVC]{textemphasis}{#1}}
\newcommand*\xem[1]{\xem@emph{\xem@bold{\xem@colortext{\xem@color}{#1}}}}
\newcommand*\xem@emph{%
  \skvifbool xem@useitalic\then
    \expandafter\emph
  \else
    \expandafter\@firstofone
  \fi
}
\newcommand*\xem@bold{%
  \skvifbool xem@usebold\then
    \expandafter\textbf
  \else
    \expandafter\@firstofone
  \fi
}
\newcommand*\xem@colortext{%
  \skvifbool xem@usecolor\then
    \expandafter\textcolor
  \else
    \expandafter\@secondoftwo
  \fi
}

\LoadClass{article}

\if@titlepage
  \renewcommand\maketitle{%
    \ifskvcl@clearpage
      \clearpage
    \fi
    \begin{titlepage}%
      \skvcl@newfootnotestyle
      \let\footnotesize\small
      \let\footnoterule\relax
      \let\footnote\thanks
      \null\vfil
      \vskip\skvcl@pretitleskip\relax
      \begin{center}%
        {\skvcl@titlefont\@title\par}%
        \vskip\skvcl@posttitleskip\relax
        {%
          \skvcl@authorfont
          \lineskip.75em\relax
          \begin{tabular}[t]{c}%
            \@author
          \end{tabular}\par
        }%
        \vskip1.5em\relax
        \skvifbool skvcl@putdate\then{{\skvcl@datefont\@date}}\fi
      \end{center}\par
      \@thanks
      \vfil\null
    \end{titlepage}%
    \skvcl@settitlepageno{\c@page\skvcl@firstpagenumber\relax}%
    \skvcl@titlecmds
  }
\else
  \renewcommand\maketitle{%
    \par
    \begingroup
    \skvcl@newfootnotestyle
    \if@twocolumn
      \ifnum\col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
    \endgroup
    \skvcl@titlecmds
  }
  \def\@maketitle{%
    \newpage
    \null
    \vskip\skvcl@pretitleskip\relax
    \begin{center}%
      \let\footnote\thanks
      {\skvcl@titlefont\@title\par}%
      \vskip\skvcl@posttitleskip\relax
      {\skvcl@authorfont
        \lineskip.5em\relax
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par
      }%
      \vskip1em\relax
      \skvifbool skvcl@putdate\then{\skvcl@datefont\@date}\fi
    \end{center}%
    \par
    \vskip1.5em\relax
  }
\fi

\endinput
