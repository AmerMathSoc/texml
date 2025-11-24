%% RecipeBook.cls
%% Copyright 2015 Brad Granger
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
% The Current Maintainer of this work is Brad Granger
%
% This work consists of the file RecipeBook.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RecipeBook}[2015/02/13 Custom recipe class]

\LoadClass[letterpaper,12pt,twocolumn]{article}

\RequirePackage[document]{ragged2e} % Left-aligns document (need document option)
\RequirePackage{amsmath,amsfonts,amssymb} % Use for \square symbol, etc.
\RequirePackage{xparse} % Multiple optional arguments in new environments
\RequirePackage{wrapfig} % Use for wrapping around large numbers in instructions
\RequirePackage{graphicx} % Use to include figures
\RequirePackage{eso-pic} % Used for transparent images
\RequirePackage{anyfontsize} % Provides arbitrary font sizes
\RequirePackage{scrextend} % Used with anyfontsize
\RequirePackage{multirow,multicol} % Join cells in tabular
\RequirePackage{nicefrac} % nice slanted fractions using \nicefrac
\RequirePackage{xcolor} % Change text color using \color{} within group or env.
\RequirePackage{gensymb} % Provides the degree symbol with \degree
\RequirePackage{booktabs} % Nice table line \toprule
\RequirePackage{tabularx} % Used for auto-width tables
\RequirePackage{calc} % Provides \widthof for wrapping around numbers in \step{}.
\RequirePackage{picture} % Used for absolute dimensions with put{}
%----Adds parskip between minipage environments------------------------------%
\RequirePackage{parskip}
\setlength{\parskip}{\medskipamount}
\newcommand{\@minipagerestore}{\setlength{\parskip}{\medskipamount}}
%----Define fonts and font sizes---------------------------------------------%
\RequirePackage{tgtermes}
\RequirePackage[T1]{fontenc}
\renewcommand{\rmdefault}{qtm}
\newlength{\basefontsize}
\setlength{\basefontsize}{13pt}
\newlength{\basefontskipsize}
\setlength{\basefontskipsize}{14pt}
\newlength{\recipetitlefontsize}
\setlength{\recipetitlefontsize}{22pt}
\newlength{\instrnumsize}
\setlength{\instrnumsize}{22pt}
\newlength{\recipeheadfontsize}
\setlength{\recipeheadfontsize}{17pt}
\changefontsizes[\basefontskipsize]{\basefontsize} % Default font skip/size

