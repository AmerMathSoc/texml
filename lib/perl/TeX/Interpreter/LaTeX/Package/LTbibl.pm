package TeX::Interpreter::LaTeX::Package::LTbibl;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use List::Util qw(all);

use TeX::Token qw(:factories);

use TeX::Utils::Misc qw(pluralize);

my sub do_sort_cites;
my sub do_resolve_cites;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&do_resolve_cites, 1); # Same level as do_resolve_xrefs

    $tex->add_output_hook(\&do_sort_cites, 2);

    $tex->read_package_data();

    return;
}

sub do_resolve_cites {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    return unless $tex->if('TeXML@resolveXMLxrefs@');

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    $tex->print_nl("Resolving \\cite's");

    my $num_cites = 0;

    my $pass = 0;

    while (my @cites = $body->findnodes(qq{descendant::xref[starts-with(attribute::specific-use, "unresolved cite")]})) {
        if (++$pass > 10) {
            $tex->print_nl("resolve_cites: Bailing on pass number $pass");

            last;
        }

        for my $xref (@cites) {
            (undef, my $cite_cmd) = split / /, $xref->getAttribute('specific-use');

            next unless $cite_cmd eq 'cite';

            # Disable 'bysame' processing for amsrefs.
            $tex->define_simple_macro('prev@names', "");

            (my $key = $xref->getAttribute("rid")) =~ s{^bibr-}{b\@};

            my $token = make_csname_token($key);

            if (defined $tex->expansion_of($key)) {
                my $token_list = TeX::TokenList->new({ tokens => [ $token ] });

                my $label = $tex->convert_token_list($token_list);

                ## TODO: Why doesn't this work?  \csname not working?
                # my $label = $tex->convert_fragment(qq{\\csname $key \\endcsname});

                if (defined $label && $label->hasChildNodes()) {
                    $xref->setAttribute('specific-use', 'cite');

                    my $first = $xref->firstChild();

                    $xref->replaceChild($label, $first);

                    $num_cites++;
                }
            }
        }
    }

    my $cites = pluralize("cite", $num_cites);

    $tex->print_nl("Resolved $num_cites $cites");

    # $tex->print_ln();

    my @cites = $body->findnodes(qq{descendant::xref[attribute::specific-use="unresolved cite"]});

    if (@cites) {
        $tex->print_nl("Unable to resolve the following cites:");

        for my $cite (@cites) {
            $tex->print_nl("    $cite");
        }
    }

    return;
}

sub do_sort_cites {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    return unless $tex->if('TeXMLsortcites@');

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my @groups = $body->findnodes(qq{descendant::cite-group});

    $tex->print_nl("Sorting cite groups");

    my $num_sorted = 0;

    my sub __extract_cite_label {
        my $xref_node = shift;

        my $label = $xref_node->firstChild();

        return "$label" + 0;
    }

    for my $cite_group (@groups) {
        my @xrefs = $cite_group->findnodes(qq{descendant::xref});

        next if @xrefs < 2;

        my @labels = map { $_->firstChild() } @xrefs;

        return unless all { m{^\d+$} } @labels;

        my @new = map { [ __extract_cite_label($_), $_->cloneNode(1) ] } @xrefs;

        my @sorted = sort { $a->[0] <=> $b->[0] } @new;

        for (my $i = 0; $i < @new; $i++) {
            $xrefs[$i]->replaceNode($sorted[$i]->[1]);
        }

        $num_sorted++;
    }

    $tex->print_ln();

    $tex->print_nl(sprintf "Sorted %d cite group%s",
                   $num_sorted,
                   $num_sorted == 1 ? "" : "s"
        );

    return;
}

1;

__DATA__

\ProvidesPackage{LTbibl}

\newif\ifTeXMLsortcites@
\TeXMLsortcites@false

\def\TeXMLsortCites{\TeXMLsortcites@true}
\def\TeXMLnoSortCites{\TeXMLsortcites@false}

%% Standard LaTeX two-pass cycle:
%%
%% FIRST PASS: (K = key, L = label)
%%
%%     \cite{K}       writes \citation{K} to aux file; calls \@cite@ofmt
%%     \@cite@ofmt    typesets \textbf{?}
%%
%%     \bibitem[L]{K} writes \bibcite{K}{L} to aux file
%%                    does *not* define \b@K
%%
%%  SECOND PASS:
%%
%%  Read aux file:
%%      \citation{K} ->     % no-op
%%      \bibcite{K}{L} -> \def\b@K{L}
%%
%%  In document:
%%
%%      \cite{K}    typsets \b@K    % in \@cite@ofmt

