%% fcavtex.cls, v-1.1 waltermaldonado
%% Copyright 2015 by Walter Maldonado Jr 
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Walter Maldonado Jr
%%
%% Creator and original mantainer: Walter Maldonado Jr <walter@agroestat.com.br>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fcavtex}[2015/06/26 Thesis class for UNESP/FCAV - BRAZIL]

\LoadClass[12pt,openright,twoside]{memoir}

\RequirePackage[a4paper,vmargin=3cm,inner=3cm,outer=2cm]{geometry}
\RequirePackage[english,brazil]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{helvet}
\RequirePackage{layout}
\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\RequirePackage{ragged2e}
\RequirePackage{microtype}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{memhfixc}
\RequirePackage{indentfirst}
\RequirePackage[setpagesize=false]{hyperref}
\RequirePackage[sectionbib]{chapterbib}
\RequirePackage[alf]{abntex2cite}
\RequirePackage[cm]{{sfmath}}

% References
\bibliographystyle{fcavtex}

% Page Style
\makepagestyle{pstyle}
\copypagestyle{pstyle}{empty}
\makeevenhead{pstyle}{\fontsize{12}{12}\selectfont\sffamily\thepage}{\hfill}{}
\makeoddhead{pstyle}{}{\hfill}{\fontsize{12}{12}\selectfont\sffamily\thepage}

\makepagestyle{cstyle}
\copypagestyle{cstyle}{empty}
\makeevenfoot{cstyle}{\hfill}{\fontsize{12}{12}\selectfont\sffamily\thepage}{}
\makeoddfoot{cstyle}{\hfill}{\fontsize{12}{12}\selectfont\sffamily\thepage}{}

\aliaspagestyle{chapter}{cstyle}

\makechapterstyle{chap1}{%
  \def\chapterheadstart{\justifying}
  \def\afterchapternum{\space\textendash\space}
  \renewcommand{\chapnamefont}{\fontsize{12}{12}\selectfont\sffamily\bfseries\MakeUppercase}
  \renewcommand{\chapnumfont}{\fontsize{12}{12}\selectfont\sffamily\bfseries}
  \renewcommand{\chaptitlefont}{\fontsize{12}{12}\selectfont\sffamily\bfseries}
  \renewcommand{\afterchaptertitle}{}
  \setlength{\afterchapskip}{\onelineskip}
  \def\afterchaptertitle{\par\nobreak\vskip \afterchapskip}
}
\renewcommand\memendofchapterhook{%
	\preparebibliography
	\setlength{\parindent}{12.5mm}
}

% Section styles
\setsecheadstyle{\raggedright\MakeUppercase}
\setbeforesecskip{\onelineskip}
\setaftersecskip{\onelineskip}
\titleformat{\section}{\justifying\fontsize{12}{12}\selectfont\sffamily\bfseries}{\thesection}{5pt}{}
\titleformat{\subsection}{\justifying\fontsize{12}{12}\selectfont\sffamily\bfseries\itshape}{\thesubsection}{5pt}{}
\titleformat{\subsubsection}{\justifying\fontsize{12}{12}\selectfont\sffamily\itshape}{\thesubsubsection}{5pt}{}

