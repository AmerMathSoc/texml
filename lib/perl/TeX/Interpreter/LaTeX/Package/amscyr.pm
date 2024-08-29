package TeX::Interpreter::LaTeX::Package::amscyr;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use TeX::Token qw(:catcodes :factories);
use TeX::TokenList qw(:factories);

use TeX::Output::FontMapper;

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->define_pseudo_macro('texml@translit@ot@two' => \&do_translit_ot2);

    $tex->read_package_data();

    return;
}

sub do_translit_ot2 {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $token_list = new_token_list;

    my $arg = $tex->read_undelimited_parameter();

    ## This is barely acceptable.  We don't handle ligatures, although
    ## note the definitions of \dz, etc., below.  It also chokes on
    ## things like \textcyr{\char"1E }.  In order to handle this sort
    ## of thing properly, we will probably need to postpone it until
    ## the output stage.

    my $enc = TeX::Output::FontMapper::get_encoding('OT2');

    for my $token ($arg->get_tokens()) {
        if ($token == CATCODE_LETTER || $token == CATCODE_OTHER) {
            my $char_code = ord($token->get_char());

            if (defined(my $new_char_code = $enc->[$char_code])) {
                $new_char_code =~ s{<0x(.*?)>}{hex($1)}e;

                $token_list->push(make_character_token(chr($new_char_code), $token->get_catcode()));
            } else {
                $token_list->push($token);
            }
        } else {
            $token_list->push($token);
        }
    }

    return $token_list;
}

1;

__DATA__

\ProvidesPackage{amscyr}

\let\textcyr\texml@translit@ot@two

\def\mathcyr#1{\mathrm{\texml@translit@ot@two{#1}}}

\protected@edef\mitBe{\protect\mathit{\Uchar"0411 }}
\protected@edef\cyrCh{\protect\mathrm{\Uchar"0427}}
\protected@edef\Sha{\protect\mathrm{\Uchar"0428}}
\protected@edef\Shcha{\protect\mathrm{\Uchar"0429}}
\protected@edef\De{\protect\mathrm{\Uchar"0434}}

\protected@edef\cprime{\Uchar"044C }
\protected@edef\Cprime{\Uchar"042C }
\protected@edef\cdprime{\Uchar"044A }
\protected@edef\Cdprime{\Uchar"042A }

\newcommand{\dbar}{dj}
\newcommand{\Dbar}{Dj}

\protected@edef\dz{\Uchar"0455 }
\protected@edef\Dz{\Uchar"0405 }
\protected@edef\dzh{\Uchar"045F }
\protected@edef\Dzh{\Uchar"040F }

\endinput

__END__
