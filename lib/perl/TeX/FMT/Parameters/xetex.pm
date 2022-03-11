package TeX::FMT::Parameters::xetex;

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

## THIS DOESN'T WORK YET.

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(TeX::FMT::Parameters::tex);

use TeX::Class;

my %XeTeX_math_given_of :INT(:name<XeTeX_math_given> :default<70>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_parameter(max_quarterword => 0xFFFF);

    $self->set_parameter(min_halfword => -0xFFFFFFF);
    $self->set_parameter(max_halfword => 0x3FFFFFFF);

    $self->set_parameter(biggest_char => 65535);

    $self->set_parameter(biggest_usv => 0x10FFFF);

    $self->set_parameter(prim_size => 480);

    # EQTB region 3

    $self->set_parameter(thin_mu_skip_code  => 16);
    $self->set_parameter(med_mu_skip_code   => 17);
    $self->set_parameter(thick_mu_skip_code => 18);

    $self->set_parameter(glue_pars => 19);

    # Command codes

    $self->set_parameter(last_item => 71);

    $self->set_parameter(XeTeX_def_code => sub { $_[0]->def_code() + 1 });

    $self->set_parameter(frozen_primitive => sub { $_[0]->frozen_control_sequence() + 11 });

    $self->set_parameter(frozen_null_font => sub { $_[0]->frozen_control_sequence() + 12 });

    $self->set_parameter(XeTeX_linebreak_skip_code => 15);

    $self->set_parameter(tex_toks => sub { $_[0]->local_base() + 10 });

    $self->set_parameter(etex_toks_base => sub { $_[0]->tex_toks() });
    $self->set_parameter(every_eof_loc => sub { $_[0]->etex_toks_base() });
    $self->set_parameter(XeTeX_inter_char_loc => sub { $_[0]->every_eof_loc() + 1 });
    $self->set_parameter(etex_toks => sub { $_[0]->XeTeX_inter_char_loc() + 1 });

    $self->set_parameter(toks_base => sub { $_[0]->etex_toks() });

    $self->set_parameter(math_font_base => sub { $_[0]->cur_font_loc() + 1 });

    $self->set_parameter(web2c_int_pars => sub { $_[0]->web2c_int_base() + 3 });

    $self->set_parameter(etex_int_base => sub { $_[0]->web2c_int_pars() });

    $self->set_parameter(tracing_assigns_code => sub { $_[0]->etex_int_base() });

    $self->set_parameter(tracing_groups_code => sub { $_[0]->etex_int_base() + 1 });

    $self->set_parameter(tracing_ifs_code => sub { $_[0]->etex_int_base() + 2 });

    $self->set_parameter(tracing_scan_tokens_code => sub { $_[0]->etex_int_base() + 3 });

    $self->set_parameter(tracing_nesting_code => sub { $_[0]->etex_int_base() + 4 });

    $self->set_parameter(pre_display_direction_code => sub { $_[0]->etex_int_base() + 5 });

    $self->set_parameter(last_line_fit_code => sub { $_[0]->etex_int_base() + 6 });

    $self->set_parameter(saving_vdiscards_code => sub { $_[0]->etex_int_base() + 7 });

    $self->set_parameter(saving_hyph_codes_code => sub { $_[0]->etex_int_base() + 8 });

    $self->set_parameter(suppress_fontnotfound_error_code => sub { $_[0]->etex_int_base() + 9 });

    $self->set_parameter(XeTeX_linebreak_locale_code => sub { $_[0]->etex_int_base() + 10 });

    $self->set_parameter(XeTeX_linebreak_penalty_code => sub { $_[0]->etex_int_base() + 11 });

    $self->set_parameter(XeTeX_protrude_chars_code => sub { $_[0]->etex_int_base() + 12 });

    $self->set_parameter(eTeX_state_code => sub { $_[0]->etex_int_base() + 13 });

    $self->set_parameter(eTeX_states => 9);

    $self->set_parameter(etex_int_pars => sub { $_[0]->eTeX_state_code() + $_[0]->eTeX_states() });

    $self->set_parameter(synctex_code => sub { $_[0]->etex_int_pars() });

    $self->set_parameter(int_pars => sub { $_[0]->synctex_code() + 1 });

    $self->set_parameter(pdf_page_width_code  => 21);
    $self->set_parameter(pdf_page_height_code => 22);

    $self->set_parameter(dimen_pars => sub { $_[0]->pdf_page_height_code() + 1 });

    return;
}

1;

__END__
