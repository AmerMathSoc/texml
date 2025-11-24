% asaetr.cls
%
% Minimal hack needed to have asaetr.sty compile
% using \documentclass instead of \documentstyle.
% 05 Sept 1997 TCI Software Research
% Added access to asaesub documentclass option.
% 08 June 1999 MacKichan Software, Inc. (gp)
% Added the two-letter font commands that are supposed to
% be defined in the class file.
% 11 May 2000 MacKichan Software, Inc. (gp)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asaetr}
\newif\if@asaesubmit %(gp)
\@asaesubmitfalse
\DeclareOption{asaesub}{\@asaesubmittrue} %(gp)
% for 2.09 compatability
\newdimen\@maxsep       
\newdimen\@dblmaxsep

\def\@normalsize{\@setsize\normalsize{12pt}\ixpt\@ixpt
 \abovedisplayskip 4pt plus 1pt minus 1pt
 \belowdisplayskip \abovedisplayskip
 \abovedisplayshortskip 4pt plus 1pt
 \belowdisplayshortskip \abovedisplayshortskip
 \let\@listi\@listI}

\let\normalsize=\@normalsize

\input asaetr.sty

\ProcessOptions  %(gp)

% Borrowed from article.cls
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}

\if@asaesubmit   %(gp)
  \input{asaesub.sty}
\fi
\endinput %(gp)
