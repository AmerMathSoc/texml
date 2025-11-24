  %% br-lex.cls
  %% Copyright (c) Youssef Cherem <ycherem(at)gmail.com>, 2016
  %
  % This work may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either version 1.3c
  % of this license or (at your option) any later version.
  % The latest version of this license is in
  %   http://www.latex-project.org/lppl.txt
  % and version 1.3 or later is part of all distributions of LaTeX
  % version 2005/12/01 or later.
  %
  % This work has the LPPL maintenance status `maintained'.
  % 
  % The Current Maintainer of this work is Youssef Cherem.
  %
  % This work consists of the files br-lex.cls, brlex-doc.tex, the example
  % leis-exemplo.tex and the files compiled therefrom: 
  % brlex-doc.pdf and leis-exemplo.pdf


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{br-lex}[2016/02/11]
\LoadClassWithOptions{mwbk}
\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\RequirePackage[sharp]{easylist}
\RequirePackage[normalem]{ulem}
\renewcommand{\thechapter}{%Capítulo 
	\Roman{chapter}} %%%retirado: CAPÍTULO~ por causa da opção Koma chapterprefix=true
\renewcommand{\thesection}{Seção \Roman{section}}

\SetSectionFormatting{section}
{10pt plus4pt}
{\centering\large\textbf{\ifHeadingNumbered
		\HeadingNumber\enspace\fi\\[8pt] %retirei o ponto
		\HeadingText}}
{6pt plus2pt}

\RequirePackage{hyperref}
\RequirePackage[all]{nowidow}

\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setmainlanguage{brazil}
\else
\RequirePackage[utf8]{inputenc}
\RequirePackage[brazil]{babel}
\fi



%%risca partes do texto
\newcommand{\cortado}[1]{\sout{#1}}

\newcommand{\titulo}[1]{
	\begin{center}
		\centering \bfseries \huge #1
	\end{center}
	\thispagestyle{plain}}

\newcommand{\descricao}[1]{\hfill%
	\begin{minipage}{0.5\textwidth}
		#1
	\end{minipage}
	\vspace{\baselineskip}
	}




% % % Para começar capítulos na mesma página:


% opção de começar capítulos na mesma página: capitulo

\DeclareOption{capitulo}{%
	\SetSectionFormatting[wholewidth]{chapter}
{24pt plus5pt minus2pt}
	{\FormatChapterHeading{0pt}%
		{\centering\large \@chapapp \space}{\Large\centering}}
{10pt plus3pt}
}


\DeclareOption{paragrafoespaco}{%
\setlength{\parskip}{10pt}%
\setlength{\parindent}{0pt}%
}

\DeclareOption{paragrafonormal}{%
	\setlength{\parskip}{0pt}%
}

\ExecuteOptions{paragrafoespaco}

\ProcessOptions\relax


%% Do pacote easylist: listas segundo a norma: incisos, alíneas, itens.
\ListProperties(Numbers1=R,Numbers2=l,Numbers3=a,FinalMark1={~---},FinalMark2={)},Hide2=1,Hide3=2,Margin1=4em,Margin2=6em,Margin3=7.5em,Align=move) %Space*=10pt entre mesmo nível,Space=9pt,Space*=9pt
%Adiciona: Margin=\the\parindent,Progressive=3ex, 27-04-2015Progressive=3em,Margin1=5em,Align=move

%%%from the etoolbox package: restart numbering easylist
\AtBeginEnvironment{easylist}
{\ListProperties(Start1=1)}
{}
{}

%\renewcommand*{\chapterheadstartvskip}{\vspace*{-12pt}}
%\renewcommand*{\chapterheadendvskip}{\vspace*{-24pt}}



\newcounter{artigo}
\newcommand{\artigo}{\refstepcounter{artigo} % 
	\ifnum\theartigo<10 %
	{\bfseries Art.~\arabic{artigo}º~~}%
	\else
	{\bfseries Art. \arabic{artigo}~~}%
	\fi
	%Art. \arabic{artigo}.~
	}

\newcounter{paragrafo}
\newcommand{\paragrafo}{\refstepcounter{paragrafo} % 
	\ifnum\theparagrafo<10 %
	\S~\arabic{paragrafo}º~%
	\else
	\S~\arabic{paragrafo}~%
	\fi
}

\newenvironment{paragrafos}{\setcounter{paragrafo}{0}
	\setlength{\parindent}{0pt}
	\leftskip=4em
	%\begin{addmargin}[4em]{0pt} 
	}
	{%\end{addmargin}
		}
	
	
\endinput
