package TeX::Interpreter::LaTeX::Package::constants;

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

use TeX::Utils::Misc qw(nonempty pluralize);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::constants::DATA{IO});

    $tex->define_csname('TeXML@resolveconstants' => \&do_resolve_constants);

    return;
}

sub do_resolve_constants {
    my $tex   = shift;
    my $token = shift;

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $pass = 0;

    $tex->print_nl("Resolving \\Cr");

    my $num_resolved = 0;

    while (my @xrefs = $body->findnodes(qq{descendant::texml_constant[starts-with(attribute::specific-use, "constants")]})) {
        if (++$pass > 10) {
            $tex->print_nl("resolve_constants: Bailing on pass number $pass");

            last;
        }

        for my $xref (@xrefs) {
            (undef, my $ref_cmd) = split / /, $xref->getAttribute('specific-use');
            if ($ref_cmd eq 'Cr') {
                my $key = $xref->getAttribute("rid");

                my $tex_fragment = qq{\\Cr{$key}};

                my $label = $tex->convert_fragment($tex_fragment);

                if (nonempty($label) && $label->hasChildNodes()) {
                    my $parent = $xref->parentNode();

                    $parent->replaceChild($label, $xref);
                }
            }
        }
    }

    my $refs  = pluralize("reference", $num_resolved);

    $tex->print_nl("Resolved $num_resolved constants");

    return;
}

1;

__DATA__

% Because of the use of \AtEndDocument and \@onlypreamble, it's easier
% to just inline the entire package.  As long as we're doing that,
% we'll also clean up the code a bit.

\ProvidesPackage{constants}

\AtTeXMLend{\TeXML@resolveconstants}

\def\TeXMLNoResolveconstants{\let\TeXML@resolveconstants\@empty}

\RequirePackage{keyval}

\def\@if@constant@exists#1#2#3{\@ifundefined{cst@family@#1}{#3}{#2}}

\global\@namedef{cst@family@normal}{}

\newcounter{cst@counter@normal}

\def\cst@format@normal#1{\arabic{#1}}

\def\cst@symbol@normal{C}

