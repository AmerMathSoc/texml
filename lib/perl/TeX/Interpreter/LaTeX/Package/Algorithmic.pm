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

use version; our $VERSION = qv '2.1.0';

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
            $tex->define_simple_macro('ALG@linenodelimiter' => $value);
        }
    }

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{Algorithmic}

\@namedef{ver@algorithmic.sty}{XXX}

\LoadPackage{ALGutils}

\DeclareOption{noend}{\setboolean{ALG@noend}{true}}

\ProcessOptions

%% Define \algorithmicindent in case someone tries to customize it.

\let\algorithmicindent\dimen@

\newcommand{\ALG@linenodelimiter}{:}

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

\def@ALG@statement*[\algorithmicrequire]{\REQUIRE}{require}
\def@ALG@statement*[\algorithmicensure]{\ENSURE} {ensure}

\newcommand{\TRUE}{\algorithmictrue{}}
\newcommand{\FALSE}{\algorithmicfalse{}}
\newcommand{\AND}{\algorithmicand{} }
\newcommand{\OR}{\algorithmicor{} }
\newcommand{\XOR}{\algorithmicxor{} }
\newcommand{\NOT}{\algorithmicnot{} }
\newcommand{\TO}{\algorithmicto{} }

\def@ALG@statement{\STATE}{statement}
\let\STMT\STATE

\newcommand{\PRINT}{\STATE \algorithmicprint{} }
\newcommand{\RETURN}{\STATE \algorithmicreturn{} }

\def\algorithmiccomment#1{%
    \ALG@endgroup
    \ALG@begingroup
        \let\ALG@endtoplevel\ALG@endtoplevel@
        \ALG@pushtag{comment}#1%
}

\let\COMMENT\algorithmiccomment

\newcommand{\INPUTS}[1][]{%
    \ALG@endtoplevel
    \ALG@begingroup
        \ALG@pushtag{inputs}%
        \ALG@line{\algorithmicinputs}{#1}%
        \ALG@begingroup % LEVEL 2
            \ALG@pushtag{block}%
}

\newcommand{\ENDINPUTS}{%
            \ALG@endtoplevel
        \ALG@endgroup
    \ALG@endgroup
}

\newcommand{\OUTPUTS}[1][]{%
    \ALG@endtoplevel
    \ALG@begingroup
        \ALG@pushtag{outputs}%
        \ALG@line{\algorithmicoutputs}{#1}%
        \ALG@begingroup % LEVEL 2
            \ALG@pushtag{block}%
}

\newcommand{\ENDOUTPUTS}{%
            \ALG@endtoplevel
        \ALG@endgroup
    \ALG@endgroup
}

\def@ALG@statement[\algorithmicglobals]{\GLOBALS} {globals}

\newcommand{\BODY}[1][]{%
    \ALG@endtoplevel
    \ALG@begingroup
        \ALG@pushtag{body}%
        \ALG@line{\algorithmicbody}{#1}%
        \ALG@begingroup % LEVEL 2
            \ALG@pushtag{block}%
}

\newcommand{\ENDBODY}{%
            \ALG@endtoplevel
        \ALG@endgroup
    \ALG@endgroup
}

\newcommand{\WHILE}[2][]{%
    \ALG@begin@structure{while}{\algorithmicwhile}{#2}{#1}{\algorithmicdo}
}

\def\ENDWHILE{\ALG@end@structure{\algorithmicendwhile}}

\let\ALC@end@else\@empty

\newcommand{\IF}[2][]{%
    \ALG@begin@structure{if}{\algorithmicif}{#2}{#1}{\algorithmicthen}
    \let\ALC@end@else\@empty
}

\newcommand{\ELSIF}[2][]{%
                \ALG@endtoplevel
            \ALC@end@else
        \ALG@endgroup % end the block (LEVEL 2)
        \let\ALC@end@else\ALG@endgroup % (LEVEL 1)
        \ALG@begin@structure{elsif}{\algorithmicelsif}{#2}{#1}{\algorithmicthen}% LEVEL 3
}

\newcommand{\ELSE}[1][]{% No condition
                \ALG@endtoplevel
            \ALC@end@else
        \ALG@endgroup % end if block
        \let\ALC@end@else\ALG@endgroup
        \ALG@begingroup
            \ALG@pushtag{else}
            \ALG@line{\algorithmicelse}{#1}%
            \ALG@begingroup
                \ALG@pushtag{block}%
}

\def\ENDIF{%
                \ALG@endtoplevel
            \ALC@end@else
        \ALG@endgroup % END BLOCK (LEVEL 2)
        \ifALG@noend\else
            \ALG@line{\algorithmicendif}{}
        \fi
    \ALG@endgroup
}

\newcommand{\FOR}[2][]{%
    \ALG@begin@structure{for}{\algorithmicfor}{#2}{#1}{\algorithmicdo}
}

\newcommand{\FORALL}[2][]{%
    \ALG@begin@structure{forall}{\algorithmicforall}{#2}{#1}{\algorithmicdo}
}

\def\ENDFOR{\ALG@end@structure{\algorithmicendfor}}

\newcommand{\LOOP}[1][]{% No condition
    \ALG@begin@structure{loop}{\algorithmicloop}{}{#1}{}%
}

\newcommand{\REPEAT}[1][]{% No condition
    \ALG@begin@structure{repeat}{\algorithmicrepeat}{}{#1}{}%
}

\newcommand{\UNTIL}[1]{%
            \ALG@endtoplevel
        \ALG@endgroup
        \ALG@begingroup
            \ALG@pushtag{until}%
            \ALG@start@condition
                \ALG@pushtag{statement}%
                    \algorithmicuntil\ #1\par
                \ALG@popstack
            \ALG@end@condition
        \ALG@endgroup
    \ALG@endgroup
}

\def\ENDLOOP{\ALG@end@structure{\algorithmicendloop}}

\newenvironment{algorithmic}[1][0]{
    \par
    \xmlpartag{}%
    \def\\{\emptyXMLelement{br}}%
    \c@ALG@frequency=#1\relax
    \ifnum\c@ALG@frequency=\z@
        \@ALG@numberedfalse
    \else
        \@ALG@numberedtrue
        \c@ALG@line\z@
        \c@ALG@rem\z@
    \fi
    % TBD: Do we need ALC@unique?
    \ALG@begingroup
        \ALG@pushtag{algorithm}%
        \setXMLattribute{linenodelimiter}{\ALG@linenodelimiter}%
}{%
        \ALG@endtoplevel
    \ALG@endgroup
    \par
}

\TeXMLendPackage

\endinput

__END__
