package TeX::Primitive::MathGiven;

use strict;
use warnings;

use base qw(TeX::Command::Executable::Readable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_math_given) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Math qw(parse_math_code);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

my %class_of     :ATTR(:get<class>     :get<class>     :init_arg => 'class');
my %family_of    :ATTR(:get<family>    :set<family>    :init_arg => 'family');
my %char_code_of :ATTR(:get<char_code> :set<char_code> :init_arg => 'char_code');

# use TeX::Noad::Fields qw(:factories);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(int_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $char_code = $self->get_char_code();

    ## INCOMPLETE

    $tex->append_char($char_code);

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print_esc("mathchar");

    my $math_char_code = $self->get_value();

    $tex->print_hex($math_char_code);
    
    return;
}

sub make_math_given( $ ) {
    my $math_code = shift;

    my ($class, $family, $char) = parse_math_code($math_code);

    return TeX::Primitive::MathGiven->new({ value     => $math_code,
                                            class     => $class,
                                            family    => $family,
                                            char_code => $char });
}

1;

__END__
