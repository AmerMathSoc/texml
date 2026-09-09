package TeX::Utils::KeyPairs;

use 5.26.0;

# Copyright (C) 2026 American Mathematical Society
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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(parse_key_pairs) ]);
our @EXPORT_OK   = $EXPORT_TAGS{all}->@*;
our @EXPORT      = $EXPORT_TAGS{all}->@*;

use TeX::Utils::Misc qw(nonempty trim);

my $BALANCED_TEXT = qr{ # Adapted from perlre man page
    (             # paren group 1 (full string)
        \{
            (?<balanced>     # paren group 2 (contents of braces)
            (?:
                (?> \\[{}] )
               |
                (?> [^{}] )    # Non-parens without backtracking
               |
                (?1)            # Recurse to start of paren group 1
            )*
            )
        \}
    )
}smx;

sub parse_key_pairs {
    my $tex = shift;
    my $raw = shift;

    ## Quick and dirty.  Maybe too quick and dirty.

    my %key_pairs;

    return \%key_pairs unless defined $raw;

    $raw = trim($raw);

    $raw .= ',' unless $raw =~ m{,\z};

    while (nonempty($raw)) {
        $raw =~ s{^([a-z]+)[ =]*}{}ismx and do {
            my $key = $1;

            my $value;

            if ($raw =~ s{\A,}{}smx) {
                $value = 'true';
            }
            elsif ($raw =~ s{\A$BALANCED_TEXT\s*,\s*}{}smx) {
                $value = trim($+{balanced});
            }
            elsif ($raw =~ s{\A([^,]+),\s*}{}smx) {
                $value = trim($1);
            }
            else {
                $tex->error_message(qq{Bad key-pair input [$raw]});

                last;
            }

            $key_pairs{$key} = $value;
        };
    }

    return \%key_pairs;
}

1;

__END__
