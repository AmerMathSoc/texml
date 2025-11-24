%%
%% This is file `semproc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% semproc.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% semproc --- LaTeX class for seminar proceedings
%% E-mail: tobias.columbus@kit.edu
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{semproc}
  [2015/06/15 v0.1 LaTeX class for seminar proceedings]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions\relax
\LoadClass{scrreprt}
\RequirePackage{xkeyval}
\PassOptionsToPackage{dvipsnames}{xcolor}
\RequirePackage{xcolor}
\RequirePackage{etoc}
\RequirePackage%
  [unicode=true,colorlinks=true,hypertexnames=false]
  {hyperref}
\RequirePackage{bookmark}
\hypersetup{allcolors={RoyalBlue}}
\RequirePackage{etoolbox}
\RequirePackage{biblatex}
\RequirePackage{csquotes}
\providecaptionname{german,ngerman}%
  {\talkname}{Vortrag}
\providecaptionname{german,ngerman}%
  {\notesname}{Notizen von}
\providecaptionname{german,ngerman}%
  {\nospeakername}{Kein Vortragender}
\providecaptionname{german,ngerman}%
  {\localtocheadingname}{Inhalt}
\providecaptionname{german,ngerman}%
  {\summaryname}{Zusammenfassung}
\providecaptionname{USenglish,UKenglish,english}%
  {\talkname}{Talk}
\providecaptionname{USenglish,UKenglish,english}%
  {\notesname}{Notes by}
\providecaptionname{USenglish,UKenglish,english}%
  {\nospeakername}{No speaker}
\providecaptionname{USenglish,UKenglish,english}%
  {\localtocheadingname}{Contents}
\providecaptionname{USenglish,UKenglish,english}%
  {\summaryname}{Abstract}
\newkomafont{talkhead}
  {\usekomafont{disposition}\usekomafont{section}}
\newkomafont{talktitle}
  {\usekomafont{disposition}\usekomafont{chapter}}
\newkomafont{talkspeakers}
  {\usekomafont{disposition}}
\newkomafont{globaltocspeaker}
  {\sffamily}
\newkomafont{globaltocnumber}
  {\usekomafont{disposition}}
\newkomafont{globaltocpage}
  {\usekomafont{disposition}}
\newkomafont{globaltoctitle}
  {\usekomafont{disposition}}
\newkomafont{localtocheading}
  {\usekomafont{disposition}}
\newkomafont{localtocnumber}
  {\sffamily}
\newkomafont{localtocpage}
  {\sffamily}
\newkomafont{localtoctitle}
  {\sffamily}
\newkomafont{summaryheading}
  {\usekomafont{disposition}}
\newcommand{\nonumchapter}[1]{%
  \chapter*{#1}%
  \etoctoccontentsline*{chapter}{#1}{0}%
}
\newcounter{talk}
\setcounter{talk}{0}
\def\talkautorefname{\talkname}
\@addtoreset{section}{talk}
\@addtoreset{equation}{section}
\renewcommand\thesection{\arabic{section}}
\renewcommand\theHsection{\arabic{section}}
\renewcommand\theequation{\thesection.\arabic{equation}}
\newcommand{\semproc@talk@head}[1]{%
  {\noindent\usekomafont{talkhead}\talkname~\thetalk}%
  {\par\nobreak\vskip2ex}%
  {\usekomafont{talktitle}\noindent#1}
  \vskip1ex\noindent\hrulefill\vskip1ex
  {
    \usekomafont{talkspeakers}
    \noindent\semproc@talk@speaker%
    \ifdefvoid{\semproc@talk@notes}{}{%
      \hfill{\notesname~\semproc@talk@notes}%
    }
    \par\nobreak%
  }%
  \vskip 3.5ex
}
\define@key{talk}{speaker}%
  [\nospeakername]%
  {\def\semproc@talk@speaker{#1}}
\define@key{talk}{notes}%
  []%
  {\def\semproc@talk@notes{#1}}
\newcommand*\talk[2][\empty]{%
  \presetkeys{talk}{speaker,notes}{}%
  \setkeys{talk}{#1}%
  \refstepcounter{talk}%
  \cleardoubleoddplainpage%
  \thispagestyle{\chapterpagestyle}%
  \semproc@talk@head{#2}
  \renewcommand\@currentlabelname{#2}
  \newrefsection%
  \etoctoccontentsline*{talk}%
    {\protect\numberline{\thetalk}#2}{0}
  \etoctoccontentsline{speaker}%
    {\protect\numberline{}\semproc@talk@speaker}
  \renewcommand\@currentlabelname{#2}
}
\newlength{\semproc@toc@skip}
\setlength{\semproc@toc@skip}{4em}
\newlength{\semproc@toc@calc}
\newcommand\semproc@toc@skipafter[1]{%
  \settowidth{\semproc@toc@calc}%
    {#1\etocthenumber}%
  \addtolength{\semproc@toc@calc}%
    {-\semproc@toc@skip}%
  \setlength{\semproc@toc@calc}%
    {-\semproc@toc@calc}%
  \noindent{#1\etocnumber}%
  \hskip\semproc@toc@calc%
}
\newcommand{\globaltoc}{%
  \begingroup
    \etocsetnexttocdepth{1}
    \etocsetlevel{speaker}{1}
    \etocsetlevel{section}{2}
    \etocsetlevel{talk}{0}
    \etocsetlevel{chapter}{0}
    \etocsetstyle{speaker}
      {}
      {}
      {%
        \hskip\semproc@toc@skip%
        {\usekomafont{globaltocspeaker}\etocthename}%
        \nobreak\hfill\nobreak\par%
      }
      {}
    \etocsetstyle{talk}
      {}
      {\vskip1ex\leavevmode\relax}
      {%
        \semproc@toc@skipafter{\usekomafont{globaltocnumber}}%
        {%
          \usekomafont{globaltoctitle}%
          \etocname%
        }%
        \nobreak%
        \leaders\hbox to .3cm{\hss.}\hfill%
        \nobreak%
        \makebox[1cm][r]{%
          \usekomafont{globaltocpage}%
          \hss\etocpage%
        }\par%
      }
      {}
    \tableofcontents
  \endgroup
}
\newcommand{\localtoc}{%
  \begingroup
    \let\parskip@old%
    \parskip\parskip0ex%
    \etocsetnexttocdepth{2}
    \etocsetlevel{section}{1}
    \etocsetlevel{subsection}{2}
    \etocsetlevel{talk}{-2}
    \etocsetlevel{speaker}{-2}
    \etocsetlevel{chapter}{-2}
    \etocsetstyle{section}
      {}
      {%
        \ifthenelse{\equal{\etocthenumber}{1}}%
        {}%
        {\vskip1ex}%
      }
      {%
        \semproc@toc@skipafter{%
          \usekomafont{localtocnumber}%
        }%
        {%
          \usekomafont{localtoctitle}%
          \etocname%
        }%
        \nobreak%
        \leaders\hbox to .3cm{\hss.}\hfill%
        \nobreak%
        \makebox[1cm][r]{%
          \usekomafont{localtocpage}%
          \hss\etocpage%
        }\vskip0.5ex%
      }
      {}
    \etocsetstyle{subsection}
      {}
      {}
      {%
        \semproc@toc@skipafter{%
          \usekomafont{localtocnumber}%
        }%
        {%
          \usekomafont{localtoctitle}%
          \etocname
        }%
        \nobreak%
        \leaders\hbox to .3cm{\hss.}\hfill%
        \nobreak%
        \makebox[1cm][r]{%
          \usekomafont{localtocpage}%
          \hss\etocpage%
        }\vskip0.5ex%
      }
      {}
      \etocsettocstyle{%
        \centerline{%
          \usekomafont{localtocheading}%
          \localtocheadingname%
        }
      }{}
    \localtableofcontents
    \parskip\parskip@old
  \endgroup
}
\newenvironment{summary}
  {%
    \centerline{%
      \usekomafont{summaryheading}%
      \summaryname%
    }%
  \let\parindent@old\parindent\parindent0em%
  }{%
    \parindent\parindent@old\vskip3.5ex%
  }
\newcommand{\localbib}{%
  \printbibliography[heading=subbibliography]%
}
%% 
%% Copyright (C) 2015 by Tobias Columbus <tobias.columbus@kit.edu>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% Tobias Columbus.
%% 
%% This work consists of the files semproc.dtx
%% and the derived files           semproc.ins,
%%                                 semproc.pdf,
%%                                 semproc.cls,
%%                                 example.tex,
%%                                 example.bib,
%%                                 example.pdf
%% 
%%
%% End of file `semproc.cls'.
