package TeX::Interpreter::LaTeX::Package::cases;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("cases", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::cases::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{cases}%[2002/05/02 ver 2.5 ]

\RequirePackage{amsmath}

\def\tagform@numcases#1{%
    \string\tag\string{#1\string}%
}%

\def\texml@tab@to@tag@cases{%
    \let\reserved@a\@empty
    \ifcase\aligncolno\or
        \def\reserved@a{&&}%
    \or
        \def\reserved@a{&}%
    \fi
    \reserved@a
}

\newenvironment{numcases}[1]{%
    \def\@currentreftype{disp-formula}%
    $$
    \begingroup
        \advance\c@equation\@ne
        \def\@currentlabel{\p@equation\theequation}% local
        \string\begin{\@currenvir}{#1}%
    \endgroup
    \UnicodeLineFeed
    \global\@eqnswtrue
    \global\let\df@label\@empty
    \Let@
    \let\tag\tag@in@align
    \let\math@cr@@@\math@cr@@@tagged
    \def\math@cr@@@simple{\cr}%
    \let\tagform@\tagform@numcases
    \let\label\label@in@display
    \let\texml@tab@to@tag\texml@tab@to@tag@cases
    \numc@setsub
    %% See nlm.xsl
    \xmltabletag{texml_cases}%
    \halign\bgroup
            \inlinemathtag{}$##$%       % column 1
           &##%                         % column 2
           % Why did the following stop working?
           % &\xmltablecoltag{tag}##%     % column 3
           &##%                         % column 3
        \cr
}{%
        \process@amsmath@tag
        \crcr
    \egroup
    \numc@resetsub
    \string\end{\@currenvir}%
    $$
}

\let\numc@setsub\relax
\let\numc@resetsub\relax

\def\subnumcases{%
    \let\numc@setsub\subequations 
    \let\numc@resetsub\endsubequations
    \numcases
}

\let\endsubnumcases\endnumcases 

\DeclareOption{subnum}{
    \let\numc@setsub\subequations 
    \let\numc@resetsub\endsubequations
}

\ProcessOptions

\TeXMLendPackage

\endinput

__END__
