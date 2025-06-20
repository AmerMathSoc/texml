package TeX::Interpreter::LaTeX::Package::amsthm;

use 5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use TeX::Constants qw(:named_args);

use TeX::Token qw(:factories);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Token qw(:catcodes);

my sub normalize_statements;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&normalize_statements);

    $tex->read_package_data();

    $tex->define_pseudo_macro(newtheorem => \&do_newtheorem);

    return;
}

sub normalize_statements {
    my $xml = shift;

    my $dom = $xml->get_dom();

    ## Proofs nested within their theorems cause UI problems in the
    ## AMS MathViewer, so we unnest them.  Arguably this should be
    ## done in the MathViewer-specific part of the toolchain.

    for my $theorem ($dom->findnodes("/descendant::statement[contains(\@content-type, 'theorem')]")) {
        my @proofs = $theorem->findnodes("statement[contains(\@content-type,'proof')]");

        for (my $i = 0; $i < @proofs; $i++) {
            my $proof = $proofs[$i];

            ## Only move the proof if it is the last element in the
            ## statement.  This weeds out cases such as jams447 or
            ## jams893, which have a theorem and its proof embedded
            ## inside a remark or an example.

            next if defined $proof->nextNonBlankSibling();

            my $comment_1 = XML::LibXML::Comment->new(" Proof #$i was here ");
            my $comment_2 = XML::LibXML::Comment->new(" Proof #$i moved here ");

            $theorem->replaceChild($comment_1, $proof);

            my $first = $proof->firstChild();

            $proof->insertBefore($comment_2, $first);

            my $parent = $theorem->parentNode();

            if (defined(my $sibling = $theorem->nextSibling())) {
                $parent->insertBefore($proof, $sibling);
            } else {
                $parent->insertBefore($proof, undef);
            }

            # $theorem->addSibling($proof);
        }
    }

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

sub do_newtheorem {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $numbered = ! $tex->is_starred();

    my $env_name  = $tex->read_undelimited_parameter(EXPANDED);

    $tex->ignorespaces();

    my $sibling_ctr   = $tex->scan_optional_argument();

    my $theorem_label = $tex->read_undelimited_parameter();

    $tex->ignorespaces();

    my $parent_ctr = $tex->scan_optional_argument();

    my $the_def;

    my $ctr_name = '';

    if ($numbered) {
        $the_def .= qq{\\expandafter\\providecommand\\csname ${env_name}autorefname\\endcsname{$theorem_label}\n};

        $the_def .= qq{\\amsthm\@cref\@init{$env_name}{$theorem_label}%\n};

        $ctr_name = $env_name;

        if ($sibling_ctr) {
            $ctr_name = $sibling_ctr;

            $the_def .= sprintf('\global\@namedef{the%s}{\csname the%s\endcsname}%%',
                               $env_name,
                               $sibling_ctr);

            $the_def .= "\n";
        } else {
            my $ctr_def = qq{\\newcounter{$ctr_name}\n};

            if ($parent_ctr) {
                $ctr_def .= qq{[$parent_ctr]};

                $ctr_def .= sprintf('\global\@namedef{the%s}{\csname the%s\endcsname.\arabic{%s}}%%',
                                   $ctr_name,
                                   $parent_ctr,
                                   $ctr_name);
            } else {
                $ctr_def .= sprintf('\global\@namedef{the%s}{\arabic{%s}}%%',
                                   $ctr_name,
                                   $ctr_name);
            }

            $the_def .= qq{$ctr_def\n};
        }
    }

    my $theorem_style = $tex->get_toks_list('thm@style');

    my $thm_swap = $tex->expansion_of('thm@swap') || 'N';

    $the_def .= qq{\\global\\\@namedef{${env_name}}{\\\@begintheorem{$thm_swap}{$theorem_style}{$theorem_label}{$env_name}{$ctr_name}}%\n};

    $the_def .= qq{\\global\\expandafter\\let\\csname end${env_name}\\endcsname\\\@endtheorem\n};

    # $tex->__DEBUG(qq{the_def = "$the_def"});

    $tex->begingroup();

    $tex->set_catcode(ord '@', CATCODE_LETTER);

    my $tokenized = $tex->tokenize($the_def);

    $tex->endgroup();

    return $tokenized;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{amsthm}

\providecommand{\amsthm@cref@init}{\@gobbletwo}

\newtoks\thm@style

\let\swapnumbers\@empty

\def\theoremstyle#1{\thm@style{#1}}

\theoremstyle{plain}

\newtoks\thm@headpunct

\def\th@plain{\thm@headpunct{.}}
\def\th@definition{\thm@headpunct{.}}
\def\th@remark{\thm@headpunct{.}}

\newcommand{\newtheoremstyle}[9]{%
    \expandafter\def\csname th@#1\endcsname{\thm@headpunct{#7}}%
}

\def\refstepcounter@cref[#1]#2{%
    \refstepcounter{#2}%
}

\def\swapnumbers{\edef\thm@swap{\if S\thm@swap N\else S\fi}}
\def\thm@swap{N}%

% #1    theorem style
% #2    theorem prefix
% #3    env name
% #4    theorem counter
% #5    title (optional)

\def\@begintheorem#1#2#3#4#5{\@oparg{\@begintheorem@{#1}{#2}{#3}{#4}{#5}}[]}

\def\@begintheorem@#1#2#3#4#5[#6]{
    \everypar{}\par
    \texml@inlist@hack@start
    \xmlpartag{p}
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{theorem \@currenvir}%
    \setXMLattribute{style}{thm#2}%
    \addXMLid
    \def\@currentreftype{statement}%
    \edef\@currentrefsubtype{\@currenvir}%
    \@nameuse{th@#2}%
    %%
    %% Inside lists, \xmlpartag is turned off, so we need to make
    %% sure to turn it back on.  Cf. car-brown2.  TBD: Can we
    %% insert the equivalent of a \leavevmode here somewhere?
    %%
    \xmlpartag{p}%
    %%
    \thisxmlpartag{label}%
    \if S#1%
        \if###5##\else
            \refstepcounter@cref[#4]{#5}%
            \@nameuse{the#4}%
        \fi
        %
        #3%
    \else
        #3%
        %
        \if###5##\else
            \refstepcounter@cref[#4]{#5}%
            \space\@nameuse{the#4}%
        \fi
    \fi
    \if###6##\XMLgeneratedText{\the\thm@headpunct}\fi
    \par
    \if###6##\else
        \begingroup
        \xmlpartag{}%
        \startXMLelement{title}%
            \XMLgeneratedText(#6\XMLgeneratedText)%
            \XMLgeneratedText{\the\thm@headpunct}\par
            \endXMLelement{title}\par
        \endgroup
    \fi
    \par
    \everypar{}%
    \ignorespaces
}

\def\@endtheorem{%
    \par
    \endXMLelement{statement}%
    \texml@inlist@hack@end
}

\let\QED@stack\@empty

\let\qed@elt\relax

\def\pushQED#1{%
    \toks@{\qed@elt{#1}}%
    \@temptokena\expandafter{\QED@stack}%
    \xdef\QED@stack{\the\toks@\the\@temptokena}%
}

\def\popQED{%
    \begingroup
        \let\qed@elt\popQED@elt
        \QED@stack\relax\relax
    \endgroup
}

\def\popQED@elt#1#2\relax{#1\gdef\QED@stack{#2}}

\def\qedhere{%
    \begingroup
        \let\mathqed\math@qedhere
        \let\qed@elt\setQED@elt
        \QED@stack\relax\relax
    \endgroup
}

\newif\iffirstchoice@
\firstchoice@true

\def\setQED@elt#1#2\relax{%
    \ifmeasuring@\else
        \iffirstchoice@ \gdef\QED@stack{\qed@elt{}#2}\fi
    \fi
    #1%
}

\let\qed\relax

% \square isn't exactly right, but we don't actually care; all that
% matters is that \qedsymbol isn't empty.
\providecommand{\qedsymbol}{\square}

\def\noqed{\let\qedsymbol\relax}

\DeclareRobustCommand{\qed}{%
    \ifx\qedsymbol\relax\else
        \edef\@tempa{\qedsymbol}%
        \ifx\@tempa\@empty\else
            \setXMLattribute{has-qed-box}{true}%
        \fi
    \fi
    % \ifmmode
    %     \mathqed
    % \else
    %     \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill
    %     \quad\hbox{\qedsymbol}%
    % \fi
}

% \newcommand{\mathqed}{\quad\hbox{\qedsymbol}}

\providecommand{\proofname}{Proof}

\def\proof{\@ifnextchar[\@proof{\@proof[\proofname]}}

\def\@proof[#1]{%
    \par
    \everypar{}%
    \pushQED{\qed}%
    \texml@inlist@hack@start
    \xmlpartag{p}
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{proof \@currenvir}
    \par
    \begingroup
        \xmlpartag{}%
        \startXMLelement{title}%
        #1\@addpunct{.}%
        \endXMLelement{title}\par%
    \endgroup
    \par
}

\def\endproof{%
    \par
    \popQED
    \endXMLelement{statement}%
    \texml@inlist@hack@end
}

\endinput

__END__
