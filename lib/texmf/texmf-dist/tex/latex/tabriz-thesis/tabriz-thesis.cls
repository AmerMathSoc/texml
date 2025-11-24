
%%
%%  This is file `tabriz-thesis.cls',
%%  The original file was xepersian-thesis.cls by Vafa Khalighi
%%   __________________________________
%%   Copyright © 2011-2013 Vahid Damanafshan
%%  
%%   http://www.damanafshan.ir
%%   http://www.parsilatex.com  
%%   http://forum.parsilatex.com
%% 
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tabriz-thesis}
              [2013/03/17 v1.1 University of Tabriz projects/theses/dissertations Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper,11pt,oneside,openany]{book}
%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage[top=40mm, bottom=40mm, left=25mm, right=35mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{framed} 
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{makeidx}
\makeindex
\RequirePackage[]{hyperref}
%%%%%%%%%%%%%%%%%%%%%%%%%
\def\university#1{\gdef\@university{#1}}
\def\department#1{\gdef\@department{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\thesisdate#1{\gdef\@thesisdate{#1}}
\newcommand{\firstsupervisor}[1]{\def\@firstsupervisor{#1}}
\newcommand{\secondsupervisor}[1]{\def\@secondsupervisor{#1}}
\newcommand{\firstadvisor}[1]{\def\@firstadvisor{#1}}
\newcommand{\secondadvisor}[1]{\def\@secondadvisor{#1}}
\def\name#1{\gdef\@name{#1}}
\def\surname#1{\gdef\@surname{#1}}
\long\def\keywords#1{\gdef\@keywords{#1}}
\long\def\fa-abstract#1{\gdef\@fa-abstract{#1}}
\def\faculty#1{\gdef\@faculty{#1}}
\def\subject#1{\gdef\@subject{#1}}
\def\field#1{\gdef\@field{#1}}
\def\department#1{\gdef\@department{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\def\latintitle#1{\gdef\@latintitle{#1}}
\def\latinauthor#1{\gdef\@latinauthor{#1}}
\def\latindegree#1{\gdef\@latindegree{#1}}
\def\latinfaculty#1{\gdef\@latinfaculty{#1}}
\def\latinthesisdate#1{\gdef\@latinthesisdate{#1}}
\def\latinsubject#1{\gdef\@latinsubject{#1}}
\def\latinfield#1{\gdef\@latinfield{#1}}
\def\firstlatinsupervisor#1{\gdef\@firstlatinsupervisor{#1}}
\def\secondlatinsupervisor#1{\gdef\@secondlatinsupervisor{#1}}
\def\firstlatinadvisor#1{\gdef\@firstlatinadvisor{#1}}
\def\secondlatinadvisor#1{\gdef\@secondlatinadvisor{#1}}
\def\latinname#1{\gdef\@latinname{#1}}
\def\latinsurname#1{\gdef\@latinsurname{#1}}
\long\def\en-abstract#1{\gdef\@en-abstract{#1}}
\long\def\latinkeywords#1{\gdef\@latinkeywords{#1}}
\def\latinuniversity#1{\gdef\@latinuniversity{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@bscthesis
\@bscthesisfalse
\DeclareOption{bsc}{\@bscthesistrue}
\newif\if@mscthesis
\@mscthesisfalse
\DeclareOption{msc}{\@mscthesistrue}
\ProcessOptions
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\vtitle}{\begin{titlepage}
\vspace{-10ex}\centerline{{\includegraphics[height=4.3cm]{logo}}}
\vspace{-2ex}
{\large\@faculty\par

\vspace{-3ex}\@department}
\vskip 4ex
 \if@mscthesis
{\large\bfseries پایان‌نامه}
\else
 \if@bscthesis
 {\large\bfseries پروژه }
 \else
{\large\bfseries رساله}
\fi\fi
\vskip 2ex
{\large\bfseries\writtenfor
\if@mscthesis
کارشناسی ارشد
\else
\if@bscthesis
کارشناسی
\else
دکتری
\fi\fi
}
{\large\bfseries{در رشته}}
\vskip 1ex
\centerline{\large \bfseries\@subject%
\if@mscthesis%
، گرایش
\else
\if@bscthesis%
\relax%
\else%
، گرایش
\fi\fi
\@field}
\vskip 6ex
%\baselineskip=.750cm
\centerline{\Large \bfseries\onvan}
%\vskip .2cm
 {\huge\bfseries {\baselineskip=1cm \@title}}\baselineskip=1.5cm\par
\vskip 4ex
 \baselineskip=.5cm
\large
{\ifx\@firstsupervisor\undefined%
\ifx\@secondsupervisor\undefined%
\else\fi
\else
\ifx\@secondsupervisor\undefined%
استاد راهنما
{\Large\bfseries\par
\@firstsupervisor}
\else
\large
استادان راهنما
\par
{\Large\bfseries \@firstsupervisor{} و \@secondsupervisor}
\fi\fi}
\par\large
{\ifx\@firstadvisor\undefined%
\ifx\@secondadvisor\undefined%
\else\fi
\else
\ifx\@secondadvisor\undefined%
استاد مشاور
{\Large\bfseries\par
\@firstadvisor}
\else

\large
استادان مشاور
\par
{\Large\bfseries\@firstadvisor{} و \@secondadvisor}
\fi\fi}

{\large%
  \by}\par
\par
{\Large\bfseries{\nastaliq\large\bfseries   \@name\ \ \@surname}}\par
%\vskip 3ex
%\vfill
{\large \@thesisdate}
%\vfill
\end{titlepage}%
\newpage
\thispagestyle{empty}
\baselineskip=.7cm
\if@bscthesis \relax
\else
\begin{frame}
\noindent
نام خانوادگی دانشجو: 
\@surname
 \hspace*{\fill}
 نام: 
\@name
 \hspace*{\fill}\\ \hrule
 \vspace{3mm}
 \noindent
 عنوان:
\@title\\ \hrule
 \vspace{3mm}
 \noindent
{\ifx\@firstsupervisor\undefined%
\ifx\@secondsupervisor\undefined%
\else\fi
\else
\ifx\@secondsupervisor\undefined%
استاد راهنما:
{
\@firstsupervisor}
\else
\large
استادان راهنما:
{\@firstsupervisor{} و \@secondsupervisor}
\fi\fi}%\par
\noindent
{\ifx\@firstadvisor\undefined%
\ifx\@secondadvisor\undefined%
\else\fi
\else
\ifx\@secondadvisor\undefined%
\par\noindent
استاد مشاور:
{
\@firstadvisor}
\else\\
\large
استادان مشاور:
{\@firstadvisor{} و \@secondadvisor}
\fi\fi}
\\ \hrule
 \vspace{3mm}
 \noindent
 مقطع تحصیلی:
 \if@mscthesis
کارشناسی ارشد
\else
دکتری
\fi
 \hspace*{\fill}
رشته: 
\@subject
 \hspace*{\fill}
 گرایش:
\@field
\\ \hrule
 \vspace{3mm}
 \noindent
دانشگاه: 
\@university
 \hspace*{\fill}
\@faculty\hspace*{\fill}
\\ 
تاریخ فارغ‌التحصیلی:
\@thesisdate
 \hspace*{\fill}
تعداد صفحات: 
\pageref{LastPage}\hspace*{\fill}
\\ \hrule
 \vspace{3mm}
 \noindent
واژگان کلیدی:
\@keywords
\\ \hrule
 \vspace{3mm}
 \noindent
\textbf{چکیده}\par
\@fa-abstract
\end{frame}
\fi
}
\def\frame{\newpage
\thispagestyle{empty}
\begin{framed}\thispagestyle{empty}}
\def\endframe{\thispagestyle{empty}\end{framed}
\thispagestyle{empty}
\newpage
}
\def\abstractpage{\newpage
\thispagestyle{empty}
\vskip 15mm
\par
\begin{abstract}}
\def\endabstractpage{\end{abstract}
\newpage
}

\def\latinabstract{\newpage
\thispagestyle{empty}
\vskip 15mm
\begin{center}{\Large\bfseries \@latintitle \\[5mm]}
{\bfseries Abstract}
\end{center}
\vspace{5mm}}

\def\endlatinabstract{\newpage}

\def\acknowledgementpage{\newpage
\thispagestyle{empty}

\vspace{1cm}
\par\noindent}
\def\endacknowledgementpage{\newpage}

\def\titlepage{\newpage\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\signature{\vspace{1cm}
\begin{flushleft}
{\nastaliq \scriptsize \@name\ \@surname \\
\@thesisdate}
\end{flushleft}}

\def\abstract{\subsection*{\abstractname}\small
\@normalsize}
\def\endabstract{\par}

\newcommand{\latinvtitle}{%
\if@bscthesis \relax
\else
\begin{frame}
\noindent
Surname:
\@latinsurname
 \hspace*{\fill}
Name:
\@latinname
 \hspace*{\fill}\\ \hrule
 \vspace{3mm}
 \noindent
Title:
\@latintitle\\ \hrule
 \vspace{3mm}
 \noindent
{\ifx\@firstlatinsupervisor\undefined%
\ifx\@secondlatinsupervisor\undefined%
\else\fi
\else
\ifx\@secondlatinsupervisor\undefined%
Supervisor:
{
\@firstlatinsupervisor}
\else
\large
Supervisors:
{ \@firstlatinsupervisor{} and \@secondlatinsupervisor}
\fi\fi}\par
\noindent
{\ifx\@firstlatinadvisor\undefined%
\ifx\@secondlatinadvisor\undefined%
\else\fi
\else
\ifx\@secondlatinadvisor\undefined%
Advisor:
{
\@firstlatinadvisor}
\else
\large
Advisors:
{\@firstlatinadvisor{} and \@secondlatinadvisor}
\fi\fi}
\\ \hrule
 \vspace{3mm}
 \noindent
Degree:
 \if@mscthesis
 Master of Science
\else
 Doctor of Science
\fi
 \hspace*{\fill}
Subject:
\@latinsubject
\hspace*{\fill}
\\ 
Field:
\@latinfield
\\ \hrule
 \vspace{3mm}
 \noindent
\@latinuniversity
 \hspace*{\fill}
\@latinfaculty\hspace*{\fill}
\\ 
Date:
\@latinthesisdate
 \hspace*{\fill}
Number of pages:
\pageref{LastPage}\hspace*{\fill}
\\ \hrule
 \vspace{3mm}
 \noindent
Keywords:
\@latinkeywords
\\ \hrule
 \vspace{3mm}
 \noindent
\textbf{Abstract}\par
\@en-abstract
\end{frame}
\begin{titlepage}
\vspace{-1.5cm}{\includegraphics[height=4.3cm]{logo}}
\centerline{\bf \@latinuniversity} 
\large\bfseries
\@latinfaculty\space 
\vskip 5mm
%{
 \if@mscthesis
Dissertation Submitted in Partial 
\\[.2cm]
 Fulfillment of The Requirements For The
\\[.2cm]
Degree of Master of Science in\par
\else
Doctoral Thesis Submitted in Partial 
\\[.2cm]
Fulfillment of The  Requirements For The
\\[.2cm]
Degree of Doctor of Science in \par
\fi
{\large\bfseries \@latinsubject}
\vskip 1cm
\baselineskip=.750cm
{\Large\bfseries\@latintitle}
\baselineskip=.750cm \par
%\addtolength{\baselineskip}{-5mm}
\vskip 1.5cm
\large
{\ifx\@firstlatinsupervisor\undefined%
\ifx\@secondlatinsupervisor\undefined%
\else\fi
\else
\ifx\@secondlatinsupervisor\undefined%
Supervisor
{\large\bfseries\par
\@firstlatinsupervisor}
\else
\large
Supervisors
\par
{\large\bfseries \@firstlatinsupervisor{} and \@secondlatinsupervisor}
\fi\fi}
\par
\large
{\ifx\@firstlatinadvisor\undefined%
\ifx\@secondlatinadvisor\undefined%
\else\fi
\else
\ifx\@secondlatinadvisor\undefined%
Advisor
{\large\bfseries\par
\@firstlatinadvisor}
\else

\large
Advisors
\par
{\large\bfseries\@firstlatinadvisor{} and \@secondlatinadvisor}
\fi\fi}
\vskip 5mm
{\bfseries\latinby}\par
{\large %\supervisorfont
\@latinname \; \@latinsurname}\par
\vskip 5mm

\par
\vskip 1cm

{\@latinthesisdate}
\par
\vskip 1cm

\par

\vfill
%
\end{titlepage}
\fi}

\def\onvan{عنوان}
\def\writtenfor{برای دریافت درجه }
\def\by{پژوهشگر}
\def\latinby{By}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\bibname}{مراجع}
\newcommand\persiangloss[2]{#1\dotfill\lr{#2}\\}
\newcommand\englishgloss[2]{#2\dotfill\lr{#1}\\}
\newcommand{\پ}{پروژه/پایان‌نامه/رساله }
%%%%%%%%%%%%%%%%%%%%%%%%%%
\theoremstyle{definition}
\newtheorem{definition}{تعریف}[section]
\theoremstyle{theorem}
\newtheorem{theorem}[definition]{قضیه}
\newtheorem{lemma}[definition]{لم}
\newtheorem{proposition}[definition]{گزاره}
\newtheorem{corollary}[definition]{نتیجه}
\newtheorem{remark}[definition]{ملاحظه}
\theoremstyle{definition}
\newtheorem{example}[definition]{مثال}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancy}
\fancyhf{} 
\fancyhead[OL,EL]{\thepage}
\fancyhead[OR]{\small\rightmark}
\fancyhead[ER]{\small\leftmark}
\renewcommand{\chaptermark}[1]{%
\markboth{\thechapter.\ #1}{}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% Copyright © 2011-2013      by Vahid Damanafshan     
%% 
%% Distributable under the LaTeX Project Public License,
%% version 1.3c or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status)
%%  by Vahid Damanafshan.
%% 
%% 
%% 
%% 
%% Special thanks to Vafa Khalighi for his invaluable hints.
%%
%% End of file `tabriz-thesis.cls'.
