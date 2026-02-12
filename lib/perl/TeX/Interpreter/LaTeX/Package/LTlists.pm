package TeX::Interpreter::LaTeX::Package::LTlists;

use 5.26.0;

# Copyright (C) 2026 American Mathematical Society
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

# my sub do_set_list_style;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    # $tex->define_csname('TeXML@setliststyle' => \&do_set_list_style);

    $tex->read_package_data();

    return;
}

# my sub do_counter_style {
#     my $tex   = shift;
#     my $token = shift;
# 
#     my $arg = $tex->read_undelimited_parameter();
# 
#     $tex->conv_toks($token);
# 
#     return;
# }
# 
# my %LIST_STYLE_TYPE = (alph   => 'a', # 'lower-alpha',
#                        Alph   => 'A', # 'upper-alpha',
#                        arabic => '1', # 'decimal',
#                        roman  => 'i', # 'lower-roman',
#                        Roman  => 'I', # 'upper-roman',
#                        );
# 
# sub do_set_list_style {
#     my $tex   = shift;
#     my $token = shift;
# 
#     $tex->begingroup();
# 
#     $tex->define_csname('@arabic'   => \&do_counter_style);
#     $tex->define_csname('@roman'    => \&do_counter_style);
#     $tex->define_csname('@Roman'    => \&do_counter_style);
#     $tex->define_csname('@alph'     => \&do_counter_style);
#     $tex->define_csname('@Alph'     => \&do_counter_style);
#     # $tex->define_csname('@fnsymbol' => \&do_counter_style);
# 
#     my $item_label = $tex->convert_fragment('\\csname @itemlabel\\endcsname');
# 
#     $tex->endgroup();
# 
#     if ($item_label =~ m{\A (.*?) (?:\\\@(arabic|roman|alph)) (.*) \z}ismx) {
#         my ($prefix, $list_style, $suffix) = ($1, $2, $3);
# 
#         # $tex->set_xml_attribute('html:type', $LIST_STYLE_TYPE{$list_style});
# 
#         if (nonempty($prefix) || nonempty($suffix)) {
#             my $content = 'counter(counter)';
# 
#             if (nonempty($prefix)) {
#                 $content = qq{'$prefix' } . $content;
#             }
# 
#             if (nonempty($suffix)) {
#                 $content .= qq{ '$suffix'};
#             }
# 
#             # $tex->set_xml_attribute('html:style' => qq{content: $content});
#         }
#     } else {
#         if ($item_label eq "\x{2022}") {
#             # $tex->set_xml_attribute('html:style', qq{list-style-type: disc});
#         } else {
#             # $tex->set_xml_attribute('html:style', qq{list-style-type: '$item_label'});
#         }
#     }
# 
#     return;
# }

1;

__DATA__

\ProvidesPackage{LTlists}

\newif\if@newitem
\@newitemfalse

%% We need a hook to add XML ids to <ref-list>s.  We don't want to add
%% an id to every list environment because in obscure borderline cases
%% where, for example, there is a \label embedded inside an unnumbered
%% list, it could cause the label to resolve to a different location.

\newif\if@listXMLid
\@listXMLidfalse

%%

\newif\if@stdList

\def\@listelementname{def-list}
\def\@listitemname{def-item}
\def\@listlabelname{term}
\def\@listdefname{def}
\let\@listconfig\@empty

%% afterfigureinlist@ should probably be replaced by \texml@inlist@hack@start

\newif\ifafterfigureinlist@
\afterfigureinlist@false

\let\@listpartag\@empty

\newif\if@texml@inlist@
\@texml@inlist@false

% Move to laTeXML.ltx?

