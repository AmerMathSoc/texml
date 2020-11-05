package TeXML::CFG;

use strict;
use warnings;

use version; our $VERSION = qv '2.0.0';

use base qw(Config::IniFiles);

use FindBin;

(my $TEXML_ROOT = $FindBin::RealBin) =~ s{/bin$}{};

GET_CFG: {
    my $CFG;

    sub get_cfg {
        my $class = shift;
        my $arg_ref = shift; # || {};

        return $CFG if defined $CFG;

        $CFG = __PACKAGE__->new(-default => 'DEFAULTS',
                                -allowcontinue => 1);

        my $cfg_file = $arg_ref->{cfg_file};;

        if (! defined $cfg_file) {
            (my $program_name = $0) =~ s{^.*/}{};

            $cfg_file = "$program_name.cfg";
        }

        $cfg_file = "$FindBin::RealBin/../cfg/$cfg_file";

        if (-e $cfg_file) {
            $CFG->SetFileName($cfg_file);
            $CFG->ReadConfig();
        }

        return $CFG;
    }

    ## Avoid finalization segfault.
    END { undef $CFG; }
}

sub val {
    my $self = shift;

    my $val = $self->SUPER::val(@_);

    $val =~ s{\$TEXML_ROOT\b}{$TEXML_ROOT} if defined $val;

    return $val;
}

1;

__END__
