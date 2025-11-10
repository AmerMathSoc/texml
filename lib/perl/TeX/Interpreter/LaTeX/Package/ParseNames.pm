package TeX::Interpreter::LaTeX::Package::ParseNames;

# Semi-experimental support for parsing names à la BibTeX.  This is
# probably about as far as we can go with this approach.

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);

use TeX::Utils::Misc;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->define_csname('texml@parse@name' => \&do_parse_name);

    # $tex->read_package_data();

    return;
}

sub do_parse_name {
    my $tex   = shift;
    my $token = shift;

    my $prefix = $tex->read_undelimited_parameter()->head();

    $prefix = $prefix->get_csname() if $prefix == CATCODE_CSNAME;

    ## TODO: This is going to choke if there is a ~ or control space
    ## in the name.  Cf. changes to amsclass's do_parse_name().

    my $raw_name = trim($tex->read_undelimited_parameter(EXPANDED));

    my ($given, $von, $surname, $suffix) = parse_name($raw_name);

    $surname = "$von $surname" if nonempty($von);

    my $string_name = $surname;

    $string_name = "$given $string_name" if nonempty($given);

    $string_name .= ", $suffix" if nonempty($suffix);

    $tex->define_simple_macro("$prefix\@string\@name", $string_name);

    $tex->define_simple_macro("$prefix\@given",   $given);
    $tex->define_simple_macro("$prefix\@surname", $surname);
    $tex->define_simple_macro("$prefix\@suffix",  $suffix);

    return;
}

my %IS_AUX = (Bar => 1,
              De  => 1,
              Den => 1,
              Der => 1,
              Di  => 1,
              Du  => 1,
              El  => 1,
              La  => 1,
              Le  => 1,
              Van => 1,
              Von => 1,
              );

my $TOKEN;

{
    my $ESCAPE = qr{\\}; # *sigh*

    my $COMMA = qr{,};

    my $LETTER = qr{(?: \p{L} )}smx;

    my $NON_LETTER = qr{(?: \P{L} )}smx;

    my $CONTROL_WORD     = qr{ $ESCAPE ( $LETTER+ ) }osmx;

    my $CONTROL_SYMBOL   = qr{ $ESCAPE ( $NON_LETTER ) }osmx;

    my $CONTROL_SEQUENCE = qr{ (?: $CONTROL_SYMBOL | $CONTROL_WORD ) }osmx;

    my $BALANCED_TEXT;

    {
        use re 'eval';

        ## Note that this is subtly different from the corresponding
        ## pattern in TeX::LaTeX::Parser.

        $BALANCED_TEXT = qr{
            (?> $CONTROL_SEQUENCE | [^{}]+ | \{\} | \{ (??{ $BALANCED_TEXT }) \} )*
        }osmx;
    }

    my $WORD = qr{ (   $CONTROL_SYMBOL
                     | $CONTROL_SEQUENCE\p{Space}*
                     | [^,\p{Space}{}]
                     | \{ $BALANCED_TEXT \} ) +
    }osmx;

    $TOKEN = qr{ ( $WORD | \p{Space}+ | $COMMA ) }smx;
}

sub is_particle { # "von"
    my $string = shift;

    # BibTeX only tests to see if the first character is lowercase.

    return exists $IS_AUX{$string} || $string eq lc($string);
}

sub is_suffix {
    my $string = shift;

    return $string =~ /\A ( [Jj]r\.? | [IVX]+ ) \z /smx;
}

sub tokenize_namelist {
    my $name = shift;

    my $num_commas = 0;

    my @groups;

    my @tokens;

    while ($name =~ s/\A ($TOKEN)//osmx) {
        my $token = $1;

        next if $token =~ m{\A \p{Space}+ \z}smx;

        if ($token eq ',') {
            push @groups, [ @tokens ];

            @tokens = ();

            next;
        }

        push @tokens, $token;
    }

    push @groups, [ @tokens ] if @tokens;

    return @groups;
}

sub __parse_surname {
    my @surname = @_;

    my @von;

    while (@surname > 1 && is_particle($surname[0])) {
        push @von, shift @surname;
    }

    return (join(" ", @von), join(" ", @surname));
}

sub __parse_name_1 {
    my @groups = @_;

    return unless @groups;

    my @tokens = $groups[0]->@*;

    return unless @tokens;

    my @first;
    my @von;

    my @last = pop @tokens;

    while (my $token = shift @tokens) {
        if (is_particle($token)) {
            push @von, $token;

            last;
        }

        push @first, $token;
    }

    while (@tokens && is_particle($tokens[0])) {
        push @von, shift @tokens;
    }

    unshift @last, @tokens;

    my $first = join " ", @first;
    my $von   = join " ", @von;
    my $last  = join " ", @last;
    my $jr    = "";

    return ($first, $von, $last, $jr);
}

sub __parse_name_2 {
    my @groups = @_;

    return unless @groups;

    my ($von, $last) = __parse_surname($groups[0]->@*);

    my $first = join " ", $groups[1]->@*;

    my $jr = "";

    return ($first, $von, $last, $jr);
}

sub __parse_name_3 {
    my @groups = @_;

    return unless @groups;

    my ($von, $last) = __parse_surname($groups[0]->@*);

    my $jr = join " ", $groups[1]->@*;

    my $first = join " ", $groups[2]->@*;

    return ($first, $von, $last, $jr);
}

sub parse_name {
    my $name = shift;

    my @groups = tokenize_namelist($name);

    if (@groups > 3) {
        warn "Too many commas in name ", join(" ", @groups), "\n";
    }

    my @parsed;

    if (@groups > 2) {
        @parsed = __parse_name_3(@groups);
    } elsif (@groups == 2) {
        @parsed = __parse_name_2(@groups);
    } else {
        @parsed = __parse_name_1(@groups);
    }

    return wantarray ? @parsed : \@parsed;
}

1;

__DATA__

\ProvidesPackage{ParseNames}

% \LoadRawMacros

\endinput

__END__
