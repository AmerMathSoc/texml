package TeX::FMT::Mem;

use v5.26.0;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use TeX::Arithmetic qw(scaled_to_string);

use TeX::Constants qw(:node_params);

use TeX::Nodes qw(:factories);
use TeX::Node::CharNode qw(:factories);
use TeX::Node::HListNode qw(:factories);

use TeX::Type::GlueSpec qw(:factories);

use TeX::FMT::MemoryWord;

use Carp;

sub print_esc {
    my $string = shift;

    print "\\$string";

    return;
}

use TeX::Class;

my %mem :ATTR();

my %fmt          :ATTR(:get<fmt>          :set<fmt>);
my %mem_top      :ATTR(:get<mem_top>      :set<mem_top>);
my %lo_mem_max   :ATTR(:get<lo_mem_max>   :set<lo_mem_max>);
my %hi_mem_min   :ATTR(:get<hi_mem_min>   :set<hi_mem_min>);

my %params_of :ATTR(:name<params>);

sub NULL { $_[0]->null };

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $mem{$ident} = {};

    return;
}

sub get_font {
    my $self = shift;

    my $fnt_num = shift;

    return $self->get_fmt()->get_font($fnt_num);
}

sub set_word {
    my $self = shift;

    my $ptr  = shift;
    my $word = shift;

    if (! eval { $word->isa("TeX::FMT::MemoryWord") }) {
        $word = TeX::FMT::MemoryWord->new({ record => $word });
    }

    return $mem{ident $self}->{$ptr} = $word;
}

sub get_word {
    my $self = shift;

    my $ptr  = shift;

    return $mem{ident $self}->{$ptr};
}

sub get_link {
    my $self = shift;
    my $ptr  = shift;

    my $word = $self->get_word($ptr);

    confess "Undefined word at $ptr" unless defined $word;

    return $word->get_rh();
}

sub get_info {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_lh();
}

sub get_token_ref_count {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_lh();
}

sub get_type {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_hh_b0();
}

sub get_subtype {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_hh_b1();
}

sub get_node_size {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_lh();
};

sub get_llink {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_info($ptr + 1);
};

sub get_rlink {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_link($ptr + 1);
};

sub get_glue_ref_count {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_link($ptr);
}

sub get_stretch {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 2)->get_sc();
}

sub get_shrink {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 3)->get_sc();
}

sub get_width {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 1)->get_sc();
}

sub get_depth {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 2)->get_sc();
}

sub get_height {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 3)->get_sc();
}

sub get_shift_amount {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 4)->get_sc();
}

sub get_list_ptr {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 5)->get_link();
}

sub get_glue_order {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 5)->get_subtype();
}

sub get_glue_sign {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 5)->get_type();
}

sub get_glue_set {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 6)->get_gr();
}

sub get_float_cost {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 1)->get_int();
}

sub get_ins_ptr {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 4)->get_info();
}

sub get_split_top_ptr {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr + 4)->get_link();
}

sub get_stretch_order {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_type($ptr);
}

sub get_shrink_order {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_subtype($ptr);
}

sub get_glue {
    my $self = shift;
    my $ptr  = shift;

    return make_glue_spec($self->get_width($ptr),
                          [ $self->get_stretch($ptr), $self->get_stretch_order($ptr) ],
                          [ $self->get_shrink($ptr),  $self->get_shrink_order($ptr) ]
);
}

sub show_word {
    my $self = shift;
    my $ptr  = shift;

    my $fmt = shift;

    my $info = $self->get_info($ptr);
    my $link = $self->get_link($ptr);

    my $type = $self->get_type($ptr);
    my $subtype = $self->get_subtype($ptr);

    print "mem($ptr): info=$info; link=$link; type=$type; subtype=$subtype\n";

    return;
}

