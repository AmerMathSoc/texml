% CPES/WEMPEC/UW-Madison Slide Class...
%
% By Eric Benedict, 26 September 2000
% WEMPEC, UW-Madison
%
%===============================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uwmslide}[2000/09/26 Univ. WI-Madison Slide Format]
%Pass options onto the slides class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{slides}}
\ProcessOptions\relax
\LoadClass{article}
\RequirePackage{epsfig}
\usepackage{times}		% Times works good for *.pdf conversions

% Define a flag, \@@slide, to indicate if the current slide
%  should include a \newpage command, 1=include it, 0=don't
\newcount\@@slide
\global\@@slide=1

% Define the 'adjustment' for the first slide after the title
% slide.  Its a dirty trick, but seems to work...
\newlength{\@@adjslide}
\setlength{\@@adjslide}{-1.5in}


% Define the width of the left half of the slide
%\newdimen{\@@leftslidewidth}
%\global\@@leftslidewidth=4.25in  % define a default, just to be safe
\newlength{\@@leftslidewidth}
\setlength{\@@leftslidewidth}{4.25in}  % define a default, just to be safe
\newlength{\@@rightslidewidth}



% Define a flag, \@@slidetype to indicate the type of double
% item slide which is being used.
%  0 = Not being used --> \slidedivider generates error msg
%  1 = plain doubleslide
%  2 = leftitem
%  3 = rightitem
%  4 = doubleitem
\newcount\@@slidetype
\global\@@slidetype=0	

%==========================
% Set the paper size
%===========================
\setlength\paperheight{8.5in}
\setlength\paperwidth{11in}
\special{! /landplus90 true store} % rotate 90 deg clockwise in dvips
\special{landscape} % set the paper size for dvips
\setlength\textwidth{9.5in}
\setlength\textheight{6in}
\setlength\hoffset{-0.25in}
\setlength\voffset{-0.25in}
\setlength\oddsidemargin{0in}
\setlength\evensidemargin{0in}

\setlength\footskip{2bp}



% Enlarge the headheight for the logo
\setlength\headheight{74bp}
\setlength\topmargin{-37bp}

% Place the logo and rules for the header/footers.
\IfFileExists{logo.eps}{
\renewcommand{\@oddhead}{\vbox{\psfig{file=logo.eps,height=72bp} \hfill\\[1.5bp] \rule{\textwidth}{0.4bp}}}
\renewcommand{\@evenhead}{\vbox{\psfig{file=logo.eps,height=72bp} \hfill\\[1.5bp] \rule{\textwidth}{0.4bp}}}
} % Logo file exists
{\ClassWarning{uwmslide}{Logo file logo.eps not found.\MessageBreak  Omitting logo in header}
\renewcommand{\@oddhead}{\rule{\textwidth}{0.4bp}}
\renewcommand{\@evenhead}{\rule{\textwidth}{0.4bp}}
} % Logo file AWOL...
%
\renewcommand{\@oddfoot}{\parbox{\textwidth}{\rule{\textwidth}{0.4pt} \\[1pt]  \rule{1pt}{0pt}\hfill {\rm \thepage}}}
\renewcommand{\@evenfoot}{\parbox{\textwidth}{\rule{\textwidth}{0.4pt} \\[1pt] \rule{1pt}{0pt}\hfill {\rm \thepage}}}



%================================
%
%  Define the larger font sizes appropriate for slides
%   (copied from the slitex.cls file...)
%
%================================
\def\ifourteenpt{14.4}
\def\iseventeenpt{17.28}
\def\itwentypt{20.74}
\def\itwentyfourpt{24.88}
\def\itwentyninept{28.66}
\def\ithirtyfourpt{34.4}
\def\ifortyonept{41.28}
\def\@setfontsize@parms#1#2#3#4#5#6#7#8{%
   \lineskip #1\relax%
   \parskip #2\relax
   \abovedisplayskip #3\relax
   \belowdisplayskip #4\relax
   \abovedisplayshortskip #5\relax
   \belowdisplayshortskip #6\relax
  \setbox\strutbox=\hbox{\vrule \@height#7\p@\@depth#8\p@\@width\z@}%
  \baselineskip\baselinestretch\baselineskip
  \normalbaselineskip\baselineskip}
