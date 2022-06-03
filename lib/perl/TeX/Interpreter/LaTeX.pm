package TeX::Interpreter::LaTeX;

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

use base qw(TeX::Interpreter Exporter);

our %EXPORT_TAGS = ( handlers => [ qw(do_gobble_opt
                                      do_opt_gobble
                                      do_star_opt_gobble
                                      make_gobbler
                                   ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{handlers} } );

our @EXPORT;

use List::Util qw(uniq);

use Digest::MD5 qw(md5_hex);

use File::Spec::Functions qw(catdir);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::KPSE qw(kpse_lookup);

use TeX::Interpreter qw(make_eqvt END_TEX_TOKEN);

use File::Basename;

use File::Copy;

use File::Spec::Functions qw(rel2abs);

use TeX::Class;

use TeX::Utils::Misc;

use TeX::Node::Utils qw(nodes_to_string);

use TeX::Constants qw(:booleans :named_args :module_codes);

use TeX::Token qw(:catcodes :factories);

use TeX::Token::Constants;

use TeX::TokenList;

use TeX::WEB2C qw(:command_codes :scan_types :selector_codes :token_types);

use TeX::Primitive::Parameter qw(:factories);

# use TeX::KPSE qw(kpse_lookup);

use TeX::Utils::SVG;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %document_class_of :ATTR(:name<document_class>);

# my %document_labels_of   :HASH(:name<document_label>);
# my %document_bibcites_of :HASH(:name<document_bibcite>);

######################################################################
##                                                                  ##
##                     PRIVATE CLASS CONSTANTS                      ##
##                                                                  ##
######################################################################

##***???? Why did something bad happen when these were scalars?
##***Somehow the datum became empty in make_newenvironment_handler().

my $END_TOKEN = make_csname_token("end");

use constant PAR_TOKEN => make_csname_token("par");

use constant ELT_TOKEN => make_csname_token('@elt');

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub INITIALIZE :CUMULATIVE(BASE FIRST) {
    my $tex = shift;

    $tex->set_log_ext("xlog");
    $tex->set_output_ext("xml");

    if (nonempty(my $tex_file = $tex->get_file_name())) {
        $tex->set_file_name($tex_file);
    }

    $tex->define_csname('@filtered@input' => \&do_filtered_input);

    $tex->define_pseudo_macro('@opt@gobble' => \&do_opt_gobble);

    $tex->define_counter('@ckpt');

    $tex->define_pseudo_macro('TeXMLCreateSVG' => \&do_texml_create_svg);
    $tex->define_pseudo_macro('TeXMLImportSVG' => \&do_texml_import_svg);

    $tex->define_csname(LoadRawMacros => \&do_load_raw_macros);

    return;
}

######################################################################
##                                                                  ##
##                          LATEX SUPPORT                           ##
##                                                                  ##
######################################################################

sub is_starred {
    my $tex = shift;

    my $next_token = $tex->peek_next_token();

    if (defined $next_token && $next_token == STAR) {
        $tex->get_next();

        return 1;
    }

    return;
}

sub scan_optional_argument {
    my $tex = shift;

    if (my @args = $tex->scan_macro_parameters(undef, OPT_ARG, true)) {
        ##* TODO???
        # my @tokens = $tex->expand_tokens(@{ $args[1] });

        # TRACE "\$args[1] = '$args[1]'\n";

        return $args[1];
    }

    return;
}

sub do_load_raw_macros {
    my $tex = shift;

    my $basename = $tex->expansion_of('@currname');
    my $file_ext = $tex->expansion_of('@currext');

    my $file_name = qq{$basename.$file_ext};

    my $path = kpse_lookup($file_name);

    if (empty($path)) {
        $tex->print_err("I can't find file `$file_name'.");

        return;
    }

    $tex->process_file($path);

    return;
}

######################################################################
##                                                                  ##
##                         [53] EXTENSIONS                          ##
##                                                                  ##
######################################################################

## This override is necessary until we implement enough of \output to
## allow the resetting of \protect to be done by macros.

sub write_out {
    my $tex = shift;

    my $node = shift;

    my $old_setting = $tex->selector();

    my $fileno = $node->fileno();

    ## Note that the token list has to be expanded *before* the
    ## selector is adjusted in case the expansion causes output (for
    ## example, if \tracingmacros is non-zero).

    my $token_list = $node->get_token_list();

    $tex->begingroup(); # LaTeX contamination

    $tex->let_csname(protect => "noexpand"); # LaTeX contamination

    my $expanded = $tex->expand_token_list($token_list);

    $tex->endgroup(); # LaTeX contamination

    if ($tex->get_write_open($fileno)) {
        $tex->set_selector($fileno);
    } else {
        if ( $fileno == 17 && $old_setting == term_and_log) {
            $tex->set_selector(log_only);
        }

        $tex->print_nl("");
    }

    $tex->token_show($expanded);

    $tex->print_ln();

    $tex->set_selector($old_setting);

    return;
}

######################################################################
##                                                                  ##
##                            UTILITIES                             ##
##                                                                  ##
######################################################################

## do_filtered_input() intercepts files that might need special handling:
##
##     Misc. graphics       : Convert to SVG

## TODO: Move this into TeX::Interpreter::start_input().  Or just get rid of it?

sub do_filtered_input {
    my $tex   = shift;
    my $token = shift;

    my $file_name = $tex->scan_file_name();

    if ($file_name =~ m{\.(eps_tex|pstex_t) \z}smx) {
        # Inkscape (and others?) graphics wrappers

        my $replacement = $tex->tokenize(qq{\\TeXMLCreateSVG{\\input{$file_name}}});

        $tex->begin_token_list($replacement, macro);

        return;
    }

    $tex->process_file($file_name);

    return;
}

######################################################################
##                                                                  ##
##                              ERRORS                              ##
##                                                                  ##
######################################################################

sub latex_error {
    my $tex = shift;

    my $error = shift;

    $tex->print_err("LaTeX error: $error");

    $tex->error();

    return;
}

######################################################################
##                                                                  ##
##                             COUNTERS                             ##
##                                                                  ##
######################################################################

## Interface for accessing LaTeX counters from perl.

sub __get_raw_reset_list {
    my $tex = shift;

    my $counter_name = shift;

    my $eqvt = $tex->get_csname("cl\@$counter_name");

    return unless defined $eqvt;

    my $macro = $eqvt->get_equiv();

    return unless eval { $macro->isa("TeX::Primitive::Macro") };

    return $macro; #->get_replacement_text();
}

sub get_counter_reset_list {
    my $tex = shift;

    my $counter_name = shift;

    my $reset_list = $tex->__get_raw_reset_list($counter_name);

    return unless defined $reset_list;

    my $replacement_text = $reset_list->get_replacement_text();

    return unless defined $replacement_text;

    my $list = $replacement_text->to_string();

    my @reset_list;

    while ($list =~ s{\A \\\@elt \s* \{ (.*?) \} \z}{}smx) {
        push @reset_list, $1;
    }

    return @reset_list;
}

sub add_to_reset {
    my $tex = shift;

    my $child_counter  = shift;
    my $parent_counter = shift;

    my $macro_name = "cl\@$parent_counter";

    my $eqvt = $tex->get_csname($macro_name);

    if (! defined $eqvt) {
        $tex->print_err("No counter '$parent_counter' defined");
        $tex->error();

        return;
    }

    my $macro = $eqvt->get_equiv();

    ##* TODO: ERROR
    return unless eval { $macro->isa("TeX::Primitive::Macro") };

    $macro = $macro->clone();

    my $list_r = $macro->get_replacement_text();

    $list_r->push(ELT_TOKEN);
    $list_r->push($tex->tokenize("{$child_counter}"));

    $macro->set_replacement_text($list_r);

    $tex->define_csname($macro_name, $macro, MODIFIER_GLOBAL);

    return;
}

sub define_counter {
    my $tex = shift;

    my $counter_name   = shift;
    my $parent_counter = shift;

    my $csname = "c\@$counter_name";

    my $eqvt = make_eqvt(0, level_one);

    my $counter = make_integer_parameter($csname, \$eqvt);

    $tex->define_csname($csname, $counter);

    $tex->let_csname("cl\@$counter_name", '@empty', MODIFIER_GLOBAL);

    $tex->add_to_reset($counter_name, '@ckpt');

    if (nonempty($parent_counter)) {
        $tex->add_to_reset($counter_name, $parent_counter);
    }

    $tex->let_csname("p\@$counter_name", '@empty', MODIFIER_GLOBAL);

    $tex->define_pseudo_macro("the$counter_name",
                       sub {
                           my $macro = shift;

                           my $tex = shift;
                           my $token = shift;

                           my $number = $tex->get_counter_value($counter_name);

                           return $tex->str_toks($number);
                       });

    return;
}

sub get_counter {
    my $tex = shift;

    my $counter_name = shift;

    my $eqvt = $tex->get_csname("c\@$counter_name");

    if (! defined $eqvt) {
        $tex->print_err("Unknown counter '$counter_name'");

        $tex->error();

        return;
    }

    my $assign_int = $eqvt->get_equiv();

    ## There should probably be a cleaner way to test for this.

    my $is_int = eval { $assign_int->isa("TeX::Primitive::Parameter")} &&
        $assign_int->get_level() == int_val;

    if (! $is_int) {
        $tex->fatal_error("Can't setcounter a " . ref($assign_int));
    }

    my $eqvt_ptr = $assign_int->get_eqvt_ptr();

    return $assign_int;
}

sub set_counter_value {
    my $tex = shift;

    my $counter_name = shift;
    my $new_value    = shift;

    if (defined(my $assign_int = $tex->get_counter($counter_name))) {
        $assign_int->assign_value($tex, $new_value, MODIFIER_GLOBAL);
    }

    return;
}

sub get_counter_value {
    my $tex = shift;

    my $counter_name = shift;

    if (defined(my $assign_int = $tex->get_counter($counter_name))) {
        return $assign_int->read_value($tex);
    }

    return 0;
}

sub add_to_counter {
    my $tex = shift;

    my $counter_name = shift;
    my $increment    = shift;

    if (defined(my $assign_int = $tex->get_counter($counter_name))) {
        my $old_value = $assign_int->read_value();

        my $new_value = $old_value + $increment;

        $assign_int->assign_value($tex, $new_value, MODIFIER_GLOBAL);

        return $new_value;
    }

    ##* ERROR

    return;
}

sub step_counter {
    my $tex = shift;

    my $counter_name = shift;

    return unless defined $tex->get_counter($counter_name);

    my $new_value = $tex->add_to_counter($counter_name, 1);

    for my $child_counter ($tex->get_counter_reset_list($counter_name)) {
        $tex->set_counter_value($child_counter, 0);
    }

    return $new_value;
}

######################################################################
##                                                                  ##
##                         SECTION HEADINGS                         ##
##                                                                  ##
######################################################################

my %section_stack_of :ARRAY(:name<section_stack>);
my %toc_stack_of :ARRAY(:name<toc_stack>);

######################################################################
##                                                                  ##
##                          EXTRA METHODS                           ##
##                                                                  ##
######################################################################

sub get_module_options {
    my $tex = shift;

    my $name = shift;
    my $ext  = shift;

    if (defined (my $options = $tex->expansion_of("opt\@${name}.${ext}"))) {
        return split /\s*,\s*/, $options;
    }

    return;
}

sub set_module_options {
    my $tex = shift;

    my $name = shift;
    my $ext  = shift;

    my @options = @_;

    my $opt_string = join ",", uniq @options;

    if (nonempty($opt_string)) {
        $tex->define_csname(qq{opt\@$name.$ext}, $opt_string, MODIFIER_GLOBAL);
    }

    return;
}

# sub add_module_option {
#     my $tex = shift;
# 
#     my $name = shift;
#     my $ext  = shift;
# 
#     my @options = @_;
# 
#     $self->set_module_options($name, $ext,
#                               $tex->get_module_options($name, $ext),
#                               @options);
# 
#     return;
# }
# 
# sub delete_module_option {
#     my $tex = shift;
# 
#     my $name = shift;
#     my $ext  = shift;
# 
#     my $option = shift;
# 
#     my @options = grep { $_ ne $option } $tex->get_module_options($name, $ext);
# 
#     $tex->set_module_option($name, $ext, @options);
# 
#     return;
# }

## Requires an explicit \end{ENVNAME}.  Doesn't handle nested
## occurrences of the same environment.

sub scan_environment_body {
    my $tex = shift;

    my $envname = shift;

    my $body = TeX::TokenList->new();;

    while (my $token = $tex->get_next()) {
        if ($token == $END_TOKEN) {
            my $endname = $tex->read_undelimited_parameter(EXPANDED);

            if ($endname eq $envname) {
                $tex->endgroup(); # Close the group opened by \begin{$envname}

                last;
            }

            $body->push($token, BEGIN_GROUP, $endname, END_GROUP);

            next;
        }

        $body->push($token);
    }

    return $body;
}

## process_undelimited_parameter() is similar to
## read_undelimited_parameter(EXPANDED), except that it also invokes perl
## handlers.

## This will probably go away.

sub process_undelimited_parameter {
    my $tex = shift;

    my $token_list = shift;

    if (! defined $token_list) {
        $token_list = $tex->read_undelimited_parameter();
    }

    $token_list->push(END_TEX_TOKEN);

    $tex->begin_token_list($token_list, inserted);

    $tex->push_nest();

    $tex->main_control();

    $tex->end_token_list();

    $token_list->pop();

    my @nodes = $tex->pop_nest();

    return wantarray ? @nodes : nodes_to_string(@nodes);
}

## Move to PRD/Document/Builder/LaTeX2.pm?

sub read_aux_file {
    my $tex = shift;

    my $jobname = $tex->get_job_name();

    my $aux_file = "$jobname.aux";

    return unless -r $aux_file;
            
    my $at_cat = $tex->get_catcode(ord('@'));

    $tex->set_catcode(ord('@'), CATCODE_LETTER);

    $tex->process_file($aux_file);

    $tex->set_catcode(ord('@'), $at_cat);

    return;
}

######################################################################
##                                                                  ##
##                           SVG CREATION                           ##
##                                                                  ##
######################################################################

use constant SVG_DIR => "Images";

sub do_texml_create_svg {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    ## Ignore explicit *'s and just check for math mode.
    ## URG: This might fail for $\text{\includegraphics{...}}$

    my $starred = $tex->is_starred();

    my $is_mmode = ! $tex->is_mmode();

    my $opt = $tex->scan_optional_argument();

    my $tex_fragment = $tex->read_undelimited_parameter();

    my $scale_factor = 1;

    if ($tex_fragment =~ m{\\includegraphics}) {
        my $svg_mag = $tex->TeXML_SVG_mag();

        $scale_factor = $svg_mag/1000;
    }

    if (defined(my $pinlabel = $tex->get_csname("thelabellist"))) {
        if (defined(my $equiv = $pinlabel->get_equiv())) {
            my $token_list = $equiv->macro_call($tex);

            if (defined $token_list && $token_list->length()) {
                $tex_fragment->unshift($token_list);
            }

            $tex->let_csname('thelabellist', '@empty', MODIFIER_GLOBAL);
        }
    }

    my $md5_sum = md5_hex($tex_fragment->to_string());

    my $id = "img$md5_sum";

    if (! -e SVG_DIR) {
        mkdir SVG_DIR or do {
            $tex->print_err("Unable to create " . SVG_DIR . " directory");

            $tex->error();

            return;
        };
    }

    my $out_file = catdir(SVG_DIR, "$id.svg");

    my $regenerate = $tex->do_svg();

    if (-e $out_file) {
        my $tex_file = $tex->get_file_name();

        my $m_in  = file_mtime($tex_file);
        my $m_out = file_mtime($out_file);

        if (defined $m_in && defined $m_out && $m_in < $m_out) {
            $tex->print_nl("Found up-to-date $out_file.  Not regenerating.");

            $regenerate = 0;
        }
    }

    if ($regenerate) {
        my $svg = $tex->get_svg_agent();

        if ($scale_factor != 1) {
            $tex_fragment = qq{\\scalebox{$scale_factor}{$tex_fragment}};
        }

        my $svg_file = $svg->convert_tex($tex_fragment, $id, $tex, $starred);

        if (empty($svg_file)) {
            $tex->start_xml_element("MISSING_SVG_GRAPHIC");
            $tex->end_xml_element("MISSING_SVG_GRAPHIC");

            return;
        } else {
            copy($svg_file, $out_file) or do {
                $tex->fatal_error("Couldn't copy $svg_file to $out_file: $!");
            };

            $tex->print_nl("Wrote SVG file $out_file");
            $tex->print_ln();
        }
    }

    my $expansion;

    return unless nonempty($out_file) && -e $out_file;

    if ($is_mmode) {
        if (nonempty($opt)) {
            $expansion = qq{\\TeXMLImportGraphic[$opt]{$out_file}};
        } else {
            $expansion = qq{\\TeXMLImportGraphic{$out_file}};
        }
    } else {
        my $doc = XML::LibXML->load_xml(location => $out_file);

        my $root = $doc->documentElement();

        my $width  = $root->getAttribute("width");
        my $height = $root->getAttribute("height");

        my $size = qq{width=$width,height=$height};

        if (empty($opt)) {
            $opt = $size;
        } else {
            $opt .= "," . $size;
        }

        $expansion = qq{\\MathJaxImg[$opt]{$out_file}};
    }

    return $tex->tokenize($expansion);
}

sub do_texml_import_svg {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $svg_path = $tex->read_undelimited_parameter();

    if (empty($svg_path)) {
        $tex->print_err("LaTeX error: No SVG file given");

        $tex->error();

        return;
    } elsif (! -e $svg_path) {
        $tex->print_err("LaTeX error: Can't find $svg_path");

        $tex->error();

        return;
    }

    my $expansion;

    if ($tex->is_mmode()) {
        my $doc = XML::LibXML->load_xml(location => $svg_path);

        my $root = $doc->documentElement();

        my $width  = $root->getAttribute("width");
        my $height = $root->getAttribute("height");

        $expansion = qq{\\MathJaxImg[width=$width,height=$height]{$svg_path}};
    } else {
        $expansion = qq{\\TeXMLImportGraphic{$svg_path}};
    }

    return $tex->tokenize($expansion);
}

######################################################################
##                                                                  ##
##                             HANDLERS                             ##
##                                                                  ##
######################################################################

## Gobble an optional argument plus a required argument.

sub do_gobble_opt( $$ ) {
    my $tex   = shift;
    my $token = shift;

    $tex->scan_optional_argument();

    $tex->read_undelimited_parameter();

    $tex->ignorespaces();

    return;
}

## Gobble an optional argument.

sub do_opt_gobble( $$ ) {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt = $tex->scan_optional_argument();

    return;
}

## Gobble an optional * optionally followed by an optional argument.

sub do_star_opt_gobble( $$ ) {
    my $tex   = shift;
    my $token = shift;

    $tex->is_starred();

    $tex->scan_optional_argument();

    return;
}

sub make_gobbler( $ ) {
    my $n = shift;

    return sub {
        my $tex   = shift;
        my $token = shift;

        for (1..$n) {
            $tex->read_undelimited_parameter();
        }

    };
}

1;

__END__
