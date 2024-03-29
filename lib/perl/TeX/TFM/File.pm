package TeX::TFM::File;

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

use version; our $VERSION = qv '1.1.1';

use TeX::Class;

use base qw(TeX::BinaryFile);

use Carp;

use File::Basename;

use TeX::Utils::Binary;

use constant unity => 2**16;

use constant {
    NO_TAG   => 0,
    LIG_TAG  => 1,
    LIST_TAG => 2,
    EXT_TAG  => 3
};

my %font_name_of :ATTR(:get<font_name>, :set<font_name>);

my %lf_of :ATTR(:get<lf>, :set<lf>);
my %lh_of :ATTR(:get<lh>, :set<lh>);
my %bc_of :ATTR(:get<bc>, :set<bc>);
my %ec_of :ATTR(:get<ec>, :set<ec>);
my %nw_of :ATTR(:get<nw>, :set<nw>);
my %nh_of :ATTR(:get<nh>, :set<nh>);
my %nd_of :ATTR(:get<nd>, :set<nd>);
my %ni_of :ATTR(:get<ni>, :set<ni>);
my %nl_of :ATTR(:get<nl>, :set<nl>);
my %nk_of :ATTR(:get<nk>, :set<nk>);
my %ne_of :ATTR(:get<ne>, :set<ne>);
my %np_of :ATTR(:get<np>, :set<np>);

my %checksum_of    :ATTR(:get<checksum>,    :set<checksum>);
my %design_size_of :ATTR(:get<design_size>, :set<design_size>);

my %comment_of        :ATTR(:get<comment>,  :set<comment>);
my %encoding_of       :ATTR(:get<encoding>, :set<encoding>);
my %family_of         :ATTR(:get<family>,   :set<family>);
my %face_of           :ATTR(:get<face>,     :set<face>);
my %seven_bit_safe_of :ATTR(:set<seven_bit_safe>);

my %char_info_of :ATTR;
my %width_of     :ATTR;
my %height_of    :ATTR;
my %depth_of     :ATTR;
my %italic_of    :ATTR;
my %lig_kern_of  :ATTR;
my %kern_of      :ATTR;
my %exten_of     :ATTR;
my %param_of     :ATTR;

my %char_left_kern_table_of :ATTR;
my %char_right_kern_table_of :ATTR;

my %char_lig_table_of :ATTR;

my %boundary_char_of :ATTR(:get<boundary_char> :set<boundary_char>);

my %left_boundary_lig_kern_of :ATTR(:get<left_boundary_lig_kern> :set<left_boundary_lig_kern>);

my %width_frequency_of  :ATTR;
my %height_frequency_of :ATTR;
my %depth_frequency_of  :ATTR;
my %italic_frequency_of :ATTR;
my %kern_frequency_of   :ATTR;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my $file_name = $arg_ref->{file_name};
    my $font_name = basename($file_name, ".tfm");

    $font_name_of{$ident} = $font_name;

    $left_boundary_lig_kern_of{$ident} = -1;

    return;
}

sub add_kern_pair {
    my $self = shift;

    my $ident = ident $self;

    my $left_char  = shift;
    my $right_char = shift;
    my $kern_index = shift;

    my $right_kerns = $char_right_kern_table_of{$ident};
    my $left_kerns  = $char_left_kern_table_of{$ident};

    if (! defined $right_kerns->[$left_char]) {
        $right_kerns->[$left_char] = [];
    }

    push @{ $right_kerns->[$left_char] }, [ $left_char, $right_char, $kern_index];

    if (! defined $left_kerns->[$right_char]) {
        $left_kerns->[$right_char] = [];
    }

    push @{ $left_kerns->[$right_char] }, [ $left_char, $right_char, $kern_index];

    return;
}

sub is_seven_bit_safe {
    my $self = shift;

    return $seven_bit_safe_of{ident $self};
}

sub get_char_info {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $char_info_of{ident $self};

    return $char_info->[$char_code];
}

sub get_char_info_tag {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[4];
}

sub get_char_info_remainder {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[5];
}

sub get_width {
    my $self = shift;

    my $index = shift;

    my $widths = $width_of{ident $self};

    return $widths->[$index];
}

