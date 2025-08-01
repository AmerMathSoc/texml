package TeX::Output::XML;

use 5.26.0;

# Copyright (C) 2022-2025 American Mathematical Society
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

use FindBin;

use List::Util qw(min uniq);

use TeX::Node::CharNode qw(:factories);

use TeX::Utils::XML;

use TeX::Class;

use TeX::Constants qw(UCS);

use TeX::Utils::Misc;

use TeX::KPSE qw(kpse_lookup);

use TeX::Interpreter;

use TeX::Node::XmlClassNode qw(:constants);

use XML::LibXML qw(:libxml);
use XML::LibXSLT;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

my %SYSTEM_ID = ("-//W3C//DTD XHTML 1.0 Transitional//EN" => "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd",
    );

my $DEFAULT_XSL_PATH = qq{$FindBin::RealBin/../lib/xsl};

## U+003A COLON is deliberately omitted because xsltproc doesn't like them.

my $XML_NameStartChar = qr{(?: [A-Z] | _ | [a-z] | [\x{C0}-\x{D6}] | [\x{D8}-\x{F6}] | [\x{F8}-\x{2FF}] | [\x{370}-\x{37D}] | [\x{37F}-\x{1FFF}] | [\x{200C}-\x{200D}] | [\x{2070}-\x{218F}] | [\x{2C00}-\x{2FEF}] | [\x{3001}-\x{D7FF}] | [\x{F900}-\x{FDCF}] | [\x{FDF0}-\x{FFFD}] | [\x{10000}-\x{EFFFF}])}smx;

## U+002E FULL STOP (.) is deliberately omitted because of
## http://stackoverflow.com/questions/70579/what-are-valid-values-for-the-id-attribute-in-html#79022

my $XML_NameChar = qr{(?: $XML_NameStartChar | - | [0-9] | \x{B7} | [\x{0300}-\x{036F}] | [\x{203F}-\x{2040}])}smxo;

my $XML_Name = qr{ (?: $XML_NameStartChar ) (?: $XML_NameChar )*}smxo;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %tex_engine_of :ATTR(:name<tex_engine> :type<TeX::Interpreter>);

my %dom_of :ATTR(:name<dom> :type<XML::LibXML::Document>);

my %hooks_of :ARRAY(:name<hook>);

my %current_element_of :ATTR(:name<current_element> :type<TeX::Output::XML::Element>);
my %element_stack_of   :ARRAY(:name<element_stack>  :type<TeX::Output::XML::Element>);

my %xml_id_of :HASH(:name<xml_id>);
my %xml_id_counter_of :COUNTER(:name<xml_id_counter>);

######################################################################
##                                                                  ##
##                           INNER CLASS                            ##
##                                                                  ##
######################################################################

package TeX::Output::XML::Element {
    use TeX::Class;

    my %node_of :ATTR(:name<node> :type<XML::LibXML::Node>);

    my %property_of :HASH(:name<property> :gethash<get_properties>);
    my %classes_of  :ARRAY(:name<class>);

    sub AUTOMETHOD {
        my ($self, $ident, @args) = @_;

        my $subname = $_;   # Requested subroutine name is passed via $_

        return sub {
            return $node_of{$ident}->$subname(@args);
        };
    }
}

sub new_xml_element {
    my $node    = shift;
    my $props   = shift || {};
    # my $classes = shift;

    return TeX::Output::XML::Element->new({ node     => $node,
                                            property => $props,
                                            # class    => $classes,
                                          });
}

######################################################################
##                                                                  ##
##                          INITIALIZATION                          ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                               WTF?                               ##
##                                                                  ##
######################################################################

## As far as I can tell, this is needed because XML::LibXML handles
## it's own character encodings and will treat characters in the
## Unicode C1 block (0x80..0xFF) as single-byte ISO Latin-1 unless
## perl's UTF8 flag is explicitly turned on, and this is the only way
## to ensure that.

my sub __new_utf8_char {
    my $char_code = shift;

    my $char = chr($char_code);

    utf8::upgrade($char);

    return $char; 
}

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub print_err {
    my $self = shift;

    my $s = shift;

    my $tex = $self->get_tex_engine();

    $tex->print_err($s);

    return;
}

