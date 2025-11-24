
%% identyfikacja
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upmgr}[2010/18/05 v1.13, Praca magisterska UP]

%% deklarowanie opcji
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\PassOptionsToClass{a4paper,twoside,openany}{report}

\DeclareOption{licencjacka}{\def\@rodzajpracy{licencjacka}}
\DeclareOption{magisterska}{\def\@rodzajpracy{magisterska}}

%% wykonanie opcji
\ExecuteOptions{magisterska}
\ProcessOptions
\LoadClass{report} %% tylko w przypadku pliku klas

%% zaladowanie pakietow
%%\RequirePackage{graphicx}
\RequirePackage[font=small,justification=raggedright]{caption}
\RequirePackage{polski}

%% kod glowny
\textwidth\paperwidth \advance\textwidth -55mm
\oddsidemargin-1in \advance\oddsidemargin 30mm
\evensidemargin-1in \advance\evensidemargin 25mm
\topmargin -1in \advance\topmargin 25mm
\setlength\textheight{48\baselineskip}
%% ... itd ... %%



%%
%%
