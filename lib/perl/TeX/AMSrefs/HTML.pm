package TeX::AMSrefs::HTML;

use strict;
use warnings;

use version; our $VERSION = qv '2.0.0';

use UNIVERSAL;

use base qw(TeX::AMSrefs);

use Class::Std;

my %use_mathjax_of        :ATTR(:default<0> :name<use_mathjax>);
my %suppress_hyperrefs_of :ATTR(:default<0> :name<suppress_hyperrefs>);
my %suppress_doi_of       :ATTR(:default<0> :name<suppress_doi>);
my %suppress_reviews_of   :ATTR(:default<0> :name<suppress_reviews>);

use TeX::Utils::DOI;

use PTG::Unicode::Translators qw(tex_math_to_unicode
                                 tex_to_unicode_no_math
                                 unicode_to_ascii
                                 unicode_to_html_entities
                                 xml_entities_to_unicode
    );

use TeX::Utils::Misc;

use TeX::WEB2C qw(:selector_codes);

use URI::Escape;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

my %STYLE_TO_TAG = (eprintpages => '',
                    textbf => 'strong',
                    textit => 'em',
                    url    => 'tt',
);

my %DONT_CONVERT = (doi => 1);

######################################################################
##                                                                  ##
##                          HTML5/MATHJAX                           ##
##                                                                  ##
######################################################################

# use TeX::Converters::HTML5;
# 
# HTML5: {
#     my $HTML5;
# 
#     sub get_html5_converter() {
#         if (! defined $HTML5) {
#             $HTML5 = TeX::Converters::HTML5->new( { nofiles => 1,
#                                                     selector => no_print
#                                                   });
# 
#             $HTML5->INITIALIZE();
# 
#             $HTML5->load_document_class("amscommon");
#             $HTML5->load_package("mathscinet");
#         }
# 
#         return $HTML5;
#     }
# }

######################################################################
##                                                                  ##
##                           SUBROUTINES                            ##
##                                                                  ##
######################################################################

sub __doi_url( $;$ ) {
    my $doi = shift;

    my $escape = shift;

    if ($doi !~ m{\A http:}smx) {
        $doi = doi_to_url($doi, $escape);
    }

    return $doi;
}