%% TeXML one-pass algorithm:
%%
%%     \cite{K}       writes \citation{K} to aux file; calls \@cite@ofmt
%%     \@cite@ofmt    creates <xref> element with
%%                    -- @rid = bibr-K
%%                    -- @ref-type = bibr
%%                    -- @specific-use = 'unresolved cite'
%%                    -- contents \texttt{?K}
%%                    (if \b@K already defined, then @specific-use = 'cite'
%%                    and contents = \b@K)
%%
%%     \bibitem[L]{K} writes \bibcite{K}{L} to aux file
%%                    *and* defines \b@K immediately
%%
%%     \enddocument   invokes do_resolve_cites(), which cycles through
%%                    all xref nodes with @specific-use = 'unresolved
%%                    cite' and, if \b@K is defined, replaces
%%                    the contents of the node by \b@K and resets
%%                    @specific-use = 'cite'.

\def\citeleft{%
    \leavevmode
    \startXMLelement{cite-group}%
    \XMLgeneratedText[%
}

\def\citeright{%
    \XMLgeneratedText]%
    \endXMLelement{cite-group}%
}

\def\citemid{\XMLgeneratedText{,\space}}

%% Changes \@cite@ofmt need to be coordinated with changes to
%% \format@jats@cite in amsrefs.pm

%% NB: Downstream assumes that no <x> element will appear as a direct
%% child of this <xref>.

\def\@cite@ofmt#1#2{%
    \begingroup
        \edef\@tempa{\expandafter\@firstofone#1\@empty}%
        \if@filesw\immediate\write\@auxout{\string\citation{\@tempa}}\fi
            \startXMLelement{xref}%
                \setXMLattribute{rid}{bibr-\@tempa}%
                \setXMLattribute{ref-type}{bibr}%
                \@ifundefined{b@\@tempa}{%
                    \setXMLattribute{specific-use}{unresolved cite}%
                    \texttt{?\@tempa}%
                }{%
                    \setXMLattribute{specific-use}{cite}%
                    \csname b@\@tempa\endcsname
                }%
                \@ifnotempty{#2}{%
                    \startXMLelement{cite-detail}%
                    \citemid#2%
                    \endXMLelement{cite-detail}%
                }%
            \endXMLelement{xref}%
    \endgroup
}

\PreserveMacroDefinition\@cite@ofmt

\def\@citex[#1]#2{%
    \leavevmode
    \citeleft
    \begingroup
        \let\@citea\@empty
        \@for\@citeb:=#2\do{%
            \ifx\@citea\@empty\else
                \@cite@ofmt\@citea{}%
                \citemid
            \fi
            \let\@citea\@citeb
        }%
        \ifx\@citea\@empty\else
            \@cite@ofmt\@citea{#1}%
        \fi
    \endgroup
    \citeright
}

\PreserveMacroDefinition\@citex

\def\@biblabel#1#2{%
    \typeout{Processing \string\@biblabel{#1}{#2}}%
    \setXMLattribute{id}{bibr-#2}%
    \startXMLelement{label}\XMLgeneratedText[#1\XMLgeneratedText]\endXMLelement{label}%
}

\PreserveMacroDefinition\@biblabel

%% For compatibility with amsrefs, we don't write \bibcite to the .aux
%% file.

\def\@lbibitem[#1]#2{%
    \item[\@biblabel{#1}{#2}]\leavevmode
    \bibcite{#2}{#1}%
    % \if@filesw
    %     \begingroup
    %         \let\protect\noexpand
    %         \immediate\write\@auxout{\string\bibcite{#2}{#1}}%
    %     \endgroup
    % \fi
    \ignorespaces
}

\def\@bibitem#1{%
    \item[\refstepcounter{enumiv}\@biblabel{\theenumiv}{#1}]\leavevmode
    \bibcite{#1}{\the\value{\@listctr}}%
    % \if@filesw
    %     \immediate\write\@auxout{\string\bibcite{#1}{\the\value{\@listctr}}}%
    % \fi
    \ignorespaces
}

\endinput

__END__
