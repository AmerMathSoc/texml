package TeX::Interpreter::FMT::latex;

# Copyright (C) 2022, 2023 American Mathematical Society
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

# The distinction between TeX::Interpreter::FMT::latex and
# TeX::Interpreter::LaTeX is obscure bordering on obtuse.

use Image::PNG;
use Image::JPEG::Size;

use List::Util qw(all);

use TeX::Utils::LibXML;

use TeX::Utils::Misc qw(empty file_mimetype empty nonempty pluralize trim);

use TeX::Constants qw(:named_args);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Interpreter::LaTeX::Types::RefRecord qw(:all);

use TeX::Token qw(:factories :catcodes);

use TeX::Token::Constants;

use TeX::TokenList qw(:factories);

use TeX::WEB2C qw(:token_types);

use File::Basename;
use File::Spec::Functions qw(catfile);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    (my $module = __PACKAGE__ . ".pm") =~ s{::}{\/}g;

    my $fmt_file = catfile(dirname($INC{$module}), 'laTeXML.fmt');

    $tex->load_fmt_file($fmt_file);

    $tex->define_pseudo_macro(LoadIfModuleExists => \&do_load_if_module_exists);

    $tex->read_package_data();

    ## Override definition of \leavevmode from latex.fmt
    $tex->define_csname(leavevmode => $tex->load_primitive('leavevmode'));
    $tex->define_csname(fontencoding => $tex->load_primitive('fontencoding'));

    $tex->define_csname('@push@sectionstack'  => \&do_push_section_stack);
    $tex->define_pseudo_macro('@pop@sectionstack'    => \&do_pop_section_stack);
    $tex->define_csname('@clear@sectionstack' => \&do_clear_section_stack);

    $tex->define_csname('@push@tocstack'  => \&do_push_toc_stack);
    $tex->define_pseudo_macro('@pop@tocstack'    => \&do_pop_toc_stack);
    $tex->define_csname('@clear@tocstack' => \&do_clear_toc_stack);
    # $tex->define_csname('@show@tocstack'  => \&do_show_toc_stack);

    $tex->define_csname('TeXML@resolveXMLxrefs' => \&do_resolve_xrefs);

    $tex->define_csname('TeXML@resolverefgroups' => \&do_resolve_xref_groups);

    $tex->define_csname('TeXML@sortXMLcites' => \&do_sort_cites);

    $tex->define_csname('TeXML@setliststyle' => \&do_set_list_style);

    $tex->define_csname('TeXML@add@graphic@attributes' => \&do_graphic_attibutes);

    $tex->define_csname('TeXML@register@refkey' => \&do_register_refkey);

    $tex->define_pseudo_macro(documentclass => \&do_documentclass);

    return;
}

######################################################################
##                                                                  ##
##                             COMMANDS                             ##
##                                                                  ##
######################################################################

## There's some redundancy between this and
## TeX::Interpreter::load_module() and related methods that should be
## cleaned up someday.

