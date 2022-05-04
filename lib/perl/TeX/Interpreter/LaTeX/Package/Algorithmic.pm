package TeX::Interpreter::LaTeX::Package::Algorithmic;

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

use version; our $VERSION = qv '2.0.1';

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::Algorithmic::DATA{IO});

    $tex->define_csname(algsetup => \&do_algsetup);

    return;
}

sub do_algsetup {
    my $tex = shift;

    my $opts = $tex->read_undelimited_parameter(EXPANDED);

    # \algsetup{linenodelimiter=X}

    # Ignore linenosize and indent

    for my $pair (split /\s*,\s*/, $opts) {
        my ($key, $value) = split /\s*=\s*/, $pair, 2;

        if ($key eq 'linenodelimiter') {
            $tex->define_simple_macro('ALC@linenodelimiter' => $value);
        }
    }

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{Algorithmic}

\@namedef{ver@algorithmic.sty}{XXX}

\LoadPackage{ALGutils}

\RequirePackage{ifthen}

\newboolean{ALC@noend}
\setboolean{ALC@noend}{false}

\DeclareOption{noend}{\setboolean{ALC@noend}{true}}

\ProcessOptions

%% Define \algorithmicindent in case someone tries to customize it.

\let\algorithmicindent\dimen@

\newcommand{\ALC@linenodelimiter}{:}

\newcommand{\algorithmicrequire}{\textbf{Require:}}
\newcommand{\algorithmicensure}{\textbf{Ensure:}}
\newcommand{\algorithmicend}{\textbf{end}}
\newcommand{\algorithmicif}{\textbf{if}}
\newcommand{\algorithmicthen}{\textbf{then}}
\newcommand{\algorithmicelse}{\textbf{else}}
\newcommand{\algorithmicelsif}{\algorithmicelse\ \algorithmicif}
\newcommand{\algorithmicendif}{\algorithmicend\ \algorithmicif}
\newcommand{\algorithmicfor}{\textbf{for}}
\newcommand{\algorithmicforall}{\textbf{for all}}
\newcommand{\algorithmicdo}{\textbf{do}}
\newcommand{\algorithmicendfor}{\algorithmicend\ \algorithmicfor}
\newcommand{\algorithmicwhile}{\textbf{while}}
\newcommand{\algorithmicendwhile}{\algorithmicend\ \algorithmicwhile}
\newcommand{\algorithmicloop}{\textbf{loop}}
\newcommand{\algorithmicendloop}{\algorithmicend\ \algorithmicloop}
\newcommand{\algorithmicrepeat}{\textbf{repeat}}
\newcommand{\algorithmicuntil}{\textbf{until}}
\newcommand{\algorithmicprint}{\textbf{print}}
\newcommand{\algorithmicreturn}{\textbf{return}}
\newcommand{\algorithmicand}{\textbf{and}}
\newcommand{\algorithmicor}{\textbf{or}}
\newcommand{\algorithmicxor}{\textbf{xor}}
\newcommand{\algorithmicnot}{\textbf{not}}
\newcommand{\algorithmicto}{\textbf{to}}
\newcommand{\algorithmicinputs}{\textbf{inputs}}
\newcommand{\algorithmicoutputs}{\textbf{outputs}}
\newcommand{\algorithmicglobals}{\textbf{globals}}
\newcommand{\algorithmicbody}{\textbf{do}}
\newcommand{\algorithmictrue}{\textbf{true}}
\newcommand{\algorithmicfalse}{\textbf{false}}

\defALC@toplevel*[\algorithmicrequire]{\REQUIRE}{require}
\defALC@toplevel*[\algorithmicensure]{\ENSURE} {ensure}
\newcommand{\PRINT}{\STATE \algorithmicprint{} }
\newcommand{\RETURN}{\STATE \algorithmicreturn{} }
\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\defALC@toplevel{\STATE}{statement}
\let\STMT\STATE

\def\algorithmiccomment#1{%
    \ALC@endgroup
    \ALC@begingroup
        \let\ALC@endtoplevel\ALC@endtoplevel@
        \ALC@pushtag{comment}#1%
}

\let\COMMENT\algorithmiccomment

