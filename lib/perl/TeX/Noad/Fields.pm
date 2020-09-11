package TeX::Noad::Fields;

use strict;
use warnings;

use TeX::WEB2C qw(:math_params :extras);

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(make_char_field
                                      make_text_char_field
                                      make_box_field
                                      make_mlist_field
                                   ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{factories} } );

use TeX::Noad::MathCharField;
use TeX::Noad::MathTextCharField;
use TeX::Noad::SubBoxField;
use TeX::Noad::SubMlistField;

sub make_char_field($$) {
    my $family = shift;
    my $char_code = shift;

    return TeX::Noad::MathCharField->new({ family => $family,
                                           char_code => $char_code });
}

sub make_text_char_field($$) {
    my $family = shift;
    my $char_code = shift;

    return TeX::Noad::MathTextCharField->new({ family => $family,
                                               char_code => $char_code });
}

sub make_box_field( $ ) {
    my $box = shift;

    return TeX::Noad::SubBoxField->new({ box => $box });
}

sub make_mlist_field( $ ) {
    my $mlist = shift;

    return TeX::Noad::SubMlistField->new({ mlist => $mlist });
}

1;

__END__