\newcommand{\newconstantfamily}[2]{
    \@if@constant@exists{#1}{%
        \PackageError{constants}{The family of constants '#1' already exists}{%
            Use \protect\renewconstantfamily\space to override}%
    }{%
        \expandafter\def\csname cst@family@#1\endcsname{}%
        \expandafter\def\csname cst@format@#1\endcsname{\cst@format@normal}%
        \expandafter\def\csname cst@symbol@#1\endcsname{\cst@symbol@normal}%
        \expandafter\newcounter{cst@counter@#1}%
        \define@key{constants}{format}%
            {\expandafter\def\csname cst@format@#1\endcsname{##1}}
        \define@key{constants}{symbol}%
            {\expandafter\def\csname cst@symbol@#1\endcsname{##1}}
        \define@key{constants}{reset}{\@addtoreset{cst@counter@#1}{##1}}
        \setkeys{constants}{#2}
    }%
}

\newcommand{\renewconstantfamily}[2]{
    \@if@constant@exists{#1}{%
        \define@key{constants}{format}{%
            \expandafter\def\csname cst@format@#1\endcsname{##1}%
        }%
        \define@key{constants}{symbol}{%
            \expandafter\def\csname cst@symbol@#1\endcsname{##1}%
        }
        \define@key{constants}{reset}{\@addtoreset{cst@counter@#1}{##1}}
        \setkeys{constants}{#2}
    }{%
        \PackageError{constants}{The family of constants '#1' already exists}{%
            Use \protect\renewconstantfamily\space to override}%
    }%
}

% \@onlypreamble\newconstantfamily
% \@onlypreamble\renewconstantfamily

\def\G@refundefinedconstanttrue{%
    \gdef\@refundefinedconstant{%
        \@latex@warning@no@line{There were undefined references to constants}%
    }%
}

\let\@refundefinedconstant\relax

\def\cst@tmp@format{cst@undefined@format}
\def\cst@tmp@symbol{cst@undefined@symbol}

\long\def\@firstofthree#1#2#3{#1}
\long\def\@secondofthree#1#2#3{#2}
\long\def\@thirdofthree#1#2#3{#3}

\def\cst@undefined@format#1{}

\def\cst@undefined@symbol{%
    \mathtt{C}_{\mathtt{??}}
}

% #1 -> \cstr@LABEL
% #2 -> \@Xofthree
% #3 -> LABEL

\def\@setrefconstant#1#2#3{%
    \leavevmode
    \ifx#1\relax
        \protect\G@refundefinedconstanttrue
        \nfss@text{\reset@font\bfseries ??}%
        \@latex@warning{Reference to constant `#3' undefined}%
    \else
        \expandafter#2#1\null
    \fi
}

\def\@setfamconstant#1#2#3{%
    \ifx#1\relax
        \def\cst@tmp@format{cst@undefined@format}%
        \def\cst@tmp@symbol{cst@undefined@symbol}%
    \else
        \def\cst@tmp@format{cst@format@\expandafter#2#1}%
        \def\cst@tmp@symbol{cst@symbol@\expandafter#2#1}%
    \fi
}

\newcounter{cst@tmp@counter}

\def\@setcounterconstant#1#2#3{%
    \ifx#1\relax
        \protect\G@refundefinedconstanttrue
        % \@latex@warning{Reference to constant `#3' undefined}%
    \else
        \setcounter{cst@tmp@counter}{\expandafter#2#1}%
    \fi
}

\def\refconstant#1{%
    \expandafter\@setrefconstant\csname cstr@#1\endcsname\@firstofthree{#1}%
}

\def\familyconstant#1{%
    \expandafter\@setfamconstant\csname cstr@#1\endcsname\@thirdofthree{#1}%
}

\def\counterconstant#1{%
    \expandafter\@setcounterconstant\csname cstr@#1\endcsname\@firstofthree{#1}%
}

\newcommand{\Cr}[1]{% #1 -> LABEL
    \@ifundefined{cstr@#1}{%
        \if@TeXMLend
            \protect\G@refundefinedconstanttrue
            \@latex@warning{Reference to constant `#1' undefined}%
            % \mathtt{#1}%
        \else
            \startXMLelement{texml_constant}%
                \setXMLattribute{specific-use}{constants Cr}%
                \setXMLattribute{rid}{#1}%
            \endXMLelement{texml_constant}%
        \fi
    }{%
        \familyconstant{#1}%  Defines \cst@tmp@format and \cst@tmp@symbol
        \counterconstant{#1}% Defines \cst@tmp@counter
        {\@nameuse{\cst@tmp@symbol}}_{\@nameuse{\cst@tmp@format}{cst@tmp@counter}}%
    }%
}

\newcommand{\C}[1][normal]{%
    \@if@constant@exists{#1}{%
        \expandafter\refstepcounterconstant{cst@counter@#1}%
        {\@nameuse{cst@symbol@#1}}_{\@nameuse{cst@format@#1}{cst@counter@#1}}%
    }{%
        \PackageError{constants}{Family for constants '#1' not defined}{
            Check the name or use \protect\newconstantfamily}
    }%
}

\newcommand{\Cl}[2][normal]{%
    \C[#1]%
    \labelconstant{#2}{\string #1}%
}

\def\pagerefconstant#1{%
    \PackageError{constants}{Use of pagrefconstant{#1} no supported}{}%
    \texttt{[?pagerefconstant #1]}%
}

\def\refstepcounterconstant#1{%
    \stepcounter{#1}%
    \protected@edef\@currentlabelconstant{%
        \csname p@#1\endcsname\csname the#1\endcsname
    }%
}

\def\@newl@belconstant#1#2#3{%
    \@ifundefined{#1@#2}{}{%
        \gdef\@multiplelabelsconstant{%
            \@latex@warning@no@line{%
                There were multiply-defined labels for constants%
            }%
        }%
        \@latex@warning@no@line{Label for constant `#2' multiply defined}%
    }%
    \global\@namedef{#1@#2}{#3}%
}

\def\@currentlabelconstant{}

\def\newlabelconstant{\@newl@belconstant{cstr}}

% \@onlypreamble\@newl@belconstant

\let\@multiplelabelsconstant\relax

\def\labelconstant#1#2{%
    \@bsphack
    \begingroup
        \protected@edef\@tempa{%
            \protect\newlabelconstant{#1}{{\@currentlabelconstant}{}{#2}}%
        }%
    \expandafter\endgroup
    \@tempa
    \@esphack
}

\newcommand{\resetconstant}[1][normal]{%
    \@if@constant@exists{#1}{%
        \setcounter{cst@counter@#1}{0}%
    }{%
        {\PackageError{constants}{Family for constants '#1' not defined}{%
            Check the name or use \protect\newconstantfamily}}%
    }%
}

\endinput

__END__