\newcommand{\INPUTS}[1][default]{%
    \ALC@endtoplevel
    \ALC@begingroup
        \ALC@pushtag{inputs}%
        \ALC@line{\algorithmicinputs}{#1}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDINPUTS}{%
            \ALC@endtoplevel
        \ALC@endgroup
    \ALC@endgroup
}

\newcommand{\OUTPUTS}[1][default]{%
    \ALC@endtoplevel
    \ALC@begingroup
        \ALC@pushtag{outputs}%
        \ALC@line{\algorithmicoutputs}{#1}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDOUTPUTS}{%
            \ALC@endtoplevel
        \ALC@endgroup
    \ALC@endgroup
}

\defALC@toplevel[\algorithmicglobals]{\GLOBALS} {globals}

\newcommand{\BODY}[1][default]{%
    \ALC@endtoplevel
    \ALC@begingroup
        \ALC@pushtag{body}%
        \ALC@line{\algorithmicbody}{#1}%
        \ALC@begingroup % LEVEL 2
            \ALC@pushtag{block}%
}

\newcommand{\ENDBODY}{%
            \ALC@endtoplevel
        \ALC@endgroup
    \ALC@endgroup
}

\newcommand{\WHILE}[2][default]{%
    \ALC@begin@structure{while}{\algorithmicwhile}{#2}{#1}{\algorithmicdo}
}

\def\ENDWHILE{\ALC@end@structure{\algorithmicendwhile}}

\let\ALC@end@else\@empty

\newcommand{\IF}[2][default]{%
    \ALC@begin@structure{if}{\algorithmicif}{#2}{#1}{\algorithmicthen}
    \let\ALC@end@else\@empty
}

\newcommand{\ELSIF}[2][default]{%
                \ALC@endtoplevel
            \ALC@end@else
        \ALC@endgroup % end the block (LEVEL 2)
        \let\ALC@end@else\ALC@endgroup % (LEVEL 1)
        \ALC@begin@structure{elsif}{\algorithmicelsif}{#2}{#1}{\algorithmicthen}% LEVEL 3
}

\newcommand{\ELSE}[1][default]{% No condition
                \ALC@endtoplevel
            \ALC@end@else
        \ALC@endgroup % end if block
        \let\ALC@end@else\ALC@endgroup
        \ALC@begingroup
            \ALC@pushtag{else}
            \ALC@line{\algorithmicelse}{#1}%
            \ALC@begingroup
                \ALC@pushtag{block}%
}

\def\ENDIF{%
                \ALC@endtoplevel
            \ALC@end@else
        \ALC@endgroup % END BLOCK (LEVEL 2)
        \ifALC@noend\else
            \ALC@line{\algorithmicendif}{}
        \fi
    \ALC@endgroup
}

\newcommand{\FOR}[2][default]{%
    \ALC@begin@structure{for}{\algorithmicfor}{#2}{#1}{\algorithmicdo}
}

\newcommand{\FORALL}[2][default]{%
    \ALC@begin@structure{forall}{\algorithmicforall}{#2}{#1}{\algorithmicdo}
}

\def\ENDFOR{\ALC@end@structure{\algorithmicendfor}}

\newcommand{\LOOP}[1][default]{% No condition
    \ALC@begin@structure{loop}{\algorithmicloop}{}{#1}{}%
}

\newcommand{\REPEAT}[1][default]{% No condition
    \ALC@begin@structure{repeat}{\algorithmicrepeat}{}{#1}{}%
}

\newcommand{\UNTIL}[1]{%
            \ALC@endtoplevel
        \ALC@endgroup
        \ALC@begingroup
            \ALC@pushtag{until}%
            \ALC@start@condition
                \ALC@pushtag{statement}%
                    \algorithmicuntil\ #1\par
                \ALC@popstack
            \ALC@end@condition
        \ALC@endgroup
    \ALC@endgroup
}

\def\ENDLOOP{\ALC@end@structure{\algorithmicendloop}}

\renewenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \def\\{\emptyXMLelement{br}}%
    \ALC@frequency=#1\relax
    \ifnum\ALC@frequency=\z@
        \@ALCnumberedfalse
    \else
        \@ALCnumberedtrue
        \c@ALC@line\z@
        \c@ALC@rem\z@
    \fi
    % TBD: Do we need ALC@unique?
    \ALC@begingroup
        \ALC@pushtag{algorithm}%
        \setXMLattribute{linenodelimiter}{\ALC@linenodelimiter}%
}{%
        \ALC@endtoplevel
    \ALC@endgroup
    \par
}

\TeXMLendPackage

\endinput

__END__
