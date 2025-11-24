\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fancyslides}[2015/02/12 my custom beamer slides class]
\LoadClassWithOptions{beamer}



%%%% this is a custom class for preparing presentations
%%%% contact me if anything goes wrong
%%%% or you want to contribute to the work
%%%% pawel.lupkowski@gmail.com

%%%  Version: 1.0

%%%% first release: 24.05.2013
%%%% corrections and improvements
%%%% May 2013 minor corrections and improvements (custom colours added).
%%%% Feb 2015 handout option allowed, solution by Ignasi Furio, (http://tex.stackexchange.com/) - thank you.
%%%% Many thanks to Staszek Wawrykiewicz for his helpful comments and advices.

%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3a of this license or (at your option) any later
%% version. The latest version of this license is in:
%% http://www.latex-project.org/lppl.txt




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% PACKAGES %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage{framed}    %% FOR FRAMED SLOGANS
\RequirePackage{tikz}      %% FOR POINTED SLOGANS


%%% redefines points for itemize
\setbeamertemplate{itemize items}{$\bullet$}
\newcommand{\fitem}[1]{$\bullet$~#1 \ }
\newcommand{\pitem}[1]{$\bullet$~#1 \pause}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% FRAMES FOR SLOGANS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{mybox}{%
  \def\FrameCommand{\fboxsep=1cm \colorbox{\strcolor}}%
  \MakeFramed {\FrameRestore}}%
 {\endMakeFramed}


\newenvironment{mybox2}{%
  \def\FrameCommand{\fboxsep=1cm \colorbox{white}}%
  \color{red}\MakeFramed {\FrameRestore}}%
 {\endMakeFramed}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% COLOURS            %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{white}{rgb}{1,1,1}
\definecolor{red}{rgb}{0,0,0}
\definecolor{grey}{rgb}{0.90196079, 0.90196079, 0.90196079}
\definecolor{blue}{rgb}{0.12941177, 0.45882353, 0.60784316}
\definecolor{green}{rgb}{0.44313726 0.78431374 0.21568628}
\definecolor{orange}{rgb}{1 0.49803922 0.16470589}



\newcommand{\customtextcol}[1]{#1} %text inside boxes and dots

\newcommand{\slogan}[1]{\Huge \MakeUppercase{#1}} %text inside boxes and dots
\newcommand{\fbckg}[1]{\usebackgroundtemplate{\includegraphics[width=\paperwidth]{#1}}}%frame background

\newcommand{\thankyou}{\pointedsl{thank you}} %% thank you slide

%%% defines pointed slogan
\newcommand{\pointedsl}[1]{
\pgfsetfillopacity{\structureopacity}
\begin{center}
\tikz{ \fill[\strcolor] (0,0) circle (20ex);
\pgfsetfillopacity{1}
\node at (0,0) {
{\slogan{#1}}
};
}%%
\end{center}
}


%%% defines framed slogan
\newcommand{\framedsl}[1]{
\pgfsetfillopacity{\structureopacity}
  \begin{mybox}
\pgfsetfillopacity{1}
\begin{center}
  {\slogan{#1}}
\end{center}
\end{mybox}
}



%%% itemised list frame
\newcommand{\itemized}[1]{
\pgfsetfillopacity{\structureopacity}
  \begin{mybox}
\pgfsetfillopacity{1}
\begin{center}
\begin{Large}
\begin{itemize}
\pgfsetfillopacity{1}
#1
\end{itemize}
\end{Large}
\end{center}
\end{mybox}
}




%%% starting slide
\newcommand{\startingslide}[1]{
\begin{frame}
\pgfsetfillopacity{\structureopacity}
  \begin{mybox}
\pgfsetfillopacity{1}
\begin{center}
{\Huge \titlephrase
   
}
    
\end{center}
\end{mybox}

\vspace{-1.5cm}

\pgfsetfillopacity{0.60}
\begin{mybox2}
\pgfsetfillopacity{0.80}
\name \ $\bullet$ \  \affil \ $\bullet$ \ \email
\end{mybox2}
\end{frame}
}




%%% misc slide: for putting different stuff into it
\newcommand{\misc}[1]{
\pgfsetfillopacity{\structureopacity}
  \begin{mybox}
\pgfsetfillopacity{1}
#1
\end{mybox}
}


%%% sources slide
\newcommand{\sources}[1]{
\pgfsetfillopacity{\structureopacity}
\begin{mybox}
\begin{block}{{\Huge \bf SOURCES}}
\pgfsetfillopacity{1}
~\\
#1
\end{block}
\end{mybox}  
}



\endinput