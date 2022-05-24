package TeX::Interpreter::LaTeX::Class::maabook;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_latex_class("maabook", @options);

    $tex->set_module_list('TeX::Interpreter::LaTeX::Package::amsthm', undef);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::maabook::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesClass{maabook}

\LoadClass{TeXMLbook}

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
        \g@addto@macro\@authorlist{\protect\and\@authorname{#1}}%
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
    \begingroup
        \let\and\relax
        \let\@authorname\relax
        \addtocontents{toc}{\def\protect\@authorlist{\@authorlist}}%
    \endgroup
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

\endinput

__END__
