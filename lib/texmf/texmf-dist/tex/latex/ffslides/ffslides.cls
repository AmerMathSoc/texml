
%=== Identification ===========================================================
\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{ffslides}[2015/11/19 Freeform slides based on the article class]


%=== Initial code =============================================================
\RequirePackage{ifthen}     %needed for boolean in showgrid option declaration.
\RequirePackage{calc}               %needed for some length calculation in \qi.
\newboolean{gridvisible}
\newboolean{hasbgroundfile}
\newboolean{hasheaderfile}
\newboolean{hasfooterfile}


%=== Declaration of options ===================================================
\DeclareOption{showgrid}{\setboolean{gridvisible}{true}}

% Article-class options we wish to retain.
% Note font-size options 10pt, 11pt, 12pt have minimal impact on for document 
% appearance but are retained in case they're needed for compatibility with 
% other packages or fonts.
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{article}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{article}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{article}}

% Check unknown options to see if they are specifying background, header, or 
% footer files. If option <name> is entered, then a file matching 
% bground-<name>.txt is read to define \drawbackground. Similarly, files 
% matching header-<name>.txt or footer-<name>.txt are read to define 
% \drawheader or \drawfooter, respectively. Only the first match of each kind 
% is processed.
\DeclareOption*{%
  \ifthenelse{\boolean{hasbgroundfile}}{}%
    {
      \InputIfFileExists{bground-\CurrentOption.txt}%
        {\setboolean{hasbgroundfile}{true}}{}
    }
  \ifthenelse{\boolean{hasheaderfile}}{}%
    {
      \InputIfFileExists{header-\CurrentOption.txt}%
        {\setboolean{hasheaderfile}{true}}{}
    }
  \ifthenelse{\boolean{hasfooterfile}}{}%
    {
      \InputIfFileExists{footer-\CurrentOption.txt}%
        {\setboolean{hasfooterfile}{true}}{}
    }
}

%=== Execution of options =====================================================
\ProcessOptions\relax


%=== Package loading ==========================================================
\LoadClass[10pt,oneside,notitlepage]{article}
\RequirePackage{pstricks}  %-Used everywhere.
\RequirePackage{geometry}  %-For setting up the page.
\RequirePackage{lastpage}  %-Used in default footer.
\RequirePackage{twoopt}    %-Allows 2 optional arguments in macros.
\RequirePackage{graphics}  %-For putfig.
\RequirePackage{hyperref}  %-Used in \makesection, \makesubsection.



%=== Main code ================================================================

%---Define the lengths we'll need----------------
\newlength{\pgheight}                                %-Used to set page height.
\newlength{\pgwidth}                                  %-Used to set page width.
\newlength{\dtextwidth}                                       %-Used in \dtext.
\newlength{\qitemwidth}                                          %-Used in \qi.
\newlength{\qbulletwidth}                                        %-Used in \qi.
\newlength{\labeliwidth}                                         %-Used in \qi.
\newlength{\labeliiwidth}                                        %-Used in \qi.
\newlength{\labeliiiwidth}                                       %-Used in \qi.
\newlength{\qparskip}                                            %-Used in \qi.
\newlength{\outercapheight}  %-Approx. height of a capital letter; Used in \qi.
\newlength{\qgapheight}                    %-Used for better spacing after \qi.

