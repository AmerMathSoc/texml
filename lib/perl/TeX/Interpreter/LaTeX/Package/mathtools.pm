package TeX::Interpreter::LaTeX::Package::mathtools;

use 5.26.0;

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

use TeX::Utils::Misc qw(nonempty);

my sub do_showonlyrefs;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    # showonlyrefs needs to run before LTref::do_resolve_xrefs
    $tex->add_output_hook(\&do_showonlyrefs, 0);

    $tex->read_package_data();

    return;
}

sub do_showonlyrefs {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my @tags = $body->findnodes(q{descendant::tag[@SOR_key]});

    return unless @tags;

    $tex->print_nl("Tagging referenced equations");

    $tex->convert_fragment(qq{\\setcounter{equation}{0}});

    for my $tag (@tags) {
        my $key = $tag->getAttribute('SOR_key');

        if ($key =~ m{^set (.+) (\d+)$}) {
            $tex->convert_fragment(qq{\\setcounter{$1}{$2}});

            $tag->unbindNode();
        }
        elsif ($key eq 'SUBEQUATION_START') {
            $tex->convert_fragment(q{\begingroup \csname subequation@start\endcsname}, undef, 1);

            $tag->unbindNode();
        }
        elsif ($key eq 'SUBEQUATION_END') {
            $tex->convert_fragment(q{\csname subequation@end\endcsname\endgroup}, undef, 1);

            $tag->unbindNode();
        } elsif (defined $tex->expansion_of(qq{MT_r_$key})) {
            if (nonempty(my $counter = $tag->getAttribute('SOR_counter'))) {
                $tex->convert_fragment(qq{\\refstepcounter{$counter}}, undef, 1);

                $tag->removeAttribute('SOR_counter');
            }

            if (nonempty(my $label = $tag->getAttribute('SOR_label'))) {
                my $xml_id = $tag->getAttribute('SOR_id');

                $tag->removeAttribute('SOR_id');

                my $text = $tex->convert_fragment($label);

                $tag->appendChild($text);

                $tag->removeAttribute('SOR_label');

                $tex->convert_fragment(qq{\\csname SOR\@relabel\\endcsname{$key}{$xml_id}{$label}});
            }

            my $x = $tag->removeAttribute('SOR_key');
        } else {
            $tag->unbindNode();
        }
    }

    return;
}

1;

__DATA__

\ProvidesPackage{mathtools}

\LoadRawMacros

\MHInternalSyntaxOff % \AtEndOfPackage not working

\MHInternalSyntaxOn

