package TeX::Interpreter::LaTeX::Package::enumitem;

## Need to implement optional arguments to itemize, enumerate,
## description.  Most can be ignored, except for label and ref(?).

use strict;
use warnings;

use TeX::Utils::Misc;

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("enumitem", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::enumitem::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{enumitem}

\def\enit@enumerate@i#1#2#3#4{%
    \if@newitem\leavevmode\fi
  \ifnum#1>#3\relax
    \enit@toodeep
  \else
    \enit@prelist\z@{#1}{#2}%
    \edef\@enumctr{#2\romannumeral#1}%
    \expandafter
    \enit@list
      \csname label\@enumctr\endcsname
      {\usecounter\@enumctr
       \let\enit@calc\z@
%       \def\makelabel##1{\enit@align{\enit@format{##1}}}%
       \enit@preset{#2}{#1}{#4}%
       \enit@normlabel\@itemlabel\@itemlabel
       \enit@ref
       \enit@calcleft
       \enit@before}%
  \fi}

\def\enit@itemize@i#1#2#3#4{%
    \if@newitem\leavevmode\fi
  \ifnum#1>#3\relax
    \enit@toodeep
  \else
    \enit@prelist\@ne{#1}{#2}%
    \edef\@itemitem{label#2\romannumeral#1}%
    \expandafter
    \enit@list
      \csname\@itemitem\endcsname
       {\let\enit@calc\z@
%        \def\makelabel##1{\enit@align{\enit@format{##1}}}%
        \enit@preset{#2}{#1}{#4}% 
        \enit@calcleft
        \enit@before}%
  \fi}

\def\enit@description@i#1#2#3#4{%
    \if@newitem\leavevmode\fi
  \ifnum#1>#3\relax
    \enit@toodeep
  \else
    \enit@list{}%
      {\let\enit@type\tw@
       \advance#1\@ne
       \labelwidth\z@
       \enit@align@left
%       \let\makelabel\descriptionlabel
       \enit@style@standard
       \enit@preset{#2}{#1}{#4}%
       \enit@calcleft
       \let\enit@svlabel\makelabel
%        \def\makelabel##1{%
%          \labelsep\z@
%          \ifenit@boxdesc
%            \enit@svlabel{\enit@align{\enit@format{##1}}}%
%          \else
%            \nobreak
%            \enit@svlabel{\enit@format{##1}}%
%            \aftergroup\enit@postlabel
%          \fi}%
       \enit@before}%
  \fi}

\def\enit@trivlist{%
  \let\enit@type\tw@
  \parsep\parskip
  \csname @list\romannumeral\the\@listdepth\endcsname
  \@nmbrlistfalse
  \enit@setkeys{trivlist}%
  \enit@setkeys{trivlist\romannumeral\@listdepth}%
  \@trivlist
  \labelwidth\z@
  \leftmargin\z@
  \itemindent\z@
  \let\@itemlabel\@empty
  % \def\makelabel##1{##1}%
}

\TeXMLendPackage

\endinput

__END__