sub do_load_if_module_exists {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $name = $tex->read_undelimited_parameter(EXPANDED);
    my $ext  = $tex->read_undelimited_parameter(EXPANDED);

    my $type = $ext eq 'cls' ? 'Class' : 'Package';

    $name =~ s{-}{_}g;

    my $class = "TeX::Interpreter::LaTeX::${type}::$name";

    my $expansion = q{@secondoftwo};

    if ($tex->get_module_list($class)) {
        my $expansion = q{@firstoftwo};
    } else {
        $tex->process_string("
    \\makeatletter
    \\\@pushfilename
    \\xdef\\\@currname{$name}%
    \\xdef\\\@currext{$ext}%
    \\expandafter\\let\\csname\\\@currname.\\\@currext-h\@\@k\\endcsname\\\@empty
    \\let\\CurrentOption\\\@empty
    \\\@reset\@ptions
");

        $tex->define_simple_macro('@currname' => $name, MODIFIER_GLOBAL);
        $tex->define_simple_macro('@currext'  => $ext,  MODIFIER_GLOBAL);

        my $loaded = $tex->load_module($class);

        if ($loaded) {
            $expansion = q{@firstoftwo};

            eval { $class->install($tex) };

            if ($@) {
                $tex->fatal_error("Can't install macro class $class: $@");
            }

            $tex->set_module_list($class, 1);
        }

        $tex->process_string('\@popfilename \@reset@ptions');
    }

    return new_token_list(make_csname_token($expansion));
}

sub do_documentclass {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt   = $tex->scan_optional_argument();
    my $class = $tex->read_undelimited_parameter(EXPANDED);

    $tex->set_document_class(trim($class));

    my $expansion = new_token_list(make_csname_token('ltx@documentclass'));

    if ($opt) {
        $expansion->push(BEGIN_OPT, $opt, END_OPT);
    }

    $expansion->push(BEGIN_GROUP, $class, END_GROUP);

    return $expansion;
}

sub do_push_section_stack {
    my $tex   = shift;
    my $token = shift;

    my $level = $tex->read_undelimited_parameter(EXPANDED);
    my $tag   = $tex->read_undelimited_parameter(EXPANDED);

    $tex->push_section_stack([ $level, $tag ]);

    return;
}

sub do_pop_section_stack {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $token_list = new_token_list();

    my $target_level = $tex->read_undelimited_parameter(EXPANDED);

    my @stack = reverse  $tex->get_section_stacks();

    while (defined(my $entry = $tex->pop_section_stack())) {
        my ($level, $tag) = @{ $entry };

        if ($level < $target_level) {
            $tex->push_section_stack([ $level, $tag ]);

            last;
        } else {
            $token_list->push($tex->tokenize(qq{\\par\\endXMLelement{$tag}}));

            if ($level == $target_level) {
                last;
            }
        }
    }

    return $token_list;
}

sub do_clear_section_stack {
    my $tex   = shift;
    my $token = shift;

    while (defined(my $entry = $tex->pop_section_stack())) {
        my ($level, $tag) = @{ $entry };

        $tex->end_par();

        $tex->end_xml_element($tag);
    }

    return;
}

## There should be a cleaner way to create and manage stacks.

sub do_push_toc_stack {
    my $tex   = shift;
    my $token = shift;

    my $level = $tex->read_undelimited_parameter(EXPANDED);

    $tex->push_toc_stack($level);

    return;
}

sub do_pop_toc_stack {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $token_list = new_token_list();

    my $target_level = $tex->read_undelimited_parameter(EXPANDED);

    while (defined(my $level = $tex->pop_toc_stack())) {
        if ($level >= $target_level) {
            $tex->end_xml_element("toc-entry");
        } else {
            # Popped one level too far.  Back it up.

            $tex->push_toc_stack($level);

            last;
        }
    }

    return $token_list;
}

sub do_clear_toc_stack {
    my $tex   = shift;
    my $token = shift;

    while (defined(my $level = $tex->pop_toc_stack())) {
        $tex->end_xml_element("toc-entry");
    }

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

sub do_resolve_xrefs {
    my $tex   = shift;
    my $token = shift;

    do_showonlyrefs($tex); # grrr.  methods fucked up

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $pass = 0;

    $tex->print_nl("Resolving \\ref's and \\cite's");

    my $num_xrefs = 0;
    my $num_cites = 0;

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
            } elsif (lc($ref_cmd) eq 'cref') {
                my $ref_key = $xref->getAttribute('ref-key');

                my $new_node = $tex->convert_fragment(qq{\\texmlcleveref{${ref_cmd}}{$ref_key}});

                my $flag = $new_node->firstChild()->getAttribute("specific-use");

                if (nonempty($flag) && $flag !~ m{^un(defined|resolved)}) {
                    $num_xrefs++;
                }

                $xref->replaceNode($new_node);
            } else {
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
                } else {
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

    return;
}

sub do_resolve_xref_groups {
    my $tex   = shift;
    my $token = shift;

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    $tex->print_nl("Resolving <xref-group>s");

    for my $group ($body->findnodes(qq{descendant::xref-group})) {
        my $first = $group->getAttribute('first');
        my $last  = $group->getAttribute('last');

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

                next if $this_refkey =~ m{\@cref$};

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

    return;
}

sub __extract_cite_label( $ ) {
    my $xref_node = shift;

    my $label = $xref_node->firstChild();

    return "$label" + 0;
}

sub do_sort_cites {
    my $tex   = shift;
    my $token = shift;

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my @groups = $body->findnodes(qq{descendant::cite-group});

    $tex->print_nl("Sorting cite groups");

    my $num_sorted = 0;

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

my %LIST_STYLE_TYPE = (alph   => 'a', # 'lower-alpha',
                       Alph   => 'A', # 'upper-alpha',
                       arabic => '1', # 'decimal',
                       roman  => 'i', # 'lower-roman',
                       Roman  => 'I', # 'upper-roman',
                       );

sub do_set_list_style {
    my $tex   = shift;
    my $token = shift;

    $tex->begingroup();

    $tex->define_csname('@arabic'   => \&do_counter_style);
    $tex->define_csname('@roman'    => \&do_counter_style);
    $tex->define_csname('@Roman'    => \&do_counter_style);
    $tex->define_csname('@alph'     => \&do_counter_style);
    $tex->define_csname('@Alph'     => \&do_counter_style);
    # $tex->define_csname('@fnsymbol' => \&do_counter_style);

    my $item_label = $tex->convert_fragment('\\csname @itemlabel\\endcsname');

    $tex->endgroup();

    if ($item_label =~ m{\A (.*?) (?:\\\@(arabic|roman|alph)) (.*) \z}ismx) {
        my ($prefix, $list_style, $suffix) = ($1, $2, $3);

        # $tex->set_xml_attribute('html:type', $LIST_STYLE_TYPE{$list_style});

        if (nonempty($prefix) || nonempty($suffix)) {
            my $content = 'counter(counter)';

            if (nonempty($prefix)) {
                $content = qq{'$prefix' } . $content;
            }

            if (nonempty($suffix)) {
            $content .= qq{ '$suffix'};
            }

            # $tex->set_xml_attribute('html:style' => qq{content: $content});
        }
    } else {
        if ($item_label eq "\x{2022}") {
            # $tex->set_xml_attribute('html:style', qq{list-style-type: disc});
        } else {
            # $tex->set_xml_attribute('html:style', qq{list-style-type: '$item_label'});
        }
    }

    return;
}

sub do_counter_style {
    my $tex   = shift;
    my $token = shift;

    my $arg = $tex->read_undelimited_parameter();

    $tex->conv_toks($token);

    return;
}

sub __get_graphic_dimens( $$ ) {
    my $file = shift;
    my $mime_type = shift;

    if ($mime_type eq 'image/svg+xml') {
        my $parser = XML::LibXML->new();
        $parser->set_option(huge => 1);

        my $doc = eval { $parser->load_xml(location => $file) };

        if (! defined $doc) {
            warn "Can't parse SVG file to read dimensions\n";

            return;
        }

        my $root = $doc->documentElement();

        my $width  = $root->getAttribute("width");
        my $height = $root->getAttribute("height");

        return ($width, $height);
    }

    if ($mime_type eq 'image/jpeg') {
        my $jpg_util = Image::JPEG::Size->new();

        return $jpg_util->file_dimensions($file);
    }

    if ($mime_type eq 'image/png') {
        my $png = Image::PNG->new();

        return unless $png->read($file);
        # or do {
        #     die "Can't read $file: $!\n";
        # };

        return ($png->width(), $png->height());
    }

    return;
}

sub do_graphic_attibutes {
    my $tex   = shift;
    my $token = shift;

    my $file = $tex->read_undelimited_parameter();

    my $mime_type = file_mimetype($file);

    if (nonempty($mime_type)) {
        $tex->set_xml_attribute(mimetype => $mime_type);
    }

    if (my ($width, $height) = __get_graphic_dimens($file, $mime_type)) {
        $tex->set_xml_attribute(width => $width);
        $tex->set_xml_attribute(height => $height);
    }

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

\setXSLfile{jats}

\AtTeXMLend{\TeXML@resolveXMLxrefs}
\AtTeXMLend{\TeXML@resolverefgroups}

\def\TeXMLNoResolveXrefs{\let\TeXML@resolveXMLxrefs\@empty}

% \AtTeXMLend{\TeXML@resolveXMLcites}

% \def\TeXMLnoResolveCites{\let\TeXML@resolveXMLcites\@empty}

\newif\ifTeXMLsortcites@
\TeXMLsortcites@false

\def\TeXMLsortCites{\TeXMLsortcites@true}
\def\TeXMLnoSortCites{\TeXMLsortcites@false}

\AtTeXMLend{\ifTeXMLsortcites@ \TeXML@sortXMLcites \fi}

\def\@no@lnbk #1[#2]{ }% *sigh*

\def\controldates#1{}

% It's not clear that it's worth preserving these outside of math
% mode, since they are typically used for fine tuning that is highly
% font specific.

\UCSchardef\,"2009 % THIN SPACE
\UCSchardef\;"2005 % FOUR-PER-EM SPACE
\UCSchardef\:"2004 % THREE-PER-EM SPACE

\def\!{}

\def\HyperFirstAtBeginDocument#1{}

\def\startXMLspan#1{%
    \startXMLelement{span}%
    \setXMLclass{#1}%
}

\def\endXMLspan{%
    \endXMLelement{span}%
}

\def\emptyXMLelement#1{%
    \startXMLelement{#1}\endXMLelement{#1}%
}

\def\XMLelement#1#2{\startXMLelement{#1}#2\endXMLelement{#1}}

\def\XMLgeneratedText{\XMLelement{x}}

\def\JATStyledContent#1#2{%
    \leavevmode
    \startXMLelement{styled-content}%
    \setXMLattribute{style-type}{#1}%
    #2%
    \endXMLelement{styled-content}%
}

\UCSchardef\UnicodeLineFeed"000A

%% Save the current definition of a macro to be restored at the
%% beginning of the document, after all other packages and classes
%% have been loaded.

\def\SaveMacroDefinition#1{%
    \expandafter\global\expandafter\let\csname frozen@\string#1\endcsname#1%
}

\def\RestoreMacroDefinition#1{%
    \begingroup
        \edef\@tempa{%
            \let\noexpand#1\expandafter\noexpand\csname frozen@\string#1\endcsname
        }%
    \expandafter\endgroup
    \@tempa
}

\def\PreserveMacroDefinition#1{%
    \SaveMacroDefinition#1%
    \AtBeginDocument{\RestoreMacroDefinition#1}%
}

\def\SaveEnvironmentDefinition#1{%
    \expandafter\SaveMacroDefinition\csname#1\endcsname
    \expandafter\SaveMacroDefinition\csname end#1\endcsname
}

\def\RestoreEnvironmentDefinition#1{%
    \expandafter\RestoreMacroDefinition\csname#1\endcsname
    \expandafter\RestoreMacroDefinition\csname end#1\endcsname
}

\def\PreserveEnvironmentDefinition#1{%
    \expandafter\PreserveMacroDefinition\csname#1\endcsname
    \expandafter\PreserveMacroDefinition\csname end#1\endcsname
}

