package TeXML::CFG;

# Copyright (C) 2022 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

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
