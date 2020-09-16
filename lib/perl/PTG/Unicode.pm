package PTG::Unicode;

use strict;
use warnings;

use version; our $VERSION = qv '2.0.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    ascii_base
    base_characters
    decompose
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

use TeX::Utils::Misc;

use Unicode::UCD qw(charinfo);

######################################################################
##                                                                  ##
##                     INTERNAL IMPLEMENTATION                      ##
##                                                                  ##
######################################################################

sub __decompose( $ ) {
    my $char = shift;

    my @decomposition;

    my @partial = (sprintf "%04X", ord($char));

    while (@partial) {
        my $first = shift @partial;

        ## Prepend "U+" to keep Unicode::UCD::_getcode() from
        ## interpreting a sequence of decimal digits as a decimal
        ## integer instead of a hexadecimal integer.

        my $charinfo = charinfo("U+$first");

        my $decomposition = $charinfo->{decomposition};

        if (nonempty($decomposition) && $decomposition =~ s{<(\w+)>\s+}{}smx) {
            my $type = $1;

            if ($type ne 'fraction' && $type ne 'compat') {
                undef $decomposition;
            }
        }

        if (empty($decomposition)) {
            push @decomposition, $first;

            next;
        }

        unshift @partial, split / /, $decomposition;
    }

    return map { chr(hex($_)) } @decomposition;
}

DECOMPOSE: {
    my %DECOMPOSITION;

    sub decompose( $ ) {
        my $char = shift;

        if (! exists $DECOMPOSITION{$char}) {
            $DECOMPOSITION{$char} = [ __decompose($char) ];
        }

        return @{ $DECOMPOSITION{$char} };
    }
}

sub __base_characters( $ ) {
    my $char = shift;

    my @base;

    my @decomposition = decompose($char);

    for my $piece (@decomposition) {
        if ($piece =~ /\P{Mark}/) {
            push @base, $piece;
        }
    }

    return concat(@base);
}

BASE_CHARACTERS: {
    my %BASE;

    sub base_characters( $ ) {
        my $char = shift;

        if (! exists $BASE{$char}) {
            $BASE{$char} = __base_characters($char);
        }

        return $BASE{$char};
    }
}

sub __ascii_base( $ ) {
    my $char = shift;

    my @ascii;

    for my $base (base_characters($char)) {
        if (ord($base) < 128) {
            push @ascii, $base;
        } else {
            ## drop it
            # push @ascii, "[:$char:]";
        }
    }

    return concat(@ascii);
}

ASCII_BASE: {
    my %ASCII_BASE;

    sub ascii_base( $ ) {
        my $char = shift;

        if (! exists $ASCII_BASE{$char}) {
            $ASCII_BASE{$char} = __ascii_base($char);
        }

        return $ASCII_BASE{$char};
    }
}

1;

__END__