\DeclareMathSizes{13.82}{13.82}{10}{7}
\DeclareMathSizes{16.59}{16.59}{12}{7}
\DeclareMathSizes{19.907}{19.907}{16.59}{13.82}
\DeclareMathSizes{23.89}{23.89}{19.907}{16.59}
\DeclareMathSizes{28.66}{28.66}{23.89}{19.907}
\DeclareMathSizes{34.4}{34.4}{28.66}{23.89}
\DeclareMathSizes{41.28}{41.28}{34.4}{28.66}
\renewcommand{\normalsize}{%
      \@setfontsize\normalsize\itwentypt{28\p@ plus3\p@ minus4\p@}%
      \@setfontsize@parms
            {2pt}%
            {30\p@ plus18\p@ minus9\p@}%
            {15\p@ plus3\p@ minus3\p@}%
            {10\p@ plus3\p@ minus3\p@}%
            {10\p@ plus3\p@}
            \abovedisplayshortskip
            {17}{7}}
\normalsize
\renewcommand{\small}{\@setfontsize\small\iseventeenpt{19\p@ plus3\p@ minus\p@}%
           \@setfontsize@parms
            {2\p@}%
            {15\p@ plus15\p@ minus7\p@}%
            {12\p@ plus3\p@ minus3\p@}%
            {9\p@ plus3\p@ minus3\p@}%
            {6\p@ plus3\p@}%
            \abovedisplayshortskip
            {13.5}{5.6}}
\let\footnotesize=\small
\let\scriptsize=\small
\renewcommand{\tiny}{\@setfontsize\tiny\ifourteenpt{16\p@ plus2\p@ minus\p@}%
          \@setfontsize@parms
            {2pt}%
            {14\p@ plus3\p@ minus10\p@}%
            {11\p@ plus3\p@ minus10\p@}%
            \abovedisplayskip
            {8\p@ plus3\p@ minus5\p@}%
            {\z@ plus3\p@}%
            {10}{4}}
\renewcommand{\large}{\@setfontsize\large\itwentyfourpt{42\p@ plus8\p@ minus5\p@}%
           \@setfontsize@parms
            {2\p@}%
            {40\p@ plus20\p@ minus4\p@}%
            {20\p@ plus8\p@ minus3\p@}%
            \abovedisplayskip
            {10\p@ plus5\p@}%
            \abovedisplayshortskip
            {20}{8.5}}

\renewcommand{\Large}{\@setfontsize\Large\itwentyninept{48\p@ plus10\p@ minus6\p@}%
           \@setfontsize@parms
            {2\p@}%
            {48\p@ plus30\p@ minus6\p@}%
            {24\p@ plus10\p@ minus6\p@}%
            \abovedisplayskip
            {12\p@ plus8\p@}%
            \abovedisplayshortskip
            {27}{11}}

\renewcommand{\LARGE}{\@setfontsize\LARGE\ithirtyfourpt{52\p@ plus10\p@ minus6\p@}%
           \@setfontsize@parms
            {2\p@}%
            {52\p@ plus30\p@ minus6\p@}%
            {24\p@ plus10\p@ minus6\p@}%
            \abovedisplayskip
            {12\p@ plus8\p@}%
            \abovedisplayshortskip
            {27}{11}}

\renewcommand{\huge}{\@setfontsize\huge\ifortyonept{60\p@ plus10\p@ minus6\p@}%
           \@setfontsize@parms
            {2\p@}%
            {60\p@ plus30\p@ minus6\p@}%
            {24\p@ plus10\p@ minus6\p@}%
            \abovedisplayskip
            {12\p@ plus8\p@}%
            \abovedisplayshortskip
            {27}{11}}

