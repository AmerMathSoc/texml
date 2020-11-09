package TeX::Interpreter::LaTeX::Package::url;

use strict;
use warnings;

use TeX::Constants qw(EXPANDED);

use TeX::WEB2C qw(:catcodes);

use TeX::Utils::DOI qw(doi_to_url);

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

    $tex->define_pseudo_macro('TeXML@DOItoURI' => \&do_texml_doi_to_uri);

    return;
}

sub do_texml_doi_to_uri {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    $tex->begingroup();

    for my $char (split '', '\\$&%^_~') {
        $tex->set_catcode(ord($char), CATCODE_OTHER);
    }

    $tex->set_catcode(ord('$'), CATCODE_OTHER);

    my $doi = $tex->read_undelimited_parameter(EXPANDED);

    my $uri = doi_to_url($doi);

    my $tokens = $tex->tokenize($uri);

    $tex->endgroup();

    return $tokens;
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

    my $arg = $tex->read_undelimited_parameter();

    if ($arg->length() != 1) {
        $tex->latex_error("Expected a single control sequence, got '$arg' ");

        return;
    }

    my $cstoken = $arg->head();

    if (! $cstoken->is_csname()) {
        $tex->latex_error("Expected control sequence, got '$cstoken' ");

        return;
    }

    my $csname = $cstoken->get_csname();

    my $url_string = $tex->get_csname($csname);

    if (! defined $url_string) {
        $tex->latex_error("$cstoken is undefined");

        return;
    }

    my $eqvt = $url_string->get_equiv();

    my $url = $eqvt->get_replacement_text();

    if ($url !~ m{^(ftp|https?)://}) {
        $url->unshift($tex->tokenize('http://'));
    }

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
