package TeX::FMT::Parameters;

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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(get_engine_parameters) ]);
our @EXPORT_OK   = @{ $EXPORT_TAGS{all} };
our @EXPORT      = @{ $EXPORT_TAGS{all} };

use Carp;

use Fcntl qw(:seek);

use TeX::FMT::Parameters::Utils qw(:all);

use TeX::Class;

use TeX::Utils::Misc;

my %parameters_of :HASH(:name<parameter> :get<*custom*>);

my %skip_parameters_of  :ARRAY(:name<skip_parameter>);
my %toks_parameters_of  :ARRAY(:name<toks_parameter>);
my %int_parameters_of   :ARRAY(:name<int_parameter>);
my %dimen_parameters_of :ARRAY(:name<dimen_parameter>);

######################################################################
##                                                                  ##
##                          FACTORY METHOD                          ##
##                                                                  ##
######################################################################

sub get_engine_parameters( $ ) {
    my $engine = shift;

    my $class = __PACKAGE__ . "::" . $engine;

    if (! eval "require $class") {
        die "Could not load engine parameters '$class'\n";
    }

    return $class->new();

}

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %params = (
        has_translation_tables => 1,
        has_etex               => 0,
        has_mltex              => 1,
        has_enctex             => 1,
        
        is_xetex               => 0,
        is_luatex              => 0,

        prim_size              => 0,

        fmt_has_hyph_start     => 0,

        fmem_word_length       => 4,

        cs_token_flag        => 0xFFF,

        min_quarterword      => 0,
        min_halfword         => -0xFFFFFFF,
        max_halfword         => 0xfffffff,

        null_ptr             => sub { $_[0]->min_halfword },

        mem_bot              => 0,
        max_font_max         => 9000,
        font_mem_size        => 100000,
        hash_size            => 15000,
        hash_prime           => 8501,
        hyph_prime           => 607,
        hyph_size            => 659,
        first_text_char      => 0,
        biggest_char         => 255,
        biggest_usv          => 255,
        biggest_reg          => 255,
        number_math_families => 16,
        ##
        ## Derived parameters
        ##
        mem_min           => sub { $_[0]->mem_bot() },
        null              => sub { $_[0]->min_halfword() },
        last_text_char    => sub { $_[0]->biggest_char() },
        number_usvs       => sub { $_[0]->biggest_usv() + 1 },
        number_regs       => sub { $_[0]->biggest_reg() + 1 },
        number_math_fonts => sub { 3 * $_[0]->number_math_families() },

        ## Shared constants (i.e., these should be the same for all engines).

        ##
        ## SCAN TYPES
        ##
        int_val   => 0,
        dimen_val => 1,
        glue_val  => 2,
        mu_val    => 3,
        #* ident_val => 4, # font identifier
        #* tok_val   => 5,
        input_line_no_code => sub { $_[0]->glue_val + 1 },
        badness_code       => sub { $_[0]->input_line_no_code + 1 },
        ## MARK TYPES
        ##
        top_mark_code         => 0,
        first_mark_code       => 1,
        bot_mark_code         => 2,
        split_first_mark_code => 3,
        split_bot_mark_code   => 4,
        ##
        ##
        ##
        width_offset  => 1,
        depth_offset  => 2,
        height_offset => 3,
        ##
        ## NODE TYPES
        ##
        # hlist_node    => 0,
        # vlist_node    => 1,
        # rule_node     => 2,
        # ins_node      => 3,
        # mark_node     => 4,
        # adjust_node   => 5,
        # ligature_node => 6,
        # disc_node     => 7,
        # whatsit_node  => 8,
        # math_node     => 9,
        glue_node     => 10,
        kern_node     => 11,
        explicit      => 1,
        acc_kern      => 2,
        penalty_node  => 12,
        # unset_node    => 13,
        ##
        ## SPECIAL NODE TYPES
        ##
        open_node     => 0,
        write_node    => 1,
        close_node    => 2,
        special_node  => 3,
        # language_node => 4,
        ##
        immediate_code    => 4,
        set_language_code => 5,

        if_code   => 1,
        fi_code   => 2,
        else_code => 3,
        or_code   => 4,

        );

    $parameters_of{$ident} = \%params;

    return;
}

