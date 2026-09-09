package TeX::Interpreter::LaTeX::Class::noti20_1B;

use v5.26.0;

# Copyright (C) 2022, 2026 American Mathematical Society
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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{noti20_1B}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{notices}}

\ProcessOptions

\LoadClass{notices}

\def\init@classified{%
    \title{Classified Advertising}
    \subtitle{Employment Opportunities}
}

\newcommand{\adno}[1]{%
    \par
    #1\setXMLattribute{content-type}{adno}%
    \par
}

\newenvironment{classifiedad}[1]{%
    \section*{#1}
    \par
    \startXMLelement{abstract}\par
    \def\\{\emptyXMLelement{break}\UnicodeLineFeed}%
}{%
    \par
    \endXMLelement{abstract}\par
    \global\everypar{}%
}

\def\init@newbooks{%
  % \setpermissiontext{}
  \title{New Books Offered by the AMS}
  \def\pubhead{\zhead*}
  \def\npublines{\def\@npublines}
  \def\@npublines{11}
}

\newenvironment{npub}[5]{%
    \def\nurl{#1}%
    \def\ngraphic{#4}%
    \def\nauth##1{\textbf{##1}}%
    \def\nplace##1{\emph{##1}}%
    \def\reviewedwork@titlefont{%
      \sffamily\bfseries
      \fontsize{11}{12pt}\selectfont
      \color{Aheadcolor}%
    }%
    \def\reviewedwork@authorfont{}%
    \parindent\z@
    \parskip\medskipamount
    \vskip-1.5\baselineskip
    \featureditem
      \title{#2}
      \subtitle{#3}
      \authors{#5}
      \graphic{\ngraphic}
      \lines{\@npublines}
    \endfeatureditem
}{%
    \par
    \notiurl{bookstore.ams.org/\nurl}
    \par
}

\endinput

__END__
