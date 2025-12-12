package TeX::Interpreter::LaTeX::Package::LTref;

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

my sub do_register_refkey;
my sub do_resolve_xrefs;
my sub do_resolve_ref_ranges;

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->define_csname('TeXML@register@refkey' => \&do_register_refkey);

    $tex->add_output_hook(\&do_resolve_xrefs, 1);

    $tex->add_output_hook(\&do_resolve_ref_ranges, 9);

    $tex->read_package_data();

    return;
}

sub do_resolve_xrefs {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    return unless $tex->if('TeXML@resolveXMLxrefs@');

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $pass = 0;

    $tex->print_nl("Resolving \\ref's");

    my $num_xrefs = 0;

    $tex->begingroup();

    $tex->let_csname('@setref' => 'resolve@setref');

    $tex->let_csname('start@xref@group' => '@empty');
    $tex->let_csname('end@xref@group' => '@empty');

    ## TODO: Refine the XPath to exclude citations.

    while (my @xrefs = $body->findnodes(qq{descendant::xref[starts-with(attribute::specific-use, "unresolved ref")]})) {
        if (++$pass > 10) {
            $tex->print_nl("resolve_xrefs: Bailing on pass number $pass");

            last;
        }

        for my $xref (@xrefs) {
            (undef, undef, my $ref_cmd) = split / /, $xref->getAttribute('specific-use');

            next if $ref_cmd eq 'cite';

            my $linked = 1;

            my $link_att = $xref->getAttribute('linked');

            if (defined $link_att && $link_att eq 'no') {
                $linked = 0;
            }

            my $ref_key = $xref->getAttribute('ref-key');

            if ($ref_cmd eq 'hyperref') {
                my $r = $tex->get_macro_expansion_text("r\@$ref_key");

                $xref->setAttribute('specific-use' => 'undefined ref');

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

                $xref->setAttribute('specific-use' => 'undefined ref');

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

    my $refs  = pluralize("reference", $num_xrefs);

    $tex->print_nl("Resolved $num_xrefs $refs");

    # $tex->print_ln();

    my @xrefs = $body->findnodes(qq{descendant::xref[attribute::specific-use="undefined ref"]});

    if (@xrefs) {
        $tex->print_nl("Unable to resolve the following xrefs after $pass tries:");

        for my $xref (@xrefs) {
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
    $tex->print_ln();

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

1;

__DATA__

\ProvidesPackage{LTref}

\newif\ifTeXML@resolveXMLxrefs@
\TeXML@resolveXMLxrefs@true

\newif\ifTeXML@resolveXMLxrefgroups@
\TeXML@resolveXMLxrefgroups@true

\def\TeXMLNoResolveXrefs{\TeXML@resolveXMLxrefs@false}
\def\TeXMLNoResolveXrefgroups{\TeXML@resolveXMLxrefgroups@false}

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
\let\texml@get@eqref\texml@get@reftext

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

\let\xref@right@delim\@empty
\let\xref@left@delim\@empty

\def\@setref#1#2#3{%
        \leavevmode
        \start@xref@group
        \startXMLelement{xref}%
            \ifst@rred
                \setXMLattribute{linked}{no}%
            \fi
            \setXMLattribute{ref-key}{#1}%
            \setXMLattribute{specific-use}{unresolved ref \expandafter\@gobble\string#2}%
            \xref@right@delim#3\xref@left@delim
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
        \ifcsname r@#1\endcsname
            \@setref@link@{#1}#2%
        \else
            \setXMLattribute{specific-use}{undefined ref}%
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
    \xref@right@delim\texml@get@reftext@#2\texml@refinfo\xref@left@delim
}

\def\@setref@nolink#1#2{%
        \ifcsname r@#1\endcsname
            \protected@edef\texml@refinfo{\csname r@#1\endcsname}%
            \def\texml@get{\csname texml@get@\expandafter\@gobble\string#2\endcsname}%
            \protect\printref{\expandafter\texml@get\texml@refinfo}%
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
