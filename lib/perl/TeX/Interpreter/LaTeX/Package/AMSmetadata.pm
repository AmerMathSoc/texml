package TeX::Interpreter::LaTeX::Package::AMSmetadata;

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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(find_gentag_file) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

######################################################################
##                                                                  ##
##                             IMPORTS                              ##
##                                                                  ##
######################################################################

use TeX::Utils::Misc;

use TeX::Utils::LibXML;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

my $PUBS;
my $BUILDER;

######################################################################
##                                                                  ##
##                            UTILITIES                             ##
##                                                                  ##
######################################################################

sub __to_unicode( $ ) {
    my $mf = shift;

    my $utf8 = $mf->as_unicode();

    # Patch things like ^{c}.

    $utf8 =~ s{\^\{([a-z])\}}{<sup>$1</sup>}smxig;

    return $utf8;
}

######################################################################
##                                                                  ##
##                          XML UTILITIES                           ##
##                                                                  ##
######################################################################

sub find_gentag_file( $ ) {
    my $dom = shift;

    my $document_element = $dom->documentElement();

    my $type = $document_element->nodeName();

    if ($type eq 'article') {
        my $journal_meta = find_unique_node($dom, "/article/front/journal-meta");

        my $article_meta = find_unique_node($dom, "/article/front/article-meta");

        if (nonempty(my $pii = $article_meta->findvalue('article-id[@pub-id-type="pii"]'))) {
            return $PUBS->journal_gentag_file({ pii => $pii });
            }

        my $publ_key = $journal_meta->findvalue('journal-id[@journal-id-type="publisher"]');

        my $issue_year = $article_meta->findvalue('history/date[@date-type="issue-date"]/year');
        my $volume     = $article_meta->findvalue('volume');
        my $number     = $article_meta->findvalue('issue');
        my $pii        = $article_meta->findvalue('article-id[@pub-id-type="pii"]');
        my $gentag = $PUBS->journal_gentag_file({ publ_key => $publ_key,
                                                  year     => $issue_year,
                                                  volume   => $volume,
                                                  number   => $number,
                                                  pii      => $pii });

        return $gentag if defined $gentag;

        ## If it's just been assigned to an issue, the gentag file
        ## might still be in the EFF directory.

        return $PUBS->journal_gentag_file({ publ_key => $publ_key,
                                            year     => 0,
                                            volume   => 0,
                                            number   => 0,
                                            pii      => $pii });
    } elsif ($type eq 'book') {
        my $book = find_unique_node($dom, q{/book});

        my $book_meta = find_unique_node($dom, q{/book/book-meta});

        my $publ_key = $book_meta->findvalue(q{book-id[@book-id-type="publisher"]});
        my $volume   = $book_meta->findvalue(q{book-volume-number});

        if (empty($publ_key) || empty($volume)) {
            TeX::RunError->throw("Missing publ_key or volume\n");
        }

        return $PUBS->book_gentag_file($publ_key, $volume);
    } else {
        TeX::RunError->throw("Unknown document type '$type'");
    }

    return;
}

######################################################################
##                                                                  ##
##                          TEX INTERFACE                           ##
##                                                                  ##
######################################################################

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    if (eval "require PRD::Document::Builder") {
        $tex->print_nl("Found private AMS modules: Enabling full metadata support");

        $BUILDER = PRD::Document::Builder->new();

        require PRD::Publications; # No imports needed.

        $PUBS = PRD::Publications->new();

        require PRD::MSC;          # No imports needed.

        require PTG::URLUtils;

        PTG::URLUtils->import();

        $tex->define_csname(AddAMSmetadata => \&do_add_ams_metadata);
    } else {
        $tex->print_nl("Can't find private AMS modules: Disabling extended metadata support");

        $tex->define_csname(AddAMSmetadata => sub {});
    }

    $tex->print_ln();

    $tex->read_package_data();

    return;
}

