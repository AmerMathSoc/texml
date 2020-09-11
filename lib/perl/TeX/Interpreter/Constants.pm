package TeX::Interpreter::Constants;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.1';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(DEFAULT_CHARACTER_ENCODING expanded) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} });

our @EXPORT =  ( @{ $EXPORT_TAGS{all} });

use constant DEFAULT_CHARACTER_ENCODING => "UTF-32";

use constant expanded => 1;

1;

__END__
