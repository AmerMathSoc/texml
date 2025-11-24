%%%%%%%%%% frletter.cls %%%%%%%%%%
% The original beletter class is in the public domain. So is frletter.
%
% This code is unsupported, and comes with no warranty.
% The original beletter class was written by James Kilfiger and Frank Lenaerts, 
% to meet the specifications for formatting Belgium letters recommended by
% Frank's wife.
% It can be used in place of the standard LaTeX class
%
% The frletter class was contributed by Liviu Andronic. It tries to hack further
% the letter class and make it conform to the French typesetting conventions. 
% The frletter class consists of cosmetical modifications applied to the 
% beletter class, according to what I understand as French conventions for 
% writing letters. Please consider that I am neither a French native, nor a 
% LaTeX expert. 
%
% You will also find layout files for both beletter and frletter classes on the Lyx 
% Wiki. Both are ugly hacks inputting the letter layout, but they work and I'm OK 
% with it. There you will also find corresponding Lyx templates. 
%
% If you are on the look for a class trully specialized on typesetting French
% letters, check the lettre class developed by Denis Mégevand from the 
% Observatoire de Genève. There is no corresponding Lyx layout (not to the best 
% of my knowledge).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{frletter}[22/10/2007 French Letter Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions\relax
\LoadClass{letter}
% changed the opening
\renewcommand*{\opening}[1]{%
  \thispagestyle{firstpage}%
  \ifx\@empty\fromaddress
  \else  %if there is a from address
    \noindent\begin{tabular}[t]{@{}l@{}}%
      \fromaddress
    \end{tabular}\par%
  \fi 
%% My trial and error on the "send to address"; seems to work
    {\raggedleft\begin{tabular}{l@{}}\ignorespaces
      \toname\\ \toaddress \\*[2\parskip]%
      \@date \end{tabular}\par}%
  \vspace{2\parskip}%
  #1\par\nobreak
  \vspace{2\parskip}%
}

%%% Change these!!, or let babel change them for you.
%%% Consider using \usepackage[francais]{babel} in the LaTeX Preamble
\renewcommand*{\ccname}{cc}
\renewcommand*{\enclname}{}
\renewcommand*{\pagename}{}
\renewcommand*{\headtoname}{}

% reverted to the original letter closing; 
% uncomment the following lines to use the beletter closing style
%\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
%  \stopbreaks
%  \vspace{2\parskip}%
%  \vspace{2\parskip}%
%  \noindent
%  \ifx\@empty\fromaddress\else
%  \hspace*{\longindentation}\fi
%  \parbox{\indentedwidth}{\raggedright
%       \ignorespaces #1\\[6\medskipamount]%
%       \ifx\@empty\fromsig
%           \fromname
%       \else \fromsig \fi\strut}%
%   \par}

\renewcommand*{\cc}[1]{%
  \par\noindent
  \parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\ccname}%
    \ignorespaces #1\strut}\par}
\endinput