######################################################################
##                                                                  ##
##                   PRINT_CMD_CHR INITIALIZATION                   ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->make_cmd_handler(left_brace  => sub { (left_brace  => $_[0]) });
    $self->make_cmd_handler(right_brace => sub { (right_brace => $_[0]) });
    $self->make_cmd_handler(math_shift  => sub { (math_shift  => $_[0]) });
    $self->make_cmd_handler(mac_param   => sub { (mac_param   => $_[0]) });
    $self->make_cmd_handler(sup_mark    => sub { (sup_mark    => $_[0]) });
    $self->make_cmd_handler(sub_mark    => sub { (sub_mark    => $_[0]) });
    $self->make_cmd_handler(spacer      => sub { (spacer      => $_[0]) });
    $self->make_cmd_handler(letter      => sub { (letter      => $_[0]) });
    $self->make_cmd_handler(other_char  => sub { (other_char  => $_[0]) });

    $self->make_cmd_handler(endv => sub { (endv => "end of alignment template") });

    $self->make_cmd_handler(assign_glue =>    \&print_glue_assignment);
    $self->make_cmd_handler(assign_mu_glue => \&print_glue_assignment);
    $self->make_cmd_handler(assign_toks =>    \&print_toks_register);
    $self->make_cmd_handler(assign_int =>     \&print_int_param);
    $self->make_cmd_handler(assign_dimen =>   \&print_dimen_param);
    $self->make_cmd_handler(set_font     =>   \&print_font_spec);

    $self->make_cmd_handler(tab_mark => sub {
        my $chr_code = shift;

        if ($chr_code == $self->span_code()) {
            return ("span");
        } else {
            return (tab_mark => $chr_code);
        }
                            });

    $self->make_cmd_handler(math_style => sub { print_style($_[0]) });
    $self->make_cmd_handler(char_given => sub { ( char => $_[0] ) });
    $self->make_cmd_handler(math_given => sub { ( mathchar => $_[0]) });

    return;
}

######################################################################
##                                                                  ##
##                         CUSTOM ACCESSORS                         ##
##                                                                  ##
######################################################################

sub has_parameter {
    my $self = shift;

    my $param_name = shift;

    return exists $parameters_of{ident $self}->{$param_name};
}

sub get_parameter {
    my $self = shift;

    my $param_name = shift;

    my $value = $self->get_parameter_raw($param_name);

    croak "Unknown parameter '$param_name'" unless defined $value;

    return $value;
}

sub get_parameter_raw {
    my $self = shift;

    my $param_name = shift;

    my $value = $parameters_of{ident $self}->{$param_name};

    return unless defined $value;

    if (ref($value) eq 'CODE') {
        $value = $self->$value();
    }

    return $value;
}

######################################################################
##                                                                  ##
##                          PRINT_CMD_CHR                           ##
##                                                                  ##
######################################################################

my %cmd_handler_of :ARRAY(:name<cmd_handler>);

sub interpret_cmd_chr {
    my $self = shift;

    my $cmd_code = shift;
    my $chr_code = shift;

    my $handler = $self->get_cmd_handler($cmd_code);

    if (! defined $handler) {
        carp "Unknown command code: $cmd_code";

        return;
    }

    if (ref($handler) eq 'ARRAY') {
        return ($handler->[$chr_code]);
    } elsif (ref($handler) eq 'CODE') {
        return $handler->($chr_code, $self);
    }

    return ($handler);
}

my %REGISTER = (count => 1, dimen => 1, muskip => 1, skip => 1, toks => 1);

my %CHARACTER = (left_brace  => "begin-group character",
                 right_brace => "end-group character",
                 math_shift  => "math shift character",
                 tab_mark    => "alignment tab character",
                 mac_param   => "macro parameter character",
                 sup_mark    => "superscript character",
                 sub_mark    => "subscript character",
                 endv        => "alignment template",
                 spacer      => "blank space",
                 letter      => "the letter",
                 other_char  => "the character",
    );

sub print_cmd_chr {
    my $self = shift;

    my $cmd_code = shift;
    my $chr_code = shift;

    my ($type, $subtype) = $self->interpret_cmd_chr($cmd_code, $chr_code);

    if (! defined $type) {
        warn "*** print_cmd_chr undefined type: cmd_code='$cmd_code'; chr_code='$chr_code'\n";
        return qq{\\{cmd_code=$cmd_code; chr_code=$chr_code}};
    }

    return $subtype if $type eq 'UNKNOWN';

    return $type if $type eq 'undefined';

    if (my $description = $CHARACTER{$type}) {
        if ($type ne 'endv') {
            $description .= ' ' . chr($chr_code);
        }

        return $description;
    }

    return print_esc(" ") if $type eq 'ex_space';
    return print_esc("/") if $type eq 'ital_corr';
    return print_esc("-") if $type eq 'discretionary_hyphen';

    return "macro"                if $type eq 'call';
    return "\\long macro"         if $type eq 'long_call';
    return "\\outer macro"        if $type eq 'outer_call';
    return "\\long \\outer macro" if $type eq 'long_outer_call';

    if ($type eq 'char') {
        if (defined $subtype) {
            return print_esc(sprintf 'char"%02X', $subtype);
        } else {
            return print_esc('char');
        }
    }

    if ($type eq 'mathchar') {
        if (defined $subtype) {
            return print_esc(sprintf 'mathchar"%04X', $subtype);
        } else {
            return print_esc('mathchar');
        }
    }

    if ($REGISTER{$type}) {
        if (defined $subtype) {
            return print_esc(sprintf "%s%d", $type, $subtype);
        } else {
            return print_esc($type);
        }
    }

    return print_esc($type);
}