\renewcommand*\MT_showonlyrefs_true:{
    \MH_if_boolean:nF {show_only_refs}{
        \MH_set_boolean_T:n {show_only_refs}

        %% Save original definitions:

        % \MH_let:NwN \MT_maketag:n             \maketag@@@
        % \MH_let:NwN \MT_prev_tagform:n        \tagform@
        % \MH_let:NwN \MT_eqref:n               \eqref
        % \MH_let:NwN \MT_refeq:n               \refeq

        \MH_let:NwN \MT_incr_eqnum:           \incr@eqnum
        \MH_let:NwN \MT_array_parbox_restore: \@arrayparboxrestore
        \MH_let:NwN \MT_output_raw_tag:       \output@raw@tag@

        \MH_let:NwN \MT_subequation_start: \subequation@start
        \MH_let:NwN \MT_subequation_end:   \subequation@end

        \MH_let:NwN \MT_setcounter:nn   \setcounter
        \MH_let:NwN \MT_addtocounter:nn \addtocounter
        \MH_let:NwN \MT_stepcounter:n   \stepcounter
        \MH_let:NwN \MT_label:n         \ltx@label

        %% Install modified definitions:

        % \MH_let:NwN \maketag@@@ \MT_extended_maketag:n
        % \def\tagform@##1{\MT_extended_tagform:n {##1}}
        % \MH_let:NwN \eqref      \MT_extended_eqref:n
        % \MH_let:NwN \refeq      \MT_extended_refeq:n

        \MH_let:NwN \incr@eqnum \@empty

        \@xp\def\@xp\@arrayparboxrestore\@xp{%
            \@arrayparboxrestore
            \MH_let:NwN \incr@eqnum \@empty
        }

        \@xp\def\@xp\subequation@start\@xp{%
            \subequation@start
            \subequation@start@SOR
        }

        \@xp\def\@xp\subequation@end\@xp{%
            \subequation@end
            \subequation@end@SOR
        }

        \MH_let:NwN \output@raw@tag@ \output@raw@tag@SOR
        \MH_let:NwN \setcounter      \setcounter@SOR
        \MH_let:NwN \addtocounter    \addtocounter@SOR

        \def\stepcounter##1{%
            \MT_stepcounter:n{##1}%
            \save@counter@SOR{##1}%
        }

        \MH_let:NwN \ltx@label       \@gobble
    }
}

\def\MT_showonlyrefs_false: {
    \MH_if_boolean:nT {show_only_refs}{
        \MH_set_boolean_F:n {show_only_refs}

        % \MH_let:NwN \maketag@@@          \MT_maketag:n
        % \MH_let:NwN \tagform@            \MT_prev_tagform:n
        % \MH_let:NwN \eqref               \MT_eqref:n
        % \MH_let:NwN \refeq               \MT_refeq:n

        \MH_let:NwN \incr@eqnum          \MT_incr_eqnum:
        \MH_let:NwN \@arrayparboxrestore \MT_array_parbox_restore:
        \MH_let:NwN \output@raw@tag@     \MT_output_raw_tag:

        \MH_let:NwN \subequation@start   \MT_subequation_start:
        \MH_let:NwN \subequation@end     \MT_subequation_end:

        \MH_let:NwN \setcounter   \MT_setcounter:nn
        \MH_let:NwN \addtocounter \MT_addtocounter:nn
        \MH_let:NwN \stepcounter  \MT_stepcounter:n
        \MH_let:NwN \ltx@label    \MT_label:n
    }
}

\MHInternalSyntaxOff

\def\SOR@relabel#1#2#3{%
    \begingroup
        \def\@currentreftype{disp-formula}%
        \def\@currentrefsubtype{equation}%
        \def\@currentXMLid{#2}%
        \def\@currentlabel{#3}%
        % \expandafter\let\csname r@#1\endcsname\undefined
        \label{#1}%
    \endgroup
}

\def\save@counter@SOR#1{%
    \startXMLelement{tag}%
        \setXMLattribute{SOR_key}{set #1 \the\value{#1}}%
    \endXMLelement{tag}%
}

\def\setcounter@SOR#1#2{%
    \@ifundefined{c@#1}%
        {\@nocounterr{#1}}%
        {\global\csname c@#1\endcsname#2\relax\save@counter@SOR{#1}}%
}

\def\addtocounter@SOR#1#2{%
    \@ifundefined{c@#1}%
        {\@nocounterr{#1}}%
        {\global\advance\csname c@#1\endcsname #2\relax\save@counter@SOR{#1}}%
}

\def\output@raw@tag@SOR#1{%
    \ifx\df@label\@empty\else
        \setXMLattribute{SOR_key}{\df@label}%
        \ifx\theequation#1%
            \setXMLattribute{SOR_counter}{equation}%
            \setXMLattribute{SOR_label}{\string\theequation}%
            \setXMLattribute{SOR_id}{\@currentXMLid}%
        \else
            \setXMLattribute{SOR_label}{#1}%
            \setXMLattribute{SOR_id}{\@currentXMLid}%
        \fi
    \fi
}

\def\subequation@start@SOR{%
    \startXMLelement{tag}%
        \setXMLattribute{SOR_key}{SUBEQUATION_START}%
    \endXMLelement{tag}%
}

\def\subequation@end@SOR{%
    \startXMLelement{tag}%
        \setXMLattribute{SOR_key}{SUBEQUATION_END}%
    \endXMLelement{tag}%
}

\AtBeginDocument{%
    \def\coloneqq{\coloneq}
}

% \let\noeqref\@gobble

\renewcommand\noeqref[1]{%
    \@bsphack
    \@for\@tempa:=#1\do{%
        \@safe@activestrue%
        \edef\@tempa{\expandafter\@firstofone\@tempa}%
        % \@ifundefined{r@\@tempa}{%
        %     \protect\G@refundefinedtrue%
        %     \@latex@warning{Reference `\@tempa' on page \thepage \space undefined (\string\noeqref)}%
        % }{}%
        \global\@namedef{MT_r_\@tempa}{\@tempa}%
        % \if@filesw
        %     \protected@write\@auxout{}{\string\MT@newlabel{\@tempa}}%
        % \fi
        \@safe@activesfalse
    }
    \@esphack
}

%% TBD: \usetagform

\let\adjustlimits\@empty

\let\smashoperator\@gobbleopt

% I don't think there's a good way to emulate this.

\def\vdotswithin#1{\ensuremath{\vdots}}

% Meh.

\renewcommand*\DeclarePairedDelimiter[3]{%
    \newcommand{#1}{\mathtools@PD{#2}{#3}}%
}

\def\mathtools@PD#1#2{%
    \begingroup
        \maybe@st@rred{\mathtools@PD@{#1}{#2}}%
}

% TBD: optional argument

\def\mathtools@PD@#1#2#3{%
        \ifst@rred
            \left#1#3\right#2%
        \else
            \mathopen{#1}#3\mathclose{#2}%
        \fi
    \endgroup
}

\DeclareMathPassThrough{Aboxed}
\DeclareMathPassThrough{adjustlimits}
\DeclareMathPassThrough{ArrowBetweenLines}
\DeclareMathPassThrough{bigtimes}
\DeclareMathPassThrough{centercolon}
\DeclareMathPassThrough{clap}
\DeclareMathPassThrough{colonapprox}
\DeclareMathPassThrough{Colonapprox}
\DeclareMathPassThrough{coloneq}
\DeclareMathPassThrough{Coloneq}
\DeclareMathPassThrough{coloneqq}
\DeclareMathPassThrough{Coloneqq}
\DeclareMathPassThrough{colonsim}
\DeclareMathPassThrough{Colonsim}
\DeclareMathPassThrough{cramped}
\DeclareMathPassThrough{crampedclap}
\DeclareMathPassThrough{crampedllap}
\DeclareMathPassThrough{crampedrlap}
\DeclareMathPassThrough{crampedsubstack}
\DeclareMathPassThrough{dblcolon}
\DeclareMathPassThrough{DeclarePairedDelimiters}
\DeclareMathPassThrough{DeclarePairedDelimitersX}
\DeclareMathPassThrough{DeclarePairedDelimitersXPP}
\DeclareMathPassThrough{eqcolon}
\DeclareMathPassThrough{Eqcolon}
\DeclareMathPassThrough{eqqcolon}
\DeclareMathPassThrough{Eqqcolon}
\DeclareMathPassThrough{lparen}
\DeclareMathPassThrough{mathclap}
\DeclareMathPassThrough{mathllap}
\DeclareMathPassThrough{mathmakebox}
\DeclareMathPassThrough{mathmbox}
\DeclareMathPassThrough{mathrlap}
% \DeclareMathPassThrough{mathtoolsset}
\DeclareMathPassThrough{MoveEqLeft}
\DeclareMathPassThrough{MTFlushSpaceAbove}
\DeclareMathPassThrough{MTFlushSpaceBelow}
\DeclareMathPassThrough{MTThinColon}
\DeclareMathPassThrough{ndownarrow}
\DeclareMathPassThrough{newtagform}
\DeclareMathPassThrough{nuparrow}
\DeclareMathPassThrough{ordinarycolon}
\DeclareMathPassThrough{overbracket}
\DeclareMathPassThrough{prescript}
\DeclareMathPassThrough{refeq}
\DeclareMathPassThrough{renewtagform}
\DeclareMathPassThrough{rparen}
% \DeclareMathPassThrough{shortvdotswithin}
\DeclareMathPassThrough{shoveleft}
\DeclareMathPassThrough{shoveright}
\DeclareMathPassThrough{splitdfrac}
\DeclareMathPassThrough{splitfrac}
\DeclareMathPassThrough{textclap}
\DeclareMathPassThrough{textllap}
\DeclareMathPassThrough{textrlap}
\DeclareMathPassThrough{underbracket}
% \DeclareMathPassThrough{usetagform}
% \DeclareMathPassThrough{vdotswithin}
\DeclareMathPassThrough{xhookleftarrow}
\DeclareMathPassThrough{xhookrightarrow}
\DeclareMathPassThrough{xLeftarrow}
\DeclareMathPassThrough{xleftharpoondown}
\DeclareMathPassThrough{xleftharpoonup}
\DeclareMathPassThrough{xleftrightarrow}
\DeclareMathPassThrough{xLeftrightarrow}
\DeclareMathPassThrough{xleftrightharpoons}
\DeclareMathPassThrough{xmapsto}
\DeclareMathPassThrough{xmathstrut}
\DeclareMathPassThrough{xRightarrow}
\DeclareMathPassThrough{xrightharpoondown}
\DeclareMathPassThrough{xrightharpoonup}
\DeclareMathPassThrough{xrightleftharpoons}

\DefineAMSMathSimpleEnvironment{Bmatrix*}
\DefineAMSMathSimpleEnvironment{Bsmallmatrix}
\DefineAMSMathSimpleEnvironment{Bsmallmatrix*}
\DefineAMSMathSimpleEnvironment{Vmatrix*}
\DefineAMSMathSimpleEnvironment{Vsmallmatrix}
\DefineAMSMathSimpleEnvironment{Vsmallmatrix*}
\DefineAMSMathSimpleEnvironment{bmatrix*}
\DefineAMSMathSimpleEnvironment{bsmallmatrix}
\DefineAMSMathSimpleEnvironment{bsmallmatrix*}
% \DefineAMSMathSimpleEnvironment{cases*}
\DefineAMSMathSimpleEnvironment{crampedsubarray}
\DefineAMSMathSimpleEnvironment{dcases}
% \DefineAMSMathSimpleEnvironment{dcases*}
\DefineAMSMathSimpleEnvironment{drcases}
% \DefineAMSMathSimpleEnvironment{drcases*}
\DefineAMSMathSimpleEnvironment{lgathered}
\DefineAMSMathSimpleEnvironment{matrix*}
\DefineAMSMathSimpleEnvironment{multlined}
\DefineAMSMathSimpleEnvironment{pmatrix*}
\DefineAMSMathSimpleEnvironment{psmallmatrix}
\DefineAMSMathSimpleEnvironment{psmallmatrix*}
\DefineAMSMathSimpleEnvironment{rcases}
% \DefineAMSMathSimpleEnvironment{rcases*}
\DefineAMSMathSimpleEnvironment{rgathered}
\DefineAMSMathSimpleEnvironment{smallmatrix*}
\DefineAMSMathSimpleEnvironment{spreadlines}
\DefineAMSMathSimpleEnvironment{vmatrix*}
\DefineAMSMathSimpleEnvironment{vsmallmatrix}
\DefineAMSMathSimpleEnvironment{vsmallmatrix*}

%% mathtools redefines gathered, so we need to re-redefine it.

\DefineAMSMathSimpleEnvironment{gathered}

\DeclareMathPassThrough{underbrace}[1]
\DeclareMathPassThrough{overbrace}[1]

\endinput

__END__
