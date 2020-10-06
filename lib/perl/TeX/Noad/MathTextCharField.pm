package TeX::Noad::MathTextCharField;

use strict;
use warnings;

use base qw(TeX::Noad::MathCharField);

use TeX::Class;

sub is_math_text_char {
    return 1;
}

1;

__END__
