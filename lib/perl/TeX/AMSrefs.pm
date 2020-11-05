package TeX::AMSrefs;

use strict;
use warnings;

use version; our $VERSION = qv '2.0.0';

use Class::Std;

use Lingua::EN::Numbers::Ordinate;

use TeX::AMSrefs::BibItem;

use TeX::Utils::DOI;

use TeX::Utils::Misc;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %l2h_mode          :ATTR(:default(0)     init_arg => 'l2h_mode');

my %sort_bibliography  :ATTR(:default(1)     :set<sort_bibliography>);

my %label_style        :ATTR(:default('numeric'))
                       :ATTR(:set<label_style> :get<label_style>);

my %y2k_mode           :ATTR(:default(0)     :set<y2k_mode>);
my %bysame_mode        :ATTR(:default(1)     :set<bysame_mode>);

my %short_journals     :ATTR(:default(0)     :set<short_journals>);
my %short_publishers   :ATTR(:default(0)     :set<short_publishers>);
my %short_months       :ATTR(:default(0)     :set<short_months>);
my %initials           :ATTR(:default(0)     :set<initials>);

my %traditional_quotes :ATTR(:default(1)     :set<traditional_quotes>);

my %sort_citations     :ATTR(:default(1)     :set<sort_citations>);
my %compress_citations :ATTR(:default(1)     :set<compress_citations>);

my %backrefs           :ATTR(:default(0)     :set<backrefs>);
my %style              :ATTR(:default('ams') :set<style> :get<style>);

my %omit_language      :ATTR(:default<0> :set<omit_language>);

my %xref_list          :ATTR;

######################################################################
##                                                                  ##
##                         CLASS VARIABLES                          ##
##                                                                  ##
######################################################################

my %BIB_SPEC;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

use constant ETAL_TEXT => 'et al.';

######################################################################
##                                                                  ##
##                           GLOBAL DATA                            ##
##                                                                  ##
######################################################################

my @FULL_MONTH = qw(NULL January February March
                         April   May      June
                         July    August   September
                         October November December
                         Winter  Spring   Summer     Fall);

my @SHORT_MONTH = qw(NULL Jan. Feb. Mar.
                          Apr. May  June
                          Jul. Aug. Sep.
                          Oct. Nov. Dec.
                          Winter  Spring   Summer     Fall);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $id, $args_ref) = @_;

    for my $citekey ('alii', 'etal', 'et al.') {
        my $abbrev = TeX::AMSrefs::BibItem->new({ type    => 'name',
                                                  citekey => $citekey,
                                                  starred => 1 });

        $abbrev->add_entry(name => ETAL_TEXT);

        $self->remember_bibitem($abbrev);
    }

    return;
}

######################################################################
##                                                                  ##
##                         CUSTOM ACCESSORS                         ##
##                                                                  ##
######################################################################

sub l2h_mode {
    my $self = shift;

    return $l2h_mode{ident $self};
}

sub sort_bibliography {
    my $self = shift;

    return $sort_bibliography{ident $self};
}

sub y2k_mode {
    my $self = shift;

    return $y2k_mode{ident $self};
}

sub bysame_mode {
    my $self = shift;

    return $bysame_mode{ident $self};
}

sub use_short_journals {
    my $self = shift;

    return $short_journals{ident $self};
}

sub use_short_publishers {
    my $self = shift;

    return $short_publishers{ident $self};
}

sub use_short_months {
    my $self = shift;

    return $short_months{ident $self};
}

sub use_initials {
    my $self = shift;

    return $initials{ident $self};
}

sub use_traditional_quotes {
    my $self = shift;

    return $traditional_quotes{ident $self};
}

sub sort_citations {
    my $self = shift;

    return $sort_citations{ident $self};
}

sub compress_citations {
    my $self = shift;

    return $compress_citations{ident $self};
}

sub use_backrefs {
    my $self = shift;

    return $backrefs{ident $self};
}

sub author_year_mode {
    my $self = shift;

    return $self->get_label_style() eq 'author-year';
}

sub get_cite_left {
    my $self = shift;

    return $self->author_year_mode() ? '(' : '[';
}