sub error {
    my $self = shift;

    my $tex = $self->get_tex_engine();

    $tex->error();

    return;
}

sub fatal_error {
    my $self = shift;

    my $s = shift;

    my $tex = $self->get_tex_engine();

    $tex->fatal_error($s);

    return;
}

sub open_document {
    my $self = shift;

    my $filename = shift;  ## Dummy argument for this class.

    my $tex = $self->get_tex_engine();

    my $dom = XML::LibXML::Document->createDocument("1.0", "UTF-8");

    $self->set_dom($dom);

    my $public_id = $tex->get_xml_public_id();
    my $xml_root  = $tex->get_xml_doc_root();

    my $system_id = $tex->get_xml_system_id() || $SYSTEM_ID{$public_id};

    $dom->createInternalSubset($xml_root, $public_id, $system_id);

    my $root_node = $dom->createElement($xml_root);

    $root_node->setNamespace("http://www.w3.org/1999/xlink", "xlink", 0);

    $dom->setDocumentElement($root_node);

    $self->set_current_element(new_xml_element($root_node));

    return;
}

sub add_link {
    my $self = shift;

    my $parent = shift;

    my $atts = shift;

    my $dom = $self->get_dom();

    my $link = $dom->createElement("link");

    if (defined $atts) {
        if (ref($atts) ne 'HASH') {
            die "Stop being bloody daft";
        }

        while (my ($key, $val) = each %{ $atts }) {
            $link->setAttribute($key, $val);
        }
    }

    $parent->appendChild($link);

    return;
}

sub __normalize_id {
    my $self = shift;

    my $raw_id = shift;

    return $raw_id if $raw_id =~ m{\A $XML_Name \z}smxo;

    if (defined(my $sub_id = $self->get_xml_id($raw_id))) {
        return $sub_id;
    }

    my $new_id = "texmlid" . $self->incr_xml_id_counter();

    my $tex = $self->get_tex_engine();

    $tex->wlog("Changing XML id '$raw_id' to '$new_id'");
    $tex->wlog_ln();

    $self->set_xml_id($raw_id, $new_id);

    return $new_id;
}

sub normalize_ids {
    my $self = shift;

    my $dom = $self->get_dom();

    for my $node ($dom->findnodes("/descendant::*[\@rid]")) {
        my $id = $node->getAttribute('rid');
        my $new_id = $self->__normalize_id($id);

        if ($id ne $new_id) {
            $node->setAttribute(rid => $new_id);
        }
    }

    for my $node ($dom->findnodes("/descendant::*[\@id]")) {
        my $id = $node->getAttribute('id');
        my $new_id = $self->__normalize_id($id);

        if ($id ne $new_id) {
            $node->setAttribute(id => $new_id);
        }
    }

    for my $node ($dom->findnodes("/descendant::tex-math")) {
        $self->__replace_cssID($node);
    }

    for my $group ($dom->findnodes(qq{descendant::xref-group})) {
        if (nonempty(my $id = $group->getAttribute('first'))) {
            $group->setAttribute(first => $self->__normalize_id($id));
        }

        if (nonempty(my $id = $group->getAttribute('last'))) {
            $group->setAttribute(last => $self->__normalize_id($id));
        }

        if (nonempty(my $ids = $group->getAttribute('middle'))) {
            my @ids = split / /, $ids;

            my @new = map { $self->__normalize_id($_) } @ids;

            $group->setAttribute(middle => "@new");
        }
    }

    return;
}

sub __replace_cssID {
    my $self = shift;

    my $node = shift;

    for my $child ($node->childNodes()) {
        if ($child->nodeType() == XML_TEXT_NODE) {
            my $text = $child->data();

            $text =~ s{\\cssId\{(.*?)\}\{\}}
                      { sprintf q{\cssId{%s}{}}, $self->__normalize_id($1) }smxeg;

            $child->setData($text);
        } else {
            $self->__replace_cssID($child);
        }
    }

    return;
}

