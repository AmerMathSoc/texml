% legislation.cls
% Copyright 2016 Lin DasSarma <lindas@umbc.edu>
% 
% This file is part of umbclegislation.
% 
% umbclegislation is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{legislation}[2016/6/8 UMBC SGA Legislation Template]

\LoadClass{article}

\RequirePackage{etoolbox}
\RequirePackage{mdframed}
\RequirePackage{enumitem}
\RequirePackage[pagewise]{lineno}
\RequirePackage{xifthen}

% Fix for top and bottom boxes
\mdfsetup{
	leftmargin=-10pt,
	rightmargin=-10pt
}

\linespread{1.3}

\setlength{\tabcolsep}{0em} % Fix for signature lines

\DeclareOption{smallmargin}{
    \PassOptionsToPackage{margin=1in}{geometry}
}

\DeclareOption{nomargin}{
    \newcommand{\@nomargin}{}
}

\DeclareOption{nogeometry}{
    \newcommand{\@nogeometrypackage}{}
}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{geometry}}

\newcommand{\@legislationType}{senate}

\DeclareOption{senate}{
	\renewcommand{\@legislationType}{senate}
}
\DeclareOption{financeBoard}{
	\renewcommand{\@legislationType}{finance}
}
\DeclareOption{joint}{
	\renewcommand{\@legislationType}{joint}
}
\DeclareOption{draft}{
	\newcommand{\@draftwatermark}{}
}