{
    my $param_no = 0;

sub show_token_list {
    my $self = shift;

    my $fmt = shift;

    my $ref_count = shift;

    return if $ref_count == $fmt->null();

    # print "show_token_list: ref_count = $ref_count\n";

    # print "\ntoken_ref_count($ref_count) = " . $self->get_token_ref_count($ref_count) . "\n";
    # print "link($ref_count) = " . $self->get_link($ref_count) . "\n";

    $param_no = 0;

    for (my $p = $self->get_link($ref_count); $p != $self->NULL; $p = $self->get_link($p)) {
        eval { $self->show_token($p, $fmt) };

        if ($@) {
            print "show_token error for token $p:\n";
            print "\t$@\n";
            print "end error\n";
            print "NULL=" . $self->NULL . "\n";
        }
    }

    return;
}

sub show_token {
    my $self = shift;
    my $p = shift;
    my $fmt = shift;

    my $info = $self->get_info($p);

    if ($info >= $self->cs_token_flag) {
        $self->print_cs($info - $self->cs_token_flag, $fmt);
    } else {
        use integer;

        my $m;
        my $c;

        if ($self->is_xetex()) {
            $m = $info / 010000000;
            $c = $info % 010000000;
        } else {
            $m = $info / 0400;
            $c = $info % 0400;
        }

        if (   $m < $self->car_ret   || $m == $self->sup_mark
            || $m == $self->sub_mark || $m == $self->spacer
            || $m == $self->letter   || $m == $self->other_char) {
            print chr($c);
            return;
        }

        if ($m == $self->mac_param) {
            print chr($c) . chr($c);
            return;
        }

        if ($m == $self->out_param) {
            print "#";

            if ($c <= 9) {
                print chr($c + ord("0"));
            } else {
                print "!";
            }

            return;
        }

        if ($m == $self->match) {
            print "#" . ++$param_no;
            return;
        }

        if ($m == $self->end_match) {
            print "->";
            return;
        }

        print_esc "BAD.{c=$c;m=$m;info=$info}";
    }

    return;
}

}

sub print_cs {
    my $self = shift;

    my $p = shift;
    my $fmt = shift;

    if ($p < $self->active_base()) {
        print_esc("IMPOSSIBLE ");
    } elsif ($p < $self->single_base()) {
        print chr($p - $self->active_base());
    } elsif ($p < $self->null_cs()) {
        my $char = chr($p - $self->single_base());
        print_esc $char;
        if ($char =~ /[a-z]/i) {
            print " ";
        }
    } else {
        my $string_no = $fmt->get_hash()->get_text($p);

        if (! defined $string_no) {
            print "\n\\WOAH!($p)";

            return;
        }

        print_esc $fmt->get_string($string_no);
        print " ";
    }

    # print "\n";

    return;
}

sub show_node_list {
    my $self = shift;

    my $p = shift;

    my $hi_mem_min = $self->get_hi_mem_min();

    my $mem_end = $self->get_mem_top();

    while ($p > $self->mem_min) {
        if ($p > $mem_end) {
            print "Bad link, display aborted.";
            return;
        }

        if ($p >= $hi_mem_min) {
            print " " . chr($self->get_subtype($p));
        } else {

            for my $type ($self->get_type($p)) {

                if ($type == $self->hlist_node || $type == $self->vlist_node
                    || $type == $self->unset_node) {
                    $self->display_box($p);
                    next;
                }

                if ($type == $self->math_node) {
                    $self->display_math_node($p);
                    next;
                }

                print "Node type $type\n";

            #     rule_node:                          @<Display rule |p|@>;
            #     ins_node:                           @<Display insertion |p|@>;
            #     whatsit_node:                       @<Display the whatsit node |p|@>;
            #     glue_node:                          @<Display glue |p|@>;
            #     kern_node:                          @<Display kern |p|@>;
            #     math_node:                          @<Display math node |p|@>;
            #     ligature_node:                      @<Display ligature |p|@>;
            #     penalty_node:                       @<Display penalty |p|@>;
            #     disc_node:                          @<Display discretionary |p|@>;
            #     mark_node:                          @<Display mark |p|@>;
            #     adjust_node:                        @<Display adjustment |p|@>;
            #
            #     @<Cases of |show_node_list| that arise in mlists only@>@;
            #
            #     othercases print("Unknown node type!")
            # endcases
            }
        }

        print "\n";

        $p = $self->get_link($p);
    }

    return;
}

sub display_box {
    my $self = shift;

    my $node = shift;

    my $type = $self->get_type($node);

    if ($type == $self->hlist_node) {
        print_esc("h");
    } elsif ($type == $self->vlist_node) {
        print_esc("v");
    } else {
        print_esc("unset");
    }

    print "box(";

    print scaled_to_string($self->get_height($node));
    print "+";
    print scaled_to_string($self->get_depth($node));
    print ")x";
    print scaled_to_string($self->get_width($node));

    if ($type == $self->unset_node) {
        print "<special unset node fields>";
        # @<Display special fields of the unset node |p|@>
    } else {
        # @<Display the value of |glue_set(p)|@>;

        my $shifted = $self->get_shift_amount($node);

        if ($shifted != 0) {
            print ", shifted ";
            print scaled_to_string($shifted);
        }

        # $self->show_node_list($self->get_list_ptr($node));
    }

    return;
}

