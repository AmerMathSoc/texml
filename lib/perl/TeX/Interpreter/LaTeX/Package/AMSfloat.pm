package TeX::Interpreter::LaTeX::Package::AMSfloat;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::AMSfloat::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{AMSfloat}

% <fig id="raptor" position="float">
%   <label>Figure 1</label>
%   <caption>
%     <title>Le Raptor.</title>
%     <p>Rapidirap.</p>
%   </caption>
%   <graphic xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="data/samples/raptor.jpg"/>
% </fig>

\def\jats@figure@element{fig}

\def\caption{%
   \ifx\@captype\@undefined
     \@latex@error{\noexpand\caption outside float}\@ehd
     \expandafter\@gobble
   \else
     \expandafter\@firstofone
   \fi
   \@ifstar{\st@rredtrue\caption@}{\st@rredfalse\caption@}%
}

\def\caption@{\@dblarg{\@caption\@captype}}

\def\@caption#1[#2]#3{%
    \ifst@rred\else
        \startXMLelement{label}%
            \refstepcounter{\@captype}%
            \csname \@captype name\endcsname\space \csname the\@captype\endcsname
        \endXMLelement{label}%
    \fi
    \if###3##\else
        \startXMLelement{caption}%
            \startXMLelement{p}%
            #3%
            \endXMLelement{p}%
        \endXMLelement{caption}%
    \fi
}

\renewenvironment{figure}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{fig}%
    \def\@captype{figure}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\renewenvironment{table}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{table}%
    \def\@captype{table}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\TeXMLendPackage

\endinput

__END__
