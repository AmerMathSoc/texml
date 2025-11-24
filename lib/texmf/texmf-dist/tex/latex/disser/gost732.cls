%%
%% This is file `gost732.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gost732.dtx  (with options: `gost732')
%% 
%% Copyright (c) 2004-2014 Stanislav Kruchinin.
%% All rights reserved.
%% 
%% This file is part of the disser package.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{gost732}[2016/07/03 1.4.0 GOST 7.32-2001 implementation]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{disser}}
\ProcessOptions\relax
\LoadClass[a4paper,14pt]{disser}

\renewcommand\tocprethechapter{}
\renewcommand\tocpostthechapter{\@postskip}
\renewcommand\chapteralign{\centering}
\renewcommand\thechapterfont{\Large\bfseries}
\renewcommand\prethechapter{}
\renewcommand\postthechapter{\@postskip}
\renewcommand\afterchapter{\vskip 16\p@}

\renewcommand\postthesection{\@postskip}
\renewcommand\tocpostthesection{\@postskip}
\renewcommand\sectionindent{1cm}

\renewcommand\postthesubsection{\@postskip}
\renewcommand\tocpostthesubsection{\@postskip}
\renewcommand\subsectionindent{1cm}

\renewcommand\postthesubsubsection{\@postskip}
\renewcommand\tocpostthesubsubsection{\@postskip}
\renewcommand\subsubsectionindent{1cm}

\renewcommand\posttheparagraph{\@postskip}
\renewcommand\tocposttheparagraph{\@postskip}

\renewcommand\postthesubparagraph{\@postskip}
\renewcommand\tocpostthesubparagraph{\@postskip}

\AtBeginDocument{\addto\captionsrussian{%
\def\bibname{\cyr\CYRS\CYRP\CYRI\CYRS\CYRO\CYRK\ %
\CYRI\CYRS\CYRP\CYRO\CYRL\CYRSFTSN\CYRZ\CYRO\CYRV\CYRA\CYRN\CYRN\CYRERY\CYRH\ %
\CYRI\CYRS\CYRT\CYRO\CYRCH\CYRN\CYRI\CYRK\CYRO\CYRV}
\def\figurename{\cyr\CYRR\cyri\cyrs\cyru\cyrn\cyro\cyrk}
\def\appendixname{\cyr\CYRP\CYRR\CYRI\CYRL\CYRO\CYRZH\CYRE\CYRN\CYRI\CYRE}
\def\contentsname{\cyr\CYRS\CYRO\CYRD\CYRE\CYRR\CYRZH\CYRA\CYRN\CYRI\CYRE}
\def\listfigurename{\cyr\CYRS\CYRP\CYRI\CYRS\CYRO\CYRK\ %
\CYRI\CYRL\CYRL\CYRYU\CYRS\CYRT\CYRR\CYRA\CYRC\CYRI\CYRISHRT}
\def\listtablename{\cyr\CYRS\CYRP\CYRI\CYRS\CYRO\CYRK\ %
\CYRT\CYRA\CYRB\CYRL\CYRI\CYRC}
}}

\renewcommand\defsname{%
\cyr\CYRO\CYRB\CYRO\CYRZ\CYRN\CYRA\CYRCH\CYRE\CYRN\CYRI\CYRYA\ %
\CYRI\ \CYRS\CYRO\CYRK\CYRR\CYRA\CYRSHCH\CYRE\CYRN\CYRI\CYRYA
}

\renewcommand\defs{%
  \nchapter{\defsname}
}
\renewcommand\bibsection{%
  \nchapter{\bibname}
}
\renewcommand\introname{%
\cyr\CYRV\CYRV\CYRE\CYRD\CYRE\CYRN\CYRI\CYRE
}
\renewcommand\reviewname{%
\cyr\CYRO\CYRB\CYRZ\CYRO\CYRR\ %
\CYRL\CYRI\CYRT\CYRE\CYRR\CYRA\CYRT\CYRU\CYRR\CYRERY
}
\renewcommand\conclusionname{%
\cyr\CYRZ\CYRA\CYRK\CYRL\CYRYU\CYRCH\CYRE\CYRN\CYRI\CYRE
}
\renewcommand\theenumi  {\asbuk{enumi}}
\renewcommand\theenumii {\arabic{enumii}}
\renewcommand\theenumiii{\roman{enumiii}}
\renewcommand\theenumiv {\Asbuk{enumiv}}

\renewcommand\labelenumi  {\theenumi)}
\renewcommand\labelenumii {\theenumii)}
\renewcommand\labelenumiii{\theenumiii)}
\renewcommand\labelenumiv {\theenumiv)}

\renewcommand\p@enumii  {\theenumi}
\renewcommand\p@enumiii {\theenumi.\theenumii}
\renewcommand\p@enumiv  {\p@enumiii.\theenumiii}

\renewcommand\labelitemi  {\normalfont\bfseries \textendash}
\renewcommand\labelitemii {\textbullet}
\renewcommand\labelitemiii{\textasteriskcentered}
\renewcommand\labelitemiv {\textperiodcentered}

\captionsetup{format=plain,justification=centering,labelsep=endash}
\captionsetup[longtable]{justification=raggedright,singlelinecheck=false}
\captionsetup[table]{justification=raggedright,singlelinecheck=false}

\setcitestyle{semicolon}

\renewcommand\postthefootnote{$^)$}

\endinput
%%
%% End of file `gost732.cls'.
