package TeX::Interpreter::LaTeX::Package::url;

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

use TeX::Constants qw(EXPANDED);

use TeX::Node::Extension::UnicodeStringNode qw(:factories);

use TeX::Utils::DOI qw(doi_to_url);
use TeX::Utils::Misc qw(nonempty);

use TeX::Token qw(:catcodes);

use TeX::Token::Constants;

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname('TeXML@NormalizeURL' => \&do_normalize_url);

    $tex->define_pseudo_macro('Url@FormatString' => \&do_url_formatstring);

    return;
}

sub do_url_formatstring {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $url_string = $tex->get_csname('Url@String');

    if (! defined $url_string) {
        die "No URL\@string!\n";
    }

    my $eqvt = $url_string->get_equiv();

    my $url_for_display = $eqvt->get_replacement_text();

    my $url_for_link = $url_for_display->clone();

    if ($url_for_link !~ m{^((ftp|https?)://|mailto:)}) {
        ## I would really like to use https here, but there's always
        ## the chance that we're dealing with an old server that
        ## doesn't support https.
        ##
        ## Of course, we could also be dealing with a paranoid server
        ## that doesn't support http...

        $url_for_link->unshift($tex->tokenize('http://'));
    }

    my $formatted = TeX::TokenList->new();

    $tex->begingroup();

    $tex->set_catcode(ord('\\'), CATCODE_ESCAPE);
    $tex->set_catcode(ord('{'),  CATCODE_BEGIN_GROUP);
    $tex->set_catcode(ord('}'),  CATCODE_END_GROUP);
    $tex->set_catcode(ord(' '),  CATCODE_IGNORED);

    ## No linebreaks here because this is in the scope of \obeylines from \Url

    $formatted = $tex->tokenize(q{\leavevmode\startXMLelement{ext-link}\setXMLattribute{xlink:href}});

    $formatted->push(BEGIN_GROUP, $url_for_link, END_GROUP);

    $formatted->push($url_for_display);

    $formatted->push($tex->tokenize(q{\endXMLelement{ext-link}}));

    $tex->endgroup();

    return $formatted;
}

sub do_normalize_url {
    my $tex   = shift;
    my $token = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box = $tex->box($index);

    my $url = $box->to_string();

    # Although fundamentally misguided
    # (https://unspecified.wordpress.com/2012/02/12/how-do-you-escape-a-complete-uri/),
    # hopefully this is useful heuristic:

    if ($url !~ m{%} && $url =~ m{\A(?: (ftp|https?)://)? (.*?) (?:/ (.*?))? (?: \? (.*))? \z}smx) {
        my $proto = $1 || 'http';
        my $host  = $2;
        my $path  = $3;
        my $query = $4;

        ## This is kind of like URI::Escape::escape_uri, but it
        ## doesn't replace /

        $url = qq{$proto://$host};

        if (nonempty($path)) {
            $path =~ s{([^A-Za-z0-9/\-\._~\#])}{ sprintf("%%%02X", ord($1)) }eg;

            $url .= qq{/$path};
        }

        $url .= qq{?$query} if nonempty $query;
    }

    $box->delete_nodes();

    $box->push_node(new_unicode_string($url));

    return;
}

1;

__DATA__

\ProvidesPackage{url}

\LoadRawMacros

% \def\url{%
%   \leavevmode
%   \begingroup
%       \Url
% }

%% TBD: Might need to remove spaces

\def\Url{%      % # & _ ~ $ ^
        \fontencoding{UCS}%
        \Url@movingtest
        \ifmmode\@inmatherr$\fi %$
        \let\do\@makeother \dospecials % verbatim catcodes
        \catcode`\\=\z@  % Vide infra.
        \catcode`\{=\@ne % with exceptions
        \catcode`\}=\tw@
        \catcode`\ =10 % allow "\url {x}"
        \let\%\@percentchar
        \edef\#{\string##}%
        \edef\&{\string&}%
        \edef\_{\string_}%
        \edef\~{\string~}%
        \edef~{\string~}%
        \def\\{\textbackslash}%\textbackslash
        \let\\\textbackslash
        \edef\\{\Uchar"005C }%
        \@ifnextchar\bgroup{\obeyspaces\obeylines\Url@z}\Url@y
}

\def\Url@z#1{%
        \toks@\expandafter{\expanded{#1}}% Vide infra.
        \edef\Url@String{\the\toks@}%
        \edef\Url@String{\expandafter\strip@prefix\meaning\Url@String}%
        \Url@ObeySp % may be no-op; otherwise put ordinary (12) space characters
        \Url@HyperHook
        {\Url@FormatString}%
    \endgroup
}

\endinput

__END__

Consider this document:

    \documentclass{amsart}

    \usepackage{url}

    \def\A{https://www.ams.org}

    \begin{document}

    \url{\A}

    \end{document}

The output is "\A" (unlinked because url.sty alone doesn't create
links.)

If you replace the url package by hyperref, the output is
"https://www.ams.org" (properly linked).

In other words, hyperref.sty expands macros inside of \url; url.sty
doesn't.

I don't want to implement two different versions of \url, so I'm just
going to fold hyperref's behaviour into url.  This involves changing
the catcode of `\\ in \Url and expanding the token list in the first
line of \Url@z.