sub __author_search_url( $ ) {
    my $raw_name = shift;

    return if $raw_name eq TeX::AMSrefs::ETAL_TEXT;

    my $ascii = unicode_to_ascii(xml_entities_to_unicode($raw_name));

    return sprintf qq{https://www.ams.org/mathscinet/search/authors.html?authorName=%s}, uri_escape($ascii);
}

sub format_name_le( $ ) {
    my $self = shift;

    my $raw_name = shift;

    my ($surname, $given, $jr) = split /,\s*/, $raw_name;

    my $name = $given;

    if (nonempty $surname) {
        $name .= " $surname";
    }

    if (nonempty $jr) {
        $name .= " $jr";
    }

    $name = trim($name);

    if (!$self->get_suppress_hyperrefs() &&
        nonempty(my $url = __author_search_url($raw_name))) {
        return sprintf qq{<a href="%s">%s</a>}, $url, $name;
    }

    return $name;
}

sub format_name_be( $ ) {
    my $self = shift;

    my $raw_name = shift;

    my ($surname, $given, $jr) = split /,\s*/, $raw_name;

    my $name = trim("$surname $given");

    if (!$self->get_suppress_hyperrefs() &&
        nonempty(my $url = __author_search_url($raw_name))) {
        return sprintf qq{<a href="%s">%s</a>}, $url, $name;
    }

    return $name;
}

sub get_field {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $field = $bibitem->get_field($key);

    ## Unpack compound values.

    if (UNIVERSAL::isa($field, "TeX::AMSrefs::BibItem::Entry")) {
        if (UNIVERSAL::isa($field->get_value(), "TeX::AMSrefs::BibItem")) {
            return $field->get_value();
        }
    }

    my $is_array = UNIVERSAL::isa($field, 'ARRAY');

    my @entries = $is_array ? @{ $field } : ($field);

    # get_html5_converter();

    if (! $DONT_CONVERT{$key}) {
        for my $entry (@entries) {
            next unless defined $entry;

            next if $entry->get_attribute("__unicode");

            my $value = $entry->get_value();

            my $html;

            $html = $value;

            if ($self->get_use_mathjax()) {
                # my $html5 = get_html5_converter();
                # 
                # $html = trim($html5->convert_string($value));

                $html = tex_to_unicode_no_math($value);
            } else {
                $html = tex_math_to_unicode($value);
                $html = unicode_to_html_entities($html);
            }

            $entry->set_value($html);
            $entry->set_attribute("__unicode", 1);
        }
    }

    if ($is_array) {
        return wantarray ? @{ $field } : $field;
    } else {
        return $field;
    }
}

sub apply_style {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $style = shift;

    my $text = $self->get_field($bibitem, $key);

    my $tag = $STYLE_TO_TAG{$style};

    if (nonempty($tag)) {
        return sprintf '<%s>%s</%s>', $tag, $text, $tag;
    } else {
        return $text;
    }
}

sub format_journal_volume {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $volume = $self->get_field($bibitem, $key);

    my $url = $volume->get_attribute('url');

    my $text = $self->apply_style($bibitem, $key, 'textbf');

    if (!$self->get_suppress_hyperrefs() &&
        nonempty($url)) {
        return qq{<a href = "$url">} . $text . '</a>';
    } else {
        return $text;
    }
}

sub issuetext {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $number = $self->get_field($bibitem, $key);

    my $url = $number->get_attribute('url');

    my $text = "no.&nbsp;$number";

    if (!$self->get_suppress_hyperrefs() &&
        nonempty($url)) {
        return qq{<a href = "$url">} . $text . '</a>';
    } else {
        return $text;
    }
}

sub print_doi {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return '' if ($self->get_suppress_doi());

    my $doi = $self->get_field($bibitem, $key);

    my $display_url = __doi_url($doi);

    my $href_url = $doi->get_attribute('url');

    if (empty $href_url) {
        $href_url = __doi_url($doi, 1);
    }
    
    return $href_url if ($self->get_suppress_hyperrefs());
        
    return sprintf qq{<a href="%s">%s</a>}, $href_url, $display_url;
}

sub format_pages( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $text = $self->get_field($bibitem, $key);

    return "pp.&nbsp;$text";
}

sub format_title {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $title = $self->get_field($bibitem, $key);

    my $url = $title->get_attribute('url');

    # if (empty($url)) {
    #     my $doi = $bibitem->get_field('doi');
    # 
    #     if (nonempty($doi)) {
    #         $url = __doi_url($doi);
    #     }
    # }

    my $title_html = qq{<em>$title</em>};

    if (!$self->get_suppress_hyperrefs() &&
        nonempty($url)) {
        return qq{<a href = "$url" class="amsJournalReferenceTitle">} . $title_html . '</a>';
    } else {
        return $title_html;
    }
}

sub format_journal {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $journal = $self->get_field($bibitem, $key);

    my $url = $journal->get_attribute('url');

    if (!$self->get_suppress_hyperrefs() &&
        nonempty($url)) {
        return qq{<a href = "$url">} . $journal . '</a>';
    } else {
        return $journal;
    }
}

sub __format_mr_link( $ ) {
    my $mr_num = shift;

    my ($cno) = split /\s+/, $mr_num;

    my $url = qq{https://www.ams.org/mathscinet-getitem?mr=$cno};

    return sprintf q{<a href="%s">MR <strong>%s</strong></a>}, $url, $mr_num;
}

sub print_reviews {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return '' if ($self->get_suppress_reviews());

    my @reviews = $self->get_field($bibitem, $key);

    for my $review (@reviews) {
        if ($review =~ m{\A \\MR\{ (.*?) \} \z}smx) {
            my $mr_num = $1;

            if ($self->get_suppress_hyperrefs()) {
                $review = $mr_num;
            } else {
                $review = __format_mr_link($mr_num);
            }
        }
    }

    return $self->print_series(q{}, q{, }, q{, }, q{, }, q{}, @reviews);
}

1;

__END__
