%% Copyright 2004 Vjacheslav A. Fyodorov






















\NeedsTeXFormat{LaTeX2e} \ProvidesClass{eskd}[2004/10/12 a4 eskd
format (V.Fyodorov@tltsu.ru)]

\newif\ifeskd@twoside
\eskd@twosidefalse

\newif\ifeskd@title
\eskd@titlefalse

\newcommand{\eskdheight}{282}
\newcommand{\eskdencoding}{koi8-r}
\newcommand{\eskdyear}{\number\year}

\newcommand{\eskd@thin}{0.2}
\newcommand{\eskd@half@thin}{0.1}

\newcommand{\eskd@thick}{0.4}
\newcommand{\eskd@half@thick}{0.2}

\RequirePackage{keyval}

\define@key{eskd}{height}{\renewcommand{\eskdheight}{#1}}
\define@key{eskd}{encoding}{\renewcommand{\eskdencoding}{#1}}
\define@key{eskd}{year}{\renewcommand{\eskdyear}{#1}}

\DeclareOption{title}{\eskd@titletrue}

\DeclareOption{twoside}{%
  \eskd@twosidetrue
  \PassOptionsToClass{\CurrentOption}{article}
  \PassOptionsToPackage{twosideshift=0pt}{geometry}
  }

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\edef\@tempa{%
    \noexpand\setkeys{eskd}{\CurrentOption}}\@tempa}

\ProcessOptions\relax

\LoadClass[a4paper]{article}


\RequirePackage[koi8-r,\eskdencoding]{inputenc}
\RequirePackage[russian]{babel}
\RequirePackage[T2A]{fontenc}
\RequirePackage{rotating}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}

\RequirePackage{pscyr}
\renewcommand{\rmdefault}{far}

\RequirePackage[left=24mm,right=11mm%
,top=10mm,nofoot,headsep=0pt]{geometry}



\newcommand{\set@eskd@bottom}[1]{%
  \setlength{\textheight}{\eskdheight mm}
  \addtolength{\textheight}{-#1}
  \addtolength{\textheight}{5 mm}
  }





\newsavebox{\eskd@vertical@frame}

\newcommand{\make@eskd@vertical@frame}{%
        \unitlength 1mm %
    \savebox{\eskd@vertical@frame}(0,0){%
      \begin{rotate}{90}
        \begin{picture}(0,0)(0,0)
          \linethickness{\eskd@thick mm}
          \put(0,0){\line(0,1){12}}
          \put(25,0){\line(0,1){12}}
          \put(60,0){\line(0,1){12}}
          \put(85,0){\line(0,1){12}}
          \put(110,0){\line(0,1){12}}
          \put(145,0){\line(0,1){12}}
          \put(0,12){\line(0,1){\eskd@half@thick}}
          \put(145,12){\line(0,1){\eskd@half@thick}}
          \put(0,7){\line(1,0){145}}
          \put(0,12){\line(1,0){145}}
          \put(12.5,9.5){\makebox(0,0){\itshape
              \textar{Инв. \textnumero\ подл.}}}
          \put(42.5,9.5){\makebox(0,0){\itshape
              \textar{Подп. и дата}}}
          \put(72.5,9.5){\makebox(0,0){\itshape
              \textar{Взам. инв. \textnumero}}}
          \put(97.5,9.5){\makebox(0,0){\itshape
              \textar{Инв. \textnumero\ дубл.}}}
          \put(127.5,9.5){\makebox(0,0){\itshape
              \textar{Подп. и дата}}}
                                %
        \end{picture}%
        \end{rotate}
      }}



\newsavebox{\eskd@border}

\newcommand{\make@eskd@border}{%
   \savebox{\eskd@border}(0,0){%
      \unitlength 1mm
      \begin{picture}(0,0)(0,\eskdheight)
         \linethickness{\eskd@thick mm}
         \put(0,0){\line(1,0){185}}
         \put(0,\eskdheight){\line(1,0){185}}
         \put(0,0){\line(0,1){\eskdheight}}
         \put(185,0){\line(0,1){\eskdheight}}
         \put(-\eskd@half@thick,0){\line(1,0){\eskd@half@thick}}
         \put(-\eskd@half@thick,\eskdheight){\line(1,0){\eskd@half@thick}}
         \put(185,0){\line(1,0){\eskd@half@thick}}
         \put(185,\eskdheight){\line(1,0){\eskd@half@thick}}
      \end{picture}
}}



\newsavebox{\eskd@common@left}

\newcommand{\make@eskd@common@left}{%
  \savebox{\eskd@common@left}(0,0){%
    \unitlength 1mm %
    \begin{picture}(0,0)(0,0)
      \linethickness{\eskd@thick mm}
      \put(7,0){\line(0,1){15}}
      \put(17,0){\line(0,1){15}}
      \put(40,0){\line(0,1){15}}
      \put(55,0){\line(0,1){15}}
      \put(0,5){\line(1,0){65}}
      \put(0,15){\line(1,0){65}}
      \linethickness{\eskd@thin mm}
      \put(0,10){\line(1,0){65}}
      \put(3.5,2.5){\makebox(0,0){\footnotesize\itshape\textar{Изм.}}}
      \put(12,2.5){\makebox(0,0){\itshape\textar{Лист}}}
      \put(28.5,2.5){\makebox(0,0){\itshape
          \textar{\textnumero\ докум.}}}
      \put(47.5,2.5){\makebox(0,0){\itshape\textar{Подп.}}}
      \put(60,2.5){\makebox(0,0){\small\itshape\textar{Дата}}}
    \end{picture}
    }}


\newsavebox{\eskd@common@hole}
\newcommand{\make@eskd@common@hole}{%
  \savebox{\eskd@common@hole}(0,0){%
    \unitlength 1mm
    \begin{picture}(0,0)(0,0)
      \linethickness{\eskd@thick mm}
      \put(0,0){\line(0,1){15}}
      \put(110,0){\line(0,1){15}}
      \put(0,15){\line(1,0){110}}
                                %
    \end{picture}
    }}



\newsavebox{\eskd@common@page}

\newcommand{\make@eskd@common@page}{%
  \savebox{\eskd@common@page}(0,0){%
    \unitlength 1mm
    \begin{picture}(0,0)(0,0)
      \linethickness{\eskd@thick mm}
      \put(0,15){\line(1,0){10}}
      \put(0,8){\line(1,0){10}}
                                %
    \end{picture}
    }}



\newcommand{\make@eskd@common@style}{%
  \newsavebox{\eskd@common@list}
  \savebox{\eskd@common@list}{\itshape
    \textar{\ifeskd@twoside Стр.\else Лист\fi}}
  \newsavebox{\eskd@common@gost}
  \savebox{\eskd@common@gost}{\scriptsize\textar{ГОСТ 2.104-68
      Форма 2\ifeskd@twoside б\else a\fi}}
  \newsavebox{\eskd@common@signature}
  \savebox{\eskd@common@signature}{{\inputencoding{\eskdencoding}\eskd@ii}}
  \fancypagestyle{common}{%
  \fancyhf{}
  \fancyhead[L]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      \put(0,0){\usebox{\eskd@border}}
      \put(0,-\eskdheight){\usebox{\eskd@vertical@frame}}
      \put(0,-\eskdheight){\usebox{\eskd@common@left}}
      \put(65,-\eskdheight){\usebox{\eskd@common@hole}}
      \put(175,-\eskdheight){\usebox{\eskd@common@page}}
      \put(0,-\eskdheight){\begin{picture}(0,0)
          \put(180,4){\makebox(0,0){\large\textbf{\textar{\thepage}}}}
          \put(120,7.5){\makebox(0,0){\usebox{\eskd@common@signature}}}
          \put(180,11.5){\makebox(0,0){\usebox{\eskd@common@list}}}
          \put(185,\ifeskd@twoside-1\else0\fi){\makebox(0,0)[rt]{%
              \usebox{\eskd@common@gost}}}
        \end{picture}}
    \end{picture}
    }
  \ifeskd@twoside
  \fancyhead[LE]{%
    \unitlength 1mm
    \begin{picture}(0,0)(3,-6)
      \put(0,0){\usebox{\eskd@border}}
      \put(120,-\eskdheight){\usebox{\eskd@common@left}}
      \put(10,-\eskdheight){\usebox{\eskd@common@hole}}
      \put(0,-\eskdheight){\usebox{\eskd@common@page}}
      \put(0,-\eskdheight){\begin{picture}(0,0)
          \put(5,4){\makebox(0,0){\large\textbf{\textar{\thepage}}}}
          \put(65,7.5){\makebox(0,0){\usebox{\eskd@common@signature}}}
          \put(5,11.5){\makebox(0,0){\usebox{\eskd@common@list}}}
          \put(185,\ifeskd@twoside-1\else0\fi){\makebox(0,0)[rt]{%
              \usebox{\eskd@common@gost}}}
        \end{picture}}
    \end{picture}
    }
  \fi
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
}




\newcommand{\make@eskd@first@style}{%
  \newsavebox{\eskd@first@text}
  \savebox{\eskd@first@text}{%
    \unitlength 1mm
    \begin{picture}(0,0)(0,0)
      \put(185,-1){\makebox(0,0)[rt]{\scriptsize
          ГОСТ 2.104-68 Форма 2}}
      \put(3.5,27.5){\makebox(0,0){\footnotesize\itshape Изм.}}
      \put(12,27.5){\makebox(0,0){\itshape Лист}}
      \put(28.5,27.5){\makebox(0,0){\itshape\textnumero\ докум.}}
      \put(47.5,27.5){\makebox(0,0){\itshape Подп.}}
      \put(60,27.5){\makebox(0,0){\small\itshape Дата}}
      \put(8.5,22.5){\makebox(0,0){\itshape Разраб.}}
      \put(8.5,17.5){\makebox(0,0){\itshape Пров.}}
      \put(8.5,7.5){\makebox(0,0){\itshape Н. контр.}}
      \put(8.5,2.5){\makebox(0,0){\itshape Утв.}}
      \put(142.5,22.5){\makebox(0,0){\itshape Лит.}}
      \put(157.5,22.5){\makebox(0,0){\itshape
          \ifeskd@twoside Стр.\else Лист\fi}}
      \put(175,22.5){\makebox(0,0){\itshape
          \ifeskd@twoside Страниц\else Листов\fi}}

    \end{picture}
    }
  \fancypagestyle{first}{%
    \fancyhf{}
    \fancyhead[L]{%
      \unitlength 1mm
      \begin{picture}(0,0)(3,-6)
        \put(0,0){\usebox{\eskd@border}}
        \put(0,-\eskdheight){\usebox{\eskd@vertical@frame}}
        \put(0,-\eskdheight){\makebox(0,0){%
            \unitlength 1mm
            \begin{picture}(0,0)(0,0)
              \put(157.5,17.5){\makebox(0,0){\ifthenelse
                  {\pageref{LastPage}=1}{}{\thepage}}}
              \put(175,17.5){\makebox(0,0){\pageref{LastPage}}}
              \put(18,22.5){\makebox(0,0)[l]{\eskd@xiI}}
              \put(18,17.5){\makebox(0,0)[l]{\eskd@xiII}}
              \put(18,12.5){\makebox(0,0)[l]{\eskd@xiIII}}
              \put(18,7.5){\makebox(0,0)[l]{\eskd@xiIV}}
              \put(18,2.5){\makebox(0,0)[l]{\eskd@xiV}}
              \put(67,12.5){\makebox(0,0)[l]{%
                  \parbox{66mm}{\large\raggedright\eskd@i}}}
              \put(125,32.5){\makebox(0,0){\LARGE\eskd@ii}}
              \put(160,7.5){\makebox(0,0){\eskd@ix}}
              \put(8.5,12.5){\makebox(0,0){\itshape\eskd@x}}
              \linethickness{\eskd@thick mm}
              \put(7,25){\line(0,1){15}}
              \put(17,0){\line(0,1){40}}
              \put(40,0){\line(0,1){40}}
              \put(55,0){\line(0,1){40}}
              \put(65,0){\line(0,1){40}}
              \put(135,0){\line(0,1){25}}
              \put(140,15){\line(0,1){5}}
              \put(145,15){\line(0,1){5}}
              \put(150,15){\line(0,1){10}}
              \put(165,15){\line(0,1){10}}
              \put(0,40){\line(1,0){185}}
              \put(0,30){\line(1,0){65}}
              \put(0,25){\line(1,0){185}}
              \put(135,20){\line(1,0){50}}
              \put(135,15){\line(1,0){50}}
              \linethickness{\eskd@thin mm}
              \put(0,35){\line(1,0){65}}
              \multiput(0,5)(0,5){4}{\line(1,0){65}}
              \put(0,0){\usebox{\eskd@first@text}}
                                %
            \end{picture}
            }}
      \end{picture}
      }
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}}
  }

\newcommand{\make@eskd@title@style}{%
  \newsavebox{\eskd@title@text}
  \savebox{\eskd@title@text}{\scriptsize\textar{Ф. 1288}}
  \newsavebox{\eskd@agr}
  \savebox{\eskd@agr}{\usefont{T2A}{far}{b}{n}\Large Согласовано}
  \newsavebox{\eskd@appr}
  \savebox{\eskd@appr}{\usefont{T2A}{far}{b}{n}\Large Утверждаю}
  \fancypagestyle{title}{%
    \fancyhf{}
    \fancyhead[L]{%
      \unitlength 1mm
      \begin{picture}(0,0)(3,-6)
        \put(0,0){\usebox{\eskd@border}}
        \put(0,-\eskdheight){\usebox{\eskd@vertical@frame}}
        \put(185,-\eskdheight){%
          \begin{picture}(0,0)
            \put(0,-1){\makebox(0,0)[rt]{\usebox{\eskd@title@text}}}
          \end{picture}}
      \end{picture}
      }
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}}
  }


\newcommand{\eskd@i}{}
\newcommand{\docName}[1]{\renewcommand{\eskd@i}{#1}}
\newcommand{\fI}{\docName}

\newcommand{\eskd@ii}{}
\newcommand{\docSignature}[1]{\renewcommand{\eskd@ii}{#1}}
\newcommand{\fII}[1]{\renewcommand{\eskd@ii}{#1}}

\newcommand{\eskd@ix}{}
\newcommand{\fIX}[1]{\renewcommand{\eskd@ix}{#1}}
\newcommand{\docLabel}[1]{\renewcommand{\eskd@ix}{#1}}

\newcommand{\eskd@x}{}
\newcommand{\middleLabel}[1]{\renewcommand{\eskd@x}{#1}}
\newcommand{\fX}[1]{\renewcommand{\eskd@x}{#1}}

\newcommand{\eskd@xiI}{}
\newcommand{\docAuthor}[1]{\renewcommand{\eskd@xiI}{#1}}
\newcommand{\fXIi}[1]{\renewcommand{\eskd@xiI}{#1}}

\newcommand{\eskd@xiII}{}
\newcommand{\docChecker}[1]{\renewcommand{\eskd@xiII}{#1}}
\newcommand{\fXIii}[1]{\renewcommand{\eskd@xiII}{#1}}

\newcommand{\eskd@xiIII}{}
\newcommand{\middleName}[1]{\renewcommand{\eskd@xiIII}{#1}}
\newcommand{\fXIiii}[1]{\renewcommand{\eskd@xiIII}{#1}}

\newcommand{\eskd@xiIV}{}
\newcommand{\normController}[1]{\renewcommand{\eskd@xiIV}{#1}}
\newcommand{\fXIiv}[1]{\renewcommand{\eskd@xiIV}{#1}}

\newcommand{\eskd@xiV}{}
\newcommand{\approvedBy}[1]{\renewcommand{\eskd@xiV}{#1}}
\newcommand{\fXIv}[1]{\renewcommand{\eskd@xiV}{#1}}


\newcommand{\eskd@title@i}{}
\newcommand{\titleTop}[1]{\renewcommand{\eskd@title@i}{#1}}
\newcommand{\tfI}[1]{\renewcommand{\eskd@title@i}{#1}}

\newif\ifeskd@title@appr \eskd@title@apprfalse
\newif\ifeskd@title@agr  \eskd@title@agrfalse

\newcommand{\eskd@des@list}{}

\newcommand{\eskd@title@iii@right@position}{}
\newcommand{\eskd@title@iii@right@name}{}
\newcommand{\titleApprovedBy}[2]{%
  \renewcommand{\eskd@title@iii@right@position}{#1}
  \renewcommand{\eskd@title@iii@right@name}{#2}
  \eskd@title@apprtrue
  }

\newcommand{\eskd@title@iii@left@position}{}
\newcommand{\eskd@title@iii@left@name}{}
\xdef\eskd@agr@list{}
\newcommand{\titleAgreedBy}[2]{%
  \ifeskd@title@agr
  \xdef\eskd@agr@list{\eskd@agr@list#1\par\vrule
    depth 0.8pt height -0.4pt width31mm~#2\par
    ''\vrule depth 0.8pt height -0.4pt width8mm''\vrule
    depth 0.8pt height -0.4pt width20mm\ \eskdyear\ \cyrg\par\vskip 3mm}
  \else
  \renewcommand{\eskd@title@iii@left@position}{#1}
  \renewcommand{\eskd@title@iii@left@name}{#2}
  \eskd@title@agrtrue
  \fi
  }

\xdef\eskd@author@list{}
\newcommand{\titleDesignedBy}[2]{%
  \xdef\eskd@author@list{\eskd@author@list#1\par\vrule
    depth 0.8pt height -0.4pt width31mm~#2\par
    ''\vrule depth 0.8pt height -0.4pt width8mm''\vrule
    depth 0.8pt height -0.4pt width20mm\ \eskdyear\ \cyrg\par\vskip 3mm}
  }

\newcommand{\tfIII}{\hyphenpenalty=10000 %
  \begin{tabular}{@{\hspace{5mm}}p{80mm}@{\hspace{10mm}}p{80mm}}%
    \ifeskd@title@agr  \hspace{15mm}\usebox{\eskd@agr}\fi &%
    \ifeskd@title@appr \hspace{15mm}\usebox{\eskd@appr}\fi \\[3mm]
    \ifeskd@title@agr{\raggedright \eskd@title@iii@left@position}\fi &%
    \ifeskd@title@appr{\raggedright
      \eskd@title@iii@right@position}\fi\\[3mm]
    \ifeskd@title@agr \rule[-1mm]{31mm}{0.4pt}~%
    \eskd@title@iii@left@name \fi &%
    \ifeskd@title@appr \rule[-1mm]{31mm}{0.4pt}~%
    \eskd@title@iii@right@name \fi\\[3mm]
    \ifeskd@title@agr ''\rule[-1mm]{8mm}{0.4pt}''\rule[-1mm]{20mm}{0.4pt}
    \eskdyear\ \cyrg\fi &%
    \ifeskd@title@appr ''\rule[-1mm]{8mm}{0.4pt}''\rule[-1mm]{20mm}{0.4pt}
    \eskdyear\ \cyrg\fi
  \end{tabular}
  }

\newcommand{\eskd@title@iv}{\eskd@i}
\newcommand{\titleName}[1]{\renewcommand{\eskd@title@iv}{#1}}
\newcommand{\tfIV}[1]{\renewcommand{\eskd@title@iv}{#1}}

\newcommand{\eskd@title@vi}{\eskd@ii}
\newcommand{\titleSignature}[1]{\renewcommand{\eskd@title@vi}{#1}}
\newcommand{\tfVI}[1]{\renewcommand{\eskd@title@vi}{#1}}



\newcommand{\eskd@title@bottom}{\eskdyear}
\newcommand{\titleBottom}[1]{\renewcommand{\eskd@title@bottom}{#1}}

\renewcommand{\maketitle}{}
\newcommand{\eskd@maketitle}{%
\thispagestyle{title}
\set@eskd@bottom{55mm}
\usefont{T2A}{far}{m}{n}
\large
\vspace*{1mm}
\begin{center}
\bfseries\Large
\eskd@title@i
\end{center}
\vfill
\centerline{\raisebox{0mm}[0mm][0mm]{\tfIII}}
\vfill
\begin{center}
{\bfseries\Large
\MakeUppercase{\eskd@title@iv}}\mbox{}\\[3mm]
{\large\MakeUppercase{\eskd@title@vi}}
\end{center}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\vfill
\unitlength\textwidth\begin{picture}(0,0)
\put(0,0){\makebox(0,0)[l]{\hyphenpenalty=10000 %
\begin{tabular}{@{\hspace{5mm}}p{80mm}@{\hspace{10mm}}p{80mm}}
\raggedright\eskd@agr@list &{\raggedright\eskd@author@list}\\
\end{tabular}
}}
\end{picture}
\vfill\vfill
\begin{center}
  \eskd@title@bottom
\end{center}
\newpage

\ifeskd@twoside
\thispagestyle{empty}
\cleardoublepage
\fi

\thispagestyle{first}
\set@eskd@bottom{30mm}

}

\set@eskd@bottom{\ifeskd@title15mm\else55mm\fi}




\AtBeginDocument{%

  \inputencoding{koi8-r}

\newcommand{\eskdListOfChanges}{\newpage
{\small\noindent
\begin{tabular}{|c|*{7}{p{1.5cm}|}c|c|}
  \multicolumn{10}{c}{\Large\bf Лист регистрации изменений}\\\hline
& \multicolumn{4}{c|}{Номера листов
(страниц)}&&&&&\\\cline{2-5}
Изм.&из\-ме\-нен\-ных&за\-ме\-нен\-ных&но\-вых&%
ан\-ну\-ли\-ро\-ван\-ных&
Всего листов (страниц)
в докум.&\No\ докум.&Вхо\-дя\-щий \No\
сопроводительного докум. и дата&Подпись&Дата\\\hline
\vbox{\vspace{\eskdheight mm}\vspace{-6cm}}&&&&&&&&&\\\hline
\end{tabular}
}
}


  \make@eskd@border
  \make@eskd@vertical@frame

  \make@eskd@common@left
  \make@eskd@common@hole
  \make@eskd@common@page

  \make@eskd@first@style
  \make@eskd@title@style
  \make@eskd@common@style

  \pagestyle{common}
  \inputencoding{\eskdencoding}
  \ifeskd@title\eskd@maketitle
  \else\thispagestyle{first}\set@eskd@bottom{30mm}\fi

  \renewcommand{\make@eskd@border}{}
  \renewcommand{\make@eskd@vertical@frame}{}
  \renewcommand{\make@eskd@common@left}{}
  \renewcommand{\make@eskd@common@hole}{}
  \renewcommand{\make@eskd@common@page}{}
  \renewcommand{\make@eskd@first@style}{}
  \renewcommand{\make@eskd@title@style}{}
  \renewcommand{\make@eskd@common@style}{}
  \renewcommand{\eskd@maketitle}{}
  \relax
}
