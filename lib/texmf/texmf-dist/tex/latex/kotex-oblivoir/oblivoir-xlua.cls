%% File `oblivoir-xlua.cls`
%%
%% (C) Copyright 2006-2015 Kangsoo Kim <karnes at ktug org>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%  http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2006/05/20 or later.
%%
%% an oblivoir-compatible package for using with LuaLaTeX or XeLaTeX.
%% depends upon Dohyun Kim's xetexko and the author's memhangul-x.
%%
\ProvidesClass{oblivoir-xlua}
  [2015/10/19 v0.8.3 article-like class to typeset UTF-8 korean using memoir.]
\typeout{A variant of oblivoir class for Lua- or XeLaTeX.}

\providecommand\@DisabledOption[1]{%
  \typeout{[#1] option is deprecated}}

\RequirePackage{xkeyval}

%%% Disabled Options
\DeclareOptionX{dvips}{\@DisabledOption{\CurrentOption}}
\DeclareOptionX{romanfixed}{\@DisabledOption{\CurrentOption}}
\DeclareOptionX{finemath}{\@DisabledOption{\CurrentOption}}
\DeclareOptionX{nofinemath}{\@DisabledOption{\CurrentOption}}
\DeclareOptionX{strictcharcheck}{\@DisabledOption{\CurrentOption}}
\DeclareOptionX{noreserveinserts}{\@DisabledOption{\CurrentOption}}

%%% active Options
\newif\ifnokorean\nokoreanfalse
\DeclareOptionX{nokorean}{\nokoreantrue}
\newif\if@polyglossia\@polyglossiafalse
\DeclareOptionX{polyglossia}{\@polyglossiatrue}
\newif\iftwosidedoc\twosidedocfalse
\DeclareOptionX{twoside}{\twosidedoctrue}
\newif\ifopenrightdoc\openrightdocfalse
\DeclareOptionX{openright}{\openrightdoctrue}
\newif\ifkosection\kosectionfalse
\DeclareOptionX{kosection}{\kosectiontrue}
\newif\ifnobookmarks\nobookmarksfalse
\DeclareOptionX{nobookmarks}{\nobookmarkstrue}
\newif\ifhyperrefwithlyx\hyperrefwithlyxfalse
\DeclareOptionX{lyxhyper}{\hyperrefwithlyxtrue}{\hyperrefwithlyxfalse}
\newif\if@tendotfive\@tendotfivefalse
\DeclareOptionX{10.5pt}{\@tendotfivetrue}
\newif\if@koreanfn\@koreanfnfalse
\DeclareOptionX{footnote}{\@koreanfntrue}
\newif\if@toclofentry\@toclofentryfalse
\DeclareOptionX{tocentry}{\@toclofentrytrue}
%\newif\if@itemph\@itemphfalse
\DeclareOptionX{itemph}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\DeclareOptionX{gremph}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\newif\if@chapter\@chapterfalse
\DeclareOptionX{chapter}{\@chaptertrue\@toclofentrytrue}
\newif\if@microtype\@microtypefalse
\DeclareOptionX{microtype}{\@microtypetrue}
\newif\if@subfigure\@subfigurefalse
\DeclareOptionX{subfigure}{\@subfiguretrue}
\DeclareOptionX{adjustmath}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\newif\if@manspace\@manspacefalse
\DeclareOptionX{obspace}{\@manspacetrue}
%
%%% new Options
\DeclareOptionX{latinquote}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
%%% changed fontspec -> manualfontspec
\DeclareOptionX{fontspec}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\newif\if@moreverb\@moreverbfalse
\DeclareOptionX{moreverb}{\@moreverbtrue}
\newif\if@foursix\@foursixfalse\newlength\fa@setheight\newlength\fa@setwidth
\DeclareOptionX{faht}[]{\fa@setheight=#1\@foursixtrue}
\DeclareOptionX{fawd}[]{\fa@setwidth=#1\@foursixtrue}
\newif\if@amsmath\@amsmathfalse
\DeclareOptionX{amsmath}{\@amsmathtrue}
\DeclareOptionX{nowinname}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
%
\newif\ifPRELOAD\PRELOADfalse
\DeclareOptionX{preload}[]{\PRELOADtrue\def\PRELOADstr{#1}}
\def\PRELOADoptstr{}
\DeclareOptionX{preloadoption}[]{\def\PRELOADoptstr{#1}}

%% [nounfonts] 
\DeclareOptionX{unfonts}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\DeclareOptionX{nounfonts}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\DeclareOptionX{nanum}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
\DeclareOptionX{hcr}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}

\DeclareOptionX{figtabcapt}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}

\DeclareOptionX{cjk}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}
%\DeclareOptionX{cjkoption}[]{\PassOptionsToPackage{#1}{cjkutf8-ko}}
\DeclareOptionX{dhucs}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}

%%% compatibility options
\DeclareOptionX{uset1font}{\PassOptionsToPackage{usecjkt1font}{cjkutf8-ko}}
\DeclareOptionX{usedotemph}{\PassOptionsToPackage{\CurrentOption}{memhangul-x}}

%%% 
\DeclareOptionX*{%
 \PassOptionsToClass{\CurrentOption}{memoir}%
}
%
\ProcessOptionsX

% expl3
\RequirePackage{expl3,xparse}

%%% moreverb
\if@moreverb
 \RequirePackage{moreverb}
\fi

%%% preload
\ifPRELOAD
 \RequirePackage[\PRELOADoptstr]{\PRELOADstr}
 \ifx\medspace\undefined\relax\else\let\medspace\relax\fi
\fi

%% LyX compatibility
\ifx\@textsubscript\undefined\else
  \let\@textsubscript\relax
\fi

%%% memoir/memhangul-ucs 로드.
\if@chapter
  \LoadClass[openany]{memoir}
\else
\iftwosidedoc
  \LoadClass[article,openany]{memoir}
\else
  \LoadClass[article,openany,oneside]{memoir}
\fi
\fi

%%% fontspec problem
%  \RequirePackage{etex}\reserveinserts{40}%

%%% workaround with flowfram
\if@foursix
 \newcommand*{\fa@dblfoursix}{\stockheight=\fa@setheight \stockwidth=\fa@setwidth}
 \fa@dblfoursix
\fi

%%% ams{math|symb}
\if@amsmath
 \RequirePackage{amsmath,xob-amssymb}
\fi

%%%
\ifopenrightdoc\openright\fi

\RequirePackage{ifluatex}
\RequirePackage{ifxetex}

%%\RequirePackage{comment}
%%\def\finemath@status{}

%\ifxetex\else\ifluatex\else
%  \PackageError{xoblivoir}{This Document requires Xe(La)TeX or Lua(La)TeX!}{}
%\fi\fi

\def\@Load@Memhangul{%
  \if@polyglossia
    \RequirePackage[polyglossia]{memhangul-x}
  \else
    \RequirePackage[nonfrench,hangulpagestyle]{memhangul-x}
  \fi
}

\ifnokorean\else
  \@Load@Memhangul
\fi

\if@chapter\else
  \counterwithout{section}{chapter}
\fi

%%%
%%% xetex doesn't know microtype,
%%% but xetexko has hangingpunctuation feature, which
%%% we will use instead.
%%%
\ifnokorean\else
\if@microtype
  \ifxetex
    \usepackage{xetexko-hanging}
	\AtBeginDocument{\hangingpunctuation}
	\typeout {xoblivoir: use xetexko-hanging instead of microtype}
  \else
%   \ifluatex
%      \enablemicrotype
%    \fi
  \fi
\fi
\fi

%%% 기본 자간
\newdimen\ob@hu  % 1jw=.95em, 1hu=1/16jw. see hfontspec.oblivoir
\ifnokorean\ob@hu=\z@\else\ob@hu=.059375em\fi
%%% defaultskip: suppressed (2015/04/19)
\if@manspace
\def\ob@DEFAULTskips{%
	\def\memucshangulskips{}%
	\def\memucsinterwordskip{%
		\spaceskip = .390\BASE@FONTsize plus .1\BASE@FONTsize minus .1\BASE@FONTsize
%		\if@nonfrench
		\xspaceskip = .432\BASE@FONTsize plus .11\BASE@FONTsize minus .1\BASE@FONTsize
%		\fi
	}%
	\def\memucsinterwordchapterskip{%
		\spaceskip = .41\BASE@FONTsize plus .11\BASE@FONTsize minus .1\BASE@FONTsize
%		\if@nonfrench
		\xspaceskip = .55\BASE@FONTsize plus .1\BASE@FONTsize minus .1\BASE@FONTsize
%		\fi
	}%
}
\let\DEFAULTskips\ob@DEFAULTskips
\else
\let\memucshangulskips\relax
\let\memucsinterwordskip\relax
\let\memucsinterwordchapterskip\relax
\let\DEFAULTskips\relax
\fi
\def\ob@thinthinspace{\hskip2\ob@hu}
\def\ob@onethirdspace{\hskip5\ob@hu}

\ifnokorean\else
\if@koreanfn
%%% footnote setting
%%% 99)에 해당하는 박스 길이를 구한 다음
\newsavebox\mytmpbox\sbox\mytmpbox{\footnotesize 99)\ }
%%% 각주 번호 박스를 길이에 대하여 오른쪽 정렬함. 두 자리
%%% 각주 번호 기준으로 오른쪽 정렬되도록 만든다.
\footmarkstyle{\makebox[\wd\mytmpbox][r]{#1)\ }}
\setlength\footmarksep{\wd\mytmpbox}
\setlength\footmarkwidth{0pt}
\setlength\footparindent{0pt}
%\ifnokorean\else
\SetFnmark{\textsuperscript}{\textsuperscript{)}}
%\fi
\fi\fi
%%% footnotes and floats. codes from memmanadd.pdf
\renewcommand*{\footnoterule}{\kern-3pt\vfill
  \hrule width 0.4\columnwidth \kern 2.6pt}
\setlength{\skip\footins}{1.3\onelineskip}

%%% toc 등의 레이아웃.
\if@chapter\else
\renewcommand\chaptitlefont{\Large\bfseries}
\renewcommand\printchapternonum{}
\renewcommand\printchaptertitle[1]{\chaptitlefont #1}
\setlength\afterchapskip{\onelineskip}
\setlength\beforechapskip{1.5\onelineskip}
\fi

\setlength\cftsectionindent{0pt}
\ifnokorean\else
\setlength\cftsectionnumwidth{1.8em}
\setlength\cftsubsectionindent{1.8em}
\setlength\cftsubsectionnumwidth{2.5em}
\fi
\if@chapter\else
\let\cftchapterindent\cftsectionindent
\let\cftchapternumwidth\cftsectionnumwidth
\let\cftbeforechapterskip\cftbeforesectionskip
\fi

\renewcommand\cftsectionpresnum{\hfill}
\renewcommand\cftsectionaftersnum{\hskip.8em}

%% moved kscntformat to memhangul-x
%%%% kscntformat
%%%% HLaTeX의 \kscntformat 명령을 흉내냄
%%%% \kscntformat{section}{제}{절} 형식으로 쓴다.
%\newsavebox{\tmp@XXbox}
%\newdimen\tmp@XXdim
%\def\kscntformat#1#2#3{%
%	\sbox{\tmp@XXbox}{#2\expandafter\number\csname c@#1\endcsname#3}%
%	\setlength\tmp@XXdim{\wd\tmp@XXbox}\advance\tmp@XXdim by1em%
%	\expandafter\def\csname the#1\endcsname{#2\expandafter\number\csname c@#1\endcsname#3}%
%	\expandafter\renewcommand\csname cft#1numwidth\endcsname{\tmp@XXdim}%
%	\expandafter\renewcommand\csname cft#1presnum\endcsname{}%
%	\expandafter\renewcommand\csname cft#1aftersnum\endcsname{}%
%}

%\ifnokorean\else
%\ifkosection
%\kscntformat{section}{제}{절}
%\renewcommand\thesubsection{\arabic{section}.\arabic{subsection}}
%\fi\fi

%%% misc settings
\raggedbottom
\ifnokorean
\renewcommand\sectionmark[1]{\markboth{\thetitle}{#1}}
\else
\renewcommand\sectionmark[1]{\markboth{\thetitle}{#1}}
\fi
%\renewcommand\subsectionmark[1]{\markright{#1}}
\ifnokorean
\newcommand*\MarkDocTitle{\markboth{\thetitle}{}}
\else
\newcommand*\MarkDocTitle{\markboth{\thetitle}{}}
\fi

%%% for bookmarks and hyperref
\def\CallHyperref{%
 \ifnobookmarks
   \@Call@Hyperref@Without@Bookmarks
 \else 
   \@Call@Hyperref@With@Bookmarks
 \fi
}

\def\@Call@Hyperref@Without@Bookmarks{%
 \ifluatex
  \usepackage[unicode,bookmarks=false]{hyperref}
 \else\ifxetex
  \usepackage[bookmarks=false]{hyperref}
 \else
  \usepackage[unicode,bookmarks=false]{hyperref}
 \fi\fi
}

\def\@Call@Hyperref@With@Bookmarks{%
 \ifluatex
  \usepackage[unicode]{hyperref}
 \else\ifxetex
  \usepackage{hyperref}
 \else
  \usepackage[unicode]{hyperref}
 \fi\fi 
}

%% LyX 1.6.x의 Insert-Hyperlink 기능과 충돌하지 않게 하기 위하여
%% hyperref을 로드하지 않음. (lyxhyper 옵션)
%% note: memhfixc는 memoir 자신이 로드해준다.
\ifnokorean\relax\else
  \ifhyperrefwithlyx\relax\else
    \CallHyperref
\fi\fi

%%% \engtxt를 일일이 쓰기 귀찮고 space가 하나밖에 없을 때
%%% 쓰기 위한 \ensp 매크로.
\newskip\@ensp
\@ensp=.297em plus .02em minus .01em
\def\ensp{\hskip\@ensp}

%%% article의 pagestyle 기본값은 plain임.
\pagestyle{plain}

%%% 2006/09/01 \title, \author 문제. reported by IsCho
\AtBeginDocument{%
 \@ifundefined{thetitle}{\title{}}{\relax}
 \@ifundefined{theauthor}{\author{}}{\relax}
}

%%% 2006/09/05 [10.5pt] option, [romanfixed] 2006/10/22.
\if@tendotfive
  \RequirePackage{10_5}
\fi

%%%% 2006/10/19. 현범석 님이 지적한 lof, toc 문제
\if@chapter\else
 \usepackage{ob-toclof}
\fi

%%% oblivoir-chapter (12/20)
\if@chapter
\newcommand\oblivoirchapterstyle[1]{%
 \chapterstyle{#1}
 \renewcommand{\chapterheadstart}{\clearforchapter\vspace*{\beforechapskip}}
}
\fi

%%%%%%%%%%%%% APPENDIX

\ifnokorean\def\appendixrefname{Appendix}\else\def\appendixrefname{부록}\fi
\def\appref#1{\appendixrefname~\ref{#1}}

\newif\if@AppendixTitleToToc\@AppendixTitleToTocfalse
\newif\if@AttachAppendixTitleToSecnum\@AttachAppendixTitleToSecnumfalse

\def\AppendixTitleToToc{%
 \@AppendixTitleToToctrue
}

\def\AttachAppendixTitleToSecnum{%
 \@AttachAppendixTitleToSecnumtrue
}

\def\AppendixTitle{%
 \chapter*{\appendixname}
}

\ifnokorean
\usepackage{ob-nokoreanappendix}
\else
\usepackage{ob-koreanappendix}
\fi

%%%%%%%%%%%%%%% enumerate
\@ifpackageloaded{enumerate}{}{\RequirePackage{enumerate}}
\def\@enloop@{%
%%% why @enhook doesn't work?
  \ifx 가\@entemp		 \def\@tempa{\@enLabel\gana  }\else
  \ifx ㈎\@entemp		 \def\@tempa{\@enLabel\pgana }\else
  \ifx ㉮\@entemp		 \def\@tempa{\@enLabel\ogana }\else
  \ifx ㄱ\@entemp		 \def\@tempa{\@enLabel\jaso  }\else
  \ifx ㈀\@entemp		 \def\@tempa{\@enLabel\pjaso }\else
  \ifx ㉠\@entemp		 \def\@tempa{\@enLabel\ojaso }\else
  \ifx ⑴\@entemp		 \def\@tempa{\@enLabel\pnum  }\else
  \ifx ①\@entemp		 \def\@tempa{\@enLabel\onum  }\else
  \ifx ⒜\@entemp		 \def\@tempa{\@enLabel\peng  }\else
  \ifx ⓐ\@entemp		 \def\@tempa{\@enLabel\oeng  }\else
  \ifx ⅰ\@entemp		 \def\@tempa{\@enLabel\hroman}\else
  \ifx Ⅰ\@entemp		 \def\@tempa{\@enLabel\hRoman}\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifx A\@entemp         \def\@tempa{\@enLabel\Alph  }\else
  \ifx a\@entemp         \def\@tempa{\@enLabel\alph  }\else
  \ifx i\@entemp         \def\@tempa{\@enLabel\roman }\else
  \ifx I\@entemp         \def\@tempa{\@enLabel\Roman }\else
  \ifx 1\@entemp         \def\@tempa{\@enLabel\arabic}\else
  \ifx \@sptoken\@entemp \let\@tempa\@enSpace         \else
  \ifx \bgroup\@entemp   \let\@tempa\@enGroup         \else
  \ifx \@enum@\@entemp   \let\@tempa\@gobble          \else
                         \let\@tempa\@enOther
                         \@enhook
             \fi\fi\fi\fi\fi\fi\fi\fi
             \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  \@tempa}

%%% subsection까지 항번을 붙이고 toc에 두자.
\maxtocdepth{subsection}
\maxsecnumdepth{subsection}

%%% oblivoirallowbreak
\ifx\oblivoirallowbreak\undefined
\def\oblivoirallowbreak{\hskip1sp\hskip-1sp}
\fi

%%% subfigure package compatibility
\if@subfigure
 \let\c@lofdepth\relax
 \let\c@lotdepth\relax
\fi

%%% redefine \see or \seealso
\ifnokorean\else
\@ifundefined{see}{}{%
 \renewcommand*{\see}[2]{#1\seename, \hyperpage{#2}}
}
\@ifundefined{seealso}{}{%
 \renewcommand*{\seealso}[2]{#1\alsoname, \hyperpage{#2}}
}
\fi

%%% to avoid conflicts with etextools
\ExplSyntaxOn
\cs_if_exist:NF \globcount
{ \let\globcount\newcount }
\ExplSyntaxOff

\endinput

%%% ChangeLog:
%%% 2015-10-19 : fix conflicts with etextools package.
%%%% 2015-08-01 : drop etex.sty 
%%% 2015-07-27 : fix nokorean bug 
%%% 2015-07-10 : etex-pkg conflicts fixed.
%%% 2015-04-19 : suppress space factors
%%% 2014-06-12 : introduce new xob-font.sty
%%% 2014-06-06 : replace false \renewcommand with \setlength
%%% 2013-10-26 : moved \kscntformat definition to memhangul.
%%% 2013-09-12 : integrate ifluaorxetex.sty
%%% 2013-09-01 : [cjk], [dhucs] option introduced.
%%% 2011-09-26 : [preloadoption] bugfix.
%%% 2011-09-15 : [fontspec] renamed to [manualfontspec]; and intrudoce [fontspec, xcolor, hyperref, preloadoption]
%%% 2010-09-16 : reserveinserts, lyx compatibility etc. (for TeX Live 2010)
%%%      08:46 2010-02-09 : [microtype] -> hanging punctuation (xetexko)
%%%      10:16 2009-10-27 : [preload] 옵션
%%% 오전 3:12 2009-04-07 : [lyxhyper] 옵션
%%% 오전 6:36 2008-09-18 : revive microtype option, in spite of its impotence.
%%% 오후 2:16 2008-09-18 : latinquote 옵션
%%% 오전 4:58 2008-09-30 : xkospace 새 버전에 맞춘 대대적인 수정.
%%%                      : enumerate, hangul item title, 기호문자 등을 추가.
%%% 오후 5:25 2008-10-07 : revive gremph/itemph
%%% 오전 10:51 2008-10-08 : revive kscntformat
%%% 오전 5:12 2008-10-12 : fontspec, moreverb, xob-hanfont
%%% 오전 1:19 2008-10-13 : xetexko v0.1 반영
%%% 오전 12:50 2008-10-22 : fawd, faht 옵션 추가. (workaround with flowfram)
%%% 오후 12:22 2008-10-24 : add [unicode] option to hyperref under LuaTeX
%%% 13:49 2008-11-24 : add [amsmath] option to avoid LyX's auto loading problem under XeLaTeX.
%%% 오후 17:59 2008-12-03 : nowinname 옵션 추가