%---Set up the page-------------------------------
% \ffpage{height}{aspect} is used to set up the page dimensions. 
% 
% Required arguments
%     height:  The desired page height (approximately the number of 
%              singlespaced lines).
%     aspect:  The aspect ratio (width/height). E.g. use 1.3333 for 4:3 pages,
%              1.7778 for 16:9 pages.
%
% \ffpage should be used as early as possible in the preamble.  Especially avoid
% using macros & packages that modify line spacing before calling \ffpage.
\newcommand{\ffpage}[2]{
  \setlength{\pgheight}{#1\baselineskip}
  \setlength{\pgwidth}{#2\pgheight}
  \geometry{margin=0in,
            paperwidth=\pgwidth,
            paperheight=\pgheight}
  \psset{xunit=\paperwidth}
  \psset{yunit=-\paperheight}
}
\ffpage{22}{1.3333}  %-Set up page defaults.
\AtBeginDocument{   %-Set these at end of preamble to prevent them being changed.
  \setlength{\topskip}{0pt}                   %-keeps origin at top left corner.
  \setlength{\parindent}{0pt}                 %-keeps origin at top left corner.
}

%---showgrid command-----------------------------
\newrgbcolor{ffgridcolor}{0.9 0.9 1}      %-Can be redefined in the document.
\newcommand{\showgrid}{%
  \psgrid[gridcolor=ffgridcolor,
          subgridcolor=ffgridcolor,
          gridwidth=0.1ex,
          subgridwidth=0.1ex,
          xunit=0.1\paperwidth,
          yunit=-0.1\paperheight,
          subgriddiv=10,
          subgriddots=3,
          gridlabels=0](0,0)(10,10)
}

%---drawbackground command-----------------------
\ifthenelse{\boolean{hasbgroundfile}}%
  {}% Do nothing if file found; otherwise define default.
  {
    \newcommand{\drawbackground}{%
      % Default is an empty background
    }
  }

%---drawheader command---------------------------
\ifthenelse{\boolean{hasheaderfile}}%
  {}% Do nothing if file found; otherwise define default.
  {
    \newcommand{\drawheader}[1]{%
      \ctext[lB]{0.05}{0.07}{0.95}{\Large\textbf{#1}}
      \psline[linewidth=0.1ex](0.05,0.09)(1,0.09)
      \psline[linewidth=0.1ex](0,0.095)(0.85,0.095)
    }
  }

%---drawfooter command---------------------------
\ifthenelse{\boolean{hasfooterfile}}%
  {}% Do nothing if file found; otherwise define default.
  {
    \newcommand{\drawfooter}{%
      \ctext[l]{0.01}{0.975}{0.98}{\scriptsize \hfill \thepage /\pageref{LastPage}}
      \psline[linewidth=0.1ex](0.05,0.945)(1,0.945)
      \psline[linewidth=0.1ex](0,0.94)(0.85,0.94)
    }
  }

%---\dtext[L][R]{content}------------------------
% Creates the default text minipage. It is used in the \normalpage macro to add 
% the text/content area to a new page.  It can also be used to manually add 
% such an area to a \blankpage. 
% 
% Optional arguments
%     L:  Left edge of the text column (a number in [0,1]).  Defaults to 
%         \DefaultTextLeftEdge.
%     R:  Right edge of the text column (a number in [0,1]).  Defaults to 
%         \DefaultTextRightEdge.
% Required arguments
%     content:  The contents of the minipage.
%
% The three quantities below are used in the \dtext macro to set up the default
% text-area minipage on a \newpage.  The numbers are fractions of the page 
% width or height, measured from the top left corner. They can be redefined in 
% the document.
\newcommand{\dtextleftedge}{0.05}       %-Location of left edge of text.
\newcommand{\dtextrightedge}{0.95}      %-Location of right edge of text.
\newcommand{\dtexttopedge}{.14}         %-Location of top edge of text.
\newcommand{\dtextinclude}{}            %-To put in just before the content.
\newcommandtwoopt{\dtext}[3][\dtextleftedge][\dtextrightedge]{%
  \setlength{\dtextwidth}{#2\paperwidth}%
  \addtolength{\dtextwidth}{-#1\paperwidth}%
  \rput[tl](#1, \dtexttopedge){%
    \begin{minipage}{\dtextwidth}
      \setlength{\parskip}{.5\baselineskip}
      \setlength{\parindent}{0em}
      \mbox{}\dtextinclude#3\par
    \end{minipage}
  }
}


%--- \normalpage[L][R]{title}{content} ----------
% Creates a page with header, footer, and default text region. 
% 
% Optional arguments
%     L:  Left edge of the text column (a number in [0,1]).  Defaults to 
%         \dtextleftedge.
%     R:  Right edge of the text column (a number in [0,1]).  Defaults to 
%         \DefaultTextRightEdge.
% Required arguments
%     title:    The title of the slide (passed to \drawheader)
%     content:  The contents of the minipage.
\newcommandtwoopt{\normalpage}[4][\dtextleftedge][\dtextrightedge]{%
  \newpage%
  \drawbackground%
  \drawheader{#3}%
  \drawfooter%
  \ifthenelse{\boolean{gridvisible}}{\showgrid}{}%
  \dtext[#1][#2]{#4}%
}


%--- \blankpage ---------------------------------
% Takes no arguments and just creates a new page with the background only, to 
% which other page elements can be added manually. Useful for large graphics, 
% title slides, etc.
\newcommand{\blankpage}{%
  \newpage%
  \drawbackground%
  \ifthenelse{\boolean{gridvisible}}{\showgrid}{}%
}


%--- \ctext[RP]{x}{y}{width}{content} -----------
% "Custom text:" adds a minipage to the desired location on the slide.
% 
% Optional arguments
%     RP:  Specifies where the pstricks reference point is located on the new
%          minipage.  Some combination of l, r for horizontal location and 
%          t, b, B for vertical placement (see pstricks documentation for more 
%          info). The default is tl for top left. Note: entering an invalid 
%          value (like "c") for the reference point will cause it to be at the
%          center of the minipage.
% Required arguments
%     x:        Horizontal location of the reference point (a number in [0,1]).
%     y:        Vertical location of the reference point (a number in [0,1]).
%     width:    Width of the minipage, as a fraction of the paper width.
%     content:  The contents of the minipage.
\newcommand{\ctextinclude}{}
\newcommand{\ctext}[5][tl]{%
  \rput[#1](#2, #3){%
    \begin{minipage}{#4\paperwidth}
      \setlength{\parskip}{.5\baselineskip}
      \setlength{\parindent}{0em}
      \mbox{}\ctextinclude#5\par
    \end{minipage}
  }
}


%--- \btext[RP][style]{x}{y}{width}{content} ----------------------------------
% "Boxed text:" adds a boxed minipage to the desired location on the slide. 
% 
% Optional arguments
%     RP:     The reference point (see \ctext for description)
%     style:  pstricks graphics parameters (e.g. linecolor=red) to change the 
%             appearance of the box. The default style is that of the \btextbox 
%             defined in the visual style section. 
% Required arguments
%     x:        Horizontal location of the reference point (a number in [0,1]).
%     y:        Vertical location of the reference point (a number in [0,1]).
%     width:    Width of the minipage, as a fraction of the paper width.
%     content:  The contents of the minipage.
\newpsstyle{btextboxstyle}{linecolor=blue, linewidth=.5pt, 
                                   linearc=0.5em, framesep=0.5ex,
                                   fillcolor=white, fillstyle=solid,
                                   cornersize=absolute}
\newpsobject{btextbox}{psframebox}{style=btextboxstyle}
\newcommand{\btextinclude}{}
\newcommandtwoopt{\btext}[6][tl][]{%
  \rput[#1](#3, #4){%
    \btextbox[#2]{%
    \begin{minipage}{#5\paperwidth}
      \setlength{\parskip}{.5\baselineskip}
      \setlength{\parindent}{0em}
      \mbox{}\btextinclude#6\par
    \end{minipage}
}}}


%--- \putfig[RP]{x}{y}{width}{file} -------------
% Used for making figures. Allows a a graphics file to be placed on the page 
% with specified location and scaling.
% 
% Optional arguments
%     RP:     The reference point (see \ctext for description)
% Required arguments:
%     x:        Horizontal location of the reference point (a number in [0,1]).
%     y:        Vertical location of the reference point (a number in [0,1]).
%     width:    Width of the graphic, as a fraction of the paper width.
%     file:     The filename of the figure.
\newcommand{\putfig}[5][tl]{%
  \rput[#1](#2,#3){\psscaleboxto(#4\paperwidth,0){\includegraphics{#5}}}
}


%--- \qi[bullet]{item} --------------------------------------------------------
% "Quick item:" quick creation of a structure similar to a single line in an 
% itemize environment.  Produces text with a left part ("bullet") and a right 
% part ("item"). The bullet is typeset in LR mode in the containing scope, and
% the right part is typeset as a minipage such that the whole thing looks like 
% a hanging-indented paragraph. Two standard bullets \BUL and \BULL were 
% defined in the visual style section.
% 
% The command is not just for making lists. By changing the bullet and/or 
% nesting \qi commands it is possible to achieve different layouts of 
% content that might be useful, "on the fly" as you write. See examples in
% the template.
% 
% Optional arguments
%     bullet:  The left-side content (defaults to \BUL).
% Required arguments
%     item:  The right-side content.
\newcommand{\qitemi}{%
  \settowidth{\labeliwidth}{\labelitemi\quad}%          %-quad is two enspaces.
  \makebox[\labeliwidth][r]{\labelitemi\enspace}}
\newcommand{\qitemii}{%
  \settowidth{\labeliiwidth}{\qitemi\labelitemii\quad}%
  \makebox[\labeliiwidth][r]{\labelitemii\enspace}}
\newcommand{\qitemiii}{%
  \settowidth{\labeliiiwidth}{\qitemii\labelitemiii\quad}%
  \makebox[\labeliiiwidth][r]{\labelitemiii\enspace}}
\newcommand{\qi}[2][\qitemi]{%
  \setlength{\qparskip}{\parskip}%
  \settoheight{\outercapheight}{)}%  usually okay to use ). Expect about 1.6ex.
  \setlength{\qgapheight}{\baselineskip - \outercapheight}%
  \setlength{\qitemwidth}{\linewidth}%
  \settowidth{\qbulletwidth}{#1}%
  \addtolength{\qitemwidth}{-\qbulletwidth}%
  #1%
  \begin{minipage}[t]{\qitemwidth}%
    \setlength{\parskip}{\qparskip}%
    \mbox{}#2\rule[-\qgapheight]{0pt}{0pt}
  \end{minipage}%
}
\newcommand{\qii}[1]{\qi[\qitemii]{#1}}
\newcommand{\qiii}[1]{\qi[\qitemiii]{#1}}


%--- \gridon and \gridoff ------------------------------------------------------
% Directly controls whether the alignment grid will appear for subsequent pages,
% independent of the showgrid option. Useful for quickly changing the grid state
% when working on a particular page. Since these macros just toggle the state of
% boolean gridvisible, they only take effect on the next \normalpage or 
% blankpage.
\newcommand{\gridon}{\setboolean{gridvisible}{true}}
\newcommand{\gridoff}{\setboolean{gridvisible}{false}}


%--- \makesection[hypertarget_name]{toc_listing} -------------------------------
% Place \makesection{toc_listing} in the main text area of a page to create a 
% phantom section with name toc_listing, so that it will appear in pdf bookmarks
% and in the table of contents if one is generated.  It will also create a 
% hypertarget with name toc_listing that can be used to create links between pages
% (via hyperlink{toc_listing}{Link_text}).
% 
% Using the optional argument allows you to specify a different name for the 
% hyperlink target. 
%
% \makesubsection functions exactly the same, but makes subsections rather than
% sections.
\newcommand{\makesection}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\phantomsection\addcontentsline{toc}{section}{#2}%
     \hypertarget{#2}{}}%
    {\phantomsection\addcontentsline{toc}{section}{#2}%
     \hypertarget{#1}{}}%
}
\newcommand{\makesubsection}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\phantomsection\addcontentsline{toc}{subsection}{#2}%
     \hypertarget{#2}{}}%
    {\phantomsection\addcontentsline{toc}{subsection}{#2}%
     \hypertarget{#1}{}}%
}