sub display_math_node {
    my $self = shift;

    my $node = shift;

    print_esc("math");

    if ($self->get_subtype($node) == before) {
        print "on";
    } else {
        print "off";
    }

    my $width = $self->get_width($node);

    if ($width != 0) {
        print ", surrounded ";
        print scaled_to_string($width);
    }

    return;
}

sub extract_node_list {
    my $self = shift;

    my $ptr = shift;

    my $node_list = $self->extract_one_node($ptr);

    my $tail = $node_list;

    my $link = $self->get_link($ptr);

    while ($link > $self->null_ptr) {
        my $node = $self->extract_one_node($link);

        $tail->set_link($node);

        $tail = $node;

        $link = $self->get_link($link);
    }

    return $node_list;
}

use constant {
    hlist_node                    => 0,
    vlist_node                    => 1,
    rule_node                     => 2,
    ins_node                      => 3,
    mark_node                     => 4,
    adjust_node                   => 5,
    ligature_node                 => 6,
    disc_node                     => 7,
    whatsit_node                  => 8,
    math_node                     => 9,
    glue_node                     => 10,
    kern_node                     => 11,
    penalty_node                  => 12,
    unset_node                    => 13,
    open_node                     => 0,
    write_node                    => 1,
    close_node                    => 2,
    special_node                  => 3,
    language_node                 => 4,
};

use constant {
    ord_noad                      => 16,    # unset_node + 3
    op_noad                       => 17,    # ord_noad + 1
    bin_noad                      => 18,    # ord_noad + 2
    rel_noad                      => 19,    # ord_noad + 3
    open_noad                     => 20,    # ord_noad + 4
    close_noad                    => 21,    # ord_noad + 5
    punct_noad                    => 22,    # ord_noad + 6
    inner_noad                    => 23,    # ord_noad + 7
    radical_noad                  => 24,    # inner_noad + 1
    fraction_noad                 => 25,    # radical_noad + 1
    under_noad                    => 26,    # fraction_noad + 1
    over_noad                     => 27,    # under_noad + 1
    accent_noad                   => 28,    # over_noad + 1
    vcenter_noad                  => 29,    # accent_noad + 1
    left_noad                     => 30,    # vcenter_noad + 1
    right_noad                    => 31,    # left_noad + 1
    style_node                    => 14,    # unset_node + 1
    choice_node                   => 15,    # unset_node + 2
};

my @NODE_MAP;

$NODE_MAP[hlist_node]    = 'extract_hlist_node';
$NODE_MAP[vlist_node]    = 'extract_vlist_node';
$NODE_MAP[unset_node]    = 'extract_unset_node';
$NODE_MAP[rule_node]     = 'extract_rule_node';
$NODE_MAP[ins_node]      = 'extract_ins_node';
$NODE_MAP[whatsit_node]  = 'extract_whatsit_node';
$NODE_MAP[glue_node]     = 'extract_glue_node';
$NODE_MAP[kern_node]     = 'extract_kern_node';
$NODE_MAP[math_node]     = 'extract_math_node';
$NODE_MAP[ligature_node] = 'extract_ligature_node';
$NODE_MAP[penalty_node]  = 'extract_penalty_node';
$NODE_MAP[disc_node]     = 'extract_disc_node';
$NODE_MAP[mark_node]     = 'extract_mark_node';
$NODE_MAP[adjust_node]   = 'extract_adjust_node';
$NODE_MAP[style_node]    = 'extract_style_node';
$NODE_MAP[choice_node]   = 'extract_choice_node';

