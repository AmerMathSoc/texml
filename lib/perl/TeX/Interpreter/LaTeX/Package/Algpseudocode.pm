package TeX::Interpreter::LaTeX::Package::Algpseudocode;

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

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::Algpseudocode::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{algpseudocode}

%% Theoretically we could re-implement algorithmicx's primitives, but
%% that seems too much like work.

\RequirePackage{algorithmicx}

\LoadPackage{Algorithmic}

\DeclareOption{noend}{\setboolean{ALC@noend}{true}}
\DeclareOption{end}{\setboolean{ALC@noend}{false}}

% TBD: Decide what if anything to do about compatibility mode.

\newboolean{ALG@compatible}%
\setboolean{ALG@compatible}{false}

\DeclareOption{compatible}{%
    \typeout{For compatibility mode use algcompatible.sty!!!}%
    \setboolean{ALG@compatible}{true}%
}

\DeclareOption{noncompatible}{\setboolean{ALG@noncompatible}{false}}%

\ProcessOptions

% *** DECLARATIONS ***

% Probably don't need this
\algnewlanguage{pseudocode}
\alglanguage{pseudocode}

% *** KEYWORDS ***

\newcommand\algorithmicfunction{\textbf{function}}
\newcommand\algorithmicprocedure{\textbf{procedure}}

\newcommand\textproc{\textsc}

\let\Comment\COMMENT
\let\State\STATE

\defALC@toplevel*{\Statex}{statement}

\let\While\WHILE
\let\EndWhile\ENDWHILE

\let\For\FOR
\let\EndFor\ENDFOR

\let\ForAll\FORALL

\let\Loop\LOOP
\let\EndLoop\ENDLOOP

\let\Until\UNTIL

\let\Repeat\REPEAT

\let\If\IF
\let\EndIf\ENDIF

\let\ElsIf\ELSIF
\let\Else\ELSE

\newcommand{\Procedure}[2]{% #1 = procedure name; #2 = args
    \ALC@endtoplevel
\let\Comment\ALC@com
    \ALC@begingroup % LEVEL 1
        \ALC@pushtag{procedure}%
        \ALC@line{%
            \algorithmicprocedure\ \textproc{#1}
            \if###2##\else(#2)\fi
        }{}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\EndProcedure}{%
            \ALC@endtoplevel
        \ALC@endgroup  % LEVEL 2
        \ifALC@noend\else
            \ALC@line{\algorithmicend\ \algorithmicprocedure}{}%
        \fi
    \ALC@endgroup % LEVEL 1
}

\newcommand{\Function}[2]{% #1 = function name; #2 = args
    \ALC@endtoplevel
    \ALC@begingroup % LEVEL 1
        \ALC@pushtag{function}%
        \ALC@line{%
            \algorithmicfunction\ \textproc{#1}
            \if###2##\else(#2)\fi
        }{}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\EndFunction}{%
            \ALC@endtoplevel
        \ALC@endgroup  % LEVEL 2
        \ifALC@noend\else
            \ALC@line{\algorithmicend\ \algorithmicfunction}{}%
        \fi
    \ALC@endgroup % LEVEL
}

% *** OTHER DECLARATIONS

\let\Require\REQUIRE
\let\Ensure\ENSURE
\let\Return\RETURN

\algnewcommand\Call[2]{\textproc{#1}\ifthenelse{\equal{#2}{}}{}{(#2)}}%

\TeXMLendPackage

\endinput

__END__
