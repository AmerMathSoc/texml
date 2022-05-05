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

use version; our $VERSION = qv '2.2.0';

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

% \def\algorithmiccomment#1{%
%     \ALG@endgroup
%     \ALG@begingroup
%         \let\ALG@end@statement\ALG@end@statement@
%         \ALG@pushtag{comment}#1%
% }

\newcommand{\algorithmiccomment}[1]{\ALG@com{#1}}

\let\COMMENT\algorithmiccomment

\newcommand{\INPUTS}[1][]{%
    \ALG@open@structure*{inputs}{\algorithmicinputs}{}{#1}{}%
}

\newcommand{\ENDINPUTS}{%
    \ALG@close@structure{}%
}

\newcommand{\OUTPUTS}[1][]{%
    \ALG@open@structure*{outputs}{\algorithmicoutputs}{}{#1}{}%
}

\let\ENDOUTPUTS\ENDINPUTS

\def@ALG@statement[\algorithmicglobals]{\GLOBALS} {globals}

\newcommand{\BODY}[1][]{%
    \ALG@open@structure*{body}{\algorithmicbody}{}{#1}{}%
}

\let\ENDBODY\ENDINPUTS

\newcommand{\WHILE}[2][]{%
    \ALG@open@structure{while}{\algorithmicwhile}{#2}{#1}{\algorithmicdo}
}

\def\ENDWHILE{\ALG@close@structure{\algorithmicendwhile}}

\let\ALC@end@else\@empty

\newcommand{\IF}[2][]{%
    \ALG@open@structure{if}{\algorithmicif}{#2}{#1}{\algorithmicthen}
}

\newcommand{\ELSIF}[2][]{%
    \ALG@end@@block
                \ALG@end@statement
            \ALC@end@else
        \ALG@endgroup % end the block (LEVEL 2)
        \let\ALC@end@else\ALG@endgroup % (LEVEL 1)
        \ALG@open@structure{elsif}{\algorithmicelsif}{#2}{#1}{\algorithmicthen}% LEVEL 3
}

\newcommand{\ELSE}[1][]{% No condition
                \ALG@end@statement
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
                \ALG@end@statement
            \ALC@end@else
        \ALG@endgroup % END BLOCK (LEVEL 2)
        \ifALG@noend\else
            \ALG@line{\algorithmicendif}{}
        \fi
    \ALG@endgroup
}

\newcommand{\FOR}[2][]{%
    \ALG@open@structure{for}{\algorithmicfor}{#2}{#1}{\algorithmicdo}
}

\newcommand{\FORALL}[2][]{%
    \ALG@open@structure{forall}{\algorithmicforall}{#2}{#1}{\algorithmicdo}
}

\def\ENDFOR{\ALG@close@structure{\algorithmicendfor}}

\newcommand{\LOOP}[1][]{% No condition
    \ALG@open@structure{loop}{\algorithmicloop}{}{#1}{}%
}

\newcommand{\REPEAT}[1][]{% No condition
    \ALG@open@structure{repeat}{\algorithmicrepeat}{}{#1}{}%
}

\newcommand{\UNTIL}[1]{%
        \ALG@end@condition % paranoia
        \ALG@end@block
        \ALG@begingroup
            \ALG@pushtag{until}%
            \ALG@begin@condition
                \ALG@begin@line
                \ALG@begingroup
                    \ALG@pushtag{statement}%
                    \ALG@instatementtrue
                        \algorithmicuntil\ #1\par
            \ALG@end@condition
        \ALG@endgroup
    \ALG@endgroup
}

\def\ENDLOOP{\ALG@close@structure{\algorithmicendloop}}

\TeXMLendPackage

\endinput

__END__
