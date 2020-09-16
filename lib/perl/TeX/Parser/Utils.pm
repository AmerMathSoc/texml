package TeX::Parser::Utils;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    trim_spaces
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ( @{ $EXPORT_TAGS{all} } );

use TeX::Token qw(:factories);

use TeX::WEB2C qw(:catcodes);

use constant EOL => make_character_token("\n", CATCODE_END_OF_LINE);

sub trim_spaces( $ ) {
    my $token_list = shift;

    my $num_deleted = 0;

    my $head = $token_list->head();

    while (defined $head && ($head == CATCODE_SPACE || $head == EOL)) {
        $token_list->shift();

        $num_deleted++;

        $head = $token_list->head();
    }

    my $tail = $token_list->tail();

    while (defined $head && ($tail == CATCODE_SPACE || $tail == EOL)) {
        $token_list->pop();

        $num_deleted++;

        $tail = $token_list->tail();
    }

    return $num_deleted;
}


1;

__END__
