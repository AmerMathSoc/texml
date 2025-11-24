%%%%%%%%% gradstudentresume %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Written By: Anagha Kumar %%%%%%%%%%%%
%%%%%% License: The LATEX Project Public License (lppl1.3) %%%%%%
%%%%%% Version: 2015/11/12 %%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradstudentresume}
\LoadClassWithOptions{article}
\RequirePackage{anysize}
\RequirePackage{hyperref}
% it goes left, right, top, bottom
\marginsize{0.75in}{0.75in}{0in}{1in}

\pagestyle{plain} 

%% I know latex has smallskip, medskip etc. but I think it is important to have fine control over your output and define your own skips
\newcommand{\smallspace}{
\vspace{1mm}
}


\newcommand{\medspace}{
\vspace{3mm}
}


\newcommand{\largespace}{
\vspace{5mm}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{info}[4]
{\begin{center}
\Large{\sc{#1}} \\ \normalsize \textit{Address}: {#2} \\ \textit{Telephone}: {#3} \\ \textit{Email}: {#4} 
\end{center}}
{\largespace
}
% The parameters are name, address, telephone number, and email. 

\newenvironment{wrapped}
{ \begin{itemize}
    \setlength{\itemsep}{0pt}}
{ \end{itemize}} 

\newcommand{\sectionrule}{\noindent\hfil\rule{\textwidth}{.6pt}\hfil 
\vspace{2mm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\undergrad}[5]{\noindent \textbf{#1}\hfill {#2} \\ \textit{#3}\hfill {#4} \\ {\def\honors{#5}\ifx\honors\empty\else Graduation Honors: {#5}}\fi}
\newcommand{\grad}[6]{\noindent{\textbf{{#1}}} \hfill{#2}\\ \textit{#3} \hfill{#4} \\ Thesis: {#5} \\ Advisor: {#6}}
 
\newcommand{\sectionheading}[1]{\noindent{\large{\sc{#1}}} \\ \sectionrule}
\newcommand{\subsectionheading}[1]{\noindent {\sc{#1}} 
\smallspace

}

\newcommand{\reference}[7]{\textbf{#1} \\ {#2} \hfill{Telephone: {#3}} \\ {#4} \hfill{Email: {#5}} \\ {#6} \\ {#7}}
% The parameters are name, title, telephone number, department, email, school, and address line 2. 

\newcommand{\paper}[7] {{#1} ({#2}). {#3}. \textit{#4, #5} ({#6}), {#7}.}
% 1 is authors, 2 is year, 3 is title, 4 is journal, 5 is volume, 6 is number, 7 is pages. This is useful since you don't need to type in \textit{} etc. repeatedly when typing up your resume. Grad students with many publications will especially appreciate this feature. 

\newcommand{\myname}{\textbf{Kumar, A.}}
% so that you don't have to keep typing in \textbf{your name} for every paper you cite. 

\newcommand{\presentation}[4]{{#1} \hfill{#2} \\ \textit{#3} \hfill{#4}}
% 1 is the section of the conference, 2 is the date, 3 is the conference name or school name 4 is the location 


\newenvironment{pres}[1]
{
\textbf{#1} % name of the presentation
\begin{wrapped}}
{% use the presentation command as the argument 
\end{wrapped}
\smallspace
}


\newenvironment{desc}[3]
{
\noindent\textbf{#1} \hfill{#2}\\ \textit{#3}
\begin{wrapped}}
{ 
\end{wrapped}
\medspace
}



