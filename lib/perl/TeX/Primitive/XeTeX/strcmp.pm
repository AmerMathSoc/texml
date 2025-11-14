package TeX::Primitive::XeTeX::strcmp;

use v5.26.0;

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

use warnings;

use base qw(TeX::Command::Expandable Exporter);

our %EXPORT_TAGS = ( modifiers => [ qw(MODIFIER_CASE_INSENSITIVE) ] );

our @EXPORT_OK = $EXPORT_TAGS{modifiers}->@*;

use TeX::Constants qw(:booleans);

use TeX::Token qw(:factories);

use TeX::Class;

my %modifier_of :ATTR(:get<modifier> :init_arg<modifier> :default(0));

use constant MODIFIER_CASE_INSENSITIVE => 1;

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $save_scanner_status = $tex->scanner_status();

    my $t1 = $tex->scan_toks(false, true);

    my $s1 = $tex->toks_to_string($t1);

    my $t2 = $tex->scan_toks(false, true);

    my $s2 = $tex->toks_to_string($t2);

    my $modifier = $self->get_modifier();

    if ($modifier & MODIFIER_CASE_INSENSITIVE) {
        $s1 = lc $s1;
        $s2 = lc $s2;
    }

    my $cmp = $s1 cmp $s2;

    $tex->set_scanner_status($save_scanner_status);

    $tex->conv_toks($cmp);

    return;
}

1;

__END__
