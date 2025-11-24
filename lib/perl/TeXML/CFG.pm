package TeXML::CFG;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

use warnings;

use Config::IniFiles;

use File::Spec::Functions qw(catfile);

use FindBin;

use TeX::Class;

my %root_of     :ATTR(:name<root>);

my %cfg_dir_of  :ATTR(:name<cfg_dir>);
my %cfg_file_of :ATTR(:name<cfg_file>);

my %config_of :ATTR(:name<config>);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub BUILD :RESTRICTED { }

sub START {
    my ($self, $ident, $arg_ref) = @_;

    if (! defined $self->get_root()) {
        my $root = $FindBin::RealBin =~ s{/texml\b.*$}{/texml}r;

        $self->set_root($root);
    }

    if (! defined $self->get_cfg_dir()) {
        my $cfg_dir = catfile($self->get_root(), 'cfg');

        $self->set_cfg_dir($cfg_dir);
    }

    if (! defined $self->get_cfg_file()) {
        my $program_name = $0 =~ s{^.*/}{}r;

        my $cfg_file = "$program_name.cfg";

        $self->set_cfg_file($cfg_file);
    }

    return;
}

GET_CFG: {
    my $CFG;

    sub get_cfg {
        my $class   = shift;
        my $arg_ref = shift || {};

        return $CFG if defined $CFG;

        my $config = Config::IniFiles->new(-default => 'DEFAULTS',
                                           -allowcontinue => 1);

        $CFG = __PACKAGE__->new({ $arg_ref->%*, config => $config });

        my $cfg_file = catfile($CFG->get_cfg_dir(), $CFG->get_cfg_file());

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

    my $val = $self->get_config()->val(@_);

    if (defined (my $root = $self->get_root())) {
        $val =~ s{\$TEXML_ROOT\b}{$root}g if defined $val;
    }

    return $val;
}

######################################################################
##                                                                  ##
##                         AUTOMETHOD MAGIC                         ##
##                                                                  ##
######################################################################

sub AUTOMETHOD {
    my ($self, $ident, @args) = @_;

    my $subname = $_;   # Requested subroutine name is passed via $_

    my $config = $self->get_config();

    if ($config->can($subname)) {
        return sub() { return $config->$subname(@args) };
    }

    return;
}

1;

__END__
