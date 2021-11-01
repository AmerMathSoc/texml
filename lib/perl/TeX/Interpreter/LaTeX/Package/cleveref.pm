package TeX::Interpreter::LaTeX::Package::cleveref;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # Hide hyperref from cleveref so it doesn't try to implement it's
    # own linking.

    my $ver_hyperref = $tex->get_macro_expansion_text('ver@hyperref.sty');

    $tex->let_csname('ver@hyperref.sty' => '@undefined');

    $tex->load_latex_package("cleveref", @options);

    $tex->define_macro('ver@hyperref.sty', undef, $ver_hyperref);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::cleveref::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{cleveref}

\AtBeginDocument{%
    \def\label@noarg#1{%
        \@bsphack
            \cref@old@label{#1}%
            \begingroup
                \let\ref\relax
                \protected@edef\@tempa{%
                    \noexpand\newlabel{#1@cref}{%
                        {\cref@currentlabel}%
                        {\thepage}%
                    }%
                }%
            \expandafter\endgroup
            \@tempa
        \@esphack
    }%
    \def\label@optarg[#1]#2{%
        \@bsphack
            \cref@old@label{#2}%
            \begingroup
                \protected@edef\cref@currentlabel{%
                    \expandafter\cref@override@label@type\cref@currentlabel\@nil{#1}%
                }%
                \protected@edef\@tempa{%
                    \noexpand\newlabel{#1@cref}{%
                        {\cref@currentlabel}%
                        {\thepage}%
%                        {}%
%                        {}%
                }%
                }%
            \expandafter\endgroup
            \@tempa
        \@esphack
    }%
}

\def\@setcref#1#2#3{%
    \startXMLelement{xref}%
    \if@TeXMLend
        \@ifundefined{r@#1}{%
            \setXMLattribute{specific-use}{undefined}%
            \texttt{?#1}%
        }{%
            \cref@gettype{#1}{\@temptype}% puts label type in \@temptype
            \@ifundefined{#2@\@temptype @format#3}{%
                \edef\@tempa{#2}%
                \def\@tempb{labelcref}%
                \ifx\@tempa\@tempb\def\@temptype{default}\fi
            }{}%
            \@ifundefined{#2@\@temptype @format#3}{%
                \@latex@warning{#2 \space reference format for label type
                    `\@temptype' undefined}%
                \setXMLattribute{specific-use}{undefined}%
                \texttt{?#3}%
            }{%
                \edef\@tempa{\@nameuse{r@#1}}%
                \setXMLattribute{specific-use}{#2}%
                \setXMLattribute{rid}{\expandafter\@thirdoffour\@tempa}%
                \setXMLattribute{ref-type}{\expandafter\@fourthoffour\@tempa}%
                \setXMLattribute{ref-label}{\@temptype}%
                \expandafter\@@setcref\expandafter
                    {\csname #2@\@temptype @format#3\endcsname}{#1}%
            }%
        }%
    \else
        \setXMLattribute{ref-key}{#1}%
        \setXMLattribute{specific-use}{unresolved #2}%
    \fi
    \endXMLelement{xref}%
}

\TeXMLendPackage

\endinput

__END__