sub get_cite_right {
    my $self = shift;

    return $self->author_year_mode() ? ')' : ']';
}

sub get_cite_punct {
    my $self = shift;

    return ", ";
}

sub get_cite_AltPunct {
    my $self = shift;

    return "; ";
}

sub get_cite_mid {
    my $self = shift;

    return ", ";
}

######################################################################
##                                                                  ##
##                      MISCELLANEOUS METHODS                       ##
##                                                                  ##
######################################################################

sub remember_bibitem {
    my $self = shift;

    my $bibitem = shift;

    my $citekey = $bibitem->get_citekey();

    return $xref_list{ident $self}->{$citekey} = $bibitem;
}

sub retrieve_xref {
    my $self = shift;

    my $citekey = shift;

    return $xref_list{ident $self}->{$citekey};
}

######################################################################
##                                                                  ##
##                        UTILITY FUNCTIONS                         ##
##                                                                  ##
######################################################################

sub get_field {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $field = $bibitem->get_field($key);

    ## Unpack compound values.

    if (eval { $field->isa("TeX::AMSrefs::BibItem::Entry") }) {
        my $value = $field->get_value();

        if (eval { $value->isa("TeX::AMSrefs::BibItem") }) {
            return $value;
        }
    }

    my $is_array = ref($field) eq 'ARRAY';

    my @entries = $is_array ? @{ $field } : ($field);

    for my $entry (@entries) {
        next unless defined $entry;

        next if $entry->get_attribute("__processed");

        my $value = $entry->get_value();

        $value =~ s{\s*<BR>\s*}{ }ismg;

        $entry->set_value($value);
        $entry->set_attribute("__processed", 1);
    }

    if ($is_array) {
        return wantarray ? @{ $field } : $field;
    } else {
        return $field;
    }
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

    return trim $name;
}

sub format_name_be( $ ) {
    my $self = shift;

    my $raw_name = shift;

    my ($surname, $given, $jr) = split /,\s*/, $raw_name;

    return trim("$surname $given");
}

sub format_name( $ ) {
    my $self = shift;

    my $raw_name = shift;

    if (my $prop = $raw_name->get_attribute('inverted')) {
        if ($prop eq 'yes') {
            return $self->format_name_be($raw_name);
        }
    }

    return $self->format_name_le($raw_name);
}

sub format_name_inverted( $ ) {
    my $self = shift;

    my $raw_name = shift;

    if (my $prop = $raw_name->get_attribute('inverted')) {
        if ($prop eq 'yes') {
            return $self->format_name_be($raw_name);
        }
    }

    return $raw_name;

    # my ($surname, $given, $jr) = split /,\s*/, $raw_name;
    # 
    # return trim("$surname, $given, $jr");
}

sub format_leading_name {
    my $self = shift;

    my $raw_name = shift;

    if ($self->author_year_mode()) {
        return $self->format_name_inverted($raw_name);
    } else {
        return $self->format_name($raw_name);
    }
}

sub print_series($$$$$@) {
    my $self = shift;

    my $pre   = shift;
    my $sep_1 = shift;
    my $sep_2 = shift;
    my $sep_3 = shift;
    my $post  = shift;

    my @items = @_;

    my $list = $pre;

    my $first = shift @items;

    $list .= $first;

    if (@items == 1) {
        $list .= $sep_1;
        $list .= shift @items;
    }

    if (@items) {
        my $final = pop @items;

        $list .= $sep_2;

        $list .= join $sep_2, @items;

        if ($final ne ETAL_TEXT) {
            $list .= $sep_3;
        } else {
            $list .= " ";
        }

        $list .= $final;
    }

    $list .= $post;

    return $list;
}

sub print_standard_series(@) {
    my $self = shift;

    return $self->print_series('', q{ and }, q{, }, q{, and }, '', @_);
}

sub print_names {
    my $self = shift;

    my $pre  = shift;
    my $post = shift;

    my @names = @_;

    return $self->print_series($pre, q{ and }, q{, }, q{, and }, $post, @names);
}

