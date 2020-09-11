package TeX::Interpreter::LaTeX::Class::maabook;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_latex_class("maabook", @options);

    $tex->set_module_list('TeX::Interpreter::LaTeX::Package::amsthm', undef);

    $tex->load_document_class('TeXMLbook', @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::maabook::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesClass{maabook}

\RequirePackage{ifxetex}
\RequirePackage{amsgen}
\RequirePackage{amstext}
\RequirePackage{amscip}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{xspace}

\RequirePackage{amsthm}

\renewcommand\thesection{\thechapter.\arabic{section}}

\renewcommand{\makehalftitle}{}

\DeclareRobustCommand{\forcelinebreak}{%
    \@ifstar{\unskip\space\ignorespaces}{\unskip\space}%
}

\DeclareRobustCommand{\forcehyphenbreak}{-\ignorespaces}%

%% maabook.cls rewrites \caption if it notices that float has been
%% loaded, but since we've suppressed the float package, the maabook
%% patches end up restoring the behaviour we were trying to fix.  The
%% following two lines were added somewhat in a mood of desperation.
%% Luckily they seem to work.  For now.

\PreserveMacroDefinition\caption
\PreserveMacroDefinition\@caption

\@ifclasswith{maabook}{collection}{}{\endinput}

\def\col@author#1{%
    \ifx\@authorlist\@empty
        \gdef\@authorlist{\@authorname{#1}}%
    \else
        \g@addto@macro\@authorlist{\and\@authorname{#1}}%
    \fi
}

\def\col@affiliation#1{%
    \g@addto@macro\@authorlist{\@authoraffil{#1}}%
}

\def\mainmatter@hook{%
    \let\author\col@author
    \let\affiliation\col@affiliation
    \reset@titlepage
}

\def\xml@authorname#1{%
    \begingroup
        \xmlpartag{string-name}
        #1\par
    \endgroup
}

\def\xml@authoraffil#1{%
    \begingroup
        \xmlpartag{institution}
        #1\par
    \endgroup
}

\def\chap@maketitle{%
    \ifx\@title\@empty
        \PackageError{chapauthor}{No title!}\@ehd
    \else
        \chapter{\@title}
        \ifx\@subtitle\@empty\else
            \begingroup
                \thisxmlpartag{subtitle}%
                \@subtitle\par
            \endgroup
        \fi
        \ifx\@authorlist\@empty\else
            \startXMLelement{sec-meta}
                \startXMLelement{contrib-group}%
                \begingroup
                    \let\and\ignorespaces
                    \let\@authorname\xml@authorname
                    \let\@authoraffil\xml@authoraffil
                    \@authorlist
                \endgroup
                \endXMLelement{contrib-group}%
            \endXMLelement{sec-meta}%
        \fi
    \fi
    \reset@titlepage
}

\TeXMLendClass

\endinput

__END__