sub do_add_ams_metadata {
    my $tex   = shift;
    my $token = shift;

    my $dom = $tex->get_output_handle()->get_dom();

    $tex->print_ln();
    $tex->print_nl("%% Loading AMS metadata");

    my $gentag_file = eval { find_gentag_file($dom) };

    if ($@) {
        $tex->print_nl("%% FAILED: $@");
        $tex->print_ln();
        $tex->print_ln();

        return;
    }

    if (empty($gentag_file) || ! -e $gentag_file) {
        $tex->print_nl("%% FAILED: No gentag file!");
        $tex->print_ln();
        $tex->print_ln();

        return;
    }

    $tex->print_nl("%% Loading $gentag_file");

    my $gentag = $BUILDER->convert_xml_file($gentag_file);

    if (! defined $gentag) {
        $tex->print_err("%% FAILED: Could not parse gentag file");
        $tex->error();

        return;
    }

    ## In case the MR number isn't in the gentag file yet.
    $gentag->add_mr_number();

    my $doctype = $gentag->get_doctype();

    add_xml_lang($tex, $dom, $gentag);

    $tex->begingroup();

    ## \tsup from textcmds.sty is used in some funding statements.  We
    ## can't just load textcmds.sty because it causes too many
    ## conflicts with author macros.

    $tex->define_simple_macro(tsup => qq{\\XMLelement{sup}});

    if ($doctype eq 'article') {
        eval {
            my $old_front = find_unique_node($dom, "/article/front");

            my $new_front = create_new_journal_front($tex, $gentag, $old_front);

            $old_front->replaceNode($new_front);
        };
    } elsif ($doctype eq 'monograph') {
        eval {
            ## There might not be an existing book-meta element, so we
            ## can't just replace it.

            my $root = $dom->documentElement();

            my $book = find_unique_node($dom, q{/book});

            if (defined(my $meta = find_unique_node($dom, q{/book/book-meta}))) {
                $book->removeChild($meta);
            }

            my $front_matter = find_unique_node($root, '/book/front-matter');

            my $meta = create_book_meta($tex, $gentag);

            $root->insertBefore($meta, $front_matter);

            my $cmeta = create_collection_meta($tex, $gentag);

            $root->insertBefore($cmeta, $meta);
        };
    } else {
        $@ = "Unknown doctype '$doctype'";
    }

    $tex->endgroup();

    if ($@) {
        $tex->print_err("%% Couldn't add AMS metadata: $@");

        $tex->error();
    } else {
        $tex->print_ln();
    }

    return;
}

######################################################################
##                                                                  ##
##                         METADATA METHODS                         ##
##                                                                  ##
######################################################################

sub add_xml_lang( $ ) {
    my $tex = shift;
    my $dom = shift;
    my $gentag = shift;

    my $language = $gentag->get_language();

    return if empty($language);

    my $root = $dom->documentElement();

    if ($language eq 'English') {
        $root->setAttribute("xml:lang" => 'en');
    } elsif ($language eq 'French') {
        $root->setAttribute("xml:lang" => 'fr');
    } else {
        $tex->print_err("%% WARNING: Unknown language '$language'");

        $tex->error();
    }

    return;
}

sub append_date {
    my $tex = shift;

    my $parent     = shift;
    my $date       = shift;
    my $date_type  = shift;

    my $pub_format = shift;
    my $date_tag   = shift || "date";

    my $date_element = append_xml_element($parent, $date_tag);

    $date_element->setAttribute("date-type", $date_type);

    if (nonempty($pub_format)) {
        $date_element->setAttribute("publication-format", $pub_format);
    }

    my $year  = $date->get_year();
    my $month = $date->get_month_num();
    my $day   = $date->get_day();

    my $iso_8601_date = $year;

    if (nonempty($month) && $month > -1) {
        $iso_8601_date .= sprintf "-%02d", $month;

        if (nonempty($day) && $day > -1) {
            $iso_8601_date .= sprintf "-%02d", $day;
        }
    }
    $date_element->setAttribute("iso-8601-date", $iso_8601_date);

    append_xml_element($date_element, "day", $day) if nonempty($day) && $day > -1;
    append_xml_element($date_element, "month", $month) if nonempty($month) && $month > -1;
    append_xml_element($date_element, "year", $year);

    return;
}