\newenvironment{list}[2]{%
    \@@par
    \ifnum \@listdepth >5\relax
        \@toodeep
    \else
        \global\advance\@listdepth\@ne
    \fi
    \@texml@inlist@true
    \global\@newitemfalse
    \def\@itemlabel{#1}%
    \let\makelabel\@mklab
    \@nmbrlistfalse
    \@listXMLidfalse
    \@stdListtrue
    #2\relax
    %% The setting of listpartag probably still isn't robust enough.
    \edef\@tempa{\the\xmlpartag}%
    \ifx\@tempa\@empty
        \def\@listpartag{p}%
    \else
        \let\@listpartag\@tempa
    \fi
    \xmlpartag{}%
    \ifx\@listelementname\@empty\else
        \startXMLelement{\@listelementname}%
        \setXMLattribute{content-type}{\@currenvir}%
        \if@listXMLid
            \addXMLid
        \fi
    \fi
    \def\@currentreftype{list}%
    \def\@currentrefsubtype{item}%
    \@listconfig
    \global\@newlisttrue
    \afterfigureinlist@false
}{%
    \@@par
    \if@newlist\else
        \ifafterfigureinlist@
        \else
            \list@endpar
        \fi
        \ifx\@listitemname\@empty\else
            \ifx\@listdefname\@empty\else
                \endXMLelement{\@listdefname}%
            \fi
            \endXMLelement{\@listitemname}%
        \fi
    \fi
    \ifx\@listelementname\@empty\else
        % \if@stdList
        %     \TeXML@setliststyle
        % \fi
        \endXMLelement{\@listelementname}%
    \fi
    \global\advance\@listdepth\m@ne
}

\def\list@beginpar{%
    \ifx\@listpartag\@empty\else
        \startXMLelement{\@listpartag}%
    \fi
}

\def\list@endpar{%
    \ifx\@listpartag\@empty\else
        \endXMLelement{\@listpartag}%
    \fi
}

\def\@mklab#1{%
    \gdef\list@item@init{%
        \ifx\@listlabelname\@empty\else
            \startXMLelement{\@listlabelname}%
        \fi
        {#1}% Braces handle abominations like \item[\bf 1.]
        \ifx\@listlabelname\@empty\else
            \endXMLelement{\@listlabelname}
        \fi
        \ifx\@listdefname\@empty\else
            \startXMLelement{\@listdefname}%
        \fi
    }%
}

\def\item{%
    \@inmatherr\item
    \@ifnextchar [{\@stdListfalse\@item}{\@noitemargtrue \@item[\@itemlabel]}%
}

\def\@item[#1]{%
    \ifafterfigureinlist@
        \ifafterfigureinlist@
            \global\afterfigureinlist@false
        \else
            \list@endpar
        \fi
        \list@beginpar
    \fi
    \@@par
    \if@newlist
        \global\@newlistfalse
    \else
        \list@endpar
        \ifx\@listitemname\@empty\else
            \ifx\@listdefname\@empty\else
                \endXMLelement{\@listdefname}%
            \fi
            \endXMLelement{\@listitemname}%
        \fi
    \fi
    \global\@newitemtrue
    \if@noitemarg
        \if@nmbrlist
            \refstepcounter\@listctr
        \fi
    \fi
    \stepXMLid
    \makelabel{#1}%
    \everypar{\list@everypar}%
    \ignorespaces
}

\let\list@item@init\@empty

\def\list@everypar{%
    \if@newitem
        \global\@newitemfalse
        \ifx\@listitemname\@empty\else
            \startXMLelement{\@listitemname}%
            \setXMLattribute{id}{\@currentXMLid}%
            \list@item@init
            \global\let\list@item@init\@empty
        \fi
    \else
        \ifafterfigureinlist@
            \global\afterfigureinlist@false
        \else
            \list@endpar
        \fi
    \fi
    \list@beginpar
    \@noitemargfalse
}

%% See, for example, amsthm.pm.  This should be used in other places
%% as well (floats, etc.)

\def\texml@inlist@hack@start{%
    \ifinXMLelement{def-list}%
        \ifinXMLelement{def-item}%
            \ifinXMLelement{def}%
                \ifinXMLelement{p}%
                    \list@endpar
                \else%
                    % NO-OP
                \fi
            \else%
                \list@everypar\list@endpar
            \fi
        \else%
            \list@everypar\list@endpar
        \fi
        \par
    \else
        % NO-OP
    \fi
    %
}

\def\texml@inlist@hack@end{%
    \ifinXMLelement{def-item}%
        \list@beginpar
    \fi
}

\renewenvironment{itemize}{%
    \if@newitem\leavevmode\fi
    \ifnum \@itemdepth >\thr@@
        \@toodeep
    \else
        \advance\@itemdepth\@ne
        \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
        \expandafter\list
            \csname\@itemitem\endcsname{}%
    \fi
}{%
    \endlist
}

\SaveEnvironmentDefinition{itemize}

\renewenvironment{enumerate}{%
    \if@newitem\leavevmode\fi
    \ifnum \@enumdepth >\thr@@
        \@toodeep
    \else
        \advance\@enumdepth\@ne
        \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
        \expandafter\list
            \csname label\@enumctr\endcsname{%
                \usecounter\@enumctr
            }%
    \fi
}{%
    \endlist
}

\SaveEnvironmentDefinition{enumerate}

\endinput

__END__
