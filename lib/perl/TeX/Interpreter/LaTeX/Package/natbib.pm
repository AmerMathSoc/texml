package TeX::Interpreter::LaTeX::Package::natbib;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{natbib}

\let\@listi\@empty

\expandafter\SaveMacroDefinition\csname cite \endcsname
\SaveMacroDefinition\@lbibitem
\SaveMacroDefinition\@bibitem
\SaveMacroDefinition\@citex

\LoadRawMacros

\expandafter\RestoreMacroDefinition\csname cite \endcsname
\AtBeginDocument{\RestoreMacroDefinition\@lbibitem}
\AtBeginDocument{\RestoreMacroDefinition\@bibitem}
\AtBeginDocument{\RestoreMacroDefinition\@citex}

\@ifpackagewith{natbib}{angle}{%
    \renewcommand\NAT@open{\textlangle}%
    \renewcommand\NAT@close{\textrangle}
}{}

\let\citep\cite

\def\citemid{\XMLgeneratedText{\NAT@sep}\space}

\def\citeleft{%
    \leavevmode
    \startXMLelement{cite-group}%
    \XMLgeneratedText\NAT@open
}

\def\citeright{%
    \XMLgeneratedText\NAT@close
    \endXMLelement{cite-group}%
}

%% NB: This is just enough to compile spec/plambeck.

%% TODO: This assumes maabook has been loaded.  FIX THIS

\AtBeginDocument{\let\MAA@NAT@wrap\XMLgeneratedText}

\def\hyper@natlinkstart#1{%
    \startXMLelement{xref}%
    \setXMLattribute{rid}{bibr-#1}%
    \setXMLattribute{ref-type}{bibr}%
}

\def\hyper@natlinkend{%
    \endXMLelement{xref}%
}

\def\hyper@natlinkbreak#1#2{#1}

\providecommand\hyper@natanchorstart[1]{}%
\providecommand\hyper@natanchorend{}%

\def\NAT@anchor#1#2{%
    \setXMLattribute{id}{bibr-#1}%
    \hyper@natanchorstart{#1\@extra@b@citeb}%
        \def\@tempa{#2}%
        \@ifx{\@tempa\@empty}{}{\@biblabel{#2}}%
    \hyper@natanchorend
}%

\def\@lbibitem[#1]#2{%
    \if\relax\@extra@b@citeb\relax\else
        \@ifundefined{br@#2\@extra@b@citeb}{}{%
            \@namedef{br@#2}{\@nameuse{br@#2\@extra@b@citeb}}%
        }%
    \fi
    \@ifundefined{b@#2\@extra@b@citeb}{%
        \def\NAT@num{}%
    }{%
        \NAT@parse{#2}%
    }%
    \def\NAT@tmp{#1}%
    \expandafter\let\expandafter\bibitemOpen\csname NAT@b@open@#2\endcsname
    \expandafter\let\expandafter\bibitemShut\csname NAT@b@shut@#2\endcsname
    \@ifnum{\NAT@merge>\@ne}{%
        \NAT@bibitem@first@sw{%
            \@firstoftwo
        }{%
            \@ifundefined{NAT@b*@#2}{%
                \@firstoftwo
            }{%
                \expandafter\def\expandafter\NAT@num\expandafter{\the\c@NAT@ctr}%
                \@secondoftwo
            }%
        }%
    }{%
        \@firstoftwo
    }%
    {%
        \global\advance\c@NAT@ctr\@ne
        \@ifx{\NAT@tmp\@empty}{\@firstoftwo}{%
            \@secondoftwo
        }%
        {%
            \expandafter\def\expandafter\NAT@num\expandafter{\the\c@NAT@ctr}%
            \global\NAT@stdbsttrue
        }{}%
        \bibitem@fin
        \item[\hfil\NAT@anchor{#2}{\NAT@num}]%
        \global\let\NAT@bibitem@first@sw\@secondoftwo
        \NAT@bibitem@init
    }%
    {%
        \NAT@anchor{#2}{}%
        \NAT@bibitem@cont
        \bibitem@fin
    }%
    \@ifx{\NAT@tmp\@empty}{%
        \NAT@wrout{\the\c@NAT@ctr}{}{}{}{#2}%
    }{%
        \expandafter\NAT@ifcmd\NAT@tmp(@)(@)\@nil{#2}%
    }%
}

%% spec/plambeck chapter bibliographies.  This is probably not good
%% enough in general.

\def\biblist@sec@level{1}

\renewenvironment{thebibliography}[1]{%
    % \if@backmatter
    %     \@clear@sectionstack
    % \else
    %     \backmatter
    % \fi
    %% I'm not sure what to do with \bibpreamble or if it should even be
    %% here to begin with, so I'm going to disable it for now.  Ditto
    %% \bibpostamble below.
    % \ifx\@empty\bibpreamble \else
    %     \begingroup
    %         \bibpreamble\par
    %     \endgroup
    % \fi
% \section*{}%
\@pop@sectionstack{\biblist@sec@level}%
    \def\@listelementname{ref-list}%
    \def\@listitemname{ref}%
    % \def\@listlabelname{label}
    \let\@listlabelname\@empty
    \def\@listdefname{mixed-citation}
    \list{%
        \@biblabel{\the\c@NAT@ctr}%
    }{%
        \@bibsetup{#1}%
        \global\c@NAT@ctr\z@
        \@listXMLidtrue
    }%
     \let\NAT@bibitem@first@sw\@firstoftwo
    \let\citeN\cite
    \let\shortcite\cite
    \let\citeasnoun\cite
    \startXMLelement{title}%
    \refname
    \endXMLelement{title}%
    \let\@listpartag\@empty
}{%
    \bibitem@fin
    %% See above
    % \bibpostamble
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

\endinput

__END__