sub delete_empty_paragraphs {
    my $self = shift;

    my $dom = $self->get_dom();

    my $tex = $self->get_tex_engine();

    # Delete empty p tags.  Ideally texml wouldn't generate these, but
    # getting rid of all of them could be tricky.
    # Cf. TeX::Interpreter::__is_empty_par()

    # Question: Should we remove '@*'?  I.e., should we remove empty
    # paragraphs even if they have attributes? Ditto comments.  At
    # present we don't generate those, but there might be good reasons
    # to do so in the future.

    for my $p ($dom->findnodes(qq{/descendant::p[not(@*|*|comment()|processing-instruction()) and normalize-space()='']})) {
        $tex->print_err(qq{Deleting empty paragraph: $p});

        # $tex->error();

        $p->unbindNode();
    }

    return;
}

sub run_hooks {
    my $self = shift;

    my @stages;

    for my $hook ($self->get_hooks()) {
        my ($priority, $sub) = $hook->@*;

        push $stages[$priority]->@*, $sub;
    }

    for my $stage (@stages) {
        next unless defined $stage;

        for my $hook ($stage->@*) {
            $hook->($self);
        }
    }

    return;
}

sub finalize_document {
    my $self = shift;

    $self->run_hooks();

    $self->delete_empty_paragraphs();

    $self->normalize_ids();

    return;
}

# check_first_elements() isn't ready for use because it's hard to
# decide exactly what the constraint is.  Most of our test files
# correctly start with <p> elements.

# sub check_first_element {
#     my $self = shift;
#
#     my $tex = $self->get_tex_engine();
#
#     my $dom = $self->get_dom();
#
#     my $root = $dom->documentElement();
#
#     my $first = $root->firstChild;
#
#     while (defined $first) {
#         if ($first->nodeName() eq '#text' && empty($first->textContent())) {
#             $first = $first->nextSibling();
#         }
#
#         last;
#     }
#
#     if (! defined $first) {
#         $tex->print_err("Can't find any children of the root XML element");
#
#         $tex->error();
#     }
#
#     my $first_element = $first->nodeName();
#
#     if ($first_element ne "collection-meta" && $first_element ne "front") {
#         $tex->print_err("I found weird content at the top of the file: '$first'");
#
#         $tex->error();
#     }
#
#     return;
# }

sub close_document {
    my $self = shift;

    $self->finalize_document();

    my $tex = $self->get_tex_engine();

    my $dom = $self->get_dom();

    if (my @css_rules = $tex->get_css_rules()) {
        my $job_name = $tex->get_job_name();

        my $css_file = "$job_name.css";

        my $mode = $tex->is_unicode_input() ? ">:encoding(UTF-8)" : ">";

        open(my $fh, $mode, $css_file) or do {
            $tex->fatal_error("Can't open $css_file: $!");
        };

        for my $item (@css_rules) {
            my ($selector, $body) = @{ $item };

            if ($selector eq '@import') {
                print { $fh } qq{$selector "$body"\n};
            } else {
                print { $fh } qq{$selector { $body }\n};
            }
        }

        close($fh);
    }

    if (nonempty(my $name = $tex->get_xsl_file())) {
        my $search_path = $ENV{TEXML_XSL_PATH} || $DEFAULT_XSL_PATH;

        my $xsl_path;

        for my $path ($name, "$name.xsl") {
            $xsl_path = kpse_lookup($path, $search_path);

            last if defined $xsl_path;
        }

        if (defined $xsl_path) {
            $tex->print_nl("Applying XSL stylesheet '$xsl_path'");

            my $style_doc = XML::LibXML->load_xml(location => $xsl_path,
                                                  no_cdata => 1);

            my $xslt = XML::LibXSLT->new();

            my $stylesheet = $xslt->parse_stylesheet($style_doc);

            $dom = $stylesheet->transform($dom);

            $self->set_dom($dom);
        } else {
            $tex->print_err("Can't find XSL file '$name'");

            $tex->error();
        }
    }

    return $dom;
}

sub append_text {
    my $self = shift;

    my $text = shift;

    return if length($text) == 0;

    my $current_element = $self->get_current_element();

    $current_element->appendText($text);

    return;
}