\let\Huge\huge
\renewcommand\baselinestretch{}
\setlength\parindent{\z@}



%======================================================
% Adjust the spacing in between the list items (@listi=1st level,  ii=2nd
% level, etc).
%======================================================
\renewcommand{\@listi}{{\leftmargin\leftmargini
            \parsep .25\parskip
            \topsep \parsep
            \itemsep\parskip
            \partopsep \z@}}
\renewcommand{\@listii}{{\leftmargin\leftmarginii
             \labelwidth\leftmarginii
             \advance\labelwidth-\labelsep
             \parsep .2\parskip
             \topsep \parsep
             \itemsep\parskip}}
\renewcommand{\@listiii}{{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep}}
\renewcommand{\@listiv}{{\leftmargin\leftmarginiv
             \labelwidth\leftmarginiv
             \advance\labelwidth-\labelsep}}
\renewcommand{\@listv}{{\leftmargin\leftmarginv
            \labelwidth\leftmarginv
            \advance\labelwidth-\labelsep}}
\renewcommand{\@listvi}{{\leftmargin\leftmarginvi
             \labelwidth\leftmarginvi
             \advance\labelwidth-\labelsep}}




%=============================================================================
% TITLEPAGE
%  Re-define the footer so that it has the rule line, but no number at
%  the start of the titlepage, then add the page number back in the 
%  footer for the rest of the slides...
%=============================================================================
\renewenvironment{titlepage}{%
\renewcommand{\@oddfoot}{\vbox{\rule{\textwidth}{0.4pt} \\[1pt]  \rule{1pt}{0pt}}}
 \newpage }{%
 \newpage 
 }

%=====================================================================
% MAKETITLE 
%   Adjust the \maketitle command slightly for slide usage
%=====================================================================
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \let\footnotesize\large \let\footnoterule\relax \let\footnote\thanks
    \null\vfill
   \begin{center}%
    {\Large \@title \par}%
    \vskip 3em%
    {\large
       \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}%\par
    \@thanks
    \vfill\null
  \end{titlepage}
  \setcounter{footnote}{0}
  \setcounter{page}{1} %title page is NOT counted
  \let\thanks\relax
  \let\maketitle\relax \
  \gdef\@thanks{}
  \gdef\@author{}
  \gdef\@title{}
  \global\@@slide=0 % Set flag to indicate that the title page fix is
%                   % required for the next slide
}





