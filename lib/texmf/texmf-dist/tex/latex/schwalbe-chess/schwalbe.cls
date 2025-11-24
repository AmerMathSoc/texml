%%
%% This is file `schwalbe.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% schwalbe.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from schwalbe.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file schwalbe.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%%  File 'schwalbe.dtx'
%%
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version
%% 1.2 of this license or (at your option) any later version.
%% The latest version of this license is in:
%%
%%    http://www.latex-project.org/lppl.txt
%%
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%%
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schwalbe}[2015/02/17]
\LoadClass[11pt]{article}
\RequirePackage[12pt]{schwalbe}
\RequirePackage[T2A,T1]{fontenc}% fsRUS 140121
\RequirePackage[koi8-r,utf8]{inputenc}% fsRUS 140121
\RequirePackage[ngerman,english,german]{babel}
\RequirePackage{eurosym}
\RequirePackage{ifthen}
\RequirePackage{times}
\RequirePackage{multicol}
\RequirePackage{url}
\RequirePackage{paralist}
\RequirePackage{afterpage}
\RequirePackage{picinpar}
\hyphenation{Patt-idee Da-men-op-fer nicht-ortho-doxe Grim-shaw Rein-form}

\advance\exhyphenpenalty by -10
\tolerance2000\relax
\emergencystretch15\p@
\hoffset-25mm
\voffset-25mm
\textheight26cm
\textwidth157mm
\oddsidemargin22.5mm
\topmargin19mm
\headheight0cm
\headsep0cm
\footskip10mm
\parindent0mm
\parskip1ex plus 1ex minus .5ex
\def\@oddhead{}
\def\@oddfoot{%
   \ifodd\c@page%
      \hbox to \textwidth{\hfill\thepage}%
   \else%
      \hbox to \textwidth{\thepage\hfill}%
   \fi%
}
\def\dh{d.\,h.\ \ignorespaces}
\def\ua{u.\,a.\ \ignorespaces}
\def\zB{z.\,B.\ignorespaces}
\def\su{s.\,u.\ignorespaces}
\def\ep{e.\,p.\ignorespaces}
\def\seedia{s.\,Diagr.}
\def\figline{%
\centerline{%
\wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK %
\wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK %
\wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK \wK %
}}
\def\foto#1#2#3{%
  \begin{minipage}[t]{#1}
  \hbox to #1{\hsize#1%
    \vtop to #2{%
      \noindent\hbox{}\vfill\hbox{}%
    }%
  }%
  \par%
  #3%
  \end{minipage}
}%
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 6\p@ \@plus2\p@ \@minus2\p@
               \parsep 3\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand{\Heft}[5]{%
   \def\heft@band{#1}%
   \def\heft@nr{#2}%
   \def\heft@monat{#3}%
   \def\heft@year{#4}%
   \setcounter{page}{#5}%
   \hbox to \textwidth{\vbox to 60mm{\vfill}\hfill}%
   \hbox to \textwidth{%
      {\large\bfseries HEFT~#2}%
      \hfill%
      {\large\bfseries BAND #1}%
      \hfill%
      {\large\bfseries #3~#4}%
   }%
   \vskip2mm%
   \hrule width \textwidth height 1\p@%
   %\input{intro}%
   \vskip5mm%
}
\newenvironment{Editorial}[2][Editorial]{%
   \ttitel@skip%
   \centerline{\Large\bfseries #1}%
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \begingroup%
      \def\@tempa{#2}%
      \def\@tempb{\editorial}%
      \edef\@tempc{%
         \write\sw@contents{%
            \@nearverbatim\@tempb{%
               {\@nearverbatim\@tempa}%
               {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
            }%
         }%
      }%
   \expandafter\endgroup\@tempc%
}{}
\newenvironment{aktuell}{%
   \ttitel@skip%
   \centerline{\Large\itshape AKTUELLE MELDUNGEN}
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   % Eintrag im Inhaltsverzeichnis
    \bgroup%
      \def\@tempb{\aktuell}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
            {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
}{}
\newcommand{\@dia@award@InformalEntscheid}{%
    \above@newline%
    \bgroup%
    \authorfont\the\award@tk\hfill%
    \if@sourcenr\relax%
        \the\sourcenr@tk%
    \else\if@issue%
        Heft~\the\issue@tk%
        \if@pages%
            , S.~\the\pages@tk%
        \fi%
    \else%
        \if@special\relax%
           \thediag%
        \fi
    \fi\fi%
    \egroup%
}
\newcommand{\@dia@authors@InformalEntscheid}{%
   \ifauth@r%
      \ifnormal@names%
         \def\@dianame{\@normalname}%
      \fi%
      \@firstfalse%
      \let\@action=\@dia@writename% Parse the list of authors
      \@parseTokenlist\aut@tk;%
   \fi%
}
\newboolean{normaldiaabove}
\setboolean{normaldiaabove}{true}
\newcommand{\dia@above@InformalEntscheid}{%
    \ifthenelse{\boolean{normaldiaabove}}{%
        \orig@dia@above%
    }{%
        \setboolean{above@newline}{false}%
        \@dia@award@InformalEntscheid%
        \@dia@authors@InformalEntscheid%
        \@dia@after%
        \@dia@version%
        \@dia@correction%
        \@dia@dedic%
        \@dia@fidealbum%
    }%
}
\newenvironment{InformalEntscheid}{%
    \@ifstar{\x@InformalEntscheid}{\y@InformalEntscheid}%
}{}
\newcommand{\x@InformalEntscheid}[3]{%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   % Weitere Einstellungen
   \let\orig@dia@above=\dia@above%
   \let\dia@above=\dia@above@InformalEntscheid%
   \setboolean{normaldiaabove}{false}%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \bgroup%
      \def\@tempb{\InformalEntscheid}%
      \def\@tempc{#1}%
      \def\@tempd{#2}%
      \def\@tempe{#3}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
                    {\@nearverbatim\@tempe}%
          {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\newcommand{\y@InformalEntscheid}[3]{%
   \ttitel@skip%
   \vbox{%
      \centerline{\Large\bfseries Entscheid im Informalturnier #2 der Schwalbe}%
      \centerline{\bfseries Abteilung: #1\hskip1cm Preisrichter: #3}%
   }%
   \titel@skip%
   \x@InformalEntscheid{#1}{#2}{#3}%
}
\newenvironment{Aufsatz}[2]{%
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
   \begingroup%
      \setcounter{footnote}{0}%
      \def\@tempa{#1}%
      \def\@tempc{\aufsatz}%
      \def\@tempb{#2}%
      \edef\@tempd{%
         \write\sw@contents{%
            \@nearverbatim\@tempc{%
               {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
               {\@nearverbatim\@tempa}%
               {\@nearverbatim\@tempb}%
            }%
         }%
      }%
   \expandafter\endgroup\@tempd%
}{}
\newenvironment{Urdrucke}[1]{%
    \setboolean{showcity}{true}%
    \nocomputer%
    \diagnumbering{arabic}%
    \diagnum{#1}%
    \@urdrucktrue%
    \def\do@dia@job{%
        % Gebe das Diagramm aus
        \unhbox\dia@box%
        % Erzeuge die Eintr"age f"ur das Inhaltsverzeichnis
        \sw@problem%
    }%
    \ttitel@skip%
    \centerline{\Large\bfseries Urdrucke}%
    \titel@skip%
    \stepcounter{@inhalt}%
    \inhalt@label\relax%
    % Eintrag im Inhaltsverzeichnis
    \bgroup%
       \def\@tempb{\Urdrucke}%
     \edef\@tempa{
       \write\sw@contents{%
             \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
         }%
       }%
     }%
    \expandafter\egroup\@tempa%
}{}
\newenvironment{Loesungen}[2]{%
    \begingroup%
   \ttitel@skip%
   \centerline{\Large\bfseries L\"osungen der Urdrucke aus Heft #1, #2}%
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   % Eintrag im Inhaltsverzeichnis
    \bgroup%
      \def\@tempb{\Loesungen}%
      \def\@tempc{#1}%
      \def\@tempd{#2}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
   \parskip.5ex plus 2ex%
   \catcode`/=\active%
}{%
   \catcode`/=12%
    \endgroup%
}
\newenvironment{Loeserliste}[1]{%
   \ttitel@skip%
   \centerline{\Large\bfseries L\"oserliste #1}%
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   % Eintrag im Inhaltsverzeichnis
   \bgroup%
       \def\@tempb{\Loeserliste}%
     \edef\@tempa{
       \write\sw@contents{%
             \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
         }%
       }%
     }%
   \expandafter\egroup\@tempa%
}{}
\newcommand{\dauerkonto}[1]{%
   \ttitel@skip%
   \centerline{\large\bfseries L\"oserliste: Sonderpunkte \& Dauerkonto #1}%
   \titel@skip%
}
\newcommand{\loesungswettbewerb}[1]{
   \ttitel@skip%
   \centerline{\Large\bfseries Preisbericht zum L\"osungswettbewerb #1}%
   \titel@skip%
}
\newenvironment{BuB}{%
   \ttitel@skip%
   \centerline{\Large\bfseries Bemerkungen und Berichtigungen}%
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bsol%
   % Eintrag im Inhaltsverzeichnis
    \bgroup%
      \def\@tempb{\bub}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
}{\esol}
\newcommand{\Briefkasten}{%
   \titel@skip%
   {\large\bfseries Briefkasten}%
   \hskip1em%
}
\let\titel@ext\relax
\newcounter{@inhalt}
\setcounter{@inhalt}{0}
\def\the@inhalt{\@arabic\c@@inhalt}
\def\inhalt@label{\label{inhalt\@nameuse{the@inhalt}}}
\def\Titel{\ttitel@skip\centering\addtolength{\baselineskip}{4pt}}
\def\endTitel{\titel@skip\titel@ext}
\def\Untertitel{\subtitel@skip\centering}
\def\endUntertitel{\subtitel@subskip}
\newenvironment{Bericht}[1]{%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Bericht}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}{}
\newenvironment{Gruss}[1]{%
   % Eintrag im Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
    \bgroup%
      \def\@tempb{\Bericht}%
      \def\@tempc{#1}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
}{}
\newenvironment{Tagung}[1]{%
   % Eintrag im Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
    \bgroup%
      \def\@tempb{\Bericht}%
      \def\@tempc{#1}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
          {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
}{}
\newenvironment{Turnierbericht}[2]{%
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \bgroup%
      \def\@tempb{\Turnierbericht}%
      \def\@tempc{#1}%
      \def\@tempd{#2}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}{}
\newenvironment{turnierberichte}{%
   \ttitel@skip%
   \vbox{\centering\Large\bfseries Turnierberichte}%
   \titel@skip%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \nodiagnumbering%
   % Eintrag im Inhaltsverzeichnis
    \bgroup%
      \def\@tempb{\Turnierberichte}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
}{}
\newcommand{\turnier}[1]{%
   \vskip\tw@\p@%
   {\large\bfseries#1}%
   \par%
}
\newcounter{@maerchenlexikon}
\setcounter{@maerchenlexikon}{0}
\newboolean{@first@lexikon@entry}
\newcommand{\maerchenart}[1]{%
  \ifthenelse{\boolean{@first@lexikon@entry}}{%
    \setboolean{@first@lexikon@entry}{false}%
  }{%
    --- %
  }%
  {\itshape #1:} \ignorespaces%
}
\newenvironment{maerchenlexikon}%
{%
  \ifthenelse{\value{@maerchenlexikon}=0}{%
    {\itshape Kleines M\"archenschach-Lexikon:} %
  }{}%
  \setboolean{@first@lexikon@entry}{true}%
  \stepcounter{@maerchenlexikon}%
}{}
\newenvironment{Entscheid}[1]{%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \let\titel@ext\inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Entscheid}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}{}
\newboolean{@firstbook}
\setboolean{@firstbook}{true}
\newcounter{@buecher}
\setcounter{@buecher}{0}
\newenvironment{Buecher}{%
    \ttitel@skip%
    \centerline{\Large\bfseries \ifthenelse{\value{@buecher}=1}{Buchbesprechung}{Buchbesprechungen}}%
    \titel@skip%
    \setboolean{@firstbook}{true}%
    \stepcounter{@inhalt}%
    \inhalt@label\relax%
    % Eintrag im Inhaltsverzeichnis
    \bgroup%
        \ifthenelse{\value{@buecher}=1}{\def\@tempb{\Buch}}{\def\@tempb{\Buecher}}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
    \setcounter{@buecher}{0}%
}{%
   \immediate\write\@auxout{\string\setcounter{@buecher}{\arabic{@buecher}}}%
}
\def\@book@authors#1; {%
   \if@notfirst%
      , %
   \else%
      \noindent%
      \@notfirsttrue%
   \fi%
   \@fullname#1; %
   \l@@klist%
}
\newcommand{\Buch}[2]{%
    \ifthenelse{\boolean{@firstbook}}{%
        \titel@skip%
        \setboolean{@firstbook}{false}%
    }{%
        \par%
    }%
   \stepcounter{@buecher}%
   \bgroup%
      \bfseries%
      \ifx\relax#1\else%
         \@notfirstfalse
         \let\@action\@book@authors%
         \l@@klist#1; \e@list%
         : %
      \fi%
      \itshape #2\ \ignorespaces%
   \egroup%
}
\newboolean{@firstwebsite}
\setboolean{@firstwebsite}{true}
\newcounter{@websites}
\setcounter{@websites}{0}
\newenvironment{WebSites}{%
    \ttitel@skip%
    \centerline{\Large\bfseries \ifthenelse{\value{@websites}=1}{Web-Site Besprechung}{Web-Site Besprechungen}}%
    \titel@skip%
    \setboolean{@firstwebsite}{true}%
    \stepcounter{@inhalt}%
    \inhalt@label\relax%
    % Eintrag im Inhaltsverzeichnis
    \bgroup%
        \ifthenelse{\value{@websites}=1}{\def\@tempb{\WebSite}}{\def\@tempb{\WebSites}}%
        \edef\@tempa{
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
        }%
    \expandafter\egroup\@tempa%
    \setcounter{@websites}{0}%
}{%
   \immediate\write\@auxout{\string\setcounter{@websites}{\arabic{@websites}}}%
}
\newcommand{\WebSite}[1]{%
    \ifthenelse{\boolean{@firstwebsite}}{%
        \titel@skip%
        \setboolean{@firstwebsite}{false}%
    }{%
        \par%
    }%
   \stepcounter{@websites}%
   {\bfseries#1}%
}
\def\aTurnier{%
   \@ifstar{\x@Turnier}{\y@Turnier}%
}
\def\TurnierAusschreibung#1{%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   % Eintrag im Inhaltsverzeichnis
   \bgroup%
       \def\@tempb{\TurnierAusschreibung}%
       \def\@tempc{#1}%
     \edef\@tempa{
       \write\sw@contents{%
             \@nearverbatim\@tempb{%
                {\@nearverbatim\@tempc}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
         }%
       }%
     }%
   \expandafter\egroup\@tempa%
}
\def\x@Turnier#1#2{%
   \ttitel@skip%
   \vbox{%
      \centering%
      {\large\bfseries\uppercase{#1}}\\[3mm]
      {\bfseries#2}%
   }%
   \titel@skip%
}
\def\y@Turnier#1{%
   \ttitel@skip%
   \vbox{%
      \centering%
      \large\bfseries\uppercase{#1}%
   }%
   \titel@skip%
}
\def\bTurnier{%
   \@ifstar{\by@turnier}{\bx@turnier}%
}
\def\sw@turnier{%
}
\def\bx@turnier#1#2{%
   \ttitel@skip%
   \vbox{%
      \centering%
      {\Large\bfseries#1}\\
      \bgroup%
      \bfseries%
      \@firsttrue%
      \let\@action=\sw@author%
      \l@@klist#2; \e@list%
      \egroup%
   }%
   \titel@skip%
   \diagnum{1}%
}
\def\by@turnier#1{%
   \ttitel@skip%
   \vbox{%
      \centering
      {\Large\bf#1}
   }%
   \titel@skip%
   \diagnum{1}%
}
\def\eEntscheid{%
   \@ifstar{\i@eEntscheid}{\ii@eEntscheid}%
}
\def\i@eEntscheid#1{%
   \ttitel@skip%
   \vbox{%
      \centering
      \Large\bfseries#1%
   }%
   \titel@skip%
}
\def\ii@eEntscheid#1#2{%
   \ttitel@skip%
   \vbox{%
      \centering%
      \Large\bfseries#1\\
      \large\bfseries#2%
   }%
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Bericht}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
   \titel@skip%
}
\newif\if@title\@titletrue
\def\Geburtstag{%
    \@ifnextchar *{\@@Geburtstag}{\@Geburtstag}%
}
\def\@@Geburtstag#1{\@titlefalse\@Geburtstag}%
\def\@Geburtstag{%
  \@ifnextchar [{\y@Geburtstag}{\x@Geburtstag}%
}
\def\x@Geburtstag#1#2{%
   \if@title%
   \ttitel@skip%
   \centerline{\Large\bfseries#1\ \ #2}
   \titel@skip%
   \fi%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Geburtstag}%
      \def\@tempc{#1}%
      \def\@tempd{#2}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
          {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\def\y@Geburtstag[#1]#2#3{%
   \if@title%
   \ttitel@skip%
   \centerline{#1}
   \titel@skip%
   \fi%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Geburtstag}%
      \def\@tempc{#2}%
      \def\@tempd{#3}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\def\Verstorben{\@ifstar{\y@Verstorben}{\x@Verstorben}}
\def\x@Verstorben#1#2{%
   \ttitel@skip%
   \hbox to \textwidth{\large\bf\uppercase{#1}\hfill#2}%
   \titel@skip%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Verstorben}%
      \def\@tempc{#1}%
      \def\@tempd{#2}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                    {\@nearverbatim\@tempd}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\def\y@Verstorben#1{%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \inhalt@label\relax%
   \bgroup%
      \def\@tempb{\Verstorben}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\def\Nachruf#1{%
   % Erzeuge den Eintrag f\"ur das Inhaltsverzeichnis
   \stepcounter{@inhalt}%
   \bgroup%
      \def\@tempb{\Verstorben}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
                {\@nearverbatim\pageref{inhalt\@nameuse{the@inhalt}}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
\def\Einladung{%
   \@ifnextchar[{\@@Einladung}{\@Einladung}%
}
\def\@Einladung#1{%
   \ttitel@skip%
   \vbox{%
      \centering%
      \large\bf\uppercase{#1}%
   }%
   \titel@skip%
}
\def\@@Einladung[#1]#2{%
   \ttitel@skip%
   \vbox{%
      \centering%
      \large\bf\uppercase{#2}%
   }%
   \titel@skip%
   \bgroup%
      \def\@tempb{\Einladung}%
      \def\@tempc{#1}%
      \edef\@tempa{%
            \write\sw@contents{%
            \@nearverbatim\@tempb{%
                    {\@nearverbatim\@tempc}%
               {\@nameuse{thepage}}%
                }%
            }%
      }%
   \expandafter\egroup\@tempa%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newwrite\sw@contents
\immediate\openout\sw@contents=\jobname.inhalt\relax
\newwrite\sw@problems
\immediate\openout\sw@problems=\jobname.problems\relax
\def\ttitel@skip{\vskip24\p@ plus \f@ur\p@\goodbreak}
\def\titel@skip{\nopagebreak\vskip\tw@\p@}
\def\subtitel@skip{\vskip10\p@ plus \f@ur\p@ minus \f@ur\p@ \penalty-100}
\def\subtitel@subskip{\nopagebreak\vskip\@ne\p@}
\def\sw@author#1; {%
    \sw@writeauthor#1;%
    \l@@klist%
}
\def\sw@writeauthor#1, #2/#3;{%
   \if@first%
      von~%
      \@firstfalse%
   \else%
      \ \&\ %
   \fi%
    #2~#1, #3%
}
\newif\if@gemeinschaft
\def\sw@problem{%
    % Z"ahle die Autoren
    \sw@count\z@%
    \let\@action=\sw@authorCount%
    \expandafter\l@@klist\the\aut@tk; \e@list%
    \ifnum\sw@count>\@ne%
        \@gemeinschafttrue%
    \else%
        \@gemeinschaftfalse%
    \fi%
    \bgroup%
        \let\@action=\sw@problemAuthor%
        \expandafter\l@@klist\the\aut@tk; \e@list%
    \egroup%
}
\def\sw@problemAuthor#1; {%
    \bgroup%
    \def\@tempc{\problem}%
    \def\@tempb{#1}%
    \edef\@tempa{%
        \write\sw@problems{%
            \@nearverbatim\@tempc{%
                {\@nameuse{thepage}}%
                \if@special%
                    {\@nearverbatim\thediag}%
                \else%
                    {\thediag}%
                \fi%
                {\@nearverbatim\@tempb}%
                {\if@urdruck\else n\fi\if@gemeinschaft g\fi}%
            }%
        }%
    }%
    \expandafter\egroup\@tempa%
    \l@@klist%
}
\newcount\sw@count
\def\sw@authorCount#1; {%
    \advance\sw@count\@ne%
    \l@@klist%
}
\def\@meaning#1>{}
\def\@nearverbatim{\expandafter\@meaning\meaning}
\def\i@line#1#2{#1 \hrulefill\ #2\newline}
\def\iw@author#1; {%
    \iw@writeauthor#1;%
    \l@@klist%
}
\def\iw@writeauthor#1, #2/#3;{%
   \if@first%
      \@firstfalse%
   \else%
      , \ %
   \fi%
    #2~#1%
}
\def\ix@Geburtstag#1#2#3{\i@line{#1\ \ #2}{#3}}
\def\ix@aufsatz#1#2#3{%
  \i@line{{\itshape %
  \@firsttrue%
  \let\@action\iw@author\relax%
  \aut@tk={#3}%
  \@parseTokenlist\aut@tk;%
  :\/} #2}{#1}%
}
\def\ix@InformalEntscheid#1#2#3#4{\i@line{Entscheid im Informalturnier #2, Abteilung #1}{#4}}
\def\ix@Loesungen#1#2#3{\i@line{L\"osungen der Urdrucke aus Heft #1, #2}{#3}}
\def\ix@turnierbericht#1#2#3{%
  \i@line{Entscheid im #1}{#3}%
}
\def\ix@bericht#1#2{\i@line{#1}{#2}}
\def\ix@einladung#1#2{\i@line{#1}{#2}}
\def\ix@verstorben#1#2{\i@line{#1}{#2}}
\def\ix@entscheid#1#2{\i@line{#1}{#2}}
\def\ix@editorial#1#2{\i@line{#1}{#2}}
\def\ix@ausschreibung#1#2{\i@line{#1}{#2}}
\def\i@Geburtstag#1{\ix@Geburtstag#1}
\def\i@aufsatz#1{\ix@aufsatz#1}
\def\i@aktuell#1{\i@line{Aktuelle Meldungen}{#1}}
\def\i@InformalEntscheid#1{\ix@InformalEntscheid#1}
\def\i@urdrucke#1{\i@line{Urdrucke}{#1}}
\def\i@Loesungen#1{\ix@Loesungen#1}
\def\i@Loeserliste#1{\i@line{L\"oserliste}{#1}}
\def\i@bub#1{\i@line{Bemerkungen und Berichtigungen}{#1}}
\def\i@turniere#1{\i@line{Turnierberichte}{#1}}
\def\i@buecher#1{\i@line{Buchbesprechungen}{#1}}
\def\i@buch#1{\i@line{Buchbesprechung}{#1}}
\def\i@websites#1{\i@line{Web-Site Besprechungen}{#1}}
\def\i@website#1{\i@line{Web-Site Besprechung}{#1}}
\def\i@turnierbericht#1{\ix@turnierbericht#1}
\def\i@bericht#1{\ix@bericht#1}
\def\i@einladung#1{\ix@einladung#1}
\def\i@verstorben#1{\ix@verstorben#1}
\def\i@entscheid#1{\ix@entscheid#1}
\def\i@editorial#1{\ix@editorial#1}
\def\i@TurnierAusschreibung#1{\ix@ausschreibung#1}
\def\Inhalt{%
   \centerline{\bfseries INHALT}%
   \vspace{-.5mm}
   \begingroup%
   \esol%
   \let\Geburtstag=\i@Geburtstag%
   \let\aufsatz=\i@aufsatz%
   \let\aktuell=\i@aktuell%
   \let\InformalEntscheid=\i@InformalEntscheid%
   \let\Urdrucke=\i@urdrucke%
   \let\Loesungen=\i@Loesungen%
   \let\Loeserliste=\i@Loeserliste%
   \let\bub=\i@bub%
   \let\Turnierberichte=\i@turniere%
   \let\Turnierbericht=\i@turnierbericht%
   \let\Bericht=\i@bericht%
   \let\Einladung=\i@einladung%
   \let\Buecher=\i@buecher%
   \let\Buch=\i@buch%
   \let\WebSites=\i@websites%
   \let\WebSite=\i@website%
   \let\Verstorben=\i@verstorben%
   \let\Entscheid=\i@entscheid%
   \let\editorial=\i@editorial%
   \let\TurnierAusschreibung=\i@TurnierAusschreibung%
   \immediate\closeout\sw@contents\relax%
   \input\jobname.inhalt%
   \noindent\hbox{}\endgroup%
}
\def\i@author#1, #2; {\if@first\@firstfalse\else, \fi#2~#1\l@@klist}

\def\aufsatz#1#2#3{%
   \bgroup
      \itshape
      \@firsttrue
      \let\@action=\i@author
      \l@@klist#3; \e@list%
      : %
   \egroup
   #2%
   \hrulefill\ #1\newline
}
\def\sol@slash{\nobreak\hskip\z@ plus 2\p@\char`/\hskip\z@ plus 2\p@\discretionary{}{}{}}
\catcode`/=\active\relax\let/\sol@slash\relax\catcode`/=12%
\def\bsol{\catcode`/=\active\relax}
\def\esol{\catcode`/=12\relax}
\bsol

\renewcommand{\section}{\@startsection{section}{1}{\z@}{2ex}{.5ex}{\normalfont\large\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}{1ex}{.3ex}{\normalfont\bfseries}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}{.4ex}{.1ex}{\normalfont}}

\renewcommand{\x}{:}
\InputIfFileExists{schwalbe.ext}{}{}%
\endinput
%%
%% End of file `schwalbe.cls'.
