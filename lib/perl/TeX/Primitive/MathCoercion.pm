package TeX::Primitive::MathCoercion;

use strict;
use warnings;

use base qw(TeX::Command::Executable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_coercion) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Noads;

use TeX::Class;

my %class :ATTR(:get<class> :set<class> :init_arg => "class");

sub make_coercion($$) {
    my $name  = shift;
    my $class = shift;

    return __PACKAGE__->new({ name => $name, class => $class });
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $mlist = $self->read_math_sublist();

    if (! defined $mlist) {
        die "Missing argument for \\", $self->get_name(), "\n";
    }

    $tex->add_noad(make_noad($self->get_class(), $mlist));

    return;
}

1;

__END__
