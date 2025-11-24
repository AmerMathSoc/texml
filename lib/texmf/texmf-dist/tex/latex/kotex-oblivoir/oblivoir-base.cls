%% File `oblivoir.cls`
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
\ProvidesClass{oblivoir-base}
  [2015/10/19 v0.8.1 article-like class to typeset UTF-8 korean using memoir.]
%\typeout{oblivoir requires memoir, dhucs, and memhangul. 2008/10/23.}

%%% Acknowledgements:
%%% Many thanks to
%%%   ischo who provided a computer, place and time for developing and testing.
%%%   smcho, ischo, synapse and beomsukhyun who requested functional improvements.
%%%   progress who wrote a nice introductory document.
%%%   and all the people who do or do not use this class.
%%%
%%% Options:
%%% nokorean : 영문용
%%% twoside : twoside
%%% openright
%%% kosection : 절 표제항의 한글화
%%% nobookmarks : 북마크 만들지 않음
%%% dvips : dvips 작업용 옵션
%%% 10.5pt : 10.5pt 본문 폰트 사이즈.
%%% footnote : 한글식 각주 모양 사용.
%%% tocentry : toc 등을 한 수준 위에서 처리.
%%% itemph : 강조를 itshape로 처리함.
%%% finemath : pass finemath option to dhucs. made default.
%%% nofinemath : no finemath.
%%% strictcharcheck : strictcharcheck to dhucs.
%%% microtype : load microtype and apply margin-kerning & font-expansion
%%% romanfixed : 10.5pt 옵션 사용시 영문 글꼴은 10pt로 고정.
%%% faht,fawd : flowfram과 함께 쓸 때 임의의 페이지 사이즈.
%%% moreverb : pdfmtricks와 함께 쓰기 위해 moreverb를 로드.
%%% 기타 옵션 : memoir 옵션 사용.
%%% default는 oneside, openany, kosection false, pdfbookmark임.
%%% subfigure : load old subfigure packaged
%%% 
%%% 한글 폰트 관련:
%%%   unfonts-type-1
%%%

%\RequirePackage{etex}
\RequirePackage{xkeyval}

\newif\ifnokorean\nokoreanfalse
\DeclareOptionX{nokorean}{\nokoreantrue}
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
\newif\if@dvips\@dvipsfalse
\DeclareOptionX{dvips}{\@dvipstrue}
\newif\if@tendotfive\@tendotfivefalse
\DeclareOptionX{10.5pt}{\@tendotfivetrue}
\newif\if@koreanfn\@koreanfnfalse
\DeclareOptionX{footnote}{\@koreanfntrue}
\newif\if@toclofentry\@toclofentryfalse
\DeclareOptionX{tocentry}{\@toclofentrytrue}
\newif\if@itemph\@itemphfalse
\DeclareOptionX{itemph}{\@itemphtrue}
\newif\if@resizelatin\@resizelatintrue
\DeclareOptionX{romanfixed}{\@resizelatinfalse}
\newif\if@chapter\@chapterfalse
\DeclareOptionX{chapter}{\@chaptertrue\@toclofentrytrue}
\newif\if@finemath\@finemathtrue
\DeclareOptionX{finemath}{\@finemathtrue}
\DeclareOptionX{nofinemath}{\@finemathfalse}
\newif\if@microtype\@microtypefalse
\DeclareOptionX{microtype}{\@microtypetrue}
\newif\if@subfigure\@subfigurefalse
\DeclareOptionX{subfigure}{\@subfiguretrue}
\DeclareOptionX{strictcharcheck}{\PassOptionsToPackage{\CurrentOption}{memhangul-ucs}}