%----Shrink and grow environments to scale text------------------------------%
\NewDocumentEnvironment{shrink}{O{1pt}}{
	\addtolength{\basefontsize}{-#1}
	\addtolength{\basefontskipsize}{-#1}
	\addtolength{\instrnumsize}{-#1 * 2}
	\addtolength{\recipeheadfontsize}{-#1}
	\changefontsizes[\basefontskipsize]{\basefontsize}
}{
	\addtolength{\basefontsize}{#1}
	\addtolength{\basefontskipsize}{#1}
	\addtolength{\instrnumsize}{#1 * 2}
	\addtolength{\recipeheadfontsize}{#1}
	\changefontsizes[\basefontskipsize]{\basefontsize}
}

\NewDocumentEnvironment{grow}{O{1pt}}{
	\addtolength{\basefontsize}{#1}
	\addtolength{\basefontskipsize}{#1}
	\addtolength{\instrnumsize}{#1 * 2}
	\addtolength{\recipeheadfontsize}{#1}
	\changefontsizes[\basefontskipsize]{\basefontsize}
}{
	\addtolength{\basefontsize}{-#1}
	\addtolength{\basefontskipsize}{-#1}
	\addtolength{\instrnumsize}{-#1 * 2}
	\addtolength{\recipeheadfontsize}{-#1}
	\changefontsizes[\basefontskipsize]{\basefontsize}
}

%----Some page formatting lengths--------------------------------------------%
\setlength\parindent{0pt} % Don't indent new paragraphs
\setlength\parskip{4pt} % Set space between paragraphs
\setlength{\columnsep}{12pt} % Sets margin between columns

%----Headers and footers-----------------------------------------------------%
\RequirePackage{datetime} % Provides compile date on title page
\mmddyyyydate		% Reformat \today to MM/DD/YYYY
\RequirePackage{fancyhdr} % Provide header and footer \lhead \rfoot, etc.
\fancypagestyle{recipe}{
	\fancyhead{} 
	\fancyfoot{}
	\fancyfoot[R]{\hyperlink{contents}{\arabic{page}}}
	\renewcommand{\headrulewidth}{0pt} % Remove line from header
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{titlestyle}{
	\fancyhead{}
	\fancyfoot{}
	\renewcommand{\headrulewidth}{0pt} % Remove line from header
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{tocstyle}{
	\fancyhead{}
	\fancyfoot{}
	\fancyfoot[C]{\today}
	\renewcommand{\headrulewidth}{0pt} % Remove line from header
	\renewcommand{\footrulewidth}{0pt}
}

\raggedbottom % Don't stretch blocks vertically to fit page
\RequirePackage{tikz}
\usetikzlibrary{calc, fadings}

%----Commands for working with the ToC--------------------------------------=%
% Use tocloft to remove numbers from the table of contents (ToC)
\RequirePackage{tocloft}
% Use hyperref to create links in the ToC (has to be loaded last, usually)
\RequirePackage[colorlinks]{hyperref}
\hypersetup{linkcolor=blue}
% Set page geometry (should be loaded after hyperref}
\RequirePackage[top=0.4in,inner=0.25in,outer=0.25in,bottom=0.65in,
								paperheight=8.5in, paperwidth=5.5in, 
								headheight=16pt]{geometry}

\cftsetindents{subsection}{8pt}{0pt}
\cftsetindents{section}{0pt}{0pt}
\renewcommand\thesection{}
\renewcommand\thesubsection{}
\renewcommand\cftdot{}
\renewcommand{\cftsecfont}{
	\bfseries \fontsize{\recipeheadfontsize}{\recipeheadfontsize}\selectfont 
}
\newcommand \makecontents {\tableofcontents \thispagestyle{tocstyle}}

%----\titlepage for generating title page------------------------------------%
\DeclareDocumentCommand{\titlepage}{O{Recipes} m m m}{
	\thispagestyle{titlestyle}
	\AddToShipoutPicture*{
		\put(0.20in,0){
			\parbox[b][\paperheight]{\linewidth}{%
				\vspace*{2.40in}
				\begin{tikzpicture}
					\node[anchor=north east, inner sep=0] (image) at (0,0) {%
						\includegraphics[width=1.05\linewidth]{#2}};
				\end{tikzpicture}
				\vfill
			}
		}
	}
	\AddToShipoutPicture*{
		\put(0.25\paperwidth,0){
			\parbox[b][\paperheight]{\linewidth}{%
				\vspace*{3.90in}
				\begin{tikzpicture}
					\node[anchor=north east, inner sep=0] (image) at (0,0) {%
						\includegraphics[width=1.05\linewidth]{#3}};
				\end{tikzpicture}
				\vfill
			}
		}
	}
	\AddToShipoutPicture*{
		\put(0.5\paperwidth,0){
			\parbox[b][\paperheight]{\linewidth}{%
				\vspace*{5.40in}
				\begin{tikzpicture}
					\node[anchor=north east, inner sep=0] (image) at (0,0) {%
						\includegraphics[width=1.05\linewidth]{#4}};
				\end{tikzpicture}
				\vfill
			}
		}
	}
	\AddToShipoutPicture*{
		\parbox[b][\paperheight]{\paperwidth}{
			\vspace*{0.9in}
			\centering \color{black!50}
			\fontsize{46pt}{40pt}\selectfont #1
			\vfill
		}
	}
	$\quad$
	\clearpage \newpage
}
	
%----section and subsection commands-----------------------------------------%
\RenewDocumentCommand{\section}{m}{
	\newpage
	\phantomsection 
	\cftaddtitleline{toc}{section}{#1}{}
}

\RenewDocumentCommand{\subsection}{m}{
 	\clearpage\newpage 
 	\phantomsection
	\addcontentsline{toc}{subsection}{#1}
}

%----Make page numbers hyperlinks to the ToC (along with fancyhdr, above)----%
\renewcommand{\contentsname}{\hypertarget{contents}{
	\bfseries \fontsize{\recipetitlefontsize}{\recipetitlefontsize}\selectfont
	Recipes}
}

%----Image commands----------------------------------------------------------%
\setlength{\@fptop}{0pt} % Position image at the top by setting fill to 0pt

\tikzfading[name=fade l,left color=transparent!100,right color=transparent!0]
\tikzfading[name=fade r,right color=transparent!100,left color=transparent!0]
\tikzfading[name=fade d,bottom color=transparent!100,top color=transparent!0]
\tikzfading[name=fade u,top color=transparent!100,bottom color=transparent!0]

% this "frames" a rectangle node
\newcommand\framenode[2][10pt]{
	\fill[white, opacity=1, path fading=fade u] (#2.south west) rectangle ($(#2.south east)+(0, #1)$);
	\fill[white, opacity=1, path fading=fade d] (#2.north west) rectangle ($(#2.north east)+(0,-#1)$);
	\fill[white, opacity=1, path fading=fade l] (#2.south east) rectangle ($(#2.north east)+(-#1,0)$);
	\fill[white, opacity=1, path fading=fade r] (#2.south west) rectangle ($(#2.north west)+( #1,0)$);
}

\newlength{\pagetop} \setlength{\pagetop}{32.5pt}
\DeclareDocumentCommand \leftbgpic {O{32.5pt} O{0.4} m} {
	\AddToShipoutPicture*{
		\put(0.20in,0.15in){
			\parbox[b][\paperheight]{\linewidth}{%
				\vspace*{#1}
				\begin{tikzpicture}[opacity=#2]
					\node[anchor=north east, inner sep=0] (image) at (0,0) {%
						\includegraphics[width=1.05\linewidth]{#3}};
					\framenode[25pt]{image} % opt. arg. is fade radius;
																	% mand. arg. is node name to frame
				\end{tikzpicture}
				\vfill
			}
		}
	}
}

\newlength{\pagebottom} \setlength{\pagebottom}{6.15in}
\DeclareDocumentCommand \rightbgpic {O{\pagebottom} O{0.4} m} {
	\AddToShipoutPicture*{
		\put(.49\paperwidth,0.15in){
			\parbox[b][\paperheight]{\linewidth}{%
				\vspace*{#1}
				\begin{tikzpicture}[opacity=#2]
					\node[anchor=north east, inner sep=0] (image) at (0,0) {%
						\includegraphics[width=1.05\linewidth]{#3}};
					\framenode[30pt]{image} % opt. arg. is fade radius;
																	% mand. arg. is node name to frame
				\end{tikzpicture}
				\vfill
			}
		}
	}
}

% % \pic command for float image
% \DeclareDocumentCommand{\pic}{O{t} m}{
% 	\begin{figure}[#1]
% 		\centering \includegraphics[width=0.45\textwidth]{#2} \\
% 	\end{figure}
% }

% \pic command for float image
\DeclareDocumentCommand{\pic}{O{t} m}{
	\begin{figure}[#1]
		\begin{tikzpicture}
			\node[anchor=north east, inner sep=0] (image) at (0,0) {%
				\centering \includegraphics[width=.92\linewidth]{#2}
			};
			\framenode[4pt]{image}
		\end{tikzpicture}
	\end{figure}
}

%----Title and subtitle commands---------------------------------------------%
\RenewDocumentCommand{\title}{O{\recipetitlefontsize} m}{
	\begingroup \fontsize{#1}{#1}\selectfont \bf #2 \endgroup 
}

\DeclareDocumentCommand{\subtitle}{O{18pt} m}{
	\begingroup 
		\fontsize{#1}{#1}\selectfont \textcolor{black!50} {#2} 
	\endgroup 
}

%----RecipeSection command---------------------------------------------------%
\DeclareDocumentCommand{\recipesection}{O{\recipeheadfontsize} m}{
	\begingroup \fontsize{#1}{#1}\selectfont \color{blue!60}\bf\emph{#2} \endgroup
}{}

%----Author footnote---------------------------------------------------------%
\RenewDocumentCommand{\author}{O{Author: } m}{
	\lfoot{\textcolor{black!20}{#1#2}}
}

%----Info environment--------------------------------------------------------%
\newenvironment{info}{
	\vspace*{\parskip}
	\tabular{ll}
}{
	\endtabular
	\vspace*{\parskip}
}

%----Info* environment for more compact spacing------------------------------%
\newenvironment{info*}{
	\tabular{ll}
}{
	\endtabular
}

%----Ingredients section-----------------------------------------------------%
\NewDocumentEnvironment{ingredients}{}{
	\renewcommand{\arraystretch}{1.08}
	\setlength{\tabcolsep}{4pt}
	\tabularx{\linewidth}{@{}lX@{}}
}{
	\endtabularx
}

\DeclareDocumentCommand{\item}{O{$\square$} m}{#1 & #2 \\}

% Starred version of ingredients environment for a shaded background
% with faded edges.
\RequirePackage{environ}
\RequirePackage{tcolorbox}
\NewEnviron{ingredients*}{%
	\renewcommand{\arraystretch}{1.08}
	\setlength{\tabcolsep}{4pt}
	\setlength\fboxsep{0pt}
	\begin{tcolorbox}[colback=black!4,colframe=black!2,boxrule=2pt,
										arc=7pt,boxsep=0pt,left=1pt,right=1pt,top=-5pt,
										bottom=1pt]
	\begin{tcolorbox}[colback=black!8,colframe=black!6,boxrule=2pt,
										arc=6pt,boxsep=0pt,left=0pt,right=0pt,top=-5pt,
										bottom=0pt]
		\begin{tabularx}{\linewidth}{@{}lX@{}}
			\BODY
		\end{tabularx}
	\end{tcolorbox}
	\end{tcolorbox}
}

\newcommand{\group}[1]{
	\multicolumn{2}{l}{
		\color{black!80} \emph{#1}} \\[-2pt] \toprule 
	}
	
%----Instructions section----------------------------------------------------%
\DeclareDocumentCommand{\step}{m m}{
	\begin{minipage}{\linewidth}
		\setlength{\intextsep}{4pt}
		\setlength{\columnsep}{6pt}
		\begin{wraptable}{L}{
			\widthof{\fontsize{\instrnumsize}{\instrnumsize}\selectfont 1 }}
			\begin{tabularx}{\textwidth}{@{}l@{}}
				\fontsize{\instrnumsize}{\instrnumsize}\selectfont \color{black!60}  #1 
			\end{tabularx}
		\end{wraptable}
		#2 
	\end{minipage} 

}

\DeclareDocumentCommand{\hlgroup}{O{black} m}{
	\begin{tcolorbox}[colback=black!7,colframe=black!3,boxrule=2pt,
										arc=5pt,boxsep=0pt,left=1pt,right=1pt,top=-7pt,
										bottom=-1pt]
		\begin{tcolorbox}[colback=black!12,colframe=black!10,boxrule=2pt,
											arc=4pt,boxsep=0pt,left=0pt,right=0pt,top=-7pt,
											bottom=-3pt]
			\begin{tabular}{@{}m{\linewidth}@{}}
				\emph{$\:$#2}
			\end{tabular}
		\end{tcolorbox}
	\end{tcolorbox}
}

\newcommand{\num}[1]{
	\multirow{2}{*}{
		\begingroup \fontsize{\instrnumsize}{\instrnumsize}\selectfont 
		\textcolor{black!80} #1 \endgroup
	}
}