## This is the analogue to \SwapBreak, except without all the penalty
## stuff.  We also don't try to implement the \nopunct hack.

sub append_punct($$) {
    my $text  = shift || '';
    my $punct = shift;

    # Don't append punctuation (a) to an empty string, (b) immediately
    # after whitespace or an open parenthesis, or (c) if the string
    # already ends in the punctuation mark.

    if (nonempty($text) && $text !~ /[\s\(${punct}]\z/) {
        $text .= $punct;
    }

    return $text;
}

## This should be sufficent to avoid conflicts with pre-existing
## bracket pairs.

my $internal_brace_id = 2**30;

sub next_brace_id() {
    if (defined $main::global{max_id}) {
        return ++$main::global{max_id};
    } else {
        return ++$internal_brace_id;
    }
}

sub apply_style {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $style = shift;

    my $text = $self->get_field($bibitem, $key);

    if ($self->l2h_mode) {
        my $id = next_brace_id();

        return sprintf '\\%s<#%d#>%s<#%d#>', $style, $id, $text, $id;
    } else {
        return sprintf '\\%s{%s}', $style, $text;
    }
}

######################################################################
##                                                                  ##
##                            FORMATTING                            ##
##                                                                  ##
######################################################################

sub cite_tag {
    my $self = shift;

    my $type = shift;
    my $cite_info = shift;

    return $cite_info unless ref($cite_info) eq 'ARRAY';

    if ($self->author_year_mode()) {
        my ($authors, $year) = @{ $cite_info };

        my @names;

        while ($authors =~ s/^ \s* <\#(\d+)\#> (.*) <\#\1\#>//smx) {
            push @names, $2;
        }

        if ($type eq 'ycite') {
            return $year;
        }

        my $names = $self->print_names(q{}, q{}, @names);

        if (@names > 2 && $type !~ /^full/) {
            $names = "$names[0] \\etaltext ";
        }

        if ($type =~ /ocite$/ || $type eq 'citeauthory') {
            return "$names \\citeleft $year\\citeright ";
        } elsif ($type eq 'citeauthor') {
            return $names;
        } else {
            return "$names\\citemid $year";
        }
    } else {
        my ($label, undef) = @{ $cite_info };

        return $label;
    }
}

## TODO: This is only part of what amsrefs does.

sub adjust_bibfields( $ ) {
    my $self = shift;

    my $bibitem = shift;

    my $type = $bibitem->get_type();

    if ($type eq 'article') {
        if (! $bibitem->has_volume()) {
            if ($bibitem->has_number()) {
                $bibitem->add_entry(volume => $bibitem->get_number());
                $bibitem->delete_entry('number');
            }
        }
    }

    return;
}

sub format_bib_item {
    my $self = shift;

    my $bibitem = shift;
    my $anchor  = shift;
    my $label   = shift;

    $self->adjust_bibfields($bibitem);

    my $html;

    if (nonempty($label)) {
        my $label = qq{<strong>[$label]</strong>};

        if (nonempty($anchor)) {
            $label = qq{<a name="$anchor">$label</a>};
        }

        $html = qq{<dt>$label</dt>\n<dd>\n};
    }

    my $type = $bibitem->get_type();

    if ($type eq 'article') {
        if (   $bibitem->has_booktitle()
            || $bibitem->has_book()
            || $bibitem->has_conference()) {
            $type = 'incollection';
        }
    }

    my $spec = $BIB_SPEC{$type};

    for my $format (@{ $spec }) {
        my ($key, $punct, $prefix, $formatter) = @{ $format };

        my $field = $self->get_field($bibitem, $key);

        next unless $key eq 'transition' || $field;

        my $formatted_field = $field;

        if (ref($formatter) eq 'ARRAY') {
            my ($method, @args) = @{ $formatter };

            $formatted_field = $self->$method($bibitem, $key, @args);
        } elsif (ref($formatter) eq 'CODE') {
            $formatted_field = $self->$formatter($bibitem, $key);
        } elsif (nonempty $formatter) {
            $formatted_field = $self->$formatter($bibitem, $key);
        }

        if (defined $formatted_field) {
            $html  = append_punct($html, $punct);
            $html .= $prefix;
            $html .= $formatted_field;
        }
    }

    if (nonempty($label)) {
        $html .= "</dd>";
    }

    return $html;
}

sub print_volume {
    my $self = shift;

    my $bibitem = shift;

    my $volume = $bibitem->get_volume();

    if ($bibitem->has_series()) {
        return "vol.&nbsp;$volume";
    } else {
        return "Vol.&nbsp;$volume";
    }
}

sub print_primary {
    my $self = shift;

    my $bibitem = shift;

    if ($bibitem->has_author()) {
        return $self->print_authors($bibitem, 'author');
    } elsif ($bibitem->has_editor()) {
        return $self->print_editors_a($bibitem, 'editor');
    } elsif ($bibitem->has_translator()) {
        return $self->print_translators_a($bibitem, 'translator');
    }
}

sub print_authors {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @authors = $self->get_field($bibitem, $key);

    my @names;

    if (! $bibitem->is_inner()) {
        push @names, $self->format_leading_name(shift @authors);
    }

    push @names, map { $self->format_name($_) } @authors;

    return $self->print_names(q{}, q{}, @names);
}

sub print_editors_a {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @editors = $self->get_field($bibitem, $key);

    my $pl = @editors == 1 ? "" : "s";

    my @names;

    if (! $bibitem->is_inner()) {
        push @names, $self->format_leading_name(shift @editors);
    }

    push @names, map { $self->format_name($_) } @editors;

    return $self->print_names(q{}, qq{ (ed$pl.)}, @names);
}

sub print_editors_b {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return unless $bibitem->has_author();

    my @names = map { $self->format_name($_) } $self->get_field($bibitem, $key);

    my $pl = @names == 1 ? "" : "s";

    return $self->print_names(q{(}, qq{,&nbsp;ed$pl.)}, @names);
}

##  Not currently used anywhere.

##  sub print_editors_c {
##      my $self = shift;
##  
##      my $bibitem = shift;
##      my $key     = shift;
##  
##      my @names = map { $self->format_name($_) } $self->get_field($bibitem, $key);
##  
##      return print_names(q{Edited by }, qq{}, @names);
##  }

sub print_translators_a {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @translators = $self->get_field($bibitem, $key);

    my @names;

    if (! $bibitem->is_inner()) {
        push @names, $self->format_leading_name(shift @translators);
    }

    push @names, map { $self->format_name($_) } @translators;

    return $self->print_names(q{}, q{ (trans.)}, @names);
}

##  Not currently used.

##  sub print_translators_b {
##      my $self = shift;
##  
##      my $bibitem = shift;
##      my $key     = shift;
##  
##      my @names = map { $self->format_name($_) } $self->get_field($bibitem, $key);
##  
##      my $pl = @names == 1 ? "" : "s";
##  
##      return print_names(q{(}, qq{,&nbsp;tran$pl.)}, @names);
##  }

sub print_translators_c {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return unless $bibitem->has_author() || $bibitem->has_editor();

    my @names = map { $self->format_name($_) } $self->get_field($bibitem, $key);

    return $self->print_names(q{translated by }, qq{}, @names);
}

sub print_name_list {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $field = $self->get_field($bibitem, $key);

    my @names = map { $self->format_name($_) } $self->get_field($bibitem, $key);

    return $self->print_names(q{}, qq{}, @names);
}

sub month_name {
    my $self = shift;

    my $mon = shift;

    if ($self->use_short_months()) {
        return $SHORT_MONTH[$mon] || $mon;
    } else {
        return $FULL_MONTH[$mon] || $mon;
    }
}

sub print_date_b {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift || 'date';

    my $raw_date = $self->get_field($bibitem, $key)->get_value();

    if ( $raw_date =~ /\A \d+(-\d+){0,2} \z/ ) {
        my ($year, $month, $day) = split /-+/, $raw_date;

        my @pieces;

        if (nonempty($month)) {
            if ($month =~ /\A \d+ \z/smx) {
                push @pieces, $self->month_name($month);
            } else {
                push @pieces, $month;
            }
        }

        if (nonempty($day)) {
            push @pieces, "$day,";
        }

        if (nonempty($year)) {
            push @pieces, $year;
        }

        my $formatted = join " ", @pieces;

        return $formatted;
    } else {
        return $raw_date;
    }
}

sub print_date {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift || 'date';

    return concat '(', $self->print_date_b($bibitem), ')';
}

sub print_date_posted {
    my $self = shift;

    my $bibitem = shift;

    return ", posted on " . $self->print_date($bibitem);
}

sub print_date_pv {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    if ($bibitem->has_doi()) {
        if ($bibitem->has_volume()) {
            return $self->print_date($bibitem, $key);
        } else {
            return $self->print_date_posted($bibitem, $key);
        }
    } else {
        return $self->print_date($bibitem, $key);
    }
}

sub __doi_url( $ ) {
    my $doi = shift;

    if ($doi !~ m{\A http:}smx) {
        $doi = doi_to_url($doi);
    }

    return $doi;
}

sub print_doi {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $field = $self->get_field($bibitem, $key);

    return __doi_url($field);
}

sub print_edition {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $field = $self->get_field($bibitem, $key)->get_value();

    if ($field =~ /\A \d+ \z/smx) {
        return ordinate($field) . " ed.";
    } else {
        return $field;
    }
}

sub print_thesis_type {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $type = $self->get_field($bibitem, $key)->get_value();

    if ($type =~ /^p/) {
        return "Ph.D. Thesis";
    } elsif ($type =~ /^m/) {
        return "Master's Thesis";
    } else {
        return $type;
    }
}

sub parenthesize( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $text = $self->get_field($bibitem, $key);

    return "($text)";
}

sub format_language( $ ) {
    my $self = shift;

    return if $omit_language{ident $self};

    my $bibitem = shift;
    my $key     = shift;

    my $text = $self->get_field($bibitem, $key);

    return "($text)";
}

sub format_pages( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $text = $self->get_field($bibitem, $key);

    return "pp.~$text";
}

sub format_title( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->apply_style($bibitem, $key, q{textit});
}

sub format_journal_volume( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->apply_style($bibitem, $key, q{textbf});
}

sub format_journal( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->get_field($bibitem, $key);
}

sub issuetext( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->apply_style($bibitem, $key, q{issuetext});
}

sub url( $ ) {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->apply_style($bibitem, $key, q{url});
}

######################################################################
##                                                                  ##
##                         COMPOUND FIELDS                          ##
##                                                                  ##
######################################################################

sub format_inner {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;
    my $type    = shift;

    my $inner = $bibitem->get_inner_item($key)->clone();

    $inner->set_type($type);
    $inner->set_inner(1);

    return $self->format_bib_item($inner);
}

sub print_book {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->format_inner($bibitem, $key, 'innerbook');
}

sub print_conference {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    return $self->format_inner($bibitem, $key, 'conference');
}

sub print_conference_details {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @fields;

    if (nonempty(my $address = $self->get_field($bibitem, 'address'))) {
        push @fields, $address;
    }

    if (nonempty(my $date = $self->get_field($bibitem, 'date'))) {
        push @fields, $date;
    }

    if (@fields) {
        return concat ' (', join(", ", @fields), ') ';
    }

    return;
}

sub format_one_contribution {
    my $self = shift;
    my $contribution = shift;

    if (eval { $contribution->isa('TeX::AMSrefs::BibItem') }) {
        $contribution->set_type('contribution');

        return $self->format_bib_item($contribution);
    } else {
        return $contribution;
    }
}

sub print_contributions {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @contributions = $self->get_field($bibitem, $key);

    my @items = map { $_->get_value() } @contributions;

    my @formatted = map { $self->format_one_contribution($_) } @items;

    return concat(" with ", $self->print_standard_series(@formatted));
}

sub print_partials {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @partials = $self->get_field($bibitem, $key);

    my @items;

    for my $partial (@partials) {
        my $value = $partial->get_value();

        if (eval { $value->isa("TeX::AMSrefs::BibItem") }) {
            push @items, $value;
        } else {
            my $xref = $self->retrieve_xref($value);

            if (defined $xref) {
                my $clone = $xref->clone();
                $clone->set_inner(1);

                push @items, $clone;
            } else {
                warn "Xref '$value' undefined\n";
            }
        }
    }

    return unless @items;

    my @formatted = map { $self->format_bib_item($_) } @items;

    return concat(" with ", $self->print_standard_series(@formatted));
}

sub print_reprint {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $reprint = $bibitem->get_inner_item($key)->clone();

    $reprint->set_type('book');
    $reprint->set_inner(1);

    my $copula = $reprint->get_copula() || "reprinted in";

    return concat $copula, " ", $self->format_bib_item($reprint);
}

sub print_reviews {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my @reviews = $self->get_field($bibitem, $key);

    return $self->print_series(q{}, q{, }, q{, }, q{, }, q{}, @reviews);
}

sub print_translation {
    my $self = shift;

    my $bibitem = shift;
    my $key     = shift;

    my $translation = $bibitem->get_inner_item($key);

    if (defined $translation) {
        my $language = $translation->get_language() || 'English';

        my $html = "$language transl.";

        if (my $pages = $translation->get_pages()) {
            $html .= ", ";
        } else {
            $html .= " in ";
        }

        my $item = $translation->clone();

        $item->delete_entry('language');
        $item->set_inner(1);

        $html .= $self->format_bib_item($item);

        return $html;
    }

    return;
}

######################################################################
##                                                                  ##
##                      FORMAT SPECIFICATIONS                       ##
##                                                                  ##
######################################################################

sub define_bibspec( $$ ) {
    my $self = shift;

    my $bib_type = shift;
    my $bib_spec = shift;

    $BIB_SPEC{$bib_type} = $bib_spec;

    return;
}

$BIB_SPEC{article} = [
    [ author           => q{},  q{},           \&print_authors ],
    [ title            => q{,}, q{ },          q{format_title} ],
    [ part             => q{.}, q{ },          q{} ],
    [ subtitle         => q{:}, q{ },          [ apply_style => 'textit' ] ],
    [ contribution     => q{,}, q{ },          \&print_contributions ],
    [ partial          => q{.}, q{ },          \&print_partials ],
    [ journal          => q{,}, q{ },          q{format_journal} ],
    [ volume           => q{},  q{ },          q{format_journal_volume} ],
    [ date             => q{},  q{ },          \&print_date_pv ],
    [ number           => q{,}, q{ },          q{issuetext} ],
    [ pages            => q{,}, q{ },          [ apply_style => 'eprintpages' ] ],
    [ status           => q{,}, q{ },          q{} ],
    [ eprint           => q{,}, q{ available at },  \&url ],
    [ language         => q{},  q{ },          q{format_language} ],
    [ translation      => q{;}, q{ },          \&print_translation ],
    [ reprint          => q{;}, q{ },          \&print_reprint ],
    [ note             => q{.}, q{ },          q{} ],
    [ transition       => q{.}, q{},           q{} ],
    [ review           => q{},  q{ },          q{print_reviews} ],
    [ doi              => q{,}, q{ },          q{print_doi} ],
];

$BIB_SPEC{book} = [
    [ transition       => q{}  , q{}  ,        \&print_primary ],
    [ title            => q{,} , q{ } ,        q{format_title} ],
    [ part             => q{.} , q{ } ,        q{} ],
    [ subtitle         => q{:} , q{ } ,        [ apply_style => 'textit' ] ],
    [ edition          => q{,} , q{ } ,        \&print_edition ],
    [ editor           => q{}  , q{ } ,        \&print_editors_b ],
    [ translator       => q{,} , q{ } ,        \&print_translators_c ],
    [ contribution     => q{,} , q{ } ,        \&print_contributions ],
    [ series           => q{,} , q{ } ,        q{} ],
    [ volume           => q{,} , q{ } ,        \&print_volume ],
    [ publisher        => q{,} , q{ } ,        q{} ],
    [ organization     => q{,} , q{ } ,        q{} ],
    [ address          => q{,} , q{ } ,        q{} ],
    [ date             => q{,} , q{ } ,        \&print_date_b ],
    [ status           => q{,} , q{ } ,        q{} ],
    [ language         => q{}  , q{ } ,        q{format_language} ],
    [ translation      => q{}  , q{ } ,        \&print_translation ],
    [ reprint          => q{;} , q{ } ,        \&print_reprint ],
    [ note             => q{.} , q{ } ,        q{} ],
    [ transition       => q{.} , q{}  ,        q{} ],
    [ review           => q{}  , q{ } ,        q{print_reviews} ],
];

$BIB_SPEC{partial} = [
    [ part            => q{}  ,  q{}  ,        q{} ],
    [ subtitle        => q{:} ,  q{ } ,        [ apply_style => 'textit' ] ],
    [ contribution    => q{,} ,  q{ } ,        \&print_contributions ],
    [ journal         => q{,} ,  q{ } ,        q{format_journal} ],
    [ volume          => q{}  ,  q{ } ,        q{format_journal_volume} ],
    [ date            => q{}  ,  q{ } ,        \&print_date_pv ],
    [ number          => q{,} ,  q{ } ,        q{issuetext} ],
    [ pages           => q{,} ,  q{ } ,        [ apply_style => 'eprintpages' ] ],
];

$BIB_SPEC{contribution} = [
    [ type            => q{} ,  q{}     ,      q{} ],
    [ author          => q{} ,  q{ by } ,      \&print_name_list ],
];

$BIB_SPEC{"collection.article"} = [
    [ transition      => q{}   , q{}    ,      \&print_primary ],
    [ title           => q{,}  ,  q{ }  ,      q{format_title} ],
    [ part            => q{.}  ,  q{ }  ,      q{} ],
    [ subtitle        => q{:}  ,  q{ }  ,      [ apply_style => 'textit' ] ],
    [ contribution    => q{,}  ,  q{ }  ,      \&print_contributions ],
    [ conference      => q{,}  ,  q{ }  ,      \&print_conference ],
    [ book            => q{,}  ,  q{ }  ,      \&print_book ],
    [ booktitle       => q{,}  ,  q{ }  ,      q{} ],
    [ date            => q{,}  ,  q{ }  ,      \&print_date_b ],
    [ pages           => q{,}  ,  q{ }  ,      q{format_pages} ],
    [ status          => q{,}  ,  q{ }  ,      q{} ],
    [ eprint          => q{,}  ,  q{ available at },  \&url ],
    [ language        => q{}   ,  q{ }  ,      q{format_language} ],
    [ translation     => q{}   ,  q{ }  ,      \&print_translation ],
    [ reprint         => q{;}  ,  q{ }  ,      \&print_reprint ],
    [ note            => q{.}  ,  q{ }  ,      q{} ],
    [ transition      => q{.}  ,  q{}   ,      q{} ],
    [ review          => q{}   ,  q{ }  ,      q{print_reviews} ],
    [ doi             => q{,}  ,  q{ }  ,      q{print_doi} ],
];

$BIB_SPEC{conference} = [
    [ title           => q{}   ,  q{}   ,      q{} ],
    [ transition      => q{}   ,  q{}   ,      \&print_conference_details ],
];

$BIB_SPEC{innerbook} = [
    [ title           => q{,}  ,  q{ }  ,      q{} ],
    [ part            => q{.}  ,  q{ }  ,      q{} ],
    [ subtitle        => q{:}  ,  q{ }  ,      q{} ],
    [ edition         => q{,}  ,  q{ }  ,      \&print_edition ],
    [ editor          => q{ }  ,  q{ }  ,      \&print_editors_b ],
    [ translator      => q{,}  ,  q{ }  ,      \&print_translators_c ],
    [ contribution    => q{,}  ,  q{ }  ,      \&print_contributions ],
    [ series          => q{,}  ,  q{ }  ,      q{} ],
    [ volume          => q{,}  ,  q{ }  ,      \&print_volume ],
    [ publisher       => q{,}  ,  q{ }  ,      q{} ],
    [ organization    => q{,}  ,  q{ }  ,      q{} ],
    [ address         => q{,}  ,  q{ }  ,      q{} ],
    [ date            => q{,}  ,  q{ }  ,      \&print_date_b ],
    [ note            => q{.}  ,  q{ }  ,      q{} ],
];

$BIB_SPEC{report} = [
    [ transition      => q{}   , q{}    ,      \&print_primary ],
    [ title           => q{,}  , q{ }   ,      q{format_title} ],
    [ part            => q{.}  , q{ }   ,      q{} ],
    [ subtitle        => q{:}  , q{ }   ,      [ apply_style => 'textit' ] ],
    [ edition         => q{,}  , q{ }   ,      \&print_edition ],
    [ contribution    => q{,}  , q{ }   ,      \&print_contributions ],
    [ number          => q{,}  , q{ Technical Report } ,      q{} ],
    [ series          => q{,}  , q{ }   ,      q{} ],
    [ organization    => q{,}  , q{ }   ,      q{} ],
    [ address         => q{,}  , q{ }   ,      q{} ],
    [ date            => q{,}  , q{ }   ,      \&print_date_b ],
    [ eprint          => q{,}  , q{ }   ,      \&url ],
    [ status          => q{,}  , q{ }   ,      q{} ],
    [ language        => q{}   , q{ }   ,      q{format_language} ],
    [ translation     => q{}   , q{ }   ,      \&print_translation ],
    [ reprint         => q{;}  , q{ }   ,      \&print_reprint ],
    [ note            => q{.}  , q{ }   ,      q{} ],
    [ transition      => q{.}  , q{}    ,      q{} ],
    [ review          => q{}   , q{ }   ,      q{print_reviews} ],
];

$BIB_SPEC{thesis} = [
    [ author          => q{}   ,  q{}   ,      \&print_authors ],
    [ title           => q{,}  ,  q{ }  ,      q{format_title} ],
    [ subtitle        => q{:}  ,  q{ }  ,      [ apply_style => 'textit' ] ],
    [ type            => q{,}  ,  q{ }  ,      \&print_thesis_type ],
    [ organization    => q{,}  ,  q{ }  ,      q{} ],
    [ address         => q{,}  ,  q{ }  ,      q{} ],
    [ date            => q{,}  ,  q{ }  ,      \&print_date_b ],
    [ eprint          => q{,}  ,  q{ }  ,      \&url ],
    [ status          => q{,}  ,  q{ }  ,      q{} ],
    [ language        => q{}   ,  q{ }  ,      q{format_language} ],
    [ translation     => q{}   ,  q{ }  ,      \&print_translation ],
    [ reprint         => q{;}  ,  q{ }  ,      \&print_reprint ],
    [ note            => q{.}  ,  q{ }  ,      q{} ],
    [ transition      => q{.}  ,  q{}   ,      q{} ],
    [ review          => q{}   ,  q{ }  ,      q{print_reviews} ],
];

$BIB_SPEC{name} = [
    [ name            => q{}   ,  q{}   ,      \&print_authors ],
];

$BIB_SPEC{publisher} = [
    [ publisher       => q{,}  ,  q{ }  ,      q{} ],
    [ address         => q{,}  ,  q{ }  ,      q{} ],
];

$BIB_SPEC{periodical}            = $BIB_SPEC{book};
$BIB_SPEC{collection}            = $BIB_SPEC{book};
$BIB_SPEC{proceedings}           = $BIB_SPEC{book};
$BIB_SPEC{manual}                = $BIB_SPEC{book};
$BIB_SPEC{miscellaneous}         = $BIB_SPEC{book};
$BIB_SPEC{misc}                  = $BIB_SPEC{miscellaneous};
$BIB_SPEC{unpublished}           = $BIB_SPEC{book};
$BIB_SPEC{incollection}          = $BIB_SPEC{"collection.article"};
$BIB_SPEC{inproceedings}         = $BIB_SPEC{"collection.article"};
$BIB_SPEC{"proceedings.article"} = $BIB_SPEC{"collection.article"};
$BIB_SPEC{techreport}            = $BIB_SPEC{report};

1;

__END__
