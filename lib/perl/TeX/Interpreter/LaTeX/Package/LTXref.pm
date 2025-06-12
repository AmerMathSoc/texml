package TeX::Interpreter::LaTeX::Package::LTXref;

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

use TeX::Utils::Misc qw(nonempty pluralize);

use TeX::Interpreter::LaTeX::Types::RefRecord qw(:all);

my sub do_showonlyrefs;
my sub do_register_refkey;
my sub do_resolve_xrefs;
my sub do_resolve_ref_ranges;
my sub do_sort_cites;

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->define_csname('TeXML@register@refkey' => \&do_register_refkey);

    $tex->add_output_hook(\&do_resolve_xrefs);

    $tex->add_output_hook(\&do_sort_cites, 1);

    $tex->add_output_hook(\&do_resolve_ref_ranges, 9);

    $tex->read_package_data();

    return;
}

sub do_showonlyrefs {
    my $tex   = shift;

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

sub do_resolve_xrefs { ## TODO: move cite out of this
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    return unless $tex->if('TeXML@resolveXMLxrefs@');

    do_showonlyrefs($tex); # grrr.  methods fucked up

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $pass = 0;

    $tex->print_nl("Resolving \\ref's and \\cite's");

    my $num_xrefs = 0;
    my $num_cites = 0;

    $tex->begingroup();

    $tex->let_csname('@setref' => 'resolve@setref');

    $tex->let_csname('start@xref@group' => '@empty');
    $tex->let_csname('end@xref@group' => '@empty');

    while (my @xrefs = $body->findnodes(qq{descendant::xref[starts-with(attribute::specific-use, "unresolved")]})) {
        if (++$pass > 10) {
            $tex->print_nl("resolve_xrefs: Bailing on pass number $pass");

            last;
        }

        for my $xref (@xrefs) {
            (undef, my $ref_cmd) = split / /, $xref->getAttribute('specific-use');

            if ($ref_cmd eq 'cite') {
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
            else {
                my $linked = 1;

                my $link_att = $xref->getAttribute('linked');

                if (defined $link_att && $link_att eq 'no') {
                    $linked = 0;
                }

                my $ref_key = $xref->getAttribute('ref-key');

                if ($ref_cmd eq 'hyperref') {
                    my $r = $tex->get_macro_expansion_text("r\@$ref_key");

                    $xref->setAttribute('specific-use' => 'undefined');

                    if (defined $r) {
                        my ($xml_id, $ref_type) = parse_ref_record($r);

                        if (nonempty($xml_id)) {
                            $xref->setAttribute(rid => $xml_id);
                            $xref->setAttribute('specific-use' => $ref_cmd);
                            $xref->setAttribute('ref-type' => $ref_type);
                            $xref->removeAttribute('ref-key');
                        }

                        $num_xrefs++;
                    }
                } elsif ($ref_cmd eq 'nameref') {
                    my $r = $tex->get_macro_expansion_text("r\@$ref_key");

                    $xref->setAttribute('specific-use' => 'undefined');

                    if (defined $r) {
                        my ($xml_id, $ref_type) = parse_ref_record($r);

                        if (nonempty($xml_id)) {
                            $xref->setAttribute(rid => $xml_id);
                            $xref->setAttribute('specific-use' => $ref_cmd);
                            $xref->setAttribute('ref-type' => $ref_type);
                            $xref->removeAttribute('ref-key');

                            my ($title) = $body->findnodes(qq{//*[\@id="$xml_id"]/title});

                            for my $node ($title->childNodes()) {
                                $xref->appendChild($node->cloneNode(1));
                            }
                        }

                        $num_xrefs++;
                    }
                }
                else {
                    my $new_node = $tex->convert_fragment(qq{\\${ref_cmd}{$ref_key}});

                    my $flag = $new_node->firstChild()->getAttribute("specific-use");

                    if (nonempty($flag) && $flag !~ m{^un(defined|resolved)}) {
                        $num_xrefs++;

                        if (! $linked) {
                            $new_node = $new_node->firstChild()->firstChild()->cloneNode(1);
                        }
                    }

                    $xref->replaceNode($new_node);
                }
            }
        }
    }

    my $refs  = pluralize("reference", $num_xrefs);
    my $cites = pluralize("cite", $num_cites);

    $tex->print_nl("Resolved $num_xrefs $refs and $num_cites $cites");

    # $tex->print_ln();

    my @xrefs = $body->findnodes(qq{descendant::xref[attribute::specific-use="undefined"]});

    if (@xrefs) {
        $tex->print_nl("Unable to resolve the following xrefs after $pass tries:");

        for my $xref (@xrefs) {
            $tex->print_nl("    $xref");
        }
    }

    my @cites = $body->findnodes(qq{descendant::xref[attribute::specific-use="unresolved cite"]});

    if (@cites) {
        $tex->print_nl("Unable to resolve the following cites:");

        for my $xref (@cites) {
            $tex->print_nl("    $xref");
        }
    }

    $tex->endgroup();

    return;
}

sub do_resolve_ref_ranges {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    return unless $tex->if('TeXML@resolveXMLxrefgroups@');

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    $tex->print_nl("Resolving <xref-group>s");

    $tex->begingroup();

    $tex->let_csname('start@xref@group' => '@empty');
    $tex->let_csname('end@xref@group' => '@empty');

    for my $group ($body->findnodes(qq{descendant::xref-group})) {
        my $first = $group->getAttribute('first');
        my $last  = $group->getAttribute('last');

        next unless defined $first && defined $last;

        my $first_record = $tex->get_refkey($first);

        my $skip;

        my $subtype;

        if (! defined $first_record) {
            $tex->print_err("Can't find initial xref-group id '$first'");

            $tex->error();

            $skip = 1;
        } else {
            $subtype = $first_record->get_subtype();
        }

        # $tex->__DEBUG("xref_group: first refrecord = $first_record");

        if (defined(my $last_record = $tex->get_refkey($last))) {
            # $tex->__DEBUG("xref_group: last refrecord = $last_record");

            my $t_subtype = $last_record->get_subtype;

            if (defined $subtype && $subtype ne $t_subtype) {
                $tex->print_err("Initial xref-group subtype '$subtype' does not match terminal subtype group '$t_subtype'");

                $tex->error();

                $skip = 1;
            }
        } else {
            $tex->print_err("Can't find terminal xref-group id '$last'");

            $tex->error();

            $skip = 1;
        }

        next if $skip;

        $group->setAttribute("ref-type",    $first_record->get_type());
        $group->setAttribute("ref-subtype", $subtype);

        my @middle;

        my $last_found = 0;

        if (defined(my $record = $first_record)) {
            # $tex->__DEBUG("xref_group: Starting scan with $record");

            my $subtype = $record->get_subtype();

            $group->setAttribute(first => $record->get_xml_id);

            while ($record = $record->get_next_ref()) {
                # $tex->__DEBUG("xref_group: next refrecord = $record");

                my $this_refkey = $record->get_refkey;

                next if $this_refkey =~ m{\@cref$}; ## ???

                if ($this_refkey eq $last) {
                    $last_found = 1;

                    # Is this redundant?
                    $group->setAttribute(last => $record->get_xml_id);

                    last;
                }

                if (! defined $record->get_subtype) {
                    $tex->print_err("No subtype in ref $record");

                    $tex->error();
                } elsif ($record->get_subtype eq $subtype) {
                    push @middle, $record->get_xml_id;
                }
            }
        }

        if (! $last_found) {
            $tex->print_err(qq{reference range '$first-$last':});
            $tex->print_err(qq{    Did not find label '$last' when scanning forward from label '$first'});
            $tex->print_err(qq{    Are the first and last keys reversed?});

            $tex->error();
        }

        $group->setAttribute(middle => "@middle");

        # $tex->__DEBUG("middle refs = @middle");
    }

    $tex->endgroup();

    return;
}

sub do_register_refkey {
    my $tex   = shift;
    my $token = shift;

    my $prefix = $tex->read_undelimited_parameter();
    my $refkey = $tex->read_undelimited_parameter();
    my $data   = $tex->read_undelimited_parameter();

    return unless $prefix eq 'r';

    my $prev_ref = $tex->get_cur_ref();

    my $new_ref = new_refrecord($refkey, $data, $prev_ref);

    if (defined $prev_ref) {
        $prev_ref->set_next_ref($new_ref);
    }

    $tex->set_refkey($refkey => $new_ref);

    $tex->set_cur_ref($new_ref);

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

\ProvidesPackage{LTXref}

\newif\ifTeXML@resolveXMLxrefs@
\TeXML@resolveXMLxrefs@true

\newif\ifTeXML@resolveXMLxrefgroups@
\TeXML@resolveXMLxrefgroups@true

\def\TeXMLNoResolveXrefs{\TeXML@resolveXMLxrefs@false}
\def\TeXMLNoResolveXrefgroups{\TeXML@resolveXMLxrefgroups@false}

\newif\ifTeXMLsortcites@
\TeXMLsortcites@false

\def\TeXMLsortCites{\TeXMLsortcites@true}
\def\TeXMLnoSortCites{\TeXMLsortcites@false}

\let\@currentlabel\@empty
\let\@currentXMLid\@empty
\def\@currentreftype{}
\def\@currentrefsubtype{}%% NEW

\newcounter{xmlid}

\def\stepXMLid{%
    \stepcounter{xmlid}%
    \edef\@currentXMLid{ltxid\arabic{xmlid}}%
}

\def\addXMLid{%
    \stepXMLid
    \setXMLattribute{id}{\@currentXMLid}%
}

\let\label\relax
\newcommand{\label}[2][]{%
    \@bsphack
    \begingroup
        \let\ref\relax
        \protected@edef\@tempa{%
            \noexpand\newlabel{#2}{%
                {\@currentlabel}%
                {\@currentXMLid}%
                {\ifmmode disp-formula\else\@currentreftype\fi}%
                {\ifmmode equation\else\@currentrefsubtype\fi}%
            }%
        }%
    \expandafter\endgroup
    \@tempa
    \@esphack
}

\newcommand{\@noref}[1]{%
    \G@refundefinedtrue
    \textbf{??}%
    \@latex@warning{Reference `#1' on page \thepage\space undefined}%
}

\long\def\texml@get@reftext#1#2#3#4{#1}
\long\def\texml@get@refid  #1#2#3#4{#2}
\long\def\texml@get@reftype#1#2#3#4{#3}
\long\def\texml@get@subtype#1#2#3#4{#4}

\let\texml@get@ref\texml@get@reftext

\DeclareRobustCommand\refRange[2]{%
    \leavevmode
    \start@xref@group
        \setXMLattribute{first}{#1}%
        \setXMLattribute{last}{#2}%
        \begingroup
            \suppress@xref@group
            \ref{#1}--\ref{#2}%
        \endgroup
    \end@xref@group
}

\DeclareRobustCommand\eqrefRange[2]{%
    \leavevmode
    \start@xref@group
        \setXMLattribute{first}{#1}%
        \setXMLattribute{last}{#2}%
        \begingroup
            \suppress@xref@group
            \eqref{#1}--\eqref{#2}%
        \endgroup
    \end@xref@group
}

\DeclareRobustCommand\ref{%
    \begingroup
        \maybe@st@rred\@ref
}

\def\@ref#1{%
        \ifst@rred\suppress@xref@group\fi
        \@setref {#1} \ref {}%
}

\DeclareRobustCommand\nameref{%
    \begingroup
        \maybe@st@rred\@nameref
}

\def\@nameref#1{%
        \@setref {#1} \nameref {}%
}

\def\start@xref@group{\startXMLelement{xref-group}}

\def\end@xref@group{\endXMLelement{xref-group}}

\def\suppress@xref@group{%
    \let\start@xref@group\@empty
    \let\end@xref@group\@empty
}

\def\@setref#1#2#3{%
        \leavevmode
        \start@xref@group
        \startXMLelement{xref}%
            \ifst@rred
                \setXMLattribute{linked}{no}%
            \fi
            \setXMLattribute{ref-key}{#1}%
            \setXMLattribute{specific-use}{unresolved \expandafter\@gobble\string#2}%
            #3%
        \endXMLelement{xref}%
        \end@xref@group
    \endgroup
}

\long\def\texml@get@pageref#1#2#3#4{\@latex@warning{Use of \string\pageref}}

\DeclareRobustCommand\pageref{%
    \begingroup
        \maybe@st@rred\@pageref
}

\def\@pageref#1{%
    \@setref {#1} \pageref {}
}

% #1 = LABEL
% %2 = \ref | \autoref | \pageref | ...

% \def\texml@set@prefix#1{%
%     texml@set@prefix@\expandafter\@gobble\string#1%
% }

\let\ref@prefix\@empty

\def\texml@set@prefix#1#2{%
    \ifcsname texml@set@prefix@\expandafter\@gobble\string#1\endcsname
        \edef\ref@prefix{\csname texml@set@prefix@\expandafter\@gobble\string#1\endcsname{#2}}%
    \else
        \let\ref@prefix\@empty
    \fi
}

\def\texml@get@reftext@#1{%
    \expandafter\expandafter\csname texml@get@\expandafter\@gobble\string#1\endcsname
}

\def\resolve@setref{%
    \leavevmode
    \csname @setref@\ifst@rred no\fi link\endcsname
}

\def\@setref@link#1#2{%
        \startXMLelement{xref}%
        \if@TeXMLend
        \ifcsname r@#1\endcsname
            \@setref@link@{#1}#2%
        \else
            \setXMLattribute{specific-use}{undefined}%
            \texttt{?#1}%
        \fi
        \endXMLelement{xref}%
    \endgroup
}

\def\@setref@link@#1#2{%
    \protected@edef\texml@refinfo{\csname r@#1\endcsname}%
    \setXMLattribute{specific-use}{\expandafter\@gobble\string#2}%
    %
    \edef\ref@rid{\expandafter\texml@get@refid\texml@refinfo}%
    \ifx\ref@rid\@empty
        \setXMLattribute{linked}{no}%
    \else
        \setXMLattribute{rid}{\ref@rid}%
    \fi
    %
    \edef\ref@reftype{\expandafter\texml@get@reftype\texml@refinfo}%
    \setXMLattribute{ref-type}{\ref@reftype}%
    %
    \edef\ref@subtype{\expandafter\texml@get@subtype\texml@refinfo}%
    \ifx\ref@subtype\@empty\else
        \setXMLattribute{ref-subtype}{\ref@subtype}%
        \texml@set@prefix#2\ref@subtype
        \ifx\ref@prefix\@empty\else
            \ref@prefix~%
        \fi
    \fi
    %
    \texml@get@reftext@#2\texml@refinfo
}

\def\@setref@nolink#1#2{%
        \ifcsname r@#1\endcsname
            \protected@edef\texml@refinfo{\csname r@#1\endcsname}%
            \def\texml@get{\csname texml@get@\expandafter\@gobble\string#2\endcsname}%
            \protect\printref{\expandafter\texmf@get\texml@refinfo}%
        \else
            \texttt{?#1}%
        \fi
    \endgroup
}

\let\printref\@firstofone

%% Wrap \@newl@bel in \begingroup...\endgroup instead of {...} for
%% compatibility with texml processing of math mode.

\def\@newl@bel#1#2#3{%
    \begingroup
        \@ifundefined{#1@#2}{%
            \let\prev@value\@empty
        }{%
            \edef\prev@value{\@nameuse{#1@#2}}%
        }%
        \double@expand{\global\noexpand\@namedef{#1@#2}{#3}}%
        \ifx\prev@value\@empty\else
            \expandafter\ifx\csname #1@#2\endcsname \prev@value\else
                \gdef\@multiplelabels{%
                    \@latex@warning@no@line{There were multiply-defined labels}%
                }%
                \@latex@warning@no@line{Label `#2' multiply defined: changed from '\prev@value' to '#3'}%
            \fi
        \fi
        \TeXML@register@refkey{#1}{#2}{#3}%
    \endgroup
}

\endinput

__END__
