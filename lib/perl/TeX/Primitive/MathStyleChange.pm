package TeX::Primitive::MathStyleChange;

use strict;
use warnings;

use base qw(TeX::Command::Executable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_style_change) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Noad::StyleNode;

use TeX::Class;

my %style_node :ATTR(:get<style_node> :set<style_node> :init_arg => "style");

sub make_style_change($$) {
    my $name  = shift;
    my $style = shift;

    my $style_node = TeX::Noad::StyleNode->new({ style => $style });

    return __PACKAGE__->new({ name => $name, style => $style_node });
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $style_node = $self->get_style_node();

    $tex->add_noad($style_node);

    return;
}

1;

__END__