\newif\if@moreverb\@moreverbfalse
\DeclareOptionX{moreverb}{\@moreverbtrue}
\newif\if@foursix\@foursixfalse\newlength\fa@setheight\newlength\fa@setwidth
\DeclareOptionX{faht}[]{\fa@setheight=#1\@foursixtrue}
\DeclareOptionX{fawd}[]{\fa@setwidth=#1\@foursixtrue}

\DeclareOptionX{figtabcapt}[]{\PassOptionsToPackage{\CurrentOption}{memhangul-ucs}}

%%% 2013-09-26
%%% disabled option unfonts/nounfonts, 2014-06-13
\newif\if@unfont\@unfontfalse
\DeclareOptionX{unfonts}{\@unfonttrue}
\DeclareOptionX{nounfonts}{\@unfontfalse}
\DeclareOptionX{nanum}{\@unfontfalse}
\DeclareOptionX{uset1font}{\PassOptionsToPackage{\CurrentOption}{nanumfontsel}}

\DeclareOptionX{cjk}{\PassOptionsToPackage{\CurrentOption}{memhangul-ucs}}
\DeclareOptionX{dhucs}{\PassOptionsToPackage{\CurrentOption}{memhangul-ucs}}

%%% Disabled Options
\DeclareOptionX{hcr}{}   % do nothing

\newif\if@AMSmath\@AMSmathfalse
\DeclareOptionX{amsmath}{\@AMSmathtrue}

\newif\if@FULLROOM\@FULLROOMfalse
\DeclareOptionX{moreroom}{\@FULLROOMtrue}

\DeclareOptionX*{%
 \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptionsX

%%% moreroom, reported by Juho Lee, 2013-09-26.
%%% 2015-08-01: LaTeX will do auto-alloc.
%\if@FULLROOM
%\def\alloc@#1#2#3#4#5%
% {\ifnum\count1#1<#4% make sure there's still room
%    \allocationnumber\count1#1
%    \global\advance\count1#1\@ne
%    \global#3#5\allocationnumber
%    \wlog{\string#5=\string#2\the\allocationnumber}%
%  \else\ifnum#1<6
%    \def\etex@dummy@definition{}% <-- code added
%    \begingroup \escapechar\m@ne
%    \expandafter\alloc@@\expandafter{\string#2}#5%
%  \else\errmessage{No room for a new #2}\fi\fi
% }
%\fi

%% expl3
\RequirePackage{xparse,expl3}

%%% moreverb : 2008/10/23
\if@moreverb
 \RequirePackage{moreverb}
\fi

%%% dvips
\ifnokorean\else
\if@dvips
 \PassOptionsToPackage{dvips}{memhangul-ucs}
\fi\fi

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
%%% flowfram confict : 2008/10/23
\if@foursix
 \newcommand*{\fa@dblfoursix}{\stockheight=\fa@setheight \stockwidth=\fa@setwidth}
 \fa@dblfoursix
\fi

\if@AMSmath
\RequirePackage{amsmath,amssymb}
\fi

%%%
\ifopenrightdoc\openright\fi
\newcommand\finemath@status{\if@finemath finemath\else\fi}
\ifnokorean\else
   \if@itemph
      \RequirePackage[nonfrench,interworddefault,hangulpagestyle,\finemath@status]{memhangul-ucs}
   \else
      \RequirePackage[nonfrench,interworddefault,hangulpagestyle,gremph,\finemath@status]{memhangul-ucs}
   \fi
\fi
\if@chapter\else
\counterwithout{section}{chapter}
\fi

%%% hfontspec
\ifnokorean\let\usehangulfontspec\@gobble\fi

%%% korean fontsettings
\ifnokorean\else
  \if@unfont
    \RequirePackage{hfontsel}
    \usehangulfontspec{obut}
  \else
    \RequirePackage{nanumfontsel}
    \usehangulfontspec{nanum}
  \fi
  \ifpdf
    \input glyphtounicode\pdfgentounicode=1
    \RequirePackage{dhucs-cmap}
  \else\fi
% \ifpdf
%  \RequirePackage[ps]{hfontsel} % ut**를 기본 글꼴로
%  \usehangulfontspec{obut}
%  \pdfmapfile{=unttf-pdftex-dhucs.map} % 그래도 혹시 모르므로 
%%%% dhucs-cmap은 여기서 로드한다.
%  \RequirePackage{dhucs-cmap}  % ut**가 기본글꼴일 때는 disable?
%  \input glyphtounicode\pdfgentounicode=1
% \else
%  \if@dvips
%   \RequirePackage[ps]{hfontsel} % ut**를 기본 글꼴로
%   \usehangulfontspec{obut}
%  \else
%   \RequirePackage{hfontsel}   % 아무 옵션도 없다면 un**
%   \usehangulfontspec{obun}
%   \RequirePackage{dhucs-cmap} % un**일 때
%  \fi
% \fi
\fi

%%% Gremph
\if@itemph\else
 \ifnokorean\else
%  \ifpdf
  \if@unfont
      \SetGremphFonts{outgr}{outgt}
  \else
  	  \SetGremphFonts{nanumgt}{nanumgt}
  \fi
%  \else 
%   \if@dvips
%    \SetGremphFonts{utgr}{utgt}
%   \fi
%  \fi
 \fi
\fi

%%% microtype
\ifpdf
 \if@microtype
  \RequirePackage[expansion=all]{microtype}
  % for more elaborated operation, document specific config is needed.
  % expansion works for ONE fontset only; so, basictext + LUC.
%  \DeclareMicrotypeSet{dhucsmicro}
%    { encoding = {LUC,OT1,T1,LY1,OT4,QX,T5},
%      % family   = {rm*,sf*},
%      % series   = {md*},
%      % size     = {normalsize,footnotesize,small,large}
%    }
%  \UseMicrotypeSet[expansion]{dhucsmicro}
 \fi
\else
 \if@microtype
%  \ClassWarningNoLine{oblivoir}{no pdflatex runs! microtype option is ignored.}{}
   \RequirePackage{microtype}
 \fi
\fi

%%% 기본 자간
\newdimen\ob@hu  % 1jw=.95em, 1hu=1/16jw. see hfontspec.oblivoir
\ifnokorean\ob@hu=\z@\else\ob@hu=\dhucs@hu\fi
% 기본 자간 설정은 hfontspec.obu{n/t}.
%%%\newdimen\ob@hangulglue\ob@hangulglue=-.55\ob@hu
%%%\interhchar{\ob@hangulglue}

\def\ob@DEFAULTskips{%
	\def\memucshangulskips{%
%		\interhchar{\ob@hangulglue}%
	}%
	\def\memucsinterwordskip{%
		\spaceskip = .390\BASE@FONTsize plus .1\BASE@FONTsize minus .1\BASE@FONTsize
		\if@nonfrench
		\xspaceskip = .432\BASE@FONTsize plus .11\BASE@FONTsize minus .1\BASE@FONTsize
		\fi
	}%
	\def\memucsinterwordchapterskip{%
		\spaceskip = .41\BASE@FONTsize plus .11\BASE@FONTsize minus .1\BASE@FONTsize
		\if@nonfrench
		\xspaceskip = .55\BASE@FONTsize plus .1\BASE@FONTsize minus .1\BASE@FONTsize
		\fi
	}%
}

\let\DEFAULTskips\ob@DEFAULTskips
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

%%%% kscntformat definition moved to memhangul-ucs.
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
%
%\ifnokorean\else
%\ifkosection
%\kscntformat{section}{제\ob@onethirdspace}{\ob@onethirdspace 절}
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
 \ifpdf
  \RequirePackage[pdftex,unicode,bookmarks=false]{hyperref}
 \else
  \if@dvips
   \RequirePackage[dvips,unicode,bookmarks=false]{hyperref}
  \else
   \RequirePackage[dvipdfm,unicode,bookmarks=false]{hyperref}
  \fi
 \fi
}

\def\@Call@Hyperref@With@Bookmarks{%
 \ifpdf
  \RequirePackage[pdftex,unicode]{hyperref}
 \else
  \if@dvips
   \RequirePackage[dvips,unicode]{hyperref}
  \else
   \RequirePackage[dvipdfm,unicode]{hyperref}
  \fi
 \fi
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
  \if@resizelatin
    \RequirePackage{type1cm}
    \RequirePackage{type1ec}
  \fi
\fi

%%%% 2006/10/19. 현범석 님이 지적한 lof, toc 문제
\if@chapter\else
 \RequirePackage{ob-toclof}
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
\RequirePackage{ob-nokoreanappendix}
\else
\RequirePackage{ob-koreanappendix}
\fi

%%% modified from dhucs-enumerate.sty
\ifnokorean\else
\def\@enloop@{%
  \ifx A\@entemp         \def\@memtempa{\@enLabel\Alph  }\else
  \ifx a\@entemp         \def\@memtempa{\@enLabel\alph  }\else
  \ifx i\@entemp         \def\@memtempa{\@enLabel\roman }\else
  \ifx I\@entemp         \def\@memtempa{\@enLabel\Roman }\else
  \ifx 1\@entemp         \def\@memtempa{\@enLabel\arabic}\else
  \ifx \@sptoken\@entemp \let\@memtempa\@enSpace         \else
  \ifx \bgroup\@entemp   \let\@memtempa\@enGroup         \else
  \ifx \@enum@\@entemp   \let\@memtempa\@gobble          \else
  \ifx^^ea\@entemp  % 가,
    \let\@memtempa\@dhucs@enumerate@EA\else %%%%%
  \ifx^^e2\@entemp  % ①, ⑴, ⒜, ⓐ, ⅰ, Ⅰ
    \let\@memtempa\@dhucs@enumerate@Eii\else %%%%%
  \ifx^^e3\@entemp  % ㄱ, ㉠, ㉮, ㈀, ㈎
    \let\@memtempa\@dhucs@enumerate@Eiii\else
                         \let\@memtempa\@enOther
                         \@enhook
  \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  \@memtempa}

\def\@dhucs@enumerate@error#1{%
  \PackageError{dhucs-enumerate}
    {You can't use `\unexpanded{#1}' as enum label}
    {Legal enum labels of hangul-ucs are: \MessageBreak\space\space
      \unexpanded{가, ㄱ, ㉠, ㉮, ㈀, ㈎, ①, ⑴, ⒜, ⓐ, ⅰ, Ⅰ}.}%
}
\def\@dhucs@enumerate@EA#1#2#3{%
  \ifnum\pdfstrcmp{#1#2#3}{^^ea^^b0^^80}=\z@ \def\@tempa{\@enLabel\gana}\else
    \@dhucs@enumerate@error{#1#2#3}%
  \fi
  \@tempa\relax
}
\def\@dhucs@enumerate@Eii#1#2#3{%
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^85^^b0}=\z@ \def\@tempa{\@enLabel\hroman}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^85^^a0}=\z@ \def\@tempa{\@enLabel\hRoman}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^92^^9c}=\z@ \def\@tempa{\@enLabel\peng}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^93^^90}=\z@ \def\@tempa{\@enLabel\oeng}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^91^^b4}=\z@ \def\@tempa{\@enLabel\pnum}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e2^^91^^a0}=\z@ \def\@tempa{\@enLabel\onum}\else
    \@dhucs@enumerate@error{#1#2#3}%
  \fi\fi\fi\fi\fi\fi
  \@tempa\relax
}
\def\@dhucs@enumerate@Eiii#1#2#3{%
  \ifnum\pdfstrcmp{#1#2#3}{^^e3^^88^^8e}=\z@ \def\@tempa{\@enLabel\pgana}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e3^^89^^ae}=\z@ \def\@tempa{\@enLabel\ogana}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e3^^89^^a0}=\z@ \def\@tempa{\@enLabel\ojaso}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e3^^84^^b1}=\z@ \def\@tempa{\@enLabel\jaso}\else
  \ifnum\pdfstrcmp{#1#2#3}{^^e3^^88^^80}=\z@ \def\@tempa{\@enLabel\pjaso}\else
    \@dhucs@enumerate@error{#1#2#3}%
  \fi\fi\fi\fi\fi
  \@tempa\relax
}

\fi

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
%%%          2015/10/19 : fix conflicts with etextools package.
%%%          2015/08/24 : dhuce-enumerate compatibility.
%%%          2015/08/01 : etex.sty dropped
%%% ver0.6   2014/06/12 : introduce new xob-font.sty
%%% ver0.5   2014/06/06 : replace \renewcommand's with \setlength's.
%%% ver0.4.3 2013/10/26 : move \kscntformat definition to memhangul-ucs
%%% ver0.4.2 2013/10/03 : fix a typo.
%%% ver0.4.1 2013/09/26 : [moreroom] thanks to Juho.Lee
%%% ver0.4.0 2013/09/25 : redesign for nanum type 1
%%% ver0.3.9 2012/11/22 : [figtabcapt] option
%%% ver0.3.8 2009/04/06 : [lyxhyper] option
%%% ver0.3.4 2008/10/23 : moreverb, faht, fawd options. (See xoblivoir.cls)
%%% ver0.3.3a 2008/09/30 : change the way of calling microtype (non-released version)
%%% ver0.3.3 2008/09/16 : apply microtype to non-pdflatex
%%% ver0.3.2 2007/11/18 : add \see, \seealso definition
%%% ver0.3.1 2007/10/23 : subfigure package compatibility (in order to use with LyX)
%%% ver0.3.0 2007/07/15 : no changes. part of ko.TeX
%%% ver0.2.4a 2007/07/05 : add \pjaso to enumerate
%%% ver0.2.4 2007/07/01 : adopt dhucs-enumerate.sty, enumerate hook.
%%% ver0.2.3 2007/06/26 : strictcharcheck option introduced. cf. dhucs 4.0.6
%%% ver0.2.2 2007/06/16 : finemath setto default. [nofinemath] introduced. [microtype] introduces, which works only under pdflatex.
%%% ver0.2.1 2007/06/14 : dhucs 4.0.1, memhangul-ucs 1.5.1
%%% ver0.20c 2007/06/03 : pdfbookmark option to memhangul-ucs dropped.
%%% ver0.20a 2007/05/24 : \oblivoirallowbreak introduced
%%% ver0.20 2007/05/17 : dhucs 4.0, memhangul-ucs 1.5.0
%%% ver0.18a 2007/01/14 : slightly alter calling-hyperref method.
%%% ver0.17C.a 2006/12/20 : \chapter-compatible feature. (private version) : \oblivoirchapterstyle command added.
%%% ver0.17  2006/12/06 : \appendix+nokorean option bug fix (req. by Beomsuk Hyun)
%%% ver0.16  2006/11/23 : \appendix features added. (req. by Beomsuk Hyun)
%%% ver0.15  2006/11/01 : [nokorean] option \if..\fi pair bug fix (rep. by smcho)
%%% ver0.14  2006/10/22 : [itemph], [romanfixed] option introduced.
%%% ver0.13  2006/10/19 : [tocentry] option introduced. (req. by Beomsuk Hyun)
%%% ver0.12  2006/09/25 : \kscntformat bug fix
%%% ver0.11  2006/09/18 : article-like footnote style made default, [footnote] option introduced
%%% ver0.1   2006/09/13 : renamed to oblivoir (req. by ischo)
%%% ver0.014 2006/09/05 : introduce [10.5pt] option with 10_5.sty (req. by synapse)
%%% ver0.013 2006/09/03 : introduce hfontsel.sty. (req. by synapse)
%%% ver0.012 2006/09/01 : \thetitle, \theauthor undefined problem fixed. (rep. by IsCho)
%%% ver0.011 2006/05/02 : rename ksnamedef(false) to kscntformat
%%% ver0.01  2006/04/27 : introduce [nokorean] option requested by smcho.
%%% ver0.001 2006/03/11 : started this class, just for fun!
%%%
