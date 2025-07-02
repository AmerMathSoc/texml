package TeX::Interpreter::LaTeX::Package::LTfntcmd;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use warnings;

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{LTfntcmd}

\def\@declarestyledcommand#1#2#3{%
    \DeclareRobustCommand#1[1]{%
        \ifmmode
            \string#2{##1}%
        \else
            \JATStyledContent{#3}{##1}%
        \fi
    }%
}

\@declarestyledcommand\textsl\mathsl{oblique}
\@declarestyledcommand\textbfit\mathbfit{bold-italic}
%\@declarestyledcommand\textup{font-style: normal}
% \@declarestyledcommand\textsc{font-variant: small-caps}

\@declarestyledcommand\textbfsf\mathbfsf{bold-sans}% text/72 (matsuura)

\newcommand{\@declarefontcommand}[4][OT1]{%
    \DeclareRobustCommand#2[1]{%
        \begingroup
        \ifmmode
            \fontencoding{UCS}\selectfont
            \string#3{##1}%
        \else
            \leavevmode
            \startXMLelement{#4}%
            {\fontencoding{#1}\selectfont##1}%
            \endXMLelement{#4}%
        \fi
        \endgroup
    }%
}

\@declarefontcommand\textup\text{roman}

% The following aren't quite right because, for example, \textrm{foo
% bar} retains the space, but \mathrm{foo bar} does not.  But it's
% probably correct most of the time.

\@declarefontcommand\textrm\mathrm{roman}
\@declarefontcommand\textnormal\mathrm{roman}
\@declarefontcommand\textsc\mathsc{sc}
\@declarefontcommand\textbf\mathbf{bold}
\@declarefontcommand[OT1tt]\texttt\mathtt{monospace}
\@declarefontcommand[OT1ti]\textit\mathit{italic}
\@declarefontcommand\textsf\mathsf{sans-serif}

\@declarefontcommand\underline\underline{underline}
\@declarefontcommand\textsuperscript\sp{sup}
\@declarefontcommand\textsubscript\sb{sub}

%% Defer \overline until \begin{document} to avoid warnings from
%% amsmath.sty.

\AtBeginDocument{\@declarefontcommand\overline\overline{overline}}

%% Question: Why do I need both \leavevmode's here?

\DeclareRobustCommand\emph[1]{%
    \leavevmode
    \ifmmode
        \string\mathit{#1}%
    \else
        \leavevmode
        \startXMLelement{italic}%
        \setXMLattribute{toggle}{yes}%
        #1%
        \endXMLelement{italic}%
    \fi
}

\endinput

__END__