sub calc_equiv {
    my $self = shift;

    (my $expr = shift) =~ s{ }{}g;

    my @tokens = split /([+-])/, $expr;

    my $code = shift @tokens;

    if ($code !~ m{\A \d+ \z}smx) {
        $code = $self->get_parameter($code);
    }

    while (my ($op, $val) = splice @tokens, 0, 2) {
        if ($val !~ m{\A \d+ \z}smx) {
            $val = $self->get_parameter($val);
        }

        if ($op eq '+') {
            $code += $val;
        } elsif ($op eq '-') {
            $code -= $val;
        } else {
            croak "Unknown operator '$op' in '$expr'";
        }
    }

    return $code;
}

sub primitive {
    my $self = shift;

    my $csname        = shift;
    my $cmd_code_name = shift;
    my $equiv_expr    = shift;

    if (empty $equiv_expr) {
        $self->add_command_handler($csname, $cmd_code_name, undef);

        return;
    }

    if ($cmd_code_name eq 'assign_toks') {
        my $equiv = $self->calc_equiv($equiv_expr) - $self->local_base();

        $self->set_toks_parameter($equiv, $csname);

        return;
    }

    if ($cmd_code_name eq 'assign_int') {
        my $equiv = $self->calc_equiv($equiv_expr);

        $self->set_int_parameter($equiv, $csname);

        return;
    }

    if ($cmd_code_name eq 'assign_dimen') {
        my $equiv = $self->calc_equiv($equiv_expr);

        $self->set_dimen_parameter($equiv, $csname);

        return;
    }

    if ($cmd_code_name =~ m{^assign(?:_mu)?_glue}) {
        my $equiv = $self->calc_equiv($equiv_expr);

        $self->set_skip_parameter($equiv, $csname);

        return;
    }

    my $cmd_code = $self->get_parameter($cmd_code_name);
    my $equiv    = $self->calc_equiv($equiv_expr);

    $self->add_command_handler($csname, $cmd_code_name, $equiv);

    return;
}

sub load_primitives {
    my $self = shift;

    my $data_handle = shift;

    my $position = tell($data_handle);

    local $_;

    while (<$data_handle>) {
        chomp;

        next if m/^\s*$/;

        last if m/__END__/;

        next if m{^#};

        my ($csname, $cmd_code, $equiv) = split /\s+/, trim($_), 3;

        $self->primitive($csname, $cmd_code, $equiv);
    }

    seek($data_handle, $position, SEEK_SET);

    return;
}

sub add_command_handler {
    my $self = shift;

    my $csname        = shift;
    my $cmd_code_name = shift;
    my $equiv         = shift;

    my $cmd_code = $self->get_parameter($cmd_code_name);

    my $new_handler;

    if (! defined $equiv) {
        $new_handler = $csname;
    } else {
        my @new_handler;

        if (defined(my $old_handler = $self->get_cmd_handler($cmd_code))) {
            if (ref($old_handler) eq 'ARRAY') {
                @new_handler = @{ $old_handler };
            } else {
                @new_handler = ($old_handler);
            }

            $new_handler[$equiv] = $csname;

            $new_handler = \@new_handler;
        } else {
            $new_handler[$equiv] = $csname;

            $new_handler = \@new_handler;
        }
    }

    $self->set_cmd_handler($cmd_code, $new_handler);

    return;
}

sub make_cmd_handler {
    my $self = shift;

    my $cmd_code_name = shift;
    my $handler       = shift;

    my $cmd_code = $self->get_parameter($cmd_code_name);

    $self->set_cmd_handler($cmd_code, $handler);

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

    if (defined (my $value = $self->get_parameter($subname))) {
        return sub() { return $value };
    }

    return;
}

1;

__END__