%===================================================
%  Slide Environment
%
%   This environment creates a generic slide which
%   has a title centered in Huge text at the top
%   and the remaining body left unconstrained.
%
%===================================================
\newenvironment{slide}[1]{%
\ifnum\@@slide=0   % Check for 1st slide
  \global\@@slide=1  % Set flag so we won't come back
  \vspace*{\@@adjslide}     % Dirty trick to fix the offset which
%                    %  appears on the 1st after the title slide...
\else
  \newpage
\fi%
{\Huge \begin{center} #1\end{center}}
}
{}




%===================================================
%  Item Slide Environment
%
%   This environment creates a slide which
%   has a title centered in Huge text at the top
%   and the remaining body consisting of an itemized
%   list.
%
%===================================================
\newenvironment{itemslide}[1]{% \begin{itemslide} things
\ifnum\@@slide=0   % Check for 1st slide
  \global\@@slide=1  % Set flag so we won't come back
  \vspace*{\@@adjslide}     % Dirty trick to fix the offset which
%                    %  appears on the 1st after the title slide...
\else
  \newpage
\fi%
{\Huge \begin{center} #1\end{center}}
\begin{itemize}
}
{\end{itemize}
}%\end{itemslide} things




%===================================================
%
%   \slidedivider is used by the multiple-side items 
%   to seperate the left and right hand sides of each
%   slide.
%
%===================================================
\newcommand{\slidedivider}{%
\setlength\@@rightslidewidth{\m@ne\@@leftslidewidth}
\global\addtolength{\@@rightslidewidth}{8.5in}
\ifcase\@@slidetype
%                             Error Case
\ClassWarning{uwmslide}{\protect\slidedivider\space used outside of environment.\MessageBreak
Extra \protect\slidedivider\space command ignored}
%
\or                        % plain double slide
%
\end{minipage}
\hfill
\begin{minipage}[c]{\@@rightslidewidth}
%
\or                        % leftitem slide
%
\end{itemize}
\end{minipage}
\hfill
\begin{minipage}[c]{\@@rightslidewidth}
%
\or                        % rightitem slide
%
\end{minipage}
\hfill
\begin{minipage}[c]{\@@rightslidewidth}
\begin{itemize}
%
\or                        % doubleitem slide
%
\end{itemize}
\end{minipage}
\hfill
\begin{minipage}[c]{\@@rightslidewidth}
\begin{itemize}
%
\else
%
\fi
}

%===================================================
%  Double Slide Environment
%
%    This environment creates a slide with two
%    equal spaced minipages.  This can be used to
%    put two pictures next to each other.  It is
%    also used for the leftitem, rightitem and doubleitem
%    environments...
%
%    This environment requires the \slidedivider
%    command to be used in between the two slide 
%    halves.
%===================================================
\newenvironment{doubleslide}[2][4.25in]{% \begin{doubleslide} things
\ifnum\@@slidetype=0 \global\@@slidetype=1 \fi % Set slide type 
%                                                if not already set
\ifnum\@@slide=0   % Check for 1st slide
  \global\@@slide=1  % Set flag so we won't come back
  \vspace*{\@@adjslide}     % Dirty trick to fix the offset which
%                    %  appears on the 1st after the title slide...
\else
  \newpage
\fi%
%\global\@@leftslidewidth=#1  % let \slidedivider know the size
\setlength{\@@leftslidewidth}{#1}  % let \slidedivider know the size
{\Huge \begin{center} #2\end{center}}
\begin{minipage}[c]{#1}
}
{\end{minipage}         % End the minipage
\global\@@slidetype=0   % Clear the slide type flag
}%\end{doubleslide} things





%===================================================
%  leftitem Slide Environment
%
%    This environment creates a slide with two
%    equal spaced minipages.  The left hand side
%    minipage is an itemized list.
%
%    This environment requires the \slidedivider
%    command to be used in between the two slide 
%    halves.
%===================================================
\newenvironment{leftitem}[2][4.25in]{% \begin{leftitem} things
\global\@@slidetype=2  % Set type to leftitem
\begin{doubleslide}[#1]{#2}
\begin{itemize}
}
{\end{doubleslide}}%\end{leftitem} things






%===================================================
%  rightitem Slide Environment
%
%    This environment creates a slide with two
%    equal spaced minipages.  The right hand side
%    minipage is an itemized list.
%
%    This environment requires the \slidedivider
%    command to be used in between the two slide 
%    halves.
%===================================================
\newenvironment{rightitem}[2][4.25in]{% \begin{rightitem} things
\global\@@slidetype=3  % Set type to rightitem
\begin{doubleslide}[#1]{#2}
}
{\end{itemize}
\end{doubleslide}}%\end{rightitem} things







%===================================================
%  doubleitem Slide Environment
%
%    This environment creates a slide with two
%    equal spaced minipages.  The right hand side
%    minipage is an itemized list.
%
%    This environment requires the \slidedivider
%    command to be used in between the two slide 
%    halves.
%===================================================
\newenvironment{doubleitem}[2][4.25in]{% \begin{doubleitem} things
\global\@@slidetype=4  % Set type to doubleitem
\begin{doubleslide}[#1]{#2}
\begin{itemize}
}
{\end{itemize}
\end{doubleslide}}%\end{doubleitem} things

