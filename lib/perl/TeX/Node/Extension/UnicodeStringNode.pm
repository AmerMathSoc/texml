package TeX::Node::Extension::UnicodeStringNode;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(TeX::Node::CharNode Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_unicode_string) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT;

use utf8;

use TeX::Class;

my %contents_of :ATTR(:name<contents>);

sub new_unicode_string( $ ) {
    my $string = shift;

    utf8::upgrade($string); # ugh.  See __new_utf8_string in TeX::Output::XML

    return __PACKAGE__->new({ contents => $string });
}

sub to_string :STRINGIFY {
    my $self = shift;

    return $self->get_contents();
}

1;

__END__