% Specific commands
\newcommand{\titulo}[1]{\def\vtitulo{#1}}
\newcommand{\printtitulo}{\vtitulo}
\newcommand{\tituloingles}[1]{\def\vtituloingles{#1}}
\newcommand{\printtituloingles}{\vtituloingles}
\newcommand{\autor}[1]{\def\vautor{#1}}
\newcommand{\printautor}{\vautor}
\newcommand{\orientador}[1]{\def\vorientador{#1}}
\newcommand{\printorientador}{\vorientador}
\newcommand{\instituicao}[1]{\def\vinstituicao{#1}}
\newcommand{\printinstituicao}{\vinstituicao}
\newcommand{\qualificacaoautor}[1]{\def\vqualificacaoautor{#1}}
\newcommand{\printqualificacaoautor}{\vqualificacaoautor}
\newcommand{\ano}[1]{\def\vano{#1}}
\newcommand{\printano}{\vano}
\newcommand{\tipodoc}[1]{\def\vtipodoc{#1}}
\newcommand{\printtipodoc}{\vtipodoc}
\newcommand{\titulopretendido}[1]{\def\vtitulopretendido{#1\space}}
\newcommand{\printtitulopretendido}{\vtitulopretendido}
\newcommand{\programa}[1]{\def\vprograma{#1}}
\newcommand{\printprograma}{\vprograma}
\newcommand{\email}[1]{\def\vemail{#1}}
\newcommand{\printemail}{\vemail}
\newcommand{\banca}[1]{\def\vbanca{#1}}
\newcommand{\printbanca}{\vbanca}
\newcommand{\palavraschave}[1]{\def\vpalavraschave{#1}}
\newcommand{\printpalavraschave}{\vpalavraschave}
\newcommand{\keywords}[1]{\def\vkeywords{#1}}
\newcommand{\printkeywords}{\vkeywords}
\newcommand{\nomefichacatalografica}[1]{\def\vnomefichacatalografica{#1}}
\newcommand{\printnomefichacatalografica}{\vnomefichacatalografica}
\newcommand{\cutter}[1]{\def\vcutter{#1}}
\newcommand{\printcutter}{\vcutter}
\newcommand{\cdu}[1]{\def\vcdu{#1}}
\newcommand{\printcdu}{\vcdu}


% Table of contents adjustments
\settocdepth{subsubsection}
\renewcommand{\tocheadstart}{}
\renewcommand{\printtoctitle}[1]{\fontsize{12}{12}\selectfont\sffamily\textbf{\MakeUppercase{#1}}}
\renewcommand{\aftertoctitle}{%
  \par\addtocontents{toc}{\protect\hfill\mbox{\fontsize{12}{12}\selectfont\sffamily{Página}}\protect\par}
}

\renewcommand{\cftchapterfont}{\fontsize{12}{12}\selectfont\sffamily\bfseries}
\renewcommand{\cftsectionfont}{\fontsize{12}{12}\selectfont\sffamily} 
\renewcommand{\cftsubsectionfont}{\fontsize{12}{12}\selectfont\sffamily\itshape} 
\renewcommand{\cftsubsubsectionfont}{\fontsize{12}{12}\selectfont\sffamily\itshape} 

\renewcommand{\cftchapterpagefont}{\fontsize{12}{12}\selectfont\sffamily} 
\renewcommand{\cftsectionpagefont}{\fontsize{12}{12}\selectfont\sffamily} 
\renewcommand{\cftsubsectionpagefont}{\fontsize{12}{12}\selectfont\sffamily} 
\renewcommand{\cftsubsubsectionpagefont}{\fontsize{12}{12}\selectfont\sffamily} 

\renewcommand{\cftchapterleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftsectionleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftsubsectionleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftsubsubsectionleader}{\cftdotfill{\cftsectiondotsep}}

\renewcommand{\cftbeforechapterskip}{10pt}
\renewcommand{\cftbeforesectionskip}{0pt}
\renewcommand{\cftbeforesubsectionskip}{0pt}
\renewcommand{\cftbeforesubsubsectionskip}{0pt}

% List of tables adustments
\renewcommand{\insertchapterspace}{%
  \addtocontents{lof}{\protect\addvspace{10pt}}%
  \addtocontents{lot}{\protect\addvspace{10pt}}%
}
\renewcommand{\lotheadstart}{}
\renewcommand{\printlottitle}[1]{\fontsize{12}{12}\selectfont\sffamily\textbf{\MakeUppercase{#1}}}
\renewcommand{\afterlottitle}{%
  \par\addtocontents{lot}{\protect\hfill\mbox{\fontsize{12}{12}\selectfont\sffamily{Página}}\protect\par}
}
\renewcommand{\cfttablefont}{\fontsize{12}{12}\selectfont\sffamily}
\renewcommand{\cfttablepagefont}{\fontsize{12}{12}\selectfont\sffamily}
\renewcommand{\cfttableleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftbeforetableskip}{0pt}

% List of figures adustments
\renewcommand{\lofheadstart}{}
\renewcommand{\printloftitle}[1]{\fontsize{12}{12}\selectfont\sffamily\textbf{\MakeUppercase{#1}}}
\renewcommand{\afterloftitle}{%
  \par\addtocontents{lof}{\protect\hfill\mbox{\fontsize{12}{12}\selectfont\sffamily{Página}}\protect\par}
}
\renewcommand{\cftfigurefont}{\fontsize{12}{12}\selectfont\sffamily}
\renewcommand{\cftfigurepagefont}{\fontsize{12}{12}\selectfont\sffamily}
\renewcommand{\cftfigureleader}{\cftdotfill{\cftsectiondotsep}}
\renewcommand{\cftbeforefigureskip}{0pt}

% Default formatting

\fontsize{12}{12}\selectfont\sffamily

% First page commands

% Title page
\newcommand{\capa}{
	\pagestyle{empty}
	%\begin{group}
		\null
		\center\begin{textblock}{160}(30,30)
		  \begin{Spacing}{1.5}
		    \fontsize{14}{14}\selectfont\sffamily\textbf{\MakeUppercase{\printinstituicao}}
		  \end{Spacing}
		\end{textblock}
		\center\begin{textblock}{160}(30,110)
		  \begin{Spacing}{1.5}
		    \fontsize{16}{16}\selectfont\sffamily\textbf{\MakeUppercase{\printtitulo}}
		  \end{Spacing}
		\end{textblock}
		\begin{textblock}{160}(30,165)
		  \begin{FlushRight}
		    \begin{Spacing}{1.5}
		      \fontsize{14}{14}\selectfont\sffamily\textbf{\printautor}
		      \par\fontsize{12}{12}\selectfont\sffamily{\printqualificacaoautor}
		    \end{Spacing}
		  \end{FlushRight}	
		\end{textblock}
		\center\begin{textblock}{160}(30,264)
		  \begin{Spacing}{1.5}
		    \fontsize{12}{12}\selectfont\sffamily\textbf{\printano}
		  \end{Spacing}
		\end{textblock}
		\cleardoublepage
	%\end{group}
}

\newcommand{\folhaderosto}{
	%\begin{group}
	\pagestyle{empty}
		\center\begin{textblock}{160}(30,30)
		  \begin{Spacing}{1.5}
		    \fontsize{14}{14}\selectfont\sffamily\textbf{\MakeUppercase{\printinstituicao}}
		  \end{Spacing}
		\end{textblock}
		\center\begin{textblock}{160}(30,110)
		  \begin{Spacing}{1.5}
		    \fontsize{16}{16}\selectfont\sffamily\textbf{\MakeUppercase{\printtitulo}}
		  \end{Spacing}
		\end{textblock}
		\begin{textblock}{160}(30,135)
		  \begin{FlushRight}
		    \begin{Spacing}{1.5}
		      \fontsize{14}{14}\selectfont\sffamily\textbf{\printautor}
		      \par\fontsize{14}{14}\selectfont\sffamily\textbf{\printorientador}
		    \end{Spacing}
		  \end{FlushRight}	
		\end{textblock}
		\begin{textblock}{90}(100,165)
		  \begin{sloppypar}
		    \begin{Spacing}{1.2}
		    \justify\fontsize{12}{12}\selectfont\sffamily{\printtipodoc\ apresentada à Faculdade de Ciências Agrárias e Veterinárias - Unesp, Câmpus de Jaboticabal, como parte das exigências para a obtenção do título de \printtitulopretendido  em \printprograma}
		    \end{Spacing}
		  \end{sloppypar}
		\end{textblock}
		\center\begin{textblock}{160}(30,264)
		  \begin{Spacing}{1.5}
		    \fontsize{12}{18}\selectfont\sffamily\textbf{2015}
		  \end{Spacing}
		\end{textblock}
		\null\newpage
	%\end{group}
}

\RequirePackage{hyphenat}
\RequirePackage{paralist}
\RequirePackage{mfirstuc}
\newcommand*{\splitPC}[1][]{%
	\begin{inparaenum}[1.]
		\@for\my@temp:=#1\do{%
			\item{\ignorespaces\xmakefirstuc{\my@temp}.}
		}
	\end{inparaenum}
}

\newcommand{\fichacatalografica}{
	%\begin{group}
		\center
		\null\vfill
		\fbox{\rule{12cm}{0pt}\rule[0pt]{0pt}{9cm}}
		\begin{textblock}{15}(40,113)
			\fontsize{10}{10}\selectfont\sffamily\raggedright \printcutter
		\end{textblock}
		\begin{textblock}{103}(56,109)
			\fontsize{10}{10}\selectfont\sffamily\raggedright \printnomefichacatalografica
		\end{textblock}
		\begin{textblock}{103}(56,113)
			\OnehalfSpacing\justifying
			\setlength{\parindent}{7mm}
			\fontsize{10}{10}\selectfont\sffamily\printtitulo. / \printautor. --~-- Jaboticabal, \printano \par
			\pageref{pagesLTS.roman}, \pageref{pagesLTS.arabic}\ p. ; 28cm
		\end{textblock}

		\begin{textblock}{103}(56,135)
			\OnehalfSpacing\justifying
			\fontsize{10}{10}\selectfont\sffamily
			\begingroup
				\hyphenpenalty 10000
				\exhyphenpenalty 10000
				\nohyphens{
					\begin{sloppypar}
						\ifthenelse{\equal{\vtipodoc}{Tese}}{
							Tese (doutorado)\space\textendash\space
						}{
							\ifthenelse{\equal{\vtipodoc}{Dissertação}}{
								Dissertação (mestrado)\space\textendash\space
							}
						}
						\@ Universidade Estadual Paulista, Faculdade de Ciências Agrárias e Veterinárias, \printano
						\par
						Orientador(a): \printorientador
						\par
						Banca examinadora: \vbanca
						\par
						Bibliografia
						\linebreak
						\par
						\splitPC[\vpalavraschave]
						I.~Título. II.~Jaboticabal~\textendash\ Faculdade de Ciências Agrárias e Veterinárias.
					\end{sloppypar}
				}
			\endgroup
		\end{textblock}

		\center\begin{textblock}{119}(40,187)
			\ignorespaces\fontsize{10}{10}\selectfont\sffamily \printcdu
		\end{textblock}

		\justify\begin{textblock}{120}(40,196)
		  \begin{sloppypar}
		    \begin{Spacing}{1.2}
			    \raggedright\fontsize{8}{8}\selectfont\sffamily{Ficha catalográfica elaborada pela Seção Técnica de Aquisição e Tratamento da Informação – Serviço Técnico de Biblioteca e Documentação - UNESP, Câmpus de Jaboticabal.
			    \ifdefined\vemail\par E-mail: \printemail\fi
			    }
		    \end{Spacing}
		  \end{sloppypar}
		\end{textblock}
		\vfill\null
		\newpage
	%\end{group}
}

\usepackage{incgraph,tikz}
\newcommand{\certificadodeaprovacao}[1]{
	%\begin{group}
		\center
		\incgraph[documentpaper][width=\paperwidth,height=\paperheight]{#1}
		\cleardoublepage{}
	%\end{group}
}

\newcommand{\dadoscurriculares}[1]{
	%\begin{group}
	\center\fontsize{12}{12}\selectfont\sffamily\textbf{DADOS CURRICULARES DO AUTOR}
	\par\addvspace{18pt}
	\justifying
	\setlength{\parindent}{12.5mm}
	\OnehalfSpacing#1
	\cleardoublepage{}
	%\end{group}
}

\newcommand{\epigrafe}[1]{
	%\begin{group}
		\null\vfill\raggedbottom\raggedleft\fontsize{12}{12}\selectfont\sffamily\textit{#1}
		\cleardoublepage{}
	%\end{group}
}

\newcommand{\dedicatoria}[1]{
	%\begin{group}
		\null\vfill\raggedbottom\raggedleft\fontsize{12}{12}\selectfont\sffamily\textit{#1}
		\cleardoublepage{}
	%\end{group}
}

\newcommand{\agradecimentos}[1]{
	\center\fontsize{12}{12}\selectfont\sffamily\textbf{AGRADECIMENTOS}
	\par\addvspace{18pt}
	\justifying
	\setlength{\parindent}{12.5mm}
	\OnehalfSpacing#1
	\cleardoublepage{}
}

\newcommand{\sumario}{
	\frontmatter
	\pagestyle{cstyle}
	\center
	\OnehalfSpacing
	\tableofcontents*
	\cleardoublepage{}
}

\newcommand{\resumo}[1]{
	\center\fontsize{12}{12}\selectfont\sffamily\textbf{\MakeUppercase{\printtitulo}}
	\par\addvspace{18pt}
	\justifying
	\setlength{\parindent}{0mm}
	  \SingleSpacing\textbf{RESUMO\space\textendash}\space\ignorespaces#1
	  \\
	  \\
	  \textbf{Palavras-chave: }\printpalavraschave
	\cleardoublepage{}
}

\renewcommand{\abstract}[1]{
	\center\fontsize{12}{12}\selectfont\sffamily\textbf{\MakeUppercase{\printtituloingles}}
	\par\addvspace{18pt}
	\justifying
	\setlength{\parindent}{0mm}
	  \SingleSpacing\textbf{ABSTRACT\space\textendash}\space\ignorespaces#1
	  \\
	  \\
	  \textbf{Keywords: }\printkeywords
	\cleardoublepage{}
}

\newcommand{\listadetabelas}{
	\center
	\OnehalfSpacing
	\listoftables*
	\cleardoublepage{}
}

\newcommand{\listadefiguras}{
	\center
	\OnehalfSpacing
	\listoffigures*
	\cleardoublepage{}
}

\newcommand{\corpodotextoemcapitulos}{
	\mainmatter
	\pagestyle{pstyle}
	\chapterstyle{chap1}
	\setcounter{secnumdepth}{2}
	\setcounter{secnumdepth}{3}	
	\OnehalfSpacing
}

\newcommand{\preparebibliography}{
	\citeoption{abnt-full-initials=yes}
	\citeoption{abnt-etal-list=0}
	\citeoption{abnt-thesis-year=both}
	\citeoption{abnt-emphasize=bf}
	\citeoption{abnt-url-package=url}
	\bibliographystyle{fcavtex}
	\renewcommand{\bibname}{Referências}
}

\def\bibliography#1{% ****
  {
	  \ifx \SingleSpacing\undefined
	    \singlespacing
	  \else
	    \SingleSpacing   
	  \fi  
	  %
	  \ifthenelse{\boolean{ABCIciteoptionwasused}
	               \and\boolean{ABCIauto-abntoptions}}
	   {
	   % this system of checking is not good...
	    \IfSubStringInString{abntex2-options}{#1}
	      {\if\cb@roottest
           \if@filesw\immediate\write\@auxout{\string\bibdata{#1}}\fi
           \fi 
           \begingroup % localize hooks into \@bibitem
           \ifx\@CitationPrefix\@empty\else \ifx\the@ipfilectr\@empty\else
             \@cb@insertprefix
           \fi\fi
           \cb@dobiblio{\@currentipfile.bbl}%
           \endgroup}
	      {\if\cb@roottest
           \if@filesw\immediate\write\@auxout{\string\bibdata{abntex2-options,#1}}\fi
           \fi 
           \begingroup % localize hooks into \@bibitem
           \ifx\@CitationPrefix\@empty\else \ifx\the@ipfilectr\@empty\else
             \@cb@insertprefix
           \fi\fi
           \cb@dobiblio{\@currentipfile.bbl}%
           \endgroup}
	      }
	   {
	    \if\cb@roottest
         \if@filesw\immediate\write\@auxout{\string\bibdata{#1}}\fi
         \fi 
         \begingroup % localize hooks into \@bibitem
         \ifx\@CitationPrefix\@empty\else \ifx\the@ipfilectr\@empty\else
           \@cb@insertprefix
         \fi\fi
         \cb@dobiblio{\@currentipfile.bbl}%
         \endgroup
	   }
	 % \@input@{\jobname.bbl}
  }
 }

\RequirePackage[pagecontinue=false]{pageslts}
\pagenumbering{arabic}
