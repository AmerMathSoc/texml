package TeX::Interpreter::LaTeX::Package::tikz;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.1';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::tikz::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{tikz}

\RequirePackage{pgf}

\let\tikzcdset\@gobble

\newcommand{\tikz}[1][]{%
    \@ifnextchar\bgroup{\@tikz[#1]}{\@@tikz[#1]}%
}

\def\@@tikz[#1]#2;{%
    \@tikz[#1]{#2;}%
}

\newcommand{\@tikz}[2][]{%
    \TeXMLCreateSVG{\tikz[#1]{#2}}%
}

\def\tikzpicture#1\endtikzpicture{%
    \TeXMLCreateSVG{\tikzpicture#1\endtikzpicture}%
}

\DeclareSVGEnvironment*{tikzpicture}

\def\usetikzlibrary#1{}

\def\tikzstyle#1=[#2]{}

\let\tikzset\@gobble
\let\entrymodifiers\@gobble

\DeclareSVGEnvironment{tikzcd}

\newcommand{\rotatebox}[3][]{%
    \TeXMLCreateSVG{\rotatebox[#1]{#2}{#3}}%
}

\TeXMLendPackage

\endinput

__END__