sub createElement {
    my $self = shift;

    return $self->get_dom()->createElement(@_);
}

sub push_element {
    my $self = shift;

    my TeX::Output::XML::Element $element = shift;

    my $current_element = $self->get_current_element();

    if (! defined $current_element) {
        $self->fatal_error("No current element in push_element!");

        return;
    }

    $self->push_element_stack($current_element);

    $current_element->appendChild($element->get_node());

    $self->set_current_element($element);

    return;
}

sub pop_element {
    my $self = shift;

    my $qName = shift;

    my $current_element = $self->get_current_element();

    if (! defined $current_element) {
        $self->fatal_error("No current element in pop_element!");

        return;
    }

    my $current_name = $current_element->nodeName();

    if ($current_name ne $qName) {
        $self->print_err("Current element name '$current_name' does not match '$qName' in pop_element!");

        $self->error();

        return;
    }

    ## TBD: Copy classes and styles from $current_element to $current_element->get_node;

    my $tex = $self->get_tex_engine();

    my $properties = $current_element->get_properties();

    my @classes;

    for my $k (sort keys %{ $properties }) {
        my $v = $properties->{$k};

        if (nonempty($k) && nonempty($v)) {
            my $class = $tex->find_css_class($k, $v);

            push @classes, $class;
        }
    }

    if (@classes) {
        $current_element->setAttribute(class => join " ", uniq @classes);
    }

    my $top = $self->pop_element_stack();

    if (! defined $top) {
        $self->fatal_error("Can't pop empty element stack!");

        return;
    }

    $self->set_current_element($top);

    return;
}

sub open_element {
    my $self = shift;

    my $qName = shift;
    my $ns    = shift;
    my $atts  = shift;
    my $props = shift;

    my $dom = $self->get_dom();

    my $element;

    if (empty($ns)) {
        $element = $dom->createElement($qName);
    } else {
        $element = $dom->createElementNS($ns, $qName);
    }

    if (defined($atts)) {
        while (my ($key, $val) = each %{ $atts }) {
            if (nonempty($key)) {
                $element->setAttribute($key, $val);
            }
        }
    }

    $self->push_element(new_xml_element($element, $props));

    return;
}

sub close_element {
    my $self = shift;

    my $qName = shift;

    $self->pop_element($qName);

    return;
}

sub add_attribute {
    my $self = shift;

    my $qName = shift;
    my $value = shift;

    if (nonempty($value)) {
        my $current_element = $self->get_current_element();

        $current_element->setAttribute($qName, $value);
    }

    return;
}

sub modify_class {
    my $self = shift;

    my $opcode = shift;
    my $value  = shift;

    my $qName = "class";

    my $current_element = $self->get_current_element();

    my $old_class = $current_element->getAttribute($qName);

    my @classes;

    if (nonempty($old_class)) {
        @classes = split /\s+/, $old_class;
    }

    if ($opcode == XML_SET_CLASSES) {
        if (nonempty($value)) {
            @classes = ($value);
        } else {
            @classes = ();
        }
    }
    elsif ($opcode == XML_ADD_CLASS) {
        push @classes, $value if nonempty $value;
    }
    elsif ($opcode == XML_DELETE_CLASS) {
        @classes = grep { $_ ne $value } @classes;
    }
    else {
        $self->print_err("Unknown XML class opcode '$opcode'");

        $self->err();
    }

    if (@classes) {
        my $new_class = join " ", sort { $a cmp $b } (uniq @classes);

        $current_element->setAttribute($qName, join ' ', $new_class);
    } else {
        $current_element->removeAttribute($qName);
    }

    return;
}

sub set_css_property {
    my $self = shift;

    my $property = shift;
    my $value    = shift;

    return if empty($property);

    my $current_element = $self->get_current_element();

    if (empty($value)) {
        $current_element->delete_property($property);
    } else {
        $current_element->set_property($property, $value);
    }

    return;
}

######################################################################
##                                                                  ##
##                     [32] SHIPPING PAGES OUT                      ##
##                                                                  ##
######################################################################

