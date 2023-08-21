package TeX::Interpreter::LaTeX::Package::amsthm;

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

use TeX::Constants qw(:named_args);

use TeX::Token qw(:factories);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Token qw(:catcodes);

my %FONT_STYLE = (
    rmfamily => { "font-family" => "serif" },
    sffamily => { "font-family" => "sans-serif" },
    ttfamily => { "font-family" => "monospace" },
    bfseries => { "font-weight" => "bold" },
    mdseries => { "font-weight" => "normal" },
    upshape  => { "font-style" => "normal" },
    slshape  => { "font-style" => "oblique" },
    scshape  => { "font-variant" => "small-caps" },
    itshape  => { "font-style" => "italic" },
    em       => { "font-style" => "italic" },
    );

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro(newtheorem      => \&do_newtheorem);
    $tex->define_pseudo_macro(newtheoremstyle => \&do_newtheoremstyle);

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
        $the_def .= qq{\\providecommand{\\${env_name}autorefname}{$theorem_label}\n};

        $the_def .= qq{\\amsthm\@cref\@init{$env_name}{$theorem_label}%};

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

    $the_def .= qq{\\global\\\@namedef{${env_name}}{\\\@begintheorem{$theorem_style}{$theorem_label}{$ctr_name}}%\n};

    $the_def .= qq{\\global\\expandafter\\let\\csname end${env_name}\\endcsname\\\@endtheorem\n};

    # $tex->__DEBUG(qq{the_def = "$the_def"});

    $tex->begingroup();

    $tex->set_catcode(ord '@', CATCODE_LETTER);

    my $tokenized = $tex->tokenize($the_def);

    $tex->endgroup();

    return $tokenized;
}

sub do_newtheoremstyle {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $style_name  = $tex->read_undelimited_parameter(EXPANDED);

    my $above_space = $tex->read_undelimited_parameter();
    my $below_space = $tex->read_undelimited_parameter();
    my $body_font   = $tex->read_undelimited_parameter();
    my $indent      = $tex->read_undelimited_parameter();
    my $head_font   = $tex->read_undelimited_parameter();
    my $head_punct  = $tex->read_undelimited_parameter();
    my $head_sep    = $tex->read_undelimited_parameter();
    my $head_spec   = $tex->read_undelimited_parameter();

    my %body_style = ( "font-style" => "normal" );

    for my $token (@{ $body_font }) {
        if ($token == CATCODE_CSNAME) {
            my $csname = $token->get_csname();

            if (defined (my $style = $FONT_STYLE{$csname})) {
                %body_style = (%body_style, %{ $style });
            }
        }
    }

    my $body_style = join "; ", map { "$_: $body_style{$_}" } keys %body_style;

    return $tex->tokenize(qq{\\expandafter\\def\\csname th\@${style_name}\\endcsname{\\csname thm\@headpunct\\endcsname{$head_punct}}});
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

% #1    theorem style
% #2    theorem name
% #3    theorem counter

\def\@begintheorem#1#2#3{\@oparg{\@begintheorem@{#1}{#2}{#3}}[]}

\def\@begintheorem@#1#2#3[#4]{
    \everypar{}\par
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{theorem \@currenvir}%
    \setXMLattribute{style}{thm#1}%
    \addXMLid
    \def\@currentreftype{statement}%
    \edef\@currentrefsubtype{\@currenvir}%
    %%
    %% Inside lists, \xmlpartag is turned off, so we need to make
    %% sure to turn it back on.  Cf. car-brown2.  TBD: Can we
    %% insert the equivalent of a \leavevmode here somewhere?
    %%
    \xmlpartag{p}%
    %%
    \thisxmlpartag{label}%
    #2%
    %
    \if###3##\else
        \refstepcounter{#3}%
        \space\@nameuse{the#3}%
    \fi
    \par
    \if###4##\else
        \thisxmlpartag{title}%
        (#4)\par
    \fi
    \@nameuse{th#1}%
    \par
    \everypar{\setXMLattribute{content-type}{noindent}\everypar{}}%
    \ignorespaces
}

\def\@endtheorem{%
    \par
    \endXMLelement{statement}%
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
    \startXMLelement{statement}%
    \setXMLattribute{content-type}{proof \@currenvir}
    \par
    \thisxmlpartag{title}
    #1%
    \par
}

\def\endproof{%
    \par
    \popQED
    \endXMLelement{statement}%
}

\endinput

__END__
