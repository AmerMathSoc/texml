\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rtklage}[2006/01/30 v0.1 Friedrich Vosberg]
\LoadClassWithOptions{scrartcl}
\RequirePackage[ngerman]{babel}
\RequirePackage{twoopt}
\RequirePackage{ifthen}
\RequirePackage{scrdate}
\RequirePackage{calc}
\RequirePackage[np]{numprint}
\RequirePackage[plainheadsepline]{scrpage2}
\RequirePackage{alphanum}
\RequirePackage{eso-pic}
\RequirePackage{color}
\RequirePackage{graphicx}
\RequirePackage{xspace}
\setlength{\parindent}{3em}
\setlength{\parskip}{1.5ex}
\newcommand{\rtbgtext}[1]{\textsf{\textbf{\textcolor[gray]{0.8}{#1}}}}
%
\DeclareOption{A}{%
	\AddToShipoutPicture{%
		\AtTextCenter{%
		\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
		\rotatebox{50}{\rtbgtext{Abschrift}}%
	}}}}
}
\DeclareOption{B}{%
\AddToShipoutPicture{%
	\AtTextCenter{%
	\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
	\rotatebox{50}{\rtbgtext{beglaubigte Abschrift}}%
	}}}}%
}
\DeclareOption{E}{%
\AddToShipoutPicture{%
	\AtTextCenter{%
	\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
	\rotatebox{50}{\rtbgtext{Entwurf}}%
	}}}}%
}
\ProcessOptions\relax
%
\newcounter{partcntr}
\newcommandtwoopt{\parteibez}[5][][]{%
	\ifthenelse{\value{partcntr}=0}{In dem Rechtsstreit}{%
		\ifthenelse{\value{partcntr}=1}{gegen}{und gegen}
	}%
		\par\vspace{1.5ex}\noindent\parbox{\textwidth}{%
			\textbf{#3}
			\\#4
			\ifthenelse{\equal{#2}{}}{\\#2}{%
				\\\emph{ges.\,vertr.\,d.\,d.\,#2}
			}
			\ifthenelse{\equal{#1}{}}{\\#1}{%
				\begin{center}%
					\parbox{\textwidth-12em}{%
						anwaltlich vertreten durch\\
						#1
					}%
				\end{center}
			}%
		\vspace{1.5ex}\rightline{\textbf{-- #5 --}}%
	}\par
\stepcounter{partcntr}%
}
%
\newcommand{\stggsger}[2]{%
	wegen\par\vspace{1.5ex}\noindent{\textbf{#1}}\par\vspace{1.5ex}\setlength{\parindent}{0em}erhebe ich heute am \todaysname, den \today{} Klage zum #2 und beantrage:
}
\newenvironment{antraege}{\begin{enumerate}\bfseries}{\end{enumerate}\par\begin{center}\Huge{\textbf{Begr\"undung}}\end{center}}
%
\newcounter{bewcntr}
\newcommand*{\beweis}[2][]{%
	\vspace{.5ex}\par\hspace*{3em}\textbf{Beweis:~}%
	\parbox[t]{\textwidth-\widthof{\textbf{Beweis:~}}-9em}{#2}
	\ifthenelse{\equal{#1}{x}}{%	
		\stepcounter{bewcntr}\hfill\parbox{\widthof{\textbf{-- K\,\arabic{bewcntr} --}}}{\textbf{-- K\,\arabic{bewcntr} --}}%
	}{%
	}
\ignorespaces
\vspace{1.5ex}\par
}
\title{}
\author{}
\date{}
\endinput