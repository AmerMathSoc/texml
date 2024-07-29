package TeX::Interpreter::LaTeX::Package::subfig;

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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{subfig}

\let\caption@Debug\@gobble

\LoadRawMacros

% All figures will be enclosed by <fig-group> elements, which will be
% demoted back to <fig> by XML::Output::normalize_figures() if
% necessary.

\def\jats@figure@element{fig-group}
\def\jats@table@element{table-wrap-group}

\let\caption@settype\@gobble

% \def\subref{%
%   \@ifstar
%     \sf@@subref
%     \sf@subref}
%
% \def\sf@subref#1{\ref{sub@#1}}
%
% \def\sf@@subref#1{\pageref{sub@#1}}

\def\caption@lstfmt#1#2{#1(#2)}
\def\caption@subreffmt #1#2#3#4{#1(#2)}

\def\sf@@sub@label#1{%
    \@bsphack
    \sf@oldlabel{#1}%
    \begingroup
        \let\ref\relax
        \protected@edef\@tempa{%
            \noexpand\newlabel{sub@#1}{%
                {%1
                    \caption@lstfmt
                        {\@nameuse{p@sub\@captype}}%
                        {\@nameuse{thesub\@captype}}%
                }%
                {%2
                    \caption@subreffmt
                        {\@nameuse{p@sub\@captype}}%
                        {\@nameuse{thesub\@captype}}%
                        {\the\value{\@captype}}%
                        {\the\value{sub\@captype}}%
                }%
                {\@currentXMLid}%
                {\ifmmode disp-formula\else\@currentreftype\fi}%
            }%
        }%
    \expandafter\endgroup
    \@tempa
    \@esphack
}

% #1 = sub\@captype
% #2 = list-entry (ignored)
% #3 = caption
% #4 = figure

\let\subfloat@content@type\@empty

\long\def\sf@@@subfloat#1[#2][#3]#4{%
        \leavevmode
            \ifnum\strcmp{#1}{subfigure}=0
                \startXMLelement{fig}%
            \else
                \startXMLelement{table-wrap}%
            \fi
            \addXMLid
            \ifx\subfloat@content@type\@empty\else
                \setXMLattribute{content-type}{\subfloat@content@type}%
                \let\subfloat@content@type\@empty
            \fi
            \sf@subcaption{#1}{#2}{#3}%
            #4%
            \ifnum\strcmp{#1}{subfigure}=0
                \endXMLelement{fig}%
            \else
                \endXMLelement{table-wrap}%
            \fi
    \endgroup
    \ignorespaces
}

% \gdef\caption@lfmt@EMPTY#1#2{}

% \DeclareCaptionLabelFormat{parens}{\bothIfFirst{#1}{\XMLgeneratedText\nobreakspace}\XMLgeneratedText(#2\XMLgeneratedText)}

% If there's a subfigurename, should it also be put in <x>?

% \def\subfigurename{Subfigure}

% #1 = sub\@captype
% #2 = list-entry (ignored)
% #3 = caption

\long\def\sf@subcaption#1#2#3{%
    \ifx\@empty#3\relax \else
        \protected@edef\@tempa{%
            \@ifundefined{sub\@captype name}{}{\@nameuse{sub\@captype name}}%
        }%
        \ifx\@tempa\@empty\else
            \@ifundefined{thesub\@captype}{}{%
                \protected@edef\@tempa{\@tempa\space}%
            }%
        \fi
        \@ifundefined{thesub\@captype}{}{%
            \protected@edef\@tempa{\@tempa\@nameuse{thesub\@captype}}%
        }%
        % \ifx\caption@lfmt\caption@lfmt@EMPTY\else
            \ifx\@tempa\@empty\else
                \startXMLelement{label}%
                    % \caption@lfmt{\@nameuse{#1name}}%
                    \@tempa
                \endXMLelement{label}%
            \fi
        % \fi
        \startXMLelement{caption}%
            \startXMLelement{p}%
            #3%
            \endXMLelement{p}%
        \endXMLelement{caption}%
    \fi
}

\AtBeginDocument{
    \RestoreEnvironmentDefinition{figure}
    \RestoreEnvironmentDefinition{figure*}
    \RestoreEnvironmentDefinition{table}
    \RestoreEnvironmentDefinition{table*}
    \RestoreMacroDefinition\caption
    \RestoreMacroDefinition\caption@
    \RestoreMacroDefinition\@caption
}

\endinput

__END__
