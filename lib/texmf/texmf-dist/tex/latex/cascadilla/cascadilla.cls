%% cascadilla.cls
%% Copyright 2008-2012 Max Bane
%% Version 1.8.2
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Max Bane.
%
% This work consists of the files cascadilla.cls and example.tex.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This LaTeX class provides an extension of the "article" document class that
% can be used to typeset papers conforming to the stylesheet of the Cascadilla
% Proceedings Project (http://www.lingref.com/cpp/authors/style.html), which
% is used by a number of linguistics conference proceedings (e.g., WCCFL).
% Suggestions, questions, and bug reports should be directed to Max Bane at
% max.bane@gmail.com.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changes:
% Version 1.8.2: Made footnote marks flush with left edge of body text.
% Version 1.8.1: Fixed centering of author line by simplifying \blankline
% command - thanks to Christopher Piñón.
% Version 1.8: Added author's signature statement at the top of the first page,
% and the "nosignature" option to suppress it.
% Version 1.7.1: Added commented example of listing multiple
% authors/institutions to example.tex.
% Version 1.7: Added "a4paper" option for typsetting on A4 paper, which is
% allowed by the Cascadilla stylesheet with particular margin settings.
% Version 1.6.1: Fixed compile bug caused by ill-formed date string in
% \ProvidesClass.
% Version 1.6: Redefined \thanks command once more, to conform with the new
% requirements for an "invisible asterisk".
% Version 1.5: Redefined \thanks command for use in titles.
% Version 1.4: Modified bibpunct to use cascadilla's (Cascadilla, 2006:13)
% style.
% Version 1.3: Put in some missing \selectfont's, adjusted \abovecaptionskip
% and \belowcaptionskip for use with \centering rather than the center
% environment.
% Version 1.2: Restored blank space between title and author
% Version 1.1: Made title matter optional, added notimes option, added
% additional blank line after title, section labels end with a space rather
% than a quad, made figure/table captions bold, added immediate subsection
% commands.
% Version 1.0: Initial release.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identification

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cascadilla}[2012/01/17 v1.8.2 Class for Cascadilla Proceedings
Project articles, by Max Bane]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options

\RequirePackage{ifthen}

\newboolean{hyphenate}
\newboolean{copyright}
\setboolean{copyright}{true}
\newboolean{nopagenums}
\setboolean{nopagenums}{true}
\newboolean{times}
\setboolean{times}{true}
\newboolean{a4paper}
\newboolean{signature}
\setboolean{signature}{true}

\DeclareOption{hyphenate}{\setboolean{hyphenate}{true}}
\DeclareOption{nocopyright}{\setboolean{copyright}{false}}
\DeclareOption{pagenums}{\setboolean{nopagenums}{false}}
\DeclareOption{notimes}{\setboolean{times}{false}}
\DeclareOption{a4paper}{\setboolean{a4paper}{true}}
\DeclareOption{nosignature}{\setboolean{signature}{false}}

\ProcessOptions \relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package Loading