\newcommand{\@authorname}{}
\newcommand{\@legislationNumber}{}
\newcommand{\@legislativeSession}{}
\newcommand{\@sponsor}{}
\newcommand{\@introduced}{}
\renewcommand{\author}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\legislationNumber}[1]{\renewcommand{\@legislationNumber}{#1}}
\newcommand{\legislativeSession}[1]{\renewcommand{\@legislativeSession}{#1}}
\newcommand{\sponsor}[1]{\renewcommand{\@sponsor}{#1}}
\newcommand{\introduced}[1]{\renewcommand{\@introduced}{#1}}
\newcommand{\@senatorsFor}{}
\newcommand{\@senatorsOpposing}{}
\newcommand{\@senatorsAbstaining}{}
\newcommand{\@senatorsNotPresent}{}
\newcommand{\@senatorsActed}{}
\newcommand{\senatorsActed}[5]{
	\renewcommand{\@senatorsFor}{#1}
	\renewcommand{\@senatorsOpposing}{#2}
	\renewcommand{\@senatorsAbstaining}{#3}
	\renewcommand{\@senatorsNotPresent}{#4}
	\renewcommand{\@senatorsActed}{#5}
}
\newcommand{\@representativesFor}{}
\newcommand{\@representativesOpposing}{}
\newcommand{\@representativesAbstaining}{}
\newcommand{\@representativesNotPresent}{}
\newcommand{\@representativesActed}{}
\newcommand{\representativesActed}[5]{
	\renewcommand{\@representativesFor}{#1}
	\renewcommand{\@representativesOpposing}{#2}
	\renewcommand{\@representativesAbstaining}{#3}
	\renewcommand{\@representativesNotPresent}{#4}
	\renewcommand{\@representativesActed}{#5}
}

\newcounter{whereasCounter}{}
\newcounter{resolvedCounter}{}

\ProcessOptions\relax

\pdfinfo{
  /Title (UMBC SGA Legislation)
  /Creator (Lin DasSarma <lin@umbc.in>)
  /Author (Generated at umbc.in)
  /Subject (UMBC SGA Draft Legislation)
  /Keywords (umbc,sga,legislation)
}

\ifthenelse{\isundefined{\@draftwatermark}}{}{
	\RequirePackage{draftwatermark}
	\SetWatermarkScale{5}
}

\ifthenelse{\isundefined{\@nogeometry}}{
    \ifthenelse{\isundefined{\@nomargin}}{
        \RequirePackage[top=0.5in,bottom=1in]{geometry}
    }{
        \RequirePackage{geometry}
    }
}{}

\newcommand{\legislationHeader}{
	\begin{mdframed}
	\centering{\large{
		\ifthenelse{\equal{\@legislationType}{joint}}{
			UMBC SGA Joint Legislation
		}{
			\ifthenelse{\equal{\@legislationType}{senate}}{
				UMBC SGA Senate Legislation
			}{
				UMBC SGA Finance Board Legislation
			}}
	}}
	\par
		\ifthenelse{\equal{\@legislationType}{joint}}{
			JL\@legislationNumber-\@legislativeSession
		}{
			\ifthenelse{\equal{\@legislationType}{senate}}{
				SL\@legislationNumber-\@legislativeSession
			}{
				FBL\@legislationNumber-\@legislativeSession
			}}
	\begin{description}[style=sameline, noitemsep]
		\item [Author] \@authorname
		\item [Sponsor] \@sponsor
		\item [Introduced] \@introduced
		\end{description}
	\end{mdframed}
	\centering{\section*{\@title}}
}
\newcommand{\legislation}{
	\legislationHeader
		\raggedright\begin{linenumbers}
	\begin{description}[style=sameline,leftmargin=\parindent]
	\ifnum\value{whereasCounter}=1\relax\renewcommand*{\do}[1]{\item [Whereas,] ##1}\else
	\renewcommand*{\do}[1]{
		\ifnum\value{whereasCounter}=1\relax\item [And whereas,] ##1\else\addtocounter{whereasCounter}{-1}\item [Whereas,] ##1\fi
	}\fi
	\dolistloop{\whereasList}
	\ifnum\value{resolvedCounter}=1\relax\renewcommand*{\do}[1]{\item [Be it resolved,] ##1}\else
	\renewcommand*{\do}[1]{
		\ifnum\value{resolvedCounter}=1\relax\item [Finally, be it resolved,] ##1\else\addtocounter{resolvedCounter}{-1}\item [Be it resolved,] ##1\fi
	}\fi
	\dolistloop{\resolvedList}
	\end{description}
	\end{linenumbers}
	\legislationFooter
}
\newcommand{\whereas}[1]{
	\stepcounter{whereasCounter}\listadd{\whereasList}{#1}
}
\newcommand{\resolved}[1]{
	\stepcounter{resolvedCounter}\listadd{\resolvedList}{#1}
}
\newcommand{\legislationFooter}{
	\begin{mdframed}
	\begin{description}[style=sameline, noitemsep]
		\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{joint}}{
			\item [Senators For] \@senatorsFor
			\item [Senators Opposing] \@senatorsOpposing
			\item [Senators Abstaining] \@senatorsAbstaining
			\item [Senators Not Present] \@senatorsNotPresent
			\item [Date of \ifthenelse{\equal{\@senatorsFor}{}}{Passage / Failure}{\ifthenelse{\@senatorsFor > \@senatorsOpposing}{Passage}{Failure}}] \@senatorsActed
		}{}
		\ifthenelse{\equal{\@legislationType}{joint}}{
			\end{description}
			\hrulefill
				\begin{description}[style=sameline, noitemsep]
		}{}
		\ifthenelse{\equal{\@legislationType}{finance} \OR \equal{\@legislationType}{joint}}{
			\item [Representatives For] \@representativesFor
			\item [Representatives Opposing] \@representativesOpposing
			\item [Representatives Abstaining] \@representativesAbstaining
			\item [Representatives Not Present] \@representativesNotPresent
			\item [Date of \ifthenelse{\equal{\@representativesFor}{}}{Passage / Failure}{\ifthenelse{\@representativesFor > \@representativesOpposing}{Passage}{Failure}}] \@representativesActed
		}{}
	\end{description}
	\end{mdframed}
~\\
The above piece of legislation has been presented to the Student Goverment Association of the University of Maryland, Baltimore County and has received the votes indicated above.
~\\
	\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{joint}}{
	\SignatureAndDate{Speaker of the SGA Senate}
	}{}
	\ifthenelse{\equal{\@legislationType}{finance} \OR \equal{\@legislationType}{joint}}{
	\SignatureAndDate{Chair of the SGA Finance Board}
	}{}
	\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{finance} \AND \isundefined{\@supressPresidentialApproval}}{
	~\\
	I hereby\ifthenelse{\isundefined{\@presidentialApproval}}{ approve/veto}{ \@presidentialApproval} the above piece of legislation.
	\SignatureAndDate{President of the SGA}
	}{}
}

\newcommand*{\SignatureAndDate}[1]{%
	\noindent\begin{tabular}{lll}
\\\\
	\makebox[0.65\textwidth]{\hrulefill} & \makebox[0.05\textwidth]{} & \makebox[0.3\textwidth]{\hrulefill}\\
#1 && Date
	\end{tabular}
}%
\endinput
