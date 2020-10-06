package TeXML::CFG;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use Config::IniFiles;

use FindBin;

GET_CFG: {
    my $CFG;

    sub get_cfg {
        my $class = shift;
        my $arg_ref = shift || {};

        return $CFG if defined $CFG;

        $CFG = Config::IniFiles->new(-default => 'DEFAULTS',
                                     -allowcontinue => 1);

        my $cfg_file = "$FindBin::RealBin/../cfg/texml.cfg";

        if (-e $cfg_file) {
            $CFG->SetFileName($cfg_file);
            $CFG->ReadConfig();
        }

        return $CFG;
    }

    ## Avoid finalization segfault.
    END { undef $CFG; }
}

1;

__END__
