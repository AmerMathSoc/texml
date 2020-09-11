package TeX::Primitive::TopBotMark;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

use base qw(TeX::Command::Expandable);

use TeX::WEB2C qw(:token_types);

my %mark_code_of :COUNTER(:name<mark_code> :default<-1>);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $mark_code = $self->mark_code();

    if (defined(my $token_list = $tex->get_cur_mark($mark_code))) {
        $tex->begin_token_list($token_list, mark_text);
    }

    return;
}

1;

__END__