% We're just an extension of the built-in article class.
% The Cascadilla stylesheet requires US Letter paper and 10pt body fontsize
% (which is happily LaTeX's default fontsize)
% Update (version 1.7): the Cascadilla stylesheet now admits A4 paper, with
% different margins; check for the "a4paper" option before loading the article
% class and setting the margins.
\ifthenelse{\boolean{a4paper}}{
    \LoadClass[a4paper]{article} 
    % Set up the margin widths/heights using the geometry package
    \RequirePackage[a4paper,left=3.15cm,right=3.15cm,top=2.54cm,bottom=4.29cm,foot=0.75in]{geometry}
}{
    \LoadClass[letterpaper]{article} 
    % Set up the margin widths/heights using the geometry package
    \RequirePackage[letterpaper,left=1.38in,right=1.38in,top=1.0in,bottom=1.0in,foot=0.75in]{geometry}
}


% Stylesheet requires Times Roman font
\ifthenelse{\boolean{times}}{
    \RequirePackage{times}
}{}

% Stylesheet requires the the first paragraphs of all sections be indented.
% The standardly available indentfirst package does that for us.
\RequirePackage{indentfirst}

% We'll need fancyhdr for typesetting the copyright notice required by the
% stylesheet
\RequirePackage{fancyhdr}

% We'll use titlesec to format section titles according to the stylesheet
\RequirePackage{titlesec}

% We use natbib for formatting the bibliography (plus a hacked .bst file)
\RequirePackage{natbib}

% Cascadilla prefers if table/figure captions are labeled bold
\RequirePackage[labelfont=bf]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Definitions

\newcommand{\blankline}{\quad\\}

% Booleans for whether various strings have been set
\newboolean{haveAuthor}
\newboolean{haveTitle}
\newboolean{haveInstitution}

\newboolean{afterPar}

% Commands for setting author, title, completed date, institution and copyright year
\renewcommand{\author}[1]{\gdef\@cascauthor{#1}\gdef\@author{#1}\setboolean{haveAuthor}{true}}
\renewcommand{\title}[1]{\gdef\@casctitle{#1}\gdef\@title{#1}\setboolean{haveTitle}{true}}
\newcommand{\completed}[1]{\gdef\@cascdate{#1}}
\newcommand{\institution}[1]{\gdef\@institution{#1}\setboolean{haveInstitution}{true}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}}
%\renewcommand{\thanks}[1]{\def\thefootnote{\fnsymbol{footnote}}\footnote[1]{#1}}
\renewcommand{\thanks}[1]{\def\thefootnote{\fnsymbol{footnote}}\footnotetext[1]{#1}}

%% Redefine \maketitle to conform to cascadilla stylesheet
\renewcommand{\maketitle}{%
    \begin{center}
        \ifthenelse{\boolean{signature}}{
            \normalsize
            \selectfont
            This printout has been approved by me, the author. Any mistakes in
this printout will not be fixed by the publisher. Here is my signature and the
date:
\underline{\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\quad}\\
            \blankline
        }{\blankline\blankline\blankline}
        \ifthenelse{\boolean{haveTitle}}{
            \fontsize{18}{18}
            \selectfont
            \textbf{\@title}\\
            %\blankline
            \vspace{18pt}
            \normalsize
        }{}
    
        \ifthenelse{\boolean{haveAuthor}}{
            \ifthenelse{\boolean{haveTitle}}{\blankline}{}
            \fontsize{14pt}{14pt}
            \selectfont
            \textbf{\@author}
            \normalsize
            \selectfont
        }{}
    
        \ifthenelse{\boolean{haveInstitution}}{
            \normalsize
            \selectfont
            \textbf{\@institution}
        }{}
        
        \blankline
    \end{center}
}

% The stylesheet (apparently) demands justified text *without* any
% hyphenation (i.e., only word and letter spacing), even though this is
% really ugly and violates every typographic convention, and ends up 
% looking like a cheap MS Word document. The following parameter settings
% discourage TeX's layout algorithm from breaking lines with syllabic hyphens.
% Can be suppressed by the "hyphenate" class option.
\ifthenelse{\boolean{hyphenate}}{}{
    \hyphenpenalty=5000
    \tolerance=1000
}

% Paragraph indents should be one quarter inch
\parindent=0.25in

% Footnotes should be set in 9pt, which is \small
\let\footnotesize\small

% Adjust footnotes so that numbers appear flush with margin.
% Implementation inspired by answers at:
% http://tex.stackexchange.com/questions/40976/align-footnote-mark-with-text-margin
\renewcommand{\@makefntext}[1]{%
  \settowidth{\@tempdima}{\@thefnmark} \parindent \dimexpr\@tempdima+.75em\relax%
  \noindent\makebox[1em][l]{\textsuperscript{\@thefnmark}}#1
}

% Disable page numbers. Suppressed by "pagenums" class option.
\ifthenelse{\boolean{nopagenums}}{
    \pagestyle{empty}
    \setlength{\footskip}{0in}
}{}

% Reduce the spacing around captions in tables and figures
\setlength{\abovecaptionskip}{12pt}
\setlength{\belowcaptionskip}{-5pt}

% The following bit of code increases the size of the bottom margin on the
% first page only, to make room for the copyright statement
\ifthenelse{\boolean{copyright}}{
    \setlength{\textheight}{8.75in}
    \AtBeginDocument{\setlength{\textheight}{9in}}
}{}

% The first page of the article gets a copyright statement, as specified in
% the cascadilla stylesheet
% Suppressed by the "nocopyright" class option.
\newcommand\CascadillaCopyright {
    \fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[L]{\ifthenelse{\boolean{nopagenums}}{\vspace{0.1in}}{\vspace{-0.65in}}\small\copyright{}\ \@copyrightyear\ \@cascauthor\\Cascadilla Proceedings
    Project\\Completed \@cascdate}
    \renewcommand{\headrulewidth}{0pt}
    }
}
\ifthenelse{\boolean{copyright}}{
    \AtBeginDocument{\CascadillaCopyright{}}
    \AtBeginDocument{\thispagestyle{plain}}
}{
    \ifthenelse{\boolean{nopagenums}}{
        \AtBeginDocument{\thispagestyle{empty}}
    }{}
}

% Tell natbib to indent hanging lines by a quarter inch
\setlength{\bibhang}{0.25in}

% Format section headings according to the cascadilla stylesheet
\titlelabel{\thetitle.\ }
\titleformat*{\section}{\fontsize{12pt}{0}\bf}
\titleformat*{\subsection}{\fontsize{11pt}{0}\itshape}
\titleformat*{\subsubsection}{\fontsize{11pt}{0}\itshape}
\titlespacing{\section}{0pt}{11pt}{10pt}
\titlespacing{\subsection}{0pt}{11pt}{10pt}
\titlespacing{\subsubsection}{0pt}{11pt}{10pt}

% Commands for immediate subsections, which require different spacing than
% normal headings
\newcommand{\immedsubsection}[1]{\vspace{-9pt}\subsection{#1}}
\newcommand{\immedsubsubsection}[1]{\vspace{-9pt}\subsubsection{#1}}

% Provide a command for the bibliography
\newcommand{\cascadillabibliography}[1]{\small\renewcommand{\baselinestretch}{2}\bibliographystyle{cascadilla}\bibliography{#1}}

% Set up citation punctuation for, e.g., (Shosted, 2006:13).
\AtBeginDocument{
    \bibpunct[:]{(}{)}{;}{a}{,}{,}
}