%% Now that MathJax supports scaling of images in scripts, we should
%% replace \TeXMLSVGmathchoice by something that creates SVGs that use
%% relative units:
%%
%%     https://github.com/mathjax/MathJax/issues/2124

\def\TeXMLSVGmathchoice#1{%
     \string\mathchoice
         {\TeXMLCreateSVG{$\displaystyle#1$}}%
         {\TeXMLCreateSVG{$\textstyle#1$}}%
         {\TeXMLCreateSVG{$\scriptstyle#1$}}%
         {\TeXMLCreateSVG{$\scriptscriptstyle#1$}}%
}

%% Example: \DeclareSVGMathChar\Lbag\mathopen

\def\DeclareSVGMathChar#1#2{\newcommand{#1}{#2{\TeXMLSVGmathchoice{#1}}}}

% * = preserve line breaks (for verbatim-type environments)

\def\DeclareSVGEnvironment{%
    \@ifstar{\@DeclareSVGEnvironment*}{\@DeclareSVGEnvironment{}}%
}

%% Other than \unitlength and \arraystretch, is there anything else we
%% should preserve?

\def\@DeclareSVGEnvironment#1#2{%
    \@namedef{#2}{%
        \texml@process@env#1{#2}{%
            \toks@\expandafter{\texml@body}%
            \edef\next@{%
%%
%% If we're in math mode, use the * version of TeXMLCreateSVG
%%
                \noexpand\TeXMLCreateSVG\ifmmode*\fi{%
                    \noexpand\renewcommand{\noexpand\arraystretch}{\arraystretch}
                    \noexpand\setlength{\noexpand\unitlength}{\the\unitlength}
                    \@ifundefined{extrarowheight}{}{%
                        \noexpand\setlength{\noexpand\extrarowheight}{\the\extrarowheight}%
                    }%
                    \the\toks@
                }%
            }%
            \next@
        }%
    }%
}

\def\jats@graphics@element{inline-graphic}

%% Note that the optional argument is currently ignored.

\newcommand{\TeXMLImportGraphic}[2][]{%
    \startXMLelement{\jats@graphics@element}%
    \setXMLattribute{xlink:href}{#2}%
    \TeXML@add@graphic@attributes{#2}%
    \endXMLelement{\jats@graphics@element}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      BEGINNING OF LATEX.LTX                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTSPACE.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\UCSchardef\nobreakspace"00A0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFILES.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\InputIfFileExists#1#2{%
    \IfFileExists{#1}{%
        \@filtered@input\@filef@und
    }%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTOUTENC.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\UCSchardef\{"007B
\UCSchardef\}"007D
\UCSchardef\$"0024
\UCSchardef\#"0023
\UCSchardef\%"0025

\UCSchardef\&"0026

\UCSchardef\_"005F
\UCSchardef\|"007C

\UCSchardef\AA"00C5
\UCSchardef\aa"00E5
\UCSchardef\AE"00C6
\UCSchardef\ae"00E6
\UCSchardef\cent"00A2
% \UCSchardef\copy"00A9    % WTF?!!?
\UCSchardef\copyright"00A9
\UCSchardef\curren"00A4
\UCSchardef\DH"00D0
\UCSchardef\dh"00F0
\UCSchardef\DJ"0110
\UCSchardef\dj"0111
\UCSchardef\dots"2026
\UCSchardef\iexcl"00A1
\UCSchardef\IJlig"0132
\UCSchardef\ijlig"0133
\UCSchardef\IJ"0132
\UCSchardef\ij"0133
\UCSchardef\iquest"00BF
\UCSchardef\i"0131
\UCSchardef\j"0237
\UCSchardef\laquo"00AB
\UCSchardef\ldots"2026
\UCSchardef\Lsoft"013D
\UCSchardef\lsoft"013E
\UCSchardef\L"0141
\UCSchardef\l"0142
\UCSchardef\OE"0152
\UCSchardef\oe"0153
\UCSchardef\O"00D8
\UCSchardef\o"00F8
\UCSchardef\pounds"00A3
\UCSchardef\raquo"00BB
\UCSchardef\P"00B6
\UCSchardef\S"00A7
\UCSchardef\sect"00A7
\UCSchardef\ss"00DF
\UCSchardef\TH"00DE
\UCSchardef\th"00FE
\UCSchardef\yen"00A5

%% LaTeX \text... symbols

\UCSchardef\textdollar"0024
\UCSchardef\textbackslash"005C

\UCSchardef\textacutedbl"02DD
\UCSchardef\textasciiacute"00B4
\UCSchardef\textasciibreve"02D8
\UCSchardef\textasciicaron"02C7
\UCSchardef\textasciicircum"02C6
\UCSchardef\textasciidieresis"00A8
\UCSchardef\textasciimacron"00AF
\UCSchardef\textasciitilde"02DC
\UCSchardef\textasteriskcentered"204E
\UCSchardef\textbaht"0E3F
\UCSchardef\textbar"007C
\UCSchardef\textless"003C
\UCSchardef\textgreater"003E

\UCSchardef\textbardbl"2016
\UCSchardef\textbigcircle"25EF
\UCSchardef\textblank"2422
\UCSchardef\textbraceleft"007B
\UCSchardef\textbraceright"007D
\UCSchardef\textbrokenbar"00A6
\UCSchardef\textbullet"2022
\UCSchardef\textcelsius"2103
\UCSchardef\textcent"00A2
\UCSchardef\textcircledP"2117
\UCSchardef\textcolonmonetary"20A1
\UCSchardef\textcompwordmark"200C
\UCSchardef\textcopyright"00A9
\UCSchardef\textcurrency"00A4
\UCSchardef\textdagger"2020
\UCSchardef\textdaggerdbl"2021
\UCSchardef\textdegree"00B0
\UCSchardef\textdiscount"2052
\UCSchardef\textdiv"00F7
\UCSchardef\textdong"20AB
\UCSchardef\textdownarrow"2193
\UCSchardef\textellipsis"2026
\UCSchardef\textemdash"2014
\UCSchardef\textendash"2013
\UCSchardef\textestimated"212E
\UCSchardef\texteuro"20AC
\UCSchardef\textexclamdown"00A1
\UCSchardef\textflorin"0192
\UCSchardef\textfractionsolidus"2044
\UCSchardef\textinterrobang"203D
\UCSchardef\textlangle"2329
\UCSchardef\textleftarrow"2190
\UCSchardef\textlira"20A4
\UCSchardef\textlnot"00AC
\UCSchardef\textmho"2127
\UCSchardef\textmu"00B5
\UCSchardef\textmusicalnote"266A
\UCSchardef\textnaira"20A6
\UCSchardef\textnumero"2116
\UCSchardef\textohm"2126
\UCSchardef\textonehalf"00BD
\UCSchardef\textonequarter"00BC
\UCSchardef\textonesuperior"00B9
\UCSchardef\textopenbullet"25E6
\UCSchardef\textordfeminine"00AA
\UCSchardef\textordmasculine"00BA
\UCSchardef\textparagraph"00B6
\UCSchardef\textperiodcentered"00B7
\UCSchardef\textpertenthousand"2031
\UCSchardef\textperthousand"2030
\UCSchardef\textpeso"20B1
\UCSchardef\textpm"00B1
\UCSchardef\textprime"2032
\UCSchardef\textquestiondown"00BF
\UCSchardef\textquotedblleft"201C
\UCSchardef\textquotedblright"201D
\UCSchardef\textquoteleft"2018
\UCSchardef\textquoteright"2019
\UCSchardef\textrangle"232A
\UCSchardef\textrecipe"211E
\UCSchardef\textreferencemark"203B
\UCSchardef\textregistered"00AE
\UCSchardef\textrightarrow"2192
\UCSchardef\textsection"00A7
\UCSchardef\textservicemark"2120
\UCSchardef\textsterling"00A3
\UCSchardef\textthreequarters"00BE
\UCSchardef\textthreesuperior"00B3
\UCSchardef\texttimes"00D7
\UCSchardef\texttrademark"2122
\UCSchardef\texttwosuperior"00B2
\UCSchardef\textunderscore"005F
\UCSchardef\textuparrow"2191
\UCSchardef\textvisiblespace"2423
\UCSchardef\textwon"20A9
\UCSchardef\textyen"00A5

\def\Mc{Mc}

%%
%% Miscellaneous
%%

\UCSchardef\backslash"005C
\UCSchardef\colon"003A
\UCSchardef\enspace"2002
\UCSchardef\emspace"2003
\UCSchardef\thinspace"2009
\UCSchardef\quad"2001
\UCSchardef\lbrace"007B
\UCSchardef\rbrace"007D
\UCSchardef\lt"003C
\UCSchardef\gt"003E

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTCOUNTS.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTLENGTH.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Disabling \@settodim shouldn't be necessary once the emulations of
% the box operations are working.

\def\@settodim#1#2#3{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFNTCMD.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@declarestyledcommand#1#2#3{%
    \DeclareRobustCommand#1[1]{%
        \ifmmode
            \string#2{##1}%
        \else
            \JATStyledContent{#3}{##1}%
        \fi
    }%
}

\@declarestyledcommand\textsl\mathsl{oblique}
%\@declarestyledcommand\textup{font-style: normal}
% \@declarestyledcommand\textsc{font-variant: small-caps}

\def\@declarefontcommand#1#2#3{%
    \DeclareRobustCommand#1[1]{%
        \ifmmode
            \string#2{##1}%
        \else
            \leavevmode
            \startXMLelement{#3}%
            ##1%
            \endXMLelement{#3}%
        \fi
    }%
}

\@declarefontcommand\textup\text{roman}

% The following aren't quite right because, for example, \textrm{foo
% bar} retains the space, but \mathrm{foo bar} does not.  But it's
% probably correct most of the time.

\@declarefontcommand\textrm\mathrm{roman}
\@declarefontcommand\textnormal\mathrm{roman}
\@declarefontcommand\textsc\mathsc{sc}
\@declarefontcommand\textbf\mathbf{bold}
\@declarefontcommand\texttt\mathtt{monospace}
\@declarefontcommand\textit\mathit{italic}
\@declarefontcommand\textsf\mathsf{sans-serif}

\@declarefontcommand\underline\underline{underline}
\@declarefontcommand\textsuperscript\sp{sup}
\@declarefontcommand\textsubscript\sb{sub}

%% Defer \overline until \begin{document} to avoid warnings from
%% amsmath.sty.

\AtBeginDocument{\@declarefontcommand\overline\overline{overline}}

\DeclareRobustCommand\emph[1]{%
    \ifmmode
        \string\mathit{#1}%
    \else
        \leavevmode
        \startXMLelement{italic}%
        \setXMLattribute{toggle}{yes}%
        #1%
        \endXMLelement{italic}%
    \fi
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTXREF.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    \startXMLelement{xref-group}%
        \setXMLattribute{first}{#1}%
        \setXMLattribute{last}{#2}%
        \ref{#1}--\ref{#2}%
    \endXMLelement{xref-group}%
}

\DeclareRobustCommand\eqrefRange[2]{%
    \leavevmode
    \startXMLelement{xref-group}%
        \setXMLattribute{first}{#1}%
        \setXMLattribute{last}{#2}%
        \eqref{#1}--\eqref{#2}%
    \endXMLelement{xref-group}%
}

\DeclareRobustCommand\ref{%
    \begingroup
        \maybe@st@rred\@ref
}

\def\@ref#1{%
    \expandafter\@setref {#1} \ref
}

\long\def\texml@get@pageref#1#2#3#4{\@latex@warning{Use of \string\pageref}}

\DeclareRobustCommand\pageref{%
    \begingroup
        \maybe@st@rred\@pageref
}

\def\@pageref#1{%
    \expandafter\@setref {#1} \pageref
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

\def\@setref{\csname @setref@\ifst@rred no\fi link\endcsname}

\def\@setref@link#1#2{%
        \leavevmode
        \startXMLelement{xref}%
        \ifst@rred
            \setXMLattribute{linked}{no}%
        \fi
        \if@TeXMLend
            \ifcsname r@#1\endcsname
                \@setref@link@{#1}#2%
            \else
                \setXMLattribute{specific-use}{undefined}%
                \texttt{?#1}%
            \fi
        \else
            \setXMLattribute{ref-key}{#1}%
            \setXMLattribute{specific-use}{unresolved \expandafter\@gobble\string#2}%
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
        \leavevmode
        \if@TeXMLend
            \ifcsname r@#1\endcsname
                \protected@edef\texml@refinfo{\csname r@#1\endcsname}%
                \def\texml@get{\csname texml@get@\expandafter\@gobble\string#2\endcsname}%
                \protect\printref{\expandafter\texmf@get\texml@refinfo}%
            \else
                \texttt{?#1}%
            \fi
        \else
            \startXMLelement{xref}%
            \setXMLattribute{linked}{no}%
            \setXMLattribute{ref-key}{#1}%
            \setXMLattribute{specific-use}{unresolved \expandafter\@gobble\string#2}%
            \endXMLelement{xref}%
        \fi
    \endgroup
}

\let\printref\@firstofone

%% Wrap \@newl@bel in \begingroup...\endgroup instead of {...} for
%% compatibility with texml processing of math mode.

\def\double@expand#1{%
    \begingroup
        \protected@edef\@temp@expand{#1}%
    \expandafter\endgroup
    \@temp@expand
}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTMISCEN.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewenvironment{center}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: center}
}{%
    \par
    \endXMLelement{disp-quote}%
}

\renewenvironment{flushright}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: right}%
}{%
    \par
    \endXMLelement{disp-quote}%
}

\renewenvironment{flushleft}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: left}%
}{%
    \par
    \endXMLelement{disp-quote}%
}

%% In verbatim-like environments, we need ^^M to generate
%% \UnicodeLineFeed instead of \par:

{\catcode`\^^M=\active % these lines must end with %
  \gdef\verbatim@obeylines{\catcode`\^^M\active \let^^M\UnicodeLineFeed}}%

\def\@verbatim{
    \par
    \xmlpartag{}%
    \everypar{}%
    \startXMLelement{pre}%
    \let\do\@makeother \dospecials
    \noligs=1
    \verbatim@obeylines
}

% \def\verbatim{\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}

\def\endverbatim{%
    \par
    \endXMLelement{pre}%
    \par
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTMATH.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\[{$$}
\def\]{$$}
\def\({$}
\def\){$}

%% For now assume that \bordermatrix only occurs in display math.

\def\bordermatrix#1{\TeXMLCreateSVG{$$\bordermatrix{#1}$$}}

\def\makeph@nt#1{}
%\def\mathph@nt#1#2{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTLISTS.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\renewenvironment{list}[2]{%
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
        \if@stdList
            \TeXML@setliststyle
        \fi
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTBOXES.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preserve \llap and \rlap in math mode.

\let\ltx@rlap\rlap

%% Add an extra \hbox around the argument of \rlap and \llap to
%% compensate for the fact that MathJax correctly switches to text
%% mode inside \hbox but not inside \rlap and \llap.

\def\rlap#1{%
    \ifmmode
        \string\rlap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@rlap{#1}%
    \fi
}

\let\ltx@llap\llap

\def\llap#1{%
    \ifmmode
        \string\llap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@llap{#1}%
    \fi
}

\def\centerline#1{\par#1\par}

\DeclareRobustCommand\parbox{%
    \@latex@warning@no@line{This document uses \string\parbox!}%
  \@ifnextchar[%]
    \@iparbox
    {\@iiiparbox c\relax[s]}}%

\long\def\@iiiparbox#1#2[#3]#4#5{%
    \leavevmode
    \@pboxswfalse
    \startXMLelement{span}%
    \setXMLattribute{specific-use}{parbox}%
    \ifmmode
        \text{#5}%
    \else
        #5\@@par
    \fi
    \endXMLelement{span}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTTAB.DTX                             %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\array{%
    \string\begin{array}%
    \let\\\@arraycr
    \let\par\UnicodeLineFeed
}

\def\endarray{\string\end{array}}

\def\@arraycr{\@ifstar\@xarraycr\@xarraycr}

\def\@xarraycr{\@ifnextchar[\@argarraycr{\string\\}}

\def\@argarraycr[#1]{%
    \@tempdima=#1\relax
    \string\\[\the\@tempdima]
}

\DeclareSVGEnvironment{tabbing}

\DeclareSVGEnvironment{SVG}
\DeclareSVGEnvironment{SVG*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTPICTUR.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareSVGEnvironment{picture}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTSECT.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@ams@empty

\def\ams@measure#1{%
    \if###1##%
        \@ams@emptytrue
    \else
        \@ams@emptyfalse
    \fi
}

\PreserveMacroDefinition\ams@measure

\def\@startsection#1#2#3#4#5#6{%
    \everypar{}%
    \leavevmode
    \par
    \def\@tempa{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
    \@ifstar{\st@rredtrue\@tempa}{\st@rredfalse\@tempa}%
}

%% Ideally we would just say
%%
%%     \def\@currentrefsubtype{#1}
%%
%% in \@sect, but we need a level of indirection in order to change
%% the type of \section from "section" to "appendix" in appendices.

\def\set@sec@subreftype#1{%
    \begingroup
        \let\@tempa\@empty
        \ifcsname #1@subreftype@\endcsname
            \edef\@tempa{\csname #1@subreftype@\endcsname}%
        \fi
        \ifx\@tempa\@empty
            \def\@tempa{#1}%
        \fi
        \edef\@tempa{\def\noexpand\@currentrefsubtype{\@tempa}}%
    \expandafter\endgroup
    \@tempa
}

\PreserveMacroDefinition\@startsection

% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}[ARG1]{ARG2}
%
% LEVEL = \@m if *-ed

\def\@sect#1#2#3#4#5#6[#7]#8{%
    \def\@currentreftype{sec}%
    \set@sec@subreftype{#1}%
    \ams@measure{#8}%
    \edef\@toclevel{\number#2}%
    \ifst@rred
        \let\@secnumber\@empty
        \let\@svsec\@empty
    \else
        \ifnum #2>\c@secnumdepth
            \let\@secnumber\@empty
            \let\@svsec\@empty
        \else
            \expandafter\let\expandafter\@secnumber\csname the#1\endcsname
            \refstepcounter{#1}%
            \typeout{#1\space\@secnumber}%
            \protected@edef\@svsec{%
                \ifnum#2<\@m
                    \@ifundefined{#1name}{}{%
                        \ignorespaces\csname #1name\endcsname\space
                    }%
                \fi
                \@seccntformat{#1}%
            }%
        \fi
    \fi
    \start@XML@section{#1}{\@toclevel}{\@svsec}{#8}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
}

% #1 = section type  (part, chapter, section, subsection, etc.)
% #2 = section level (-1,   0,       1,       2,          etc.)
% #3 = section label (including punctuation)
% #4 = section title

%% TODO: Add sec-type for things like acknowledgements?

\def\XML@section@tag{sec}

\def\start@XML@section#1#2#3#4{
    \par
    \stepXMLid
    \begingroup
        \ifinXMLelement{statement}%
            \startXMLelement{\XML@section@tag heading}%
        \else
            \@pop@sectionstack{#2}%
            \startXMLelement{\XML@section@tag}%
        \fi
        \setXMLattribute{id}{\@currentXMLid}%
        \setXMLattribute{disp-level}{#2}%
        \setXMLattribute{specific-use}{#1}%
        \ifinXMLelement{statement}\else
            \@push@sectionstack{#2}{\XML@section@tag}%
        \fi
        \par
        \xmlpartag{}%
        \edef\@tempa{\zap@space#3 \@empty}% Is this \edef safe?
        \ifx\@tempa\@empty\else
            \startXMLelement{label}%
            \ignorespaces#3%
            \endXMLelement{label}%
        \fi
        \begingroup
            \let\label\@gobble
            \protected@xdef\@tempa{\zap@space#4 \@empty}%
        \endgroup
        \ifx\@tempa\@empty\else
            \startXMLelement{title}%
            \ignorespaces#4%
            \endXMLelement{title}%
        \fi
        \par
        \ifinXMLelement{statement}%
            \endXMLelement{\XML@section@tag heading}%
        \fi
    \endgroup
}

\PreserveMacroDefinition\@sect

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFLOAT.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% <fig id="raptor" position="float">
%   <label>Figure 1</label>
%   <caption>
%     <title>Le Raptor.</title>
%     <p>Rapidirap.</p>
%   </caption>
%   <graphic xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="data/samples/raptor.jpg"/>
% </fig>

\def\caption{%
    \ifx\@captype\@undefined
        \@latex@error{\noexpand\caption outside float}\@ehd
        \expandafter\@gobble
    \else
        \expandafter\@firstofone
    \fi
    {\@ifstar{\st@rredtrue\caption@}{\st@rredfalse\caption@}}%
}

\SaveMacroDefinition\caption

\def\caption@{\@dblarg{\@caption\@captype}}

\SaveMacroDefinition\caption@

\def\@caption#1[#2]#3{%
    \ifst@rred\else
        %%
        %% Try very very hard not to output an empty <label/>
        %%
        %% Use a dedicated \@temp macro here because cleveref steals
        %% \@tempa in its redefinition of \refstepcounter
        %%
        \expandafter\ifx\csname the#1\endcsname \@empty \else
            \refstepcounter{#1}%
        \fi
        \@ifundefined{fnum@#1}{%
            % old-style
            \protected@edef\@templabel{\csname #1name\endcsname}%
            \expandafter\ifx\csname the#1\endcsname \@empty \else
                \ifx\@templabel\@empty\else
                    \protected@edef\@templabel{\@templabel\space}%
                \fi
                \protected@edef\@templabel{\@templabel\csname the#1\endcsname}%
            \fi
        }{%
            % \newfloat
            \protected@edef\@templabel{\@nameuse{fnum@#1}}%
        }%
        \ifx\@templabel\@empty\else
            \startXMLelement{label}%
            \ignorespaces\@templabel\unskip
            \endXMLelement{label}%
        \fi
    \fi
    \if###3##\else
        \par
        \begingroup
            \def\jats@graphics@element{inline-graphic}
            \startXMLelement{caption}%
                \startXMLelement{p}%
                #3%
                \endXMLelement{p}%
            \endXMLelement{caption}%
            \par
        \endgroup
    \fi
}

\SaveMacroDefinition\@caption

\def\@float#1{%
    \@ifnextchar[%
        {\@xfloat{#1}}%
        {\edef\reserved@a{\noexpand\@xfloat{#1}[\csname fps@#1\endcsname]}%
         \reserved@a}%
}

\def\@xfloat #1[#2]{%
    \@nodocument
    \let\center\@empty
    \let\endcenter\@empty
    \ifnum\@listdepth > 0
        \list@endpar
    \else
        \par
    \fi
    \everypar{}%
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{#1}%
    \def\@currentrefsubtype{#1}%
    \def\@captype{#1}%
    \def\jats@graphics@element{graphic}
    \edef\JATS@float@wrapper{%
        \@ifundefined{jats@#1@element}{%
            \jats@figure@element
        }{%
            \@nameuse{jats@#1@element}%
        }%
    }%
    \startXMLelement{\JATS@float@wrapper}%
    \setXMLattribute{specific-use}{#1}%
    \set@float@fps@attribute{#2}%
    \addXMLid
    \@ifundefined{c@sub#1}{}{\setcounter{sub#1}{0}}%
}%

\SaveMacroDefinition\@xfloat

\def\end@float{%
    \endXMLelement{\JATS@float@wrapper}%
    \par
    \ifnum\@listdepth > 0
        \global\afterfigureinlist@true
    \fi
}

\let\@dblfloat\@float
\let\end@dblfloat\end@float

\def\set@float@fps@attribute#1{%
    \def\@fps{#1}%
    \@onelevel@sanitize \@fps
    \expandafter \@tfor \expandafter \reserved@a
        \expandafter :\expandafter =\@fps \do{%
            \if \reserved@a H%
                \setXMLattribute{position}{anchor}%
            \fi
    }%
}

% cf. amscommon.pm

\def\footnote{%
    \stepcounter{xmlid}%
    \@ifnextchar[\@xfootnote
                 {\stepcounter\@mpfn
                   \protected@xdef\@thefnmark{\thempfn}%
                    \@footnotemark\@footnotetext}%
}

\def\footnotemark{%
    \stepcounter{xmlid}%
    \@ifnextchar[\@xfootnotemark
     {\stepcounter{footnote}%
      \protected@xdef\@thefnmark{\thefootnote}%
      \@footnotemark}}

\def\@makefnmark{%
    \char"2060 % WORD JOINER
    \startXMLelement{xref}%
        \setXMLattribute{ref-type}{fn}%
        \begingroup
            %% TODO: Where else might we need to nullify \protect?
            \let\protect\@empty
            \setXMLattribute{rid}{ltxid\arabic{xmlid}}%
            \setXMLattribute{alt}{Footnote \@thefnmark}%
        \endgroup
        \@thefnmark
    \endXMLelement{xref}%
}

\PreserveMacroDefinition\@makefnmark

\long\def\@footnotetext#1{%
    \begingroup
        \edef\@currentXMLid{ltxid\arabic{xmlid}}%
        \def\@currentreftype{fn}%
        \def\@currentrefsubtype{footnote}%
        \protected@edef\@currentlabel{%
           \csname p@footnote\endcsname\@thefnmark
        }%
        \startXMLelement{fn}%
        \setXMLattribute{id}{\@currentXMLid}%
        \vbox{%
            \everypar{}%
            % The braces around the next line should not be necessary,
            % but without them one of the footnotes in car/brown2 came
            % out with all of the contents surrounded by label tags.
            % See bugs/footnote.tex
            {\thisxmlpartag{label}\@currentlabel\par}%
            \xmlpartag{p}%
            \color@begingroup#1\color@endgroup\par
        }%
        \endXMLelement{fn}%
    \endgroup
}

\PreserveMacroDefinition\@footnotetext

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTBIBL.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%     \enddocument   invokes do_resolve_xrefs(), which cycles through
%%                    all xref nodes with @specific-use = 'unresolved
%%                    cite' and, if \b@K is defined, replaces
%%                    the contents of the node by \b@K and resets
%%                    @specific-use = 'cite'.

\let\bibliographystyle\@gobble

\def\citeleft{%
    \startXMLelement{cite-group}%
    \leavevmode\XMLgeneratedText[%
}

\def\citeright{%
    \XMLgeneratedText]%
    \endXMLelement{cite-group}%
}

\def\citemid{\XMLgeneratedText{,\space}}

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
        \@ifnotempty{#2}{\citemid#2}%
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
    \startXMLelement{label}[#1]\endXMLelement{label}%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTPAGE.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTOUTPUT.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@enlargepage#1#2{} % should be \@enlargepage?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTCLASS.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\ltx@documentclass\documentclass

\let\@classoptionslist\@empty

%% Suppress "Unknown option" warnings when loading perl-only
%% implementations of packages.  We need a better solution to this.

\let\@@unprocessedoptions\relax

%% Disable "You have requested version blah but only version blah is
%% available" warnings.

\def\@ifl@t@r#1#2{%
  % \ifnum\expandafter\@parse@version#1//00\@nil<%
  %       \expandafter\@parse@version#2//00\@nil
  %   \expandafter\@secondoftwo
  % \else
    \expandafter\@firstoftwo
  %\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                         END OF LATEX.LTX                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \let\everymath\frozen@everymath
% \let\everydisplay\frozen@everydisplay

% \def\texml@init@math{
%     \def\vcenter#1{#1}%
%     \let\mbox\math@mbox
% }
%
% \everymath{\texml@init@math}
% \everydisplay{\texml@init@math}

\def\mbox{%
  \ifmmode\expandafter\math@mbox\else\expandafter\@firstofone\fi
}

\def\math@mbox#1{%
    \string\mbox\string{\hbox{#1}\string}%
}

% \let\frozen@hbox\hbox
%
% \def\hbox{%
%   \ifmmode\expandafter\math@hbox\else\expandafter\frozen@hbox\fi
% }
%
% \def\math@hbox#1{%
%     \string\hbox\string{\frozen@hbox{#1}\string}%
% }

\def\vcenter{%
  \ifmmode\expandafter\math@vcenter\else\expandafter\vcenter\fi
}

% \math@vcenter doesn't change mode...

\def\math@vcenter#1{%
    \string\vcenter\string{#1\string}%
}

\let\texml@body\@empty
\let\texml@callback\@empty

\newif\iftexml@process@obeylines@
\texml@process@obeylines@false

\def\texml@process@env{%
    \endgroup
    \begingroup
        \@ifstar{%
            \global\texml@process@obeylines@true\texml@process@env@
        }{%
            \global\texml@process@obeylines@false\texml@process@env@
        }%
}

\def\texml@process@env@#1{%
        \iftexml@process@obeylines@ \obeylines \fi
        \def\texml@body{\begin{#1}}%
        \def\@tempa{#1}%
        \afterassignment\texml@collect
        \def\texml@callback
}

\long\def\texml@collect#1\end{%
    \g@addto@macro\texml@body{#1}%
    \texml@collect@iterate
}%

\def\texml@collect@iterate#1{%
    \g@addto@macro\texml@body{\end{#1}}%
    \def\@tempb{#1}%
    \ifx\@tempa\@tempb
        \def\next@{\texml@callback\endgroup}%
    \else
        \let\next@\texml@collect
    \fi
    \next@
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                          MATH ALPHABETS                          %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@ifrobust#1{%
    \begingroup
        \edef\@tempa{%
            \noexpand\protect
            \expandafter\noexpand
            \csname\expandafter\@gobble\string#1 \endcsname
        }%
        \ifx#1\@tempa
            \let\@tempa\@firstoftwo
        \else
            \let\@tempa\@secondoftwo
        \fi
    \expandafter\endgroup
    \@tempa
}

% Make sure the arguments to \mathbf, etc., are surrounded by braces
% because apparently MathJax demands them.

\def\DeclareTeXMLMathAlphabet#1{%
    \ifMathJaxMacro#1%
        % \typeout{\string#1 is already a TeXMLMathAlphabet}%
    \else
        % \typeout{Rewriting \string#1 as a TeXMLMathAlphabet}%
        \@DeclareTeXMLMathAlphabet#1%
    \fi
}

% This could be unified with \@DeclareMathJaxMacro with a little work.

\let\DeclareTeXMLMathAccent\DeclareTeXMLMathAlphabet

% Cf. Section 4 of "The STIX2 package" and Table 1 in "Experimental
% Unicode mathematical typesetting: The unicode-math package."

\DeclareTeXMLMathAlphabet\mathnormal
\DeclareTeXMLMathAlphabet\mathrm
\DeclareTeXMLMathAlphabet\mathbf
% \DeclareTeXMLMathAlphabet\mathbfup
\DeclareTeXMLMathAlphabet\mathit
\DeclareTeXMLMathAlphabet\mathbfit
% \DeclareTeXMLMathAlphabet\mathbfcal
\DeclareTeXMLMathAlphabet\mathcal
\DeclareTeXMLMathAlphabet\mathscr
\DeclareTeXMLMathAlphabet\mathbfscr
\DeclareTeXMLMathAlphabet\mathsf
\DeclareTeXMLMathAlphabet\mathbfsf
% \DeclareTeXMLMathAlphabet\mathbfsfup
% \DeclareTeXMLMathAlphabet\mathbfit
\DeclareTeXMLMathAlphabet\mathsfit
% \DeclareTeXMLMathAlphabet\mathsfup
\DeclareTeXMLMathAlphabet\mathbb
% \DeclareTeXMLMathAlphabet\mathbbit
\DeclareTeXMLMathAlphabet\mathfrak
\DeclareTeXMLMathAlphabet\mathbffrak
\DeclareTeXMLMathAlphabet\mathtt

\DeclareTeXMLMathAccent\underbrace

\def\underbar{\underline} % Sort of.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                          MATHJAX MACROS                          %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\txt@hspace\hspace

\def\math@hspace{\@ifstar{\string\hspace}{\string\hspace}}

\def\hspace{\ifmmode\expandafter\math@hspace\else\expandafter\txt@hspace\fi}

\edef\MathJaxImg[#1]#2{%
    \string\vcenter\string{%
        \string\img[#1]\string{#2\string}%
    \string}%
}

\def\DeclareMathJaxMacro{%
  \@ifstar{\@DeclareMathJaxMacro{}}{\@DeclareMathJaxMacro{ }}%
}

\def\@DeclareMathJaxMacro#1#2{%
    \ifMathJaxMacro#2%
        % \typeout{\string#2 is already a MathJaxMacro}%
    \else
        % \typeout{Rewriting \string#2 as a MathJaxMacro}%
        \@@DeclareMathJaxMacro{#1}{#2}%
    \fi
}

\def\@@DeclareMathJaxMacro#1#2{%
    \@ifrobust{#2}{%
        \edef\@tempa{%
            \let\expandafter\noexpand\csname non@mathmode@\string#2\endcsname
            \expandafter\noexpand\csname \expandafter\@gobble\string#2 \endcsname
        }%
        \@tempa
    }{%
        \expandafter\let\csname non@mathmode@\string#2\endcsname#2%
    }%
    \let#2\relax
    \begingroup
        \edef\@tempa{%
            \noexpand\DeclareRobustCommand\noexpand#2{%
                \relax
                \noexpand\ifmmode
                    \string#2#1%
                \noexpand\else
                    \noexpand\expandafter
                    \expandafter\noexpand\csname non@mathmode@\string#2\endcsname
                \noexpand\fi
            }%
        }%
    \expandafter\endgroup
    \@tempa
}

%% See HTMLtable.pm.  These shouldn't be passed along to MathJax.

\let\noalign\@gobble
\DeclareMathJaxMacro\multicolumn %% NOT REALLY
% \DeclareMathJaxMacro\omit        %% Ha ha!  Not really!
\DeclareMathJaxMacro\hskip
% \DeclareMathJaxMacro\cr
\DeclareMathJaxMacro\hline

\DeclareMathJaxMacro\newline

\DeclareMathJaxMacro*\ %
\DeclareMathJaxMacro*\!

% \everymath{\def\!{ }}

\DeclareMathJaxMacro*\#
\DeclareMathJaxMacro*\$
\DeclareMathJaxMacro*\%

\DeclareMathJaxMacro*\&

\DeclareMathJaxMacro*\,
\DeclareMathJaxMacro*\:
\DeclareMathJaxMacro*\;
\DeclareMathJaxMacro*\>
\DeclareMathJaxMacro*\_
\DeclareMathJaxMacro*\{
\DeclareMathJaxMacro*\|
\DeclareMathJaxMacro*\}

% We once had a paper that used \big in text mode.  Srsly.

\let\Big\@empty
\let\big\@empty
\let\Bigg\@empty
\let\bigg\@empty
\let\Biggl\@empty
\let\biggl\@empty
\let\Biggm\@empty
\let\biggm\@empty
\let\Biggr\@empty
\let\biggr\@empty
\let\Bigl\@empty
\let\bigl\@empty
\let\Bigm\@empty
\let\bigm\@empty
\let\Bigr\@empty
\let\bigr\@empty

\DeclareMathJaxMacro\Big
\DeclareMathJaxMacro\big
\DeclareMathJaxMacro\Bigg
\DeclareMathJaxMacro\bigg
\DeclareMathJaxMacro\Biggl
\DeclareMathJaxMacro\biggl
\DeclareMathJaxMacro\Biggm
\DeclareMathJaxMacro\biggm
\DeclareMathJaxMacro\Biggr
\DeclareMathJaxMacro\biggr
\DeclareMathJaxMacro\Bigl
\DeclareMathJaxMacro\bigl
\DeclareMathJaxMacro\Bigm
\DeclareMathJaxMacro\bigm
\DeclareMathJaxMacro\Bigr
\DeclareMathJaxMacro\bigr

\DeclareMathJaxMacro\LaTeX
\DeclareMathJaxMacro\TeX

\DeclareMathPassThrough{displaystyle}
\DeclareMathPassThrough{scriptscriptstyle}
\DeclareMathPassThrough{scriptstyle}
\DeclareMathPassThrough{textstyle}

\DeclareMathJaxMacro\Huge
\DeclareMathJaxMacro\huge
\DeclareMathJaxMacro\LARGE
\DeclareMathJaxMacro\large
\DeclareMathJaxMacro\Large
\DeclareMathJaxMacro\normalsize
\DeclareMathJaxMacro\scriptsize
\DeclareMathJaxMacro\small
\DeclareMathJaxMacro\Tiny
\DeclareMathJaxMacro\tiny

\DeclareMathJaxMacro\bf
\DeclareMathPassThrough{cal}
\DeclareMathJaxMacro\it
\DeclareMathPassThrough{mit}
\DeclareMathJaxMacro\rm
\DeclareMathPassThrough{scr}
\DeclareMathJaxMacro\sf
\DeclareMathJaxMacro\tt

\DeclareMathJaxMacro\hphantom
\DeclareMathJaxMacro\vphantom
\DeclareMathJaxMacro\phantom

\DeclareMathJaxMacro\strut
\DeclareMathJaxMacro\smash

\DeclareMathJaxMacro\fbox

\@namedef{fbox }#1{%
    \ifmmode
        \string\fbox{\hbox{#1}}%
    \else
        \@nameuse{non@mathmode@\string\fbox}%
    \fi
}

\DeclareMathPassThrough{stackrel}[2]

\DeclareMathPassThrough{mathbin}[1]
\DeclareMathPassThrough{mathchoice}[4]
\DeclareMathPassThrough{mathclose}[1]
\DeclareMathPassThrough{mathinner}[1]
\DeclareMathPassThrough{mathop}[1]
\DeclareMathPassThrough{mathopen}[1]
\DeclareMathPassThrough{mathord}[1]
\DeclareMathPassThrough{mathpunct}[1]
\DeclareMathPassThrough{mathrel}[1]

\DeclareMathPassThrough{mathstrut}

\DeclareMathPassThrough{limits}
\DeclareMathPassThrough{nolimits}

\DeclareMathPassThrough{buildrel}
\DeclareMathPassThrough{cases}[1]
\DeclareMathJaxMacro\choose
\DeclareMathPassThrough{eqalign}[1]
\DeclareMathPassThrough{eqalignno}[1]
\DeclareMathPassThrough{leqalignno}[1]
\DeclareMathPassThrough{pmatrix}[1]
\DeclareMathJaxMacro\root

\DeclareMathPassThrough{lefteqn}[1]
\DeclareMathPassThrough{moveleft}
\DeclareMathPassThrough{moveright}
\DeclareMathPassThrough{raise}

\DeclareMathJaxMacro\enspace
\DeclareMathJaxMacro\kern
\DeclareMathJaxMacro\mkern
\DeclareMathJaxMacro\mskip
\DeclareMathJaxMacro\negthinspace
\DeclareMathJaxMacro\qquad
\DeclareMathJaxMacro\quad
\DeclareMathJaxMacro\thinspace

% \DeclareMathJaxMacro\mmlToken

\DeclareMathPassThrough{displaylines}[1]

\DeclareMathPassThrough{Arrowvert}
\DeclareMathPassThrough{arrowvert}
\DeclareMathPassThrough{backslash}
\DeclareMathPassThrough{brace}
\DeclareMathPassThrough{bracevert}
\DeclareMathPassThrough{brack}
\DeclareMathJaxMacro\dots
\DeclareMathPassThrough{Downarrow}
\DeclareMathPassThrough{downarrow}
\DeclareMathPassThrough{gets}
\DeclareMathPassThrough{int}
\DeclareMathPassThrough{langle}
\DeclareMathPassThrough{lbrace}
\DeclareMathPassThrough{lbrack}
\DeclareMathPassThrough{lceil}
\DeclareMathJaxMacro\ldots
\DeclareMathPassThrough{lfloor}
\DeclareMathPassThrough{lgroup}
\DeclareMathPassThrough{lmoustache}
\DeclareMathJaxMacro\lower
\DeclareMathPassThrough{matrix}[1]
\DeclareMathPassThrough{mho}
\DeclareMathPassThrough{middle}
\DeclareMathPassThrough{models}
\DeclareMathPassThrough{overbrace}
\DeclareMathPassThrough{owns}
\DeclareMathPassThrough{rangle}
\DeclareMathPassThrough{rbrace}
\DeclareMathPassThrough{rbrack}
\DeclareMathPassThrough{rceil}
\DeclareMathPassThrough{rfloor}
\DeclareMathPassThrough{rgroup}
\DeclareMathPassThrough{rule}
\DeclareMathPassThrough{rmoustache}
% \DeclareMathJaxMacro\Rule
\DeclareMathJaxMacro\S
\DeclareMathPassThrough{skew}
\DeclareMathPassThrough{sqrt}
\DeclareMathPassThrough{sqsubset}
\DeclareMathPassThrough{sqsupset}
\DeclareMathPassThrough{to}
\DeclareMathPassThrough{Uparrow}
\DeclareMathPassThrough{uparrow}
\DeclareMathPassThrough{Updownarrow}
\DeclareMathPassThrough{updownarrow}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            EXTENSIONS                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{DisablePackages}
\RequirePackage{HTMLtable}
\RequirePackage{Diacritics}

\endinput

__END__