sub add_contributors {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my @all = ($gentag->get_authors(),
               $gentag->get_editors(),
               $gentag->get_translators(),
               $gentag->get_contributors());

    my $prev_type;
    my $prev_description = "";
    my $cur_contrib_group;

    for (my $seq = 0; $seq < @all; $seq++) {
        my $this_contrib = $all[$seq];

        ## There are two things that can trigger the start of a new
        ## contrib-group element:
        ##
        ## 1) The type ("author", "editor", "contrib", etc.)
        ## 2) The description is nonempty.

        my $this_type = $this_contrib->get_type();
        my $this_description = $this_contrib->get_description() || "";

        if (! defined $cur_contrib_group
            || $this_type ne $prev_type
            || (nonempty $this_description && $this_description ne $prev_description)) {
            $cur_contrib_group = append_xml_element($parent, "contrib-group");

            $cur_contrib_group->setAttribute("content-type", "${this_type}s");

            if (nonempty(my $description = $this_contrib->get_description())) {
                append_xml_element($cur_contrib_group,
                                   "author-comment",
                                   $description);
            }

            $prev_type        = $this_type;
            $prev_description = $this_description;
        }

        my $contrib = append_xml_element($cur_contrib_group, "contrib");

        $contrib->setAttribute("contrib-type" => $this_type);

        if (nonempty(my $orcid_id = $this_contrib->get_orcid_id())) {
            my $uri = qq{https://orcid.org/$orcid_id};

            my $contrib_id = append_xml_element($contrib, "contrib-id", $uri);

            $contrib_id->setAttribute("contrib-id-type" => "orcid");
        }

        if (nonempty(my $mrauth_id = $this_contrib->get_mrauth_id())) {
            my $uri = qq{https://mathscinet.ams.org/mathscinet/search/author.html?mrauthid=$mrauth_id};

            my $contrib_id = append_xml_element($contrib, "contrib-id", $uri);

            $contrib_id->setAttribute("contrib-id-type" => "mrauth");
        }

        my $name = $this_contrib->get_name();

        if ($this_contrib->is_deceased()) {
            $contrib->setAttribute(deceased => "yes");
        }

        ## make sure this element has content before adding it

        my $name_style = "western";

        my $surname = $name->get_surname();
        my $given   = $name->get_given();

        if (empty($surname)) {
            if (empty($given)) {
                undef $name_style;
            } else {
                $name_style = "given-only";
            }
        } elsif ($name->is_inverted()) {
            $name_style = "eastern";
        } else {
            $name_style = "western";
        }

        if (defined $name_style) {
            my $name_element = append_xml_element($contrib, "name");

            $name_element->setAttribute("name-style", $name_style);

            if (nonempty($surname)) {
                append_xml_element($name_element, surname => __to_unicode($surname));
            }

            if (nonempty($given)) {
                my $given_name = $given->as_unicode();

                if (nonempty(my $middle = $name->get_middle())) {
                    $given_name .= " " . $middle->as_unicode();
                }

                append_xml_element($name_element, "given-names", $given_name);
            }

            if (nonempty(my $prefix = $name->get_honorific())) {
                append_xml_element($name_element, "prefix", $prefix->as_unicode());
            }

            if (nonempty(my $suffix = $name->get_suffix())) {
                my $suffix_element = append_xml_element($name_element, "suffix");

                if ($suffix->use_comma()) {
                    append_xml_element($suffix_element, "x", ", ");
                }

                $suffix_element->appendText($suffix->as_unicode());
            }
        } elsif (defined(my $unparsed = $name->get_unparsed())) {
            my $string_name = append_xml_element($contrib, "string-name");

            $string_name->appendText($unparsed->as_unicode());
        }

        if (my @affiliations = $this_contrib->get_affiliations()) {
            for (my $i = 0; $i < @affiliations; $i++) {
                my $aff = $affiliations[$i];

                my $id = "aff${seq}_$i";

                append_xml_element($contrib, "xref", undef,
                                   { "ref-type" => "aff",
                                     rid        => $id });

                my $aff_tex = $aff->get_value();

                my $aff_xml = $tex->convert_fragment($aff_tex);

                my $aff_element = append_xml_element($cur_contrib_group,
                                                     "aff",
                                                     $aff_xml,
                                                     { id => $id });

                if ($aff->is_current()) {
                    $aff_element->setAttribute("specific-use", "current");
                }
            }
        }

        if (my @emails = $this_contrib->get_emails()) {
            for my $email (@emails) {
                my $email_element = append_xml_element($contrib, "email",
                                                       $email->get_value());

                if ($email->is_current()) {
                    $email_element->setAttribute("specific-use", "current");
                }
            }
        }

        if (my @urls = $this_contrib->get_urls()) {
            for my $url (@urls) {
                my $url_element = append_xml_element($contrib, "uri",
                                                     $url->get_value());

                # if ($uri->is_current()) {
                #     $uri_element->setAttribute("XXX", "current");
                # }
            }
        }

        if (nonempty (my $role = $this_contrib->get_role())) {
            my $comment = append_xml_element($contrib, "role",
                                             $role->get_value());
        }
    }

    return;
}

sub append_time_stamp( $ ) {
    my $parent = shift;

    my $time_stamp = iso_8601_timestamp();

    my $gen_date = append_xml_element($parent, 'date');

    $gen_date->setAttribute("date-type", 'xml-last-modified');

    $gen_date->setAttribute("iso-8601-date", $time_stamp);

    append_xml_element($gen_date, "string-date", $time_stamp);

    return;
}

sub add_history {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my $history = append_xml_element($parent, "history");

    if (nonempty(my $received = $gentag->get_received())) {
        append_date($tex, $history, $received, "received");
    }

    for my $revised ($gentag->get_reviseds()) {
        append_date($tex, $history, $revised, "rev-recd");
    }

    if (nonempty(my $preprint = $gentag->get_prepostdate())) {
        append_date($tex, $history, $preprint, "preprint", "electronic");
    }

    if (nonempty(my $issue_date = $gentag->get_issuedate())) {
        if (nonempty(my $year = $issue_date->get_year())) {
            if ($year > 0) {
                if (nonempty($issue_date->get_month())) {
                    if (empty($issue_date->get_day())) {
                        $issue_date->set_day(1);
                    }
                }

                append_date($tex, $history, $issue_date, "issue-date");
            }
        }
    }

    append_time_stamp($history);

    return;
}

sub add_permissions {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (nonempty(my $copyright = $gentag->get_copyright())) {
        my $year  = $copyright->get_year();
        my $owner = $copyright->get_owner();

        if (nonempty($year) && nonempty($owner)) {
            my $permissions = append_xml_element($parent, "permissions");

            my $revert = $copyright->get_revert();

            my $statement = qq{Copyright $year $owner};

            if (nonempty($revert)) {
                $statement .= "; reverts to public domain $revert years from publication";
            }

            $statement = $tex->convert_fragment($statement);

            append_xml_element($permissions, "copyright-statement", $statement);

            append_xml_element($permissions, "copyright-year", $year);

            $owner = $tex->convert_fragment($owner);

            append_xml_element($permissions, "copyright-holder", $owner);
        }
    }

    return;
}

sub add_self_uris {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    $gentag->delete_uri();
    $gentag->assign_uri();

    my $uri = $gentag->get_uri();

    $uri =~ s{^http:}{https:};

    append_xml_element($parent, "self-uri", $uri,
                       { "content-type" => "abstract",
                         "xlink:href"   => $uri });

    my $pii = $gentag->get_pii();

    my $pdf_uri = caturl($uri, "$pii.pdf");

    append_xml_element($parent, "self-uri", undef,
                       { "content-type" => "pdf",
                         "xlink:href"   => $pdf_uri });

    return;
}

my %RELATED_ARTICLE_TYPE = (
    'Addendum'         => 'addendum',
    'Comment'          => 'comment',
    'Correction'       => 'correction-forward',
    'Corrigendum'      => 'corrigendum-forward',
    'Erratum'          => 'erratum-forward',
    'Original Article' => 'corrected-article',
);

sub add_related_articles {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    for my $misclink ($gentag->get_related_articles()) {
        my $label = $misclink->get_label();
        my $pii   = $misclink->get_pii();

        if (empty $pii) {
            $tex->print_err("%% WARNING: No PII in $misclink");
            $tex->error();

            return;
        }

        my $type = $RELATED_ARTICLE_TYPE{$label};

        if (empty $type) {
            $tex->print_err("%% WARNING: Can't determine related-article-type for '$label'");
            $tex->error();

            return;
        }

        my $related = append_xml_element($parent, "related-article", undef,
                                         { "related-article-type" => $type });

        append_xml_element($related, 'pub-id', $pii,
                           { "pub-id-type" => "pii" });

        if (defined (my $gentag = $PUBS->journal_gentag_file({ pii => $pii }))) {
            my $doc = $BUILDER->convert_xml_file($gentag);

            my $publication = $doc->get_publication();

            my $abbrev_title = $publication->get_abbrev_title();

            my $text = qq{$abbrev_title};

            if (nonempty(my $volume = $doc->get_volume())) {
                my $year   = $doc->get_issuedate()->get_year();

                $text .= qq{ $volume ($year)};

                if (defined(my $pages = $doc->get_page_range(0))) {
                    $text .= qq{, $pages};
                }

                $text .= q{.};
            } else {
                $text .= qq{ (to appear).};
            }

            my $url = $doc->get_uri();

            append_xml_element($related, 'ext-link', $text,
                               { 'ext-link' => $url });
        } else {
            $tex->print_err("%% FAILED: Can't find gentag for $label $pii");

            $tex->error();
        }
    }

    return;
}

sub add_keywords {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (my @keywords = $gentag->get_keywords()) {
        my $kwd_group = append_xml_element($parent, "kwd-group", "",
                                           { "kwd-group-type" => "author" });

        for my $keyword (@keywords) {
            append_xml_element($kwd_group,
                           "kwd",
                           $tex->convert_fragment($keyword->get_value()));
        }
    }

    return;
}

sub add_funding_info {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (my @thankses = $gentag->get_thankses()) {
        my $funding_group = append_xml_element($parent, "funding-group");

        for my $thanks (@thankses) {
            my $tex_fragment = $thanks->get_value();

            my $xml_fragment = $tex->convert_fragment($tex_fragment);

            unless ($xml_fragment =~ m{[.!?]\z}smx) {
                append_xml_element($xml_fragment, '', '.');
            }

            append_xml_element($funding_group,
                           "funding-statement",
                           $xml_fragment);
        }
    }

    ## append_xml_element($parent, "open-access", "Funding to pay the Open
    ## Access publications charges for this article was provided by
    ## blah blah blah.")

    return;
}

sub append_custom_meta {
    my $tex = shift;

    my $parent = shift;
    my $name   = shift;
    my $value  = shift;

    my $atts   = shift;

    my $meta = append_xml_element($parent, "custom-meta", undef, $atts);

    append_xml_element($meta, "meta-name", $name);
    append_xml_element($meta, "meta-value", $value);

    return;
}

sub add_custom_meta {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (nonempty(my $commby = $gentag->get_commby())) {
        my $custom = append_xml_element($parent, "custom-meta-group");

        append_custom_meta($tex,
                           $custom,
                           "Communicated by",
                           $commby->get_value(),
                           { "specific-use" => "communicated-by" });
    }

    return;
}

sub add_msc_categories {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my %mscs;

    for my $msc ($gentag->get_mscs()) {
        $mscs{ $msc->get_source() } = $msc;
    }

    if (%mscs) {
        my $msc = $mscs{msn} || $mscs{author} || $mscs{unknown};

        my $year = $msc->get_schema();

        my $scheme = eval { PRD::MSC->new({ scheme => $year }) };

        if (! defined $scheme) {
            $tex->print_err("%% Unknown MSC scheme '$year'");

            $tex->error();

            return;
        }

        my $kwd_group = append_xml_element($parent, "kwd-group", "",
                                           { vocab => "MSC $year",
                                             'vocab-identifier' => "https://mathscinet.ams.org/msc/msc${year}.html" });

        for my $key ($msc->get_primaries()) {
            my $class = $scheme->get_class($key);

            if (! defined $class) {
                $tex->print_err("%% Unknown MSC class '$key'");

                $tex->error();

                next;
            }

            my $kwd = append_xml_element($kwd_group, "compound-kwd", "",
                                         { 'content-type' => 'primary' });

            append_xml_element($kwd, 'compound-kwd-part', $class->get_key(),
                               { 'content-type' => 'code' });

            if (nonempty(my $title = $class->get_title())) {
                $title = $tex->convert_fragment($title);

                append_xml_element($kwd, 'compound-kwd-part', $title,
                                   { 'content-type' => 'text' });
            }
        }

        for my $key ($msc->get_secondaries()) {
            my $class = $scheme->get_class($key);

            if (! defined $class) {
                $tex->print_err("%% Unknown MSC class '$key'");

                $tex->error();

                next;
            }

            my $kwd = append_xml_element($kwd_group, "compound-kwd", "",
                                         { 'content-type' => 'secondary' });

            append_xml_element($kwd, 'compound-kwd-part', $class->get_key(),
                               { 'content-type' => 'code' });

            if (nonempty(my $title = $class->get_title())) {
                $title = $tex->convert_fragment($title);

                append_xml_element($kwd, 'compound-kwd-part', $title,
                                   { 'content-type' => 'text' });
            }
        }
    }

    return;
}

######################################################################
##                                                                  ##
##                         JOURNAL METADATA                         ##
##                                                                  ##
######################################################################

sub append_journal_meta {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my $publication = $gentag->get_publication();

    my $publ_key = $publication->get_publ_key();

    my $meta = append_xml_element($parent, "journal-meta");

    append_xml_element($meta, "journal-id", $publ_key,
                   { "journal-id-type" => "publisher" });

    my $title_group = append_xml_element($meta, "journal-title-group");

    append_xml_element($title_group,
                   "journal-title", $publication->get_full_title());

    append_xml_element($title_group,
                   "abbrev-journal-title", $publication->get_abbrev_title());

    for my $issn ($publication->get_issns()) {
        my %atts;

        if (defined(my $type = $issn->get_type())) {
            $atts{"publication-format"} = $type;
        }

        append_xml_element($meta, "issn", $issn->get_value(), \%atts);
    }

    my $publisher = append_xml_element($meta, "publisher");

    ## TODO: HARD-CODED VALUE
    append_xml_element($publisher, "publisher-name", "American Mathematical Society");
    append_xml_element($publisher, "publisher-loc", "Providence, Rhode Island");

    my $uri = qq{https://www.ams.org/$publ_key/};

    append_xml_element($meta, "self-uri", $uri, { "xlink:href", $uri });

    return;
}

sub append_article_ids {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (defined (my $doi = $gentag->get_doi())) {
        append_xml_element($parent, "article-id", $doi, { "pub-id-type" => "doi" });
    }

    if (defined (my $pii = $gentag->get_pii())) {
        append_xml_element($parent, "article-id", $pii, { "pub-id-type" => "pii" });
    }

    if (defined (my $manid = $gentag->get_manid())) {
        $manid =~ s{^0+}{};

        append_xml_element($parent, "article-id", $manid, { "pub-id-type" => "manuscript" });
    }

    for my $mr ($gentag->get_mrs()) {
        append_xml_element($parent, "article-id", $mr, { "pub-id-type" => "mr" });
    }

    return;
}

sub append_article_categories {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my $cat = append_xml_element($parent, "article-categories");

    my $subj_group = append_xml_element($cat, "subj-group");

    $subj_group->setAttribute("subj-group-type", "display-channel");

    append_xml_element($subj_group, "subject", "Research article");

    return;
}

my %MONTH_TO_INT = (January   =>  1,
                    February  =>  2,
                    March     =>  3,
                    April     =>  4,
                    May       =>  5,
                    June      =>  6,
                    July      =>  7,
                    August    =>  8,
                    September =>  9,
                    October   => 10,
                    November  => 11,
                    December  => 12);

sub add_article_citation {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    my $publication = $gentag->get_publication();

    my $record = "\n\\bib{";

    my $mr_num;

    if (my @mrs = $gentag->get_mrs()) {
        $record .= $mr_num = $mrs[0];
    } else {
        $record .= $gentag->get_pii();
    }

    $record .= "}{article}{\n";

    for my $author ($gentag->get_authors()) {
        my $name = $author->get_name();

        $record .= "  author={" . $name->inverted() . "}";

        if ($name->is_inverted()) {
            $record .= "{inverted={yes}}";
        }

        $record .= ",\n"
    }

    $record .= sprintf qq{  title={%s},\n}, $gentag->get_title()->get_tex();

    $record .= sprintf qq{  journal={%s},\n}, $publication->get_abbrev_title();

    if (nonempty(my $volume = $gentag->get_volume())) {
        $volume =~ s{^0+}{};

        $record .= sprintf qq{  volume={%s},\n}, $volume;
    }

    if (nonempty(my $number = $gentag->get_number())) {
        $number =~ s{^0+}{};

        $record .= sprintf qq{  number={%s},\n}, $number;
    }

    if (nonempty(my $issue_date = $gentag->get_issuedate())) {
        my $year  = $issue_date->get_year();
        my $month = $issue_date->get_month();

        if (nonempty($year)) {
            my $date = sprintf "%04d", $year;

            if (nonempty($month)) {
                $date .= sprintf "-%02d", $MONTH_TO_INT{$month};
            }

            $record .= sprintf qq{  date={$date},\n};
        }
    }

    if (my @ranges = $gentag->get_page_ranges()) {
        $record .= sprintf qq{  pages={%s},\n}, $ranges[0];
    }

    my $issn = $publication->get_issn_by_type("print") ||
        $publication->get_issn_by_type("electronic");

    if (nonempty($issn)) {
        $record .= sprintf qq{  issn={%s},\n}, $issn;
    }

    if (nonempty($mr_num)) {
        $record .= sprintf qq{  review={%s},\n}, $mr_num;
    }

    if (nonempty(my $doi = $gentag->get_doi())) {
        $record .= sprintf qq{  doi={%s},\n}, $doi;
    }

    $record .= "}\n";

    append_xml_element($parent, "article-citation", $record, { type => "amsrefs" });

    return;
}

sub append_article_meta {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;
    my $old_front = shift;

    my $meta = append_xml_element($parent, "article-meta");

    append_article_ids($tex, $meta, $gentag);

    append_article_categories($tex, $meta, $gentag);

    my $title_group;

    if (nonempty(my $title = $gentag->get_title())) {
        $title_group = new_xml_element("title-group");

        append_xml_element($title_group,
                           'article-title',
                           $tex->convert_fragment($title->get_tex()));

        append_xml_element($title_group, 'alt-title', $title->as_unicode());
    } else {
        $title_group = find_unique_node($old_front, "article-meta/title-group");
    }

    $meta->appendChild($title_group);

    add_contributors($tex, $meta, $gentag);

    if (nonempty(my $posted = $gentag->get_postdate())) {
        append_date($tex, $meta, $posted, "pub", "electronic", "pub-date");
    }

    if (nonempty(my $volume = $gentag->get_volume())) {
        append_xml_element($meta, volume => $volume);

        if (nonempty(my $number = $gentag->get_number())) {
            append_xml_element($meta, issue => $number);
        }
    }

    if (my @ranges = $gentag->get_page_ranges()) {
        if (nonempty(my $fpage = $ranges[0]->get_start())) {
            append_xml_element($meta, fpage => $fpage);

            if (nonempty(my $lpage = $ranges[0]->get_end())) {
                append_xml_element($meta, lpage => $lpage);
            }

            append_xml_element($meta, 'page-range' => $ranges[0]);
        }
    }

    add_history($tex, $meta, $gentag);

    add_permissions($tex, $meta, $gentag);

    add_self_uris($tex, $meta, $gentag);

    add_related_articles($tex, $meta, $gentag);

    copy_xml_node("article-meta/abstract", $old_front, $meta);

    copy_xml_node("article-meta/kwd-group", $old_front, $meta);

    add_keywords($tex, $meta, $gentag);

    add_msc_categories($tex, $meta, $gentag);

    add_funding_info($tex, $meta, $gentag);

    add_custom_meta($tex, $meta, $gentag);

    add_article_citation($tex, $meta, $gentag);

    return;
}

sub append_article_notes {
    my $tex = shift;

    my $parent = shift;
    my $gentag = shift;

    if (my @dedications = $gentag->get_dedications()) {
        my $notes = append_xml_element($parent,
                                       "notes",
                                       undef,
                                       { "notes-type" => "dedication" });

        for my $dedication (@dedications) {
            my $xml = $tex->convert_fragment($dedication->get_value());

            my $par = append_xml_element($notes, "p", $xml);
        }
    }

    if (my @notes = $gentag->get_notes()) {
        my $notes = append_xml_element($parent,
                                       "notes",
                                       undef,
                                       { "notes-type" => "article" });

        for my $note (@notes) {
            my $xml = $tex->convert_fragment($note->get_value());

            my $par = append_xml_element($notes, "p", $xml);
        }
    }

    return;
}

sub create_new_journal_front( $$ ) {
    my $tex = shift;

    my $gentag    = shift;
    my $old_front = shift;

    my $front = new_xml_element("front");

    append_journal_meta($tex, $front, $gentag);

    append_article_meta($tex, $front, $gentag, $old_front);

    append_article_notes($tex, $front, $gentag);

    return $front;
}

######################################################################
##                                                                  ##
##                          BOOK METADATA                           ##
##                                                                  ##
######################################################################

sub create_collection_meta( $$ ) {
    my $tex    = shift;
    my $gentag = shift;

    my $meta = new_xml_element('collection-meta');

    my $publ_key  = $gentag->get_publ_key();
    my $volume_no = $gentag->get_volume();
    my $volume_id = $gentag->get_volume_id();

    if (nonempty(my $title = $PUBS->title($publ_key))) {
        my $title_group = new_child_element($meta, 'title-group');

        append_xml_element($title_group, 'title', $title);
    }

    if (nonempty($volume_no)) {
        my $volume_group = new_child_element($meta, 'volume-in-collection');

        append_xml_element($volume_group, 'volume-number', $volume_no);
    }

    if (nonempty(my $pissn = $PUBS->pissn($publ_key))) {
        my %atts = ("publication-format" => 'print');

        append_xml_element($meta, "issn", $pissn, \%atts);
    }

    if (nonempty(my $eissn = $PUBS->eissn($publ_key))) {
        my %atts = ("publication-format" => 'electronic');

        append_xml_element($meta, "issn", $eissn, \%atts);
    }

    for my $publisher_name ($gentag->get_publishers()) {
        my $publisher = append_xml_element($meta, "publisher");

        append_xml_element($publisher, "publisher-name", $publisher_name);

        ## TODO: HARD-CODED VALUE
        if ($publisher_name eq "American Mathematical Society") {
            append_xml_element($publisher, "publisher-loc", "Providence, Rhode Island");
        }
    }

    if (nonempty(my $copub = $tex->get_macro_expansion_text('AMS@copublisher'))) {
        my $custom = append_xml_element($meta, "custom-meta-group");

        append_custom_meta($tex, $custom, "subseries", $copub);
    }

    return $meta;
}

sub create_book_meta( $$ ) {
    my $tex    = shift;
    my $gentag = shift;

    my $meta = new_xml_element('book-meta');

    my $publ_key  = $gentag->get_publ_key();
    my $volume_no = $gentag->get_volume();
    my $volume_id = $gentag->get_volume_id();

    append_xml_element($meta, 'book-id', $publ_key,
                       { 'book-id-type' => 'publisher',
                         'assigning-authority' => 'AMS' });

    append_xml_element($meta, 'book-id', $volume_id,
                       { 'book-id-type' => 'volume_id',
                         'assigning-authority' => 'AMS' });

    if (nonempty(my $doi = $gentag->get_doi())) {
        append_xml_element($meta, 'book-id', $doi,
                           { 'book-id-type' => 'doi',
                             'assigning-authority' => 'crossref' });
    }

    my $title_group = new_child_element($meta, 'book-title-group');

    if (nonempty(my $title = $gentag->get_title())) {
        append_xml_element($title_group, 'book-title', $title->as_unicode());
    }

    if (nonempty(my $sub = $gentag->get_subtitle())) {
        append_xml_element($title_group, 'subtitle', $sub->as_unicode());
    }

    add_contributors($tex, $meta, $gentag);

    add_history($tex, $meta, $gentag);

    append_xml_element($meta, 'book-volume-number', $volume_no);

    if (defined(my $publication = $gentag->get_publication())) {
        for my $issn ($publication->get_issns()) {
            my %atts;

            if (defined(my $type = $issn->get_type())) {
                $atts{"publication-format"} = $type;
            }

            append_xml_element($meta, "issn", $issn->get_value(), \%atts);
        }
    }

    for my $isbn ($gentag->get_isbns()) {
        my %atts;

        if (defined(my $type = $isbn->get_type())) {
            $atts{"publication-format"} = $type;
        }

        append_xml_element($meta, "isbn", $isbn->get_value(), \%atts);
    }

    for my $publisher_name ($gentag->get_publishers()) {
        my $publisher = append_xml_element($meta, "publisher");

        append_xml_element($publisher, "publisher-name", $publisher_name);

        ## TODO: HARD-CODED VALUE
        if ($publisher_name eq "American Mathematical Society") {
            append_xml_element($publisher, "publisher-loc", "Providence, Rhode Island");
        }
    }

    add_permissions($tex, $meta, $gentag);

    if (nonempty(my $edition = $gentag->get_edition())) {
        append_xml_element($meta, 'edition', $edition);
    }

    add_msc_categories($tex, $meta, $gentag);

    return $meta;
}

1;

__DATA__

\ProvidesPackage{AMSmetadata}

\def\noAMSmetadata{\let\AddAMSmetadata\@empty}

\AtEndDocument{\AddAMSmetadata}

\endinput

__END__
