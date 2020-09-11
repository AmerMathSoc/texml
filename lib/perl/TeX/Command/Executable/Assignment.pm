package TeX::Command::Executable::Assignment;

use strict;
use warnings;

use Carp;

use base qw(TeX::Command::Prefixed Exporter);

our %EXPORT_TAGS = ( modifiers => [ qw(MODIFIER_LONG   MODIFIER_OUTER
                                       MODIFIER_GLOBAL MODIFIER_EXPAND
                                    ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{modifiers} } );

our @EXPORT = ();

use constant {
    MODIFIER_LONG   => 1,
    MODIFIER_OUTER  => 2,
    MODIFIER_GLOBAL => 4,
    MODIFIER_EXPAND => 8,
    # MODIFIER_PROTECTED => 16, # eTeX extension
};

use TeX::Class;

1;

__END__
