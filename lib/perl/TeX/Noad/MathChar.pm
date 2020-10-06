package TeX::Noad::MathChar;

use strict;
use warnings;

use TeX::Class;

my %class_of     :ATTR(:set<class>     :get<class>);
my %family_of    :ATTR(:set<family>    :get<family>);
my %char_code_of :ATTR(:set<char_code> :get<char_code>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $class_of{$ident}     = $arg_ref->{class};
    $family_of{$ident}    = $arg_ref->{family};
    $char_code_of{$ident} = $arg_ref->{char_code};

    return;
}

1;

__END__