sub get_width_table {
    my $self = shift;

    my @table = @{ $width_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_width_frequency_table {
    my $self = shift;

    my $table = $width_frequency_of{ident $self};

    return unless defined $table;

    my @table = @{ $table };

    return wantarray ? @table : \@table;
}

sub get_width_index {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[0];
}

sub get_char_width {
    my $self = shift;

    my $char_code = shift;

    my $width_index = $self->get_width_index($char_code);

    return $self->get_width($width_index);
}

sub char_exists {
    my $self = shift;

    my $char_code = shift;

    return unless $char_code >= $self->get_bc();
    return unless $char_code <= $self->get_ec();

    return unless $self->get_width_index($char_code) > 0;

    return 1;
}

sub get_height {
    my $self = shift;

    my $index = shift;

    my $heights = $height_of{ident $self};

    return $heights->[$index];
}

sub get_height_table {
    my $self = shift;

    my @table = @{ $height_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_height_frequency_table {
    my $self = shift;

    my $table = $height_frequency_of{ident $self};

    return unless defined $table;

    my @table = @{ $table };

    return wantarray ? @table : \@table;
}

sub get_height_index {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[1];
}

sub get_char_height {
    my $self = shift;

    my $char_code = shift;

    my $height_index = $self->get_height_index($char_code);

    return $self->get_height($height_index);
}

sub get_depth {
    my $self = shift;

    my $index = shift;

    my $depths = $depth_of{ident $self};

    return $depths->[$index];
}

sub get_depth_table {
    my $self = shift;

    my @table = @{ $depth_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_depth_frequency_table {
    my $self = shift;

    my $table = $depth_frequency_of{ident $self};

    return unless defined $table;

    my @table = @{ $table };

    return wantarray ? @table : \@table;
}

sub get_depth_index {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[2];
}

sub get_char_depth {
    my $self = shift;

    my $char_code = shift;

    my $depth_index = $self->get_depth_index($char_code);

    return $self->get_depth($depth_index);
}

sub get_italic_correction {
    my $self = shift;

    my $index = shift;

    my $italic_corrections = $italic_of{ident $self};

    return $italic_corrections->[$index];
}

sub get_italic_table {
    my $self = shift;

    my @table = @{ $italic_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_italic_frequency_table {
    my $self = shift;

    my $table = $italic_frequency_of{ident $self};

    return unless defined $table;

    my @table = @{ $table };

    return wantarray ? @table : \@table;
}

sub get_italic_correction_index {
    my $self = shift;

    my $char_code = shift;

    my $char_info = $self->get_char_info($char_code);

    return $char_info->[3];
}

sub get_char_italic_correction {
    my $self = shift;

    my $char_code = shift;

    my $ic_index = $self->get_italic_correction_index($char_code);

    return $self->get_italic_correction($ic_index);
}

sub get_char_kerns {
    my $self = shift;

    my $char_code = shift;

    my $ident = ident $self;

    $self->construct_lig_kern_list();

    my $kern_pairs = $char_right_kern_table_of{$ident}->[$char_code];

    if (defined $kern_pairs) {
        return @{ $kern_pairs };
    }

    return;
}

sub get_right_kerns {
    my $self = shift;

    my $char_code = shift;

    my $ident = ident $self;

    $self->construct_lig_kern_list();

    my $kern_pairs = $char_right_kern_table_of{$ident}->[$char_code];

    if (defined $kern_pairs) {
        return @{ $kern_pairs };
    }

    return;
}

sub get_left_kerns {
    my $self = shift;

    my $char_code = shift;

    my $ident = ident $self;

    $self->construct_lig_kern_list();

    my $kern_pairs = $char_left_kern_table_of{$ident}->[$char_code];

    if (defined $kern_pairs) {
        return @{ $kern_pairs };
    }

    return;
}

sub get_ligatures {
    my $self = shift;

    my $char_code = shift;

    my $ident = ident $self;

    $self->construct_lig_kern_list();

    my $ligs = $char_lig_table_of{$ident}->[$char_code];

    if (defined $ligs) {
        return @{ $ligs };
    }

    return;
}

sub construct_lig_kern_list {
    my $self = shift;

    my $ident = ident $self;

    return if defined $char_left_kern_table_of{$ident};

    $char_left_kern_table_of{$ident}  = [];
    $char_right_kern_table_of{$ident} = [];
    $char_lig_table_of{$ident}        = [];

    for my $char_code ($self->get_bc()..$self->get_ec()) {
        my $tag = $self->get_char_info_tag($char_code);

        next unless $tag == LIG_TAG;

        my $start_index = $self->get_char_info_remainder($char_code);

        my @lig_kern = $self->get_lig_kern_table();

        my $first_op = $lig_kern[$start_index];

        if ($first_op->[0] > 128) {
            my ($skip_byte, $next_char, $op_byte, $remainder) = @{ $first_op };

            $start_index = 256 * $op_byte + $remainder;
        }

        my $cur_index = $start_index;

        my @ligatures;

        while (1) {
            my $op = $lig_kern[$cur_index];

            my ($skip_byte, $next_char, $op_byte, $remainder) = @{ $op };

            if ($op_byte >= 128) {
                my $kern_index = 256 * ($op_byte - 128) + $remainder;

                $self->add_kern_pair($char_code, $next_char, $kern_index);
            } else {
                push @ligatures, [ $op_byte, $next_char, $remainder ];
            }

            last if $skip_byte >= 128;

            $cur_index += $skip_byte + 1;
        }

        $char_lig_table_of{$ident}->[$char_code] = \@ligatures;
    }

    return;
}

sub get_lig_kern_table {
    my $self = shift;

    my @table = @{ $lig_kern_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_kern {
    my $self = shift;

    my $index = shift;

    my $kerns = $kern_of{ident $self};

    return $kerns->[$index];
}

sub get_kern_table {
    my $self = shift;

    my @table = @{ $kern_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_kern_frequency_table {
    my $self = shift;

    my $table = $kern_frequency_of{ident $self};

    return unless defined $table;

    my @table = @{ $table };

    return wantarray ? @table : \@table;
}

sub get_exten {
    my $self = shift;

    my $char_code = shift;

    my $tag = $self->get_char_info_tag($char_code);

    return unless $tag == EXT_TAG;

    my $remainder = $self->get_char_info_remainder($char_code);

    my $extens = $exten_of{ident $self};

    return @{ $extens->[$remainder] };
}

sub get_next_larger {
    my $self = shift;

    my $char_code = shift;

    my $tag = $self->get_char_info_tag($char_code);

    return unless $tag == LIST_TAG;

    return $self->get_char_info_remainder($char_code);
}

sub get_param {
    my $self = shift;

    my $index = shift;

    my $params = $param_of{ident $self};

    return $params->[$index];
}

sub read_char_info_word {
    my $self = shift;

    my @bytes = unpack "C*", $self->read_bytes(4);

    return ($bytes[0],          # width index
            $bytes[1] >> 4,     # height index
            $bytes[1] & 0b1111, # depth_index
            $bytes[2] >> 2,     # italic_index
            $bytes[2] & 0b0011, # tag
            $bytes[3]);         # remainder
}

sub read_lig_kern_command {
    my $self = shift;

    return unpack "C*", $self->read_bytes(4);
}

sub read_extensible_recipe {
    my $self = shift;

    return unpack "CCCC", $self->read_bytes(4);
}

sub read_fixword {
    my $self = shift;

    return scalar $self->read_bytes(4);
}

sub get_fixwords {
    my $self = shift;

    my $n = shift;

    return map { $self->read_fixword(); } 1 .. $n;
}

sub read {
    my $self = shift;

    my $ident = ident $self;

    $self->open("r") or do {
        die "Can't open ", $self->get_file_name(), ": $!\n";
    };

    $lf_of{$ident} = my $lf = $self->read_unsigned(2);
    $lh_of{$ident} = my $lh = $self->read_unsigned(2);
    $bc_of{$ident} = my $bc = $self->read_unsigned(2);
    $ec_of{$ident} = my $ec = $self->read_unsigned(2);
    $nw_of{$ident} = my $nw = $self->read_unsigned(2);
    $nh_of{$ident} = my $nh = $self->read_unsigned(2);
    $nd_of{$ident} = my $nd = $self->read_unsigned(2);
    $ni_of{$ident} = my $ni = $self->read_unsigned(2);
    $nl_of{$ident} = my $nl = $self->read_unsigned(2);
    $nk_of{$ident} = my $nk = $self->read_unsigned(2);
    $ne_of{$ident} = my $ne = $self->read_unsigned(2);
    $np_of{$ident} = my $np = $self->read_unsigned(2);

    $checksum_of{$ident} = $self->read_unsigned(4);

    $self->read_design_size();

    $comment_of{$ident} = my $comment = $self->read_raw_string(($lh - 2) * 4);

    ## The internal format of the comment is purely conventional.  For
    ## "Knuth-conforming" TFM files, we can unpack the comment with
    ## the following code:
    ##
    ##     my ($encoding, $family, $seven_bit_safe, $face) = 
    ##      unpack "x[C] A[39] x[C] A[19] C x[C] x[C] C", $comment;
    ##
    ##  However, after running into a TFM file that was missing the
    ##  seven_bit_safe and face fields, I rewrote the code in the
    ##  following more paranoid fashion.

    if (length($comment) > 1) {
        $encoding_of{$ident} = unpack "A[39]", substr($comment,  1, 39);
    }

    if (length($comment) > 41) {
        $family_of{$ident} = unpack "A[19]", substr($comment, 41, 19);
    }

    if (length($comment) > 60) {
        $seven_bit_safe_of{$ident} = unpack "C", substr($comment, 61,  1);
    }

    if (length($comment) > 63) {
        $face_of{$ident} = unpack "C", substr($comment, 63,  1);
    }

    my @char_info = map { [$self->read_char_info_word()] } 1 .. $ec - $bc + 1;
    
    $char_info_of{$ident} = [ (undef) x $bc, @char_info ];

    my @width  = $self->get_fixwords($nw);
    my @height = $self->get_fixwords($nh);
    my @depth  = $self->get_fixwords($nd);
    my @italic = $self->get_fixwords($ni);

    $width_of {$ident} = \@width;
    $height_of{$ident} = \@height;
    $depth_of {$ident} = \@depth;
    $italic_of{$ident} = \@italic;

    my @lig_kern  = map { [ $self->read_lig_kern_command() ] } 1..$nl;

    $lig_kern_of{$ident} = \@lig_kern;

    if (@lig_kern) {
        my $first_op = $lig_kern[0];

        if ($first_op->[0] == 255) {
            $self->set_boundary_char($first_op->[1]);
        }
    
        my $last_op = $lig_kern[-1];

        if ($last_op->[0] == 255) {
            $self->get_left_boundary_lig_kern(256 * $last_op->[2] + $last_op->[3]);
        }
    }
    
    my @kern = $self->get_fixwords($nk);

    $kern_of{$ident} = \@kern;

    my @exten = map { [$self->read_extensible_recipe()] } 1 .. $ne;
    
    $exten_of{$ident} = \@exten;

    my @param = $self->get_fixwords($np);

    $param_of{$ident} = [ undef, @param ];

    $self->close();

    return $self;
}

sub compile_frequency_tables {
    my $self = shift;

    my $ident = ident $self;

    my @widths  = (0) x 256;
    my @heights = (0) x 256;
    my @depths  = (0) x 256;
    my @italics = (0) x 256;

    for my $char_info (@{ $char_info_of{$ident} }) {
        return unless defined $char_info;

        my ($wd_index, $ht_index, $dp_index, $ic_index) = @{ $char_info };

        $widths[$wd_index]++;
        $heights[$ht_index]++;
        $depths[$dp_index]++;
        $italics[$ic_index]++;
    }

    $width_frequency_of {$ident} = \@widths;
    $height_frequency_of{$ident} = \@heights;
    $depth_frequency_of {$ident} = \@depths;
    $italic_frequency_of{$ident} = \@italics;

    my @kerns = (0) x 256;

    for my $kern_list (@{ $char_right_kern_table_of{$ident} }) {
        for my $kern_pair (@{ $kern_list }) {
            my ($left_char, $right_char, $kern_index) = @{ $kern_pair };

            $kerns[$kern_index]++;
        }        
    }

    $kern_frequency_of{$ident} = \@kerns;
    
    return;
}

sub read_design_size {
    my $self = shift;

    my $z = $self->read_signed(2);

    if ($z < 0) {
        croak "Illegal negative font design size";
    }

    my $byte = $self->read_unsigned(1);

    $z = $z * 0400 + $byte;

    $byte = $self->read_unsigned(1);

    $z = $z * 020 + $byte/020;

    $design_size_of{ident $self} = $z;

    return $self;
}

1;

__END__