$NODE_MAP[ord_noad]      = 'extract_noad';
$NODE_MAP[op_noad]       = 'extract_noad';
$NODE_MAP[bin_noad]      = 'extract_noad';
$NODE_MAP[rel_noad]      = 'extract_noad';
$NODE_MAP[open_noad]     = 'extract_noad';
$NODE_MAP[close_noad]    = 'extract_noad';
$NODE_MAP[punct_noad]    = 'extract_noad';
$NODE_MAP[inner_noad]    = 'extract_noad';
$NODE_MAP[radical_noad]  = 'extract_noad';
$NODE_MAP[over_noad]     = 'extract_noad';
$NODE_MAP[under_noad]    = 'extract_noad';
$NODE_MAP[vcenter_noad]  = 'extract_noad';
$NODE_MAP[accent_noad]   = 'extract_noad';
$NODE_MAP[left_noad]     = 'extract_noad';
$NODE_MAP[right_noad]    = 'extract_noad';
$NODE_MAP[fraction_noad] = 'extract_noad';

my @WHATSIT_MAP;

$WHATSIT_MAP[42] = 'extract_glyph_node';

sub extract_one_node {
    my $self = shift;

    my $ptr = shift;

    my $hi_mem_min = $self->get_hi_mem_min();

    my $mem_end = $self->get_mem_top();

    if ($ptr <= $self->mem_min || $ptr > $mem_end) {
        croak "Bad link: $ptr";
    }

    if ($ptr >= $hi_mem_min) {
        return $self->extract_char_node($ptr);
    } else {
        my $type = $self->get_type($ptr);

        my $extractor = $NODE_MAP[$type] or do {
            croak "Don't know how to extract node type $type";
        };

        return $self->$extractor($ptr);
    }

    return;
}

sub extract_char_node {
    my $self = shift;

    my $ptr = shift;

    my $char = $self->get_subtype($ptr);

    my $fnt_num = $self->get_type($ptr);

    my $font = $self->get_font($fnt_num);

    return new_character($char, undef, $font);
}

sub extract_hlist_node {
    my $self = shift;

    my $ptr = shift;

    my $node = new_null_box({
        width      => $self->get_width($ptr),
        height     => $self->get_height($ptr),
        depth      => $self->get_depth($ptr),
        shift      => $self->get_shift_amount($ptr),
        glue_set   => $self->get_glue_set($ptr),
        glue_sign  => $self->get_glue_sign($ptr),
        glue_order => $self->get_glue_order($ptr) });

    my $list_ptr = $self->get_list_ptr($ptr);

    if ($list_ptr != $self->null_ptr) {
        my $contents = $self->extract_node_list($list_ptr);

        $node->set_list_ptr($contents);
    }

    return $node;
}

sub extract_vlist_node {
    my $self = shift;

    my $ptr = shift;

    my $node = new_null_vbox({
        width      => $self->get_width($ptr),
        height     => $self->get_height($ptr),
        depth      => $self->get_depth($ptr),
        shift      => $self->get_shift_amount($ptr),
        glue_set   => $self->get_glue_set($ptr),
        glue_sign  => $self->get_glue_sign($ptr),
        glue_order => $self->get_glue_order($ptr) });

    my $list_ptr = $self->get_list_ptr($ptr);

    if ($list_ptr != $self->null_ptr) {
        my $contents = $self->extract_node_list($list_ptr);

        $node->set_list_ptr($contents);
    }

    return $node;
}

## This may or may not be right

sub extract_unset_node {
    my $self = shift;

    my $ptr = shift;

    my $node = new_unset({
        width        => $self->get_width($ptr),
        height       => $self->get_height($ptr),
        depth        => $self->get_depth($ptr),
        glue_shrink  => $self->get_shift_amount($ptr),
        glue_stretch => $self->get_glue_set($ptr),
        glue_sign    => $self->get_glue_sign($ptr),
        glue_order   => $self->get_glue_order($ptr),
        span_count   => $self->get_subtype($ptr)
    });

    my $list_ptr = $self->get_list_ptr($ptr);

    if ($list_ptr != $self->null_ptr) {
        my $contents = $self->extract_node_list($list_ptr);

        $node->set_list_ptr($contents);
    }

    return $node;
}

sub extract_rule_node {
    my $self = shift;

    my $ptr = shift;

    my $width  = $self->get_width($ptr);
    my $height = $self->get_height($ptr);
    my $depth  = $self->get_depth($ptr);

    return new_rule($width, $height, $depth);
}

sub extract_ins_node {
    my $self = shift;

    my $ptr = shift;

    my $node = new_ins({
        box_number       => $self->get_subtype($ptr),
        height           => $self->get_height($ptr),
        depth            => $self->get_depth($ptr),
        split_top_ptr    => $self->get_split_top_ptr($ptr),
        float_cost       => $self->get_float_cost($ptr),
        floating_penalty => $self->get_floating_penalty($ptr) });

    my $contents = $self->extract_node_list($self->get_ins_ptr($ptr));

    $node->set_ins_ptr($contents);

    return $node;
}

