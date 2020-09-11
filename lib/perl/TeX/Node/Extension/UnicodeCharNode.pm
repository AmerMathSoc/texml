package TeX::Node::Extension::UnicodeCharNode;

## This probably doesn't need to be separate from TeX::Node::CharNode.

use strict;
use warnings;

use TeX::Output::FontMapper qw(decode_character);

use base qw(TeX::Node::CharNode Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_unicode_character) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Class;

use TeX::Interpreter::Constants;

my %CACHE;

sub new_unicode_character( $;$ ) {
    my $char_code = shift;

    my $encoding = shift || DEFAULT_CHARACTER_ENCODING;

    my $cached = $CACHE{$encoding}->{$char_code};

    return $cached if defined $cached;

    my $ucs_code = $char_code;

    if ($char_code < 256 && $encoding ne DEFAULT_CHARACTER_ENCODING) {
        $ucs_code = decode_character($encoding, $char_code);
    }

    $cached = __PACKAGE__->new({ char_code => $ucs_code });

    return $CACHE{$encoding}->{$char_code} = $cached;
}

1;

__END__
