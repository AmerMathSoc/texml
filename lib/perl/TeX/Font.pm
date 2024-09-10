package TeX::Font;

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

use strict;
use warnings;

use overload 'eq' => \&font_eq;

use Carp;

use TeX::KPSE;

use base qw(Exporter);

our %EXPORT_TAGS = ( factories => [ qw(load_font) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Class;

use TeX::Arithmetic qw(:all);

use TeX::TFM::File;

my %font_name_of     :ATTR(:get<font_name>, :set<font_name>);
my %size_of          :ATTR(:get<size>);
my %design_size_of   :ATTR(:get<design_size>);

my %tfm_of :ATTR(:get<tfm>, :set<tfm>);

my %width_table_of  :ATTR;
my %depth_table_of  :ATTR;
my %height_table_of :ATTR;
my %italic_table_of :ATTR;
my %kern_table_of :ATTR;

my %widths_of     :ATTR;
my %heights_of    :ATTR;
my %depths_of     :ATTR;
my %italics_of    :ATTR;
my %params_of     :ATTR;

sub scale($$$$) {
    my $fixword = shift;
    my $z       = shift;
    my $alpha   = shift;
    my $beta    = shift;

    my ($a, $b, $c, $d) = unpack "C*", $fixword;

    my $s = ( ( ( ( ($d * $z)/0400) + ($c * $z) ) / 0400) + ($b * $z) ) / $beta;

    if ($a == 0) {
        return $s;
    } elsif ($a == 255) {
        return $s - $alpha;
    } else {
        croak "Invalid font fixword leading byte: $a";
    }
}

sub calculate_scale_params( $ ) {
    my $size = shift;

    my $alpha = 16;

    while ($size >= 040000000) {
        $size = $size/2;
        $alpha = $alpha + $alpha;
    }

    my $beta  = 256/$alpha;

    $alpha = $alpha * $size;

    return ($size, $alpha, $beta);
}

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my $mag;
    my $font_name;
    my $design_size;
    my $size;
    my $checksum;

    if (defined (my $font_def = $arg_ref->{font_def}) ) {
        $font_name   = $font_def->get_font_name();
        $size        = $font_def->get_scale_factor();
        $design_size = $font_def->get_design_size();
        $checksum    = $font_def->get_checksum();
    } else {
        $mag         = $arg_ref->{magnification};

        $font_name   = $arg_ref->{font_name};
        $design_size = $arg_ref->{design_size};
        $size        = $arg_ref->{size};
        $checksum    = $arg_ref->{checksum};
    }

    my $tfm_file = kpse_lookup("$font_name.tfm");

    if (! defined $tfm_file) {
        warn "Can't find font $font_name\n";

        return;
    }

    my $tfm = TeX::TFM::File->new({ file_name => $tfm_file });

    $tfm->read() or die "Error reading $tfm_file\n";

    if (! defined $font_name) {
        die "Empty font name\n";
    }

    $font_name_of{$ident} = $font_name;

    my $tfm_design_size = $tfm->get_design_size();

    if (defined $design_size) {
        if ($design_size != $tfm_design_size) {
            carp "Design size mismatch for $font_name: requested $design_size, found $tfm_design_size";
        }
    } else {
        $design_size = $tfm_design_size;
    }

    $design_size_of{$ident} = $design_size;

    if (! defined $size) {
        if (defined $mag && $mag != 1000) {
            $size = xn_over_d($design_size, $mag, 1000);
        } else {
            $size = $design_size;
        }
    }
    
    $size_of{$ident} = $size;

    my ($pseudo_size, $alpha, $beta) = calculate_scale_params($size);

    $self->set_tfm($tfm);

    my $bc = $tfm->get_bc();
    my $ec = $tfm->get_ec();

    $width_table_of{$ident} = 
        [ map { scale($_, $pseudo_size, $alpha, $beta) } $tfm->get_width_table() ];

    $height_table_of{$ident} =
        [ map { scale($_, $pseudo_size, $alpha, $beta) } $tfm->get_height_table() ];

    $depth_table_of{$ident} =
         [ map { scale($_, $pseudo_size, $alpha, $beta) } $tfm->get_depth_table() ];

    $italic_table_of{$ident} =
        [ map { scale($_, $pseudo_size, $alpha, $beta) } $tfm->get_italic_table() ];

    my @widths;
    my @heights;
    my @depths;
    my @italics;

    for (my $char_code = $bc; $char_code <= $ec; $char_code++) {
        my $w = $tfm->get_char_width($char_code);

        next unless defined $w;

        my $h = $tfm->get_char_height($char_code);
        my $d = $tfm->get_char_depth($char_code);
        my $i = $tfm->get_char_italic_correction($char_code);

        $widths[$char_code]  = scale($w, $pseudo_size, $alpha, $beta);
        $heights[$char_code] = scale($h, $pseudo_size, $alpha, $beta);
        $depths[$char_code]  = scale($d, $pseudo_size, $alpha, $beta);
        $italics[$char_code] = scale($i, $pseudo_size, $alpha, $beta);
    }

    $widths_of {$ident} = \@widths;
    $heights_of{$ident} = \@heights;
    $depths_of {$ident} = \@depths;
    $italics_of{$ident} = \@italics;

    my @kern_table;

    for my $kern ($tfm->get_kern_table()) {
        my $scaled_kern = scale($kern, $pseudo_size, $alpha, $beta);

        push @kern_table, $scaled_kern;
    }

    $kern_table_of{$ident} = \@kern_table;

    my $np = $tfm->get_np();

    my @scaled_params = (undef);

    if ($np > 0) {
        my ($pseudo_size, $alpha, $beta) = calculate_scale_params(unity);

        push @scaled_params, scale($tfm->get_param(1), $pseudo_size, $alpha, $beta);
    }

    for my $i (2..$np) {
        my $param = $tfm->get_param($i);

        $scaled_params[$i] = scale($param, $pseudo_size, $alpha, $beta);
    }

    $params_of{$ident} = \@scaled_params;

    return;
}

sub load_font($;$$) {
    my $name = shift;
    my $size = shift;

    return __PACKAGE__->new({ font_name => $name, size => $size });
}

sub get_comment {
    my $self = shift;

    return $self->get_tfm()->get_comment();
}

sub get_encoding {
    my $self = shift;

    return $self->get_tfm()->get_encoding();
}

sub get_family {
    my $self = shift;

    return $self->get_tfm()->get_family();
}

sub get_face {
    my $self = shift;

    return $self->get_tfm()->get_face();
}

sub is_seven_bit_safe {
    my $self = shift;

    return $self->get_tfm()->is_seven_bit_safe();
}

sub char_exists {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->char_exists($char_code);
}

sub get_bc {
    my $self = shift;

    return $self->get_tfm()->get_bc();
}

sub get_ec {
    my $self = shift;

    return $self->get_tfm()->get_ec();
}

sub get_np {
    my $self = shift;

    return $self->get_tfm()->get_np();
}

sub get_right_kerns {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->get_right_kerns($char_code);
}

sub get_left_kerns {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->get_left_kerns($char_code);
}

sub get_ligatures {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->get_ligatures($char_code);
}

sub get_exten {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->get_exten($char_code);
}

sub get_next_larger {
    my $self = shift;

    my $char_code = shift;

    return $self->get_tfm()->get_next_larger($char_code);
}

sub get_boundary_char {
    my $self = shift;

    return $self->get_tfm()->get_boundary_char();
}

sub get_width_table {
    my $self = shift;

    my @table = @{ $width_table_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_height_table {
    my $self = shift;

    my @table = @{ $height_table_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_depth_table {
    my $self = shift;

    my @table = @{ $depth_table_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_italic_table {
    my $self = shift;

    my @table = @{ $italic_table_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_kern_table {
    my $self = shift;

    my @table = @{ $kern_table_of{ident $self} };

    return wantarray ? @table : \@table;
}

sub get_nth_kern {
    my $self = shift;

    my $index = shift;

    return $kern_table_of{ident $self}->[$index];
}

sub get_widths {
    my $self = shift;

    my @widths = @{ $widths_of{ident $self} };

    return wantarray ? @widths : \@widths;
}

sub get_char_width {
    my $self = shift;

    my $char_code = shift;

    return $widths_of{ident $self}->[$char_code];
}

sub get_char_height {
    my $self = shift;

    my $char_code = shift;

    return $heights_of{ident $self}->[$char_code];
}

sub get_char_depth {
    my $self = shift;

    my $char_code = shift;

    return $depths_of{ident $self}->[$char_code];
}

sub get_char_metrics {
    my $self = shift;

    my $char_code = shift;

    return ($self->get_char_width($char_code),
            $self->get_char_height($char_code),
            $self->get_char_depth($char_code),
            $self->get_char_italic_correction($char_code));
}

sub get_char_italic_correction {
    my $self = shift;

    my $char_code = shift;

    return $italics_of{ident $self}->[$char_code];
}

sub is_text_font {
    my $self = shift;

    return $self->get_space() != 0;
}

sub get_param {
    my $self = shift;

    my $index = shift;

    my $params = $params_of{ident $self};

    return $params->[$index];
}

sub get_slant {
    my $self = shift;

    return $self->get_param(1);
}

sub get_space {
    my $self = shift;

    return $self->get_param(2);
}

sub get_space_stretch {
    my $self = shift;

    return $self->get_param(3);
}

sub get_space_shrink {
    my $self = shift;

    return $self->get_param(4);
}

sub get_x_height {
    my $self = shift;

    return $self->get_param(5);
}

sub get_quad {
    my $self = shift;

    return $self->get_param(6);
}

sub get_extra_space {
    my $self = shift;

    return $self->get_param(7);
}

sub to_string :STRINGIFY {
    my $self = shift;

    my $name = $self->get_font_name();
    my $size = scaled_to_string($self->get_size());

    return "$name at ${size}pt";
}

sub font_eq {
    my $a = shift;
    my $b = shift;

    my $reversed = shift;

    if (! ($a->isa(__PACKAGE__) && eval { $b->isa(__PACKAGE__) })) {
        die "Both arguments to font_eq must be ", __PACKAGE__, "'s\n";
    }

    return 1 if ident($a) == ident($b);

    # Conceivably, we should test the checksum as well.

    return unless $a->get_font_name()     eq $b->get_font_name();
    return unless $a->get_size()          == $b->get_size();

    return 1;
}

1;

__END__