sub hlist_out {
    my $self = shift;

    my $box = shift;

    my $tex = $self->get_tex_engine();

    my @nodes = $box->get_nodes();

    while (defined(my $node = shift @nodes)) {
        if ($node->isa('TeX::Token')) { ## Extension
            $self->append_text($node);

            next;
        }

        ## HLIST ONLY

        if ($node->isa('TeX::Node::MathNode')) {
            $self->append_text(" "); # ???

            next;
        }

        if ($node->isa('TeX::Node::UTemplateMarker')) {
            next;
        }

        ## HLIST SPECIFIC HANDLING

        if ($node->is_glue()) {
            $self->append_text(" ");

            next;
        }

        if ($node->is_kern()) {
            $self->append_text(" ");

            next;
        }

        ## COMMON

        if ($node->isa('TeX::Node::Extension::UnicodeStringNode')) {
            $self->append_text($node->get_contents());

            next;
        }

        if ($node->is_char_node()) {
            my $enc = $node->get_encoding();

            my $char_code = $node->get_char_code();

            if ($enc ne UCS) {
                $char_code = $tex->decode_character($char_code, $enc);
            }

            $self->append_text(__new_utf8_char($char_code));

            next;
        }

        if ($node->isa('TeX::Node::XmlNode')) {
            $self->output_xml_node($node);

            next;
        }

        if ($node->is_vbox()) {
            $self->vlist_out($node);

            next;
        }

        if ($node->is_hbox()) {
            $self->hlist_out($node);

            next;
        }

        if ($node->is_rule()) {
            ## rule_ht := height(p);
            ## rule_dp := depth(p);
            ## rule_wd := width(p);
            ## goto fin_rule;

            $tex->print_err("RuleNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa("TeX::Node::FileNode")) {
            $tex->do_file_output($node);

            next;
        }

        if ($node->isa("TeX::Node::LanguageNode")) {
            ## NO-OP

            next;
        }

        if ($node->isa("TeX::Node::WhatsitNode")) {
            ## @<Output the whatsit node |p| in an hlist@>;

            my $type = ref($node);

            $tex->print_err("$type not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa('TeX::Node::MarkNode')) {
            next;
        }

        if ($node->isa('TeX::Node::PenaltyNode')) {
            next;
        }

        $tex->print_err("I didn't expect to find '$node' (",
                        ref($node),
                        ") in the middle of an hlist!");

        $tex->error();
    }

    return;
}

sub vlist_out {
    my $self = shift;

    my $box = shift;

    my $tex = $self->get_tex_engine();

    my @nodes = $box->get_nodes();

    while (defined(my $node = shift @nodes)) {
        if ($node->isa('TeX::Token')) { ## Extension
            $self->append_text($node);

            next;
        }

        ## VLIST SPECIFIC HANDLING

        if ($node->is_glue()) {
            ## IGNORE

            next;
        }

        if ($node->is_kern()) {
            ## IGNORE

            next;
        }

        ## COMMON

        if ($node->isa('TeX::Node::Extension::UnicodeStringNode')) {
            $self->append_text($node->get_contents());

            next;
        }

        if ($node->is_char_node()) {
            # This should no longer happen.

            $tex->confusion("vlistout: character '$node' in vmode");

            # # ...but it does.

            # my $char = __new_utf8_char($node->get_char_code());

            # $self->append_text($char);

            next;
        }

        if ($node->isa('TeX::Node::XmlNode')) {
            $self->output_xml_node($node);

            next;
        }

        if ($node->is_vbox()) {
            $self->vlist_out($node);

            next;
        }

        if ($node->is_hbox()) {
            $self->hlist_out($node);

            next;
        }

        if ($node->is_rule()) {
            ## rule_ht := height(p);
            ## rule_dp := depth(p);
            ## rule_wd := width(p);
            ## goto fin_rule;

            $tex->print_err("RuleNodes not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa("TeX::Node::FileNode")) {
            $tex->do_file_output($node);

            next;
        }

        if ($node->isa("TeX::Node::LanguageNode")) {
            ## NO-OP

            next;
        }

        if ($node->isa("TeX::Node::WhatsitNode")) {
            ## @<Output the whatsit node |p| in an hlist@>;

            my $type = ref($node);

            $tex->print_err("$type not implemented yet");
            $tex->error();

            next;
        }

        if ($node->isa('TeX::Node::MarkNode')) {
            next;
        }

        if ($node->isa('TeX::Node::PenaltyNode')) {
            next;
        }

        $tex->print_err("I didn't expect to find '$node' (",
                        ref($node),
                        ") in the middle of an hlist!");

        $tex->error();
    }

    return;
}

sub output_xml_node {
    my $self = shift;

    my $node = shift;

    my $tex = $self->get_tex_engine();

    if ($node->isa("TeX::Node::XmlComment")) {
        my $comment = $node->get_comment();

        if (nonempty($comment)) {
            my $dom = $self->get_dom();

            $dom->appendChild(XML::LibXML::Comment->new( $comment ));
        }

        return;
    }

    if ($node->isa("TeX::Node::MathOpenNode")) {
        my $qName = $node->get_qName();

        if (nonempty($qName)) {
            my $ns    = undef;
            my $atts  = { "content-type" => "math/tex" };

            $self->open_element($qName, $ns, $atts);

            if (nonempty(my $tex_math_tag = $node->get_inner_tag())) {
                $self->open_element($tex_math_tag, $ns);
            }
        }

        return;
    }

    if ($node->isa("TeX::Node::MathCloseNode")) {
        my $qName = $node->get_qName();

        if (nonempty($qName)) {
            if (nonempty(my $tex_math_tag = $node->get_inner_tag())) {
                $self->close_element($tex_math_tag);
            }

            $self->close_element($qName);
        }

        return;
    }

    if ($node->isa("TeX::Node::XmlOpenNode")) {
        my $qName = $node->get_qName();
        my $ns    = $node->get_namespace();
        my $atts  = $node->get_attributes();
        my $props = $node->get_properties();

        # if (my $rules = $node->list_css_rules()) {
        #     $atts->{class} = $classes;
        # }

        $self->open_element($qName, $ns, $atts, $props);

        return;
    }

    if ($node->isa("TeX::Node::XmlCloseNode")) {
        my $qName = $node->get_qName();

        $self->close_element($qName);

        return;
    }

    if ($node->isa("TeX::Node::XmlClassNode")) {
        my $value  = $node->get_value();
        my $opcode = $node->get_opcode();

        $self->modify_class($opcode, $value);

        return;
    }

    if ($node->isa("TeX::Node::XmlCSSpropNode")) {
        my $property = $node->get_property();
        my $value    = $node->get_value();

        $self->set_css_property($property, $value);

        return;
    }

    if ($node->isa("TeX::Node::XmlAttributeNode")) {
        my $qName = $node->get_qName();
        my $value = $node->get_value();

        $self->add_attribute($qName, $value);

        return;
    }

    if ($node->isa("TeX::Node::XmlImportNode")) {
        my $xml_file = $node->get_xml_file();
        my $xpath    = $node->get_xpath();

        $tex->print_nl("%% Importing XML file $xml_file");
        $tex->print_nl("%% XPath selector: $xpath");

        my $xml_doc = eval { XML::LibXML->load_xml(location => $xml_file,
                                                   no_cdata => 1) };

        if (! defined $xml_doc) {
            $tex->print_err("Can't open XML file '$xml_file'");

            return;
        }

        my $fragment = $xml_doc->find($xpath);

        my $size = defined $fragment ? $fragment->size() : 0;

        if ($size == 0) {
            $tex->print_err("No match for '$xpath' in '$xml_file'");

            return;
        }

        $tex->print_nl("%% Found $size matching element" . ($size == 1 ? "" : "s"));

        $tex->print_ln();

        my $current_element = $self->get_current_element();

        for my $node ($fragment->get_nodelist()) {
            $current_element->appendChild($node);
        }

        return;
    }

    $tex->print_err("Unknown XML node type ", ref($node), "!");
    $tex->error();

    return;
}

1;

__END__