sub extract_glue_node {
    my $self = shift;

    my $ptr = shift;

    my $subtype    = $self->get_subtype($ptr);
    my $glue_ptr   = $self->get_llink($ptr);
    my $leader_ptr = $self->get_rlink($ptr);

    if ($leader_ptr == $self->null_ptr) {
        $leader_ptr = undef;
    } else {
        $leader_ptr = $self->extract_node_list($leader_ptr);
    }

    return new_glue({ subtype       => $subtype,
                      leader_ptr    => $leader_ptr,
                      width         => $self->get_width($glue_ptr),
                      shrink        => $self->get_shrink($glue_ptr),
                      shrink_order  => $self->get_subtype($glue_ptr),
                      stretch       => $self->get_stretch($glue_ptr),
                      stretch_order => $self->get_type($glue_ptr),
                    });
}

sub extract_kern_node {
    my $self = shift;

    my $ptr = shift;

    my $subtype = $self->get_subtype($ptr);
    my $width   = $self->get_width($ptr);

    return new_kern($width, $subtype);
}

sub extract_math_node {
    my $self = shift;

    my $ptr = shift;

    return new_math($self->get_subtype($ptr), $self->get_width($ptr))
}

sub extract_ligature_node {
    my $self = shift;

    my $ptr = shift;

    my $char = $self->get_subtype($ptr + 1);

    my $fnt_num = $self->get_type($ptr + 1);

    my $font = $self->get_font($fnt_num);

    my $lig_ptr = $self->extract_node_list($self->get_link($ptr + 1));

    return new_ligature({ font => $font,
                          char_code => $char,
                          lig_ptr => $lig_ptr });
}

sub extract_penalty_node {
    my $self = shift;

    my $ptr = shift;

    my $penalty = $self->get_word($ptr + 1)->get_int();

    return new_penalty($penalty);
}

sub extract_disc_node {
    my $self = shift;

    my $ptr = shift;

    return new_disc();
}

sub extract_mark_node {
    my $self = shift;

    my $ptr = shift;

    return new_mark();
}

sub extract_adjust_node {
    my $self = shift;

    my $ptr = shift;

    return new_adjust();
}

sub extract_style_node {
    my $self = shift;

    my $ptr = shift;

    return new_style();
}

sub extract_choice_node {
    my $self = shift;

    my $ptr = shift;

    return new_choice();
}

sub extract_whatsit_node {
    my $self = shift;

    my $ptr = shift;

    my $type    = $self->get_type($ptr);
    my $subtype = $self->get_subtype($ptr);

    my $extractor = $WHATSIT_MAP[$subtype] or do {
        croak "Don't know how to extract whatsit node subtype $subtype";
    };

    return $self->$extractor($ptr);
}

sub extract_glyph_node {
    my $self = shift;

    my $ptr = shift;

    my $width  = $self->get_word($ptr + 1)->get_sc();
    my $depth  = $self->get_word($ptr + 2)->get_sc();
    my $height = $self->get_word($ptr + 3)->get_sc();

    my $glyph_info = $self->get_word($ptr + 4);

    my $b0 = $glyph_info->get_b0();

    my $fnt_num     = $glyph_info->get_b1();
    my $glyph       = $glyph_info->get_b2();
    my $glyph_count = $glyph_info->get_b3();

    my $font = $self->get_font($fnt_num);

    my $node = {
        font        => $font,
        char_code   => $glyph,
        glyph_count => $glyph_count,
        width       => $width,
        depth       => $depth,
        height      => $height,
    };

    my $x = new_glyph_node($node);

    return $x;
}

sub extract_noad {
    my $self = shift;

    my $ptr = shift;

    return;
}

######################################################################
##                                                                  ##
##                         AUTOMETHOD MAGIC                         ##
##                                                                  ##
######################################################################

sub AUTOMETHOD {
    my ($self, $ident, @args) = @_;

    my $subname = $_;   # Requested subroutine name is passed via $_

    my $params = $self->get_params();

    if ($params->has_parameter($subname)) {
        return sub() { return $params->get_parameter($subname) };
    }

    return;
}

1;

__END__
