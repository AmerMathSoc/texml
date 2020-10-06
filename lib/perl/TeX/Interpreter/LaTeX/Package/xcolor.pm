package TeX::Interpreter::LaTeX::Package::xcolor;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->load_latex_package("xcolor", @options);

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xcolor::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{xcolor}

\let\color\@gobble@opt

\def\definecolor#1#2#3{}
\let\colorlet\@gobbletwo

% \let\colorbox\@secondoftwo

\DeclareMathJaxMacro\color
% \DeclareMathJaxMacro\colorbox
\DeclareMathJaxMacro\fcolorbox
\DeclareMathJaxMacro\definecolor

\def\colorbox#1#2{%
    \ifmmode
        \string\colorbox\string{#1\string}\string{\hbox{#2}\string}%
    \else
        #2%
    \fi

}

\def\textcolor#1#2{%
    \leavevmode
    \startXMLelement{styled-content}%
    \setXMLattribute{style}{color #1}%
    #2%
    \endXMLelement{styled-content}%
}

\TeXMLendPackage

\endinput

__END__
