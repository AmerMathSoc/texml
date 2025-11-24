% last change   : 22-Jun-03 12:31:15
% status        : 0.19 beta
% created       : 2000
%
% subject       : german law decisions
%
% to do         : 
%
% © Axel Sodtalbers

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{juraurtl}[2003/06/20 V0.19 juraurtl (AS)]

\RequirePackage{jurabase}
\RequirePackage{fancyhdr}
% fancyhdr muss aktuell sein, da es aber keine Versionsinformation
% besitzt, versuchen wir es so:
\@ifundefined{fancyhead}%
  {\ClassError{juraurtl}%
     {Es wird eine veraltete Version von fancyhdr benutzt!}%
     {Aktuelle Fassung von fancyhdr aus dem CTAN laden.}%
  }%   
  {\relax}


\newif\if@strafurteil
\@strafurteilfalse

\newif\if@modern
\@modernfalse

\newif\if@draft
\@draftfalse

\DeclareOption{strafurteil}{\@strafurteiltrue}
\DeclareOption{modern}{\@moderntrue}
\DeclareOption{draft}{\@drafttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}} % Begleiter 489  
\ProcessOptions\relax

\LoadClass{scrartcl}

\AtBeginDocument{%
  \addtokomafont{section}{\bferies}
  \renewcommand*{\headrulewidth}{\z@}
  \pagestyle{fancy}
  \fancyhead{}
  \fancyfoot{}
  \if@modern
    \cfoot{\thepage}
  \else
    \cfoot{--~\thepage~--}
  \fi%
}  

\setlength{\parskip}{2.0ex}
\normalsize

\if@strafurteil
\else
  \addtolength{\textwidth}{-2em}
\fi  

\setlength{\parindent}{\z@}

\newcommand*{\@gericht}{Amtsgericht Stenkelfeld}
\newcommand*{\gericht}[1]%
  {\renewcommand*{\@gericht}{#1}}

\newcommand*{\@urteilsart}{Urteil}
\newcommand*{\urteilsart}[1]%
  {\renewcommand*{\@urteilsart}{#1}}
  
\newcommand*{\@richter}{???}
\newcommand*{\richter}[1]%
  {\renewcommand*{\@richter}{#1}}
  
\newcommand*{\@az}{???}
\newcommand*{\az}[1]%
  {\renewcommand*{\@az}{#1}}

\newcommand*{\@lmv}{??.??.??}
\newcommand*{\lmv}[1]%
  {\renewcommand*{\@lmv}{#1}}
  
\newcommand*{\@angeklagt}{???}
\newcommand*{\angeklagt}[1]%
  {\renewcommand*{\@angeklagt}{#1}}
  
\newcommand*{\@straftatbestand}{???}
\newcommand*{\straftatbestand}[1]%
  {\renewcommand*{\@straftatbestand}{#1}}
  
\newcommand{\rjust}[1]{\hspace*{\fill}#1}

\newcommand{\gegen}{%
  \begin{center}gegen\end{center}}

\if@strafurteil
  \newenvironment{rubrum}%
    {%
    \thispagestyle{empty}%
    \setlength{\parindent}{\z@}%
    \@gericht\newline%
    \@az\bigskip%
    \begin{center}
    {\scshape\bfseries\large Im Namen des Volkes
    
    \@urteilsart}
    \end{center}
    \begin{labeling}{In der Strafsache gegen\quad}
    \item[In der Strafsache gegen] \@angeklagt
    \end{labeling}
    wegen \@straftatbestand\par
    }
    {\ \par 
    \textbf{f\"ur Recht erkannt:}
    }
\else % zivilurteil
  \newenvironment{rubrum}%
    {\thispagestyle{empty}%
    \setlength{\parindent}{\z@}%
    \@gericht\newline%
    --~\@az\space --\bigskip%
    \begin{center}
    {\scshape\large Im Namen des Volkes\par}
    
    \@urteilsart\par
    
    In dem Rechtsstreit
    \end{center}%
    }
    {\ \newline 
    
    hat das \@gericht\newline%
    auf die m\"undliche Verhandlung vom \@lmv\newline%
    durch \@richter\newline%
    f\"ur Recht erkannt:
    }
\fi

\newenvironment{tenor}          % zivilrecht
  {\list{}{}\item\relax}
  {\endlist
  
  \space\ \bigskip}

\newenvironment{urteilsformel}  % strafrecht
  {}
  {\space\ \bigskip}


\newcommand{\@lawmagic}[1]{%
  \if@modern
    \textbf{#1}
  \else % 'old style'
    \underline{#1}
  \fi
}    
        
\newenvironment{tatbestand}
  {\pagebreak[3]
  \begin{center}
  \@lawmagic{Tatbestand}
  \end{center}
  }
  {}
     
\newcommand*{\gruendename}{}
\if@strafurteil
  \renewcommand*{\gruendename}{\@lawmagic{Gr\"unde:}}
\else
  \renewcommand*{\gruendename}{\@lawmagic{Entscheidungsgr\"unde}}
\fi
  
\newenvironment{gruende}
  {\pagebreak[3]
  \begin{center}
  \gruendename
  \end{center}}
  {}  

\newcommand*{\gutachtenname}{Gutachten}  % fuer Votum
\newenvironment{gutachten}
  {\pagebreak[3]
  \begin{center}
  \@lawmagic{\gutachtenname}
  \end{center}}
  {} 
                 
\newcommand{\bl}[1]{% Blatt
  \marginpar{\small\itshape\hfill #1}{}%
  } 

% Umgebung Antrag gestrichen! -> neuer Befehl \antrag in jurabase.sty!

\newenvironment{eingerueckt} % nur auf der linken Seite eingerueckt
  {\list{}{}\item\relax}
  {\endlist}  

\newenvironment{wortlaut} % wenn es auf den Wortlaut ankommt (Zitate)
  {\begin{small}
   \begin{quote}
  }
  {\end{quote}
   \end{small}
  }
  
\newenvironment{antraege}%
  {\begin{quote}%
   \begin{enumerate}}
  {\end{enumerate}%
   \end{quote}}

\newcounter{nsec}    
\newcommand{\nextsec}
  {%
  \stepcounter{nsec}%
  \begin{center}%
  \if@strafurteil
    \textbf{\Roman{nsec}.}%
  \else
    \Roman{nsec}.%
  \fi  
  \end{center}%
  }

% Spezialbefehle fuer das Strafurteil:
\newcommand{\drafthintssize}{\scriptsize}

\newcommand{\@marginlabel}[1]%  stolen from Begleiter p. 75
  {\marginpar{\drafthintssize\raggedleft\hspace{0pt}#1}}

\newcommand{\lebenslauf}{%
  \nextsec
  \if@draft \@marginlabel{Lebenslauf} \fi}
  
\newcommand{\sachverhalt}{%
  \nextsec
  \if@draft \@marginlabel{Sachverhalt} \fi}  

\newcommand{\beweiswuerdigung}{%
  \nextsec
  \if@draft \@marginlabel{Beweisw\"urdigung} \fi}

\newcommand{\rechtlichewuerdigung}{%
  \nextsec
  \if@draft \@marginlabel{Rechtliche W\"urdigung} \fi}

\newcommand{\strafzumessung}{%
  \nextsec
  \if@draft \@marginlabel{Strafzumessung} \fi}

\newcommand{\kosten}{%
  \nextsec
  \if@draft \@marginlabel{Kostenentscheidung} \fi}

% Abkuerzungen u.ae.
\newcommand{\textpercent}{\%}
\newcommand{\AG}[1]{\emph{A/G}~Rn.\,#1}


\endinput
% end of juraurtl.cls
