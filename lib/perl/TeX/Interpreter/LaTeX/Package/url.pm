package TeX::Interpreter::LaTeX::Package::url;

use strict;
use warnings;

use TeX::Constants qw(EXPANDED);

use TeX::Node::Extension::UnicodeStringNode qw(:factories);

use TeX::WEB2C qw(:catcodes);

use TeX::Utils::DOI qw(doi_to_url);
use TeX::Utils::Misc qw(nonempty);

use TeX::Token qw(make_character_token);

use TeX::WEB2C qw(:catcodes);

use constant LEFT_BRACE_TOKEN => make_character_token('{', CATCODE_BEGIN_GROUP);
use constant RIGHT_BRACE_TOKEN => make_character_token('}', CATCODE_END_GROUP);

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("url", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::url::DATA{IO});

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

    if ($url_for_link !~ m{^(ftp|https?)://}) {
        $url_for_link->unshift($tex->tokenize('http://'));
    }

    my $formatted = TeX::TokenList->new();

    $tex->begingroup();

    $tex->set_catcode(ord('\\'), CATCODE_ESCAPE);
    $tex->set_catcode(ord('{'),  CATCODE_BEGIN_GROUP);
    $tex->set_catcode(ord('}'),  CATCODE_END_GROUP);
    $tex->set_catcode(ord(' '),  CATCODE_IGNORED);

    $formatted = $tex->tokenize(q{\leavevmode
                                \startXMLelement{ext-link}
                                \setXMLattribute{xlink:href}});

    $formatted->push(LEFT_BRACE_TOKEN, $url_for_link, RIGHT_BRACE_TOKEN);

    $formatted->push($url_for_display);

    $formatted->push($tex->tokenize(q{\endXMLelement{ext-link}}));

    $tex->endgroup();

    return $formatted;
}

sub do_normalize_url {
    my $tex   = shift;
    my $token = shift;

    my $index = $tex->scan_eight_bit_int();

    my $box_ref = $tex->find_box_register($index);

    my $box = ${ $box_ref }->get_equiv();

    my $url = $box->to_string();

    # Although fundamentally misguided
    # (https://unspecified.wordpress.com/2012/02/12/how-do-you-escape-a-complete-uri/),
    # hopefully this is useful heuristic:

    if ($url !~ m{%} && $url =~ m{\A(?: (ftp|https?)://)? (.*?) / (.*?) (?: \? (.*))? \z}smx) {
        my $proto = $1 || 'http';
        my $host  = $2;
        my $path  = $3;
        my $query = $4;

        ## This is kind of like URI::Escape::escape_uri, but it
        ## doesn't replace /

        $path =~ s{([^A-Za-z0-9/\-\._~])}{ sprintf("%%%02X", ord($1)) }eg;

        $url = qq{$proto://$host/$path};

        $url .= qq{?$query} if nonempty $query;
    }

    $box->delete_nodes();

    $box->push_node(new_unicode_string($url));

    return;
}

1;

__DATA__

\begingroup
% \Url@acthash:    convert `other' (doubled) ## to active #
% \Url@actpercent: convert `other' % to active %
\lccode`+=`\#
\lccode`\~=`\#
\lowercase{%
    \long\gdef\Url@acthash{%
        \Url@Edit\Url@String{++}{~}%
        \ifnum\mathcode`\#<32768 \def~{\#}\fi
    }
}%
\lccode`+=`\%
\lccode`\~=`\%
\lowercase{%
    \long\gdef\Url@actpercent{%
        \Url@Edit\Url@String{+}{~}%
        \ifnum\mathcode`\%<32768 \def~{\@percentchar}\fi
    }%
}%

\catcode13=12 %

\gdef\Url@percent{\@ifnextchar^^M{\@gobble}{\mathbin{\mathchar`\%}}}%
\endgroup%

\endinput

__END__
