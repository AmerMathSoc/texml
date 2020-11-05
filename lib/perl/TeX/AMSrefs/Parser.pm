package TeX::AMSrefs::Parser;

use strict;
use warnings;

use version; our $VERSION = qv '1.3.3';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(add_amsrefs_handlers parse_amsrefs_bib) ]);

our @EXPORT_OK = @{ $EXPORT_TAGS{all} };

our @EXPORT =  @{ $EXPORT_TAGS{all} };

use TeX::Utils::Misc;

use TeX::Token qw(:factories);
use TeX::WEB2C qw(:catcodes);

use TeX::Parser::LaTeX;

my %COMPOUND_FIELD = (book => 1,
                      conference => 1,
                      contribution => 1,
                      partial => 1,
                      reprint => 1,
                      translation => 1,
    );

######################################################################
##                                                                  ##
##                         PACKAGE CONSTANT                         ##
##                                                                  ##
######################################################################

# my $PARSE_ENTRIES = make_csname_token('\000PARSE_ENTRIES\000');

my $PAR   = make_csname_token("par");
my $COMMA = make_character_token(",", CATCODE_OTHER);
my $EQUAL = make_character_token("=", CATCODE_OTHER);

######################################################################
##                                                                  ##
##                        INTERNAL UTILITIES                        ##
##                                                                  ##
######################################################################

sub cant( $ ) {
    die "Can't find $_[0]\n";
}

sub __skip_comma( $ ) {
    my $parser = shift;

    $parser->skip_optional_spaces();

    my $next = $parser->peek_next_token();

    return unless defined $next;

    my $found;

    if ($next == $COMMA) {
        $parser->consume_next_token();

        $found = 1;
    }

    $parser->skip_optional_spaces();

    return $found;
}

sub __skip_equal( $ ) {
    my $parser = shift;

    $parser->skip_optional_spaces();

    my $next = $parser->peek_next_token();

    return unless defined $next;

    my $found;

    if ($next == $EQUAL) {
        $parser->consume_next_token();

        $found = 1;
    }

    $parser->skip_optional_spaces();

    return $found;
}

sub __parse_key( $ ) {
    my $parser = shift;

    my $key;

    while (my $next = $parser->get_next_token()) {
        next if $next eq $PAR;

        if ($next == CATCODE_CSNAME) {
            fatal_error("Encountered '$next' in the middle of a key!\n");
        }

        my $char = $next->get_char();

        if ($char =~ m{[=,\s]}) {
            $parser->unget_tokens($next);

            last;
        }

        $key .= $char;
    }

    $parser->skip_optional_spaces();
    
    # avoid uninitialized value warning
    return (defined($key)) ? lc $key : $key;
}

sub __parse_attributes( $ ) {
    my TeX::Parser::LaTeX $parser = shift;

    my %atts;

    $parser->skip_optional_spaces();

    if ($parser->is_starred()) {
        $parser->skip_optional_spaces();

        my $attributes = $parser->read_undelimited_parameter();
        cant('attributes') unless defined $attributes;

        $parser->push_input();

        $parser->bind_to_token_list($attributes);

        while (my $att_key = __parse_key($parser)) {
            __skip_equal($parser) or do {
                my $next = $parser->peek_next_token();

                fatal_error("Encountered '$next' while looking for '='\n");
            };

            my $att_value = $parser->get_undelimtied_parameter();
            cant('attribute value') unless defined $att_value;

            $atts{$att_key} = $att_value;

            __skip_comma($parser);
        }

        # if (nonempty($att_parser->get_buffer())) {
        #     error "Unparseable entries for attributes: [$attributes]\n";
        # }

        $parser->pop_input();
    }

    return %atts;
}

sub __parse_key_pairs($$$$);

sub __parse_key_pairs($$$$) {
    my $parser  = shift;
    my $bibitem = shift;
    my $entries = shift;
    my $amsrefs = shift;

    $parser->push_input();

    $parser->bind_to_token_list($entries);

    $parser->skip_optional_spaces();

    while (my $key = __parse_key($parser)) {
        __skip_equal($parser) or do {
            my $next = $parser->peek_next_token();

            my $error;

            if (defined $next) {
                $error = "Encountered '$next'";
            } else {
                $error = "End of input";
            }
            
            fatal_error("$error while looking for '=' after '$key'\n");
        };

        my $value = $parser->read_undelimited_parameter();
        cant('value') unless defined $value;

        if (nonempty($value)) {
            my %atts = __parse_attributes($parser);

            if ($COMPOUND_FIELD{$key} && $value =~ /\A \s* (\w+) \s* =/smx) {
                my $citekey = $bibitem->get_citekey(); # ???
                my $bibtype = $bibitem->get_type();

                my $subitem = TeX::AMSrefs::BibItem->new({ type    => $bibtype,
                                                           citekey => $citekey,
                                                           inner   => 1 });

                $subitem->set_container($amsrefs);

                __parse_key_pairs($parser, $subitem, $value, $amsrefs);

                $bibitem->add_entry($key, $subitem, \%atts);
            } else {
                $bibitem->add_entry($key, $value, \%atts);
            }
        }
        
        __skip_comma($parser);
    }

    # if (nonempty(my $buffer = $parser->get_buffer())) {
    #     error "LEFTOVERS: [$buffer]\n";
    # }

    $bibitem->resolve_xrefs();

    $parser->pop_input();

    return;
}

######################################################################
##                                                                  ##
##                      SEMI-PUBLIC INTERFACE                       ##
##                                                                  ##
######################################################################

sub make_journal_def_handler( $ ) {
    my $amsrefs = shift;

    return sub {
        my $parser = shift;
        my $token = shift;

        my $key   = $parser->read_undelimited_parameter();
        my $isbn  = $parser->read_undelimited_parameter();
        my $short = $parser->read_undelimited_parameter();
        my $full  = $parser->read_undelimited_parameter();

        my $bibitem = TeX::AMSrefs::BibItem->new({ type    => 'publisher',
                                                   citekey => $key,
                                                   starred => 1 });

        $bibitem->add_entry('isbn', $isbn);

        if (defined $amsrefs && $amsrefs->use_short_journals()) {
            $bibitem->add_entry('journal', $short);
        } else {
            $bibitem->add_entry('journal', $full);
        }

        if (defined $amsrefs) {
            $amsrefs->remember_bibitem($bibitem);
        }

        return;
    };
}

sub make_name_def_handler( $ ) {
    my $amsrefs = shift;

    return sub {
        my $parser = shift;
        my $token = shift;

        my $key  = $parser->read_undelimited_parameter();
        my $name = $parser->read_undelimited_parameter();

        my $bibitem = TeX::AMSrefs::BibItem->new({ type    => 'name',
                                                   citekey => $key,
                                                   starred => 1 });

        $bibitem->add_entry('name', $name);

        if (defined $amsrefs) {
            $amsrefs->remember_bibitem($bibitem);
        }

        return;
    };
}

sub make_pub_def_handler( $ ) {
    my $amsrefs = shift;

    return sub {
        my $parser = shift;
        my $token = shift;

        my $key        = $parser->read_undelimited_parameter();
        my $short_name = $parser->read_undelimited_parameter();
        my $full_name  = $parser->read_undelimited_parameter();
        my $address    = $parser->read_undelimited_parameter();

        my $bibitem = TeX::AMSrefs::BibItem->new({ type    => 'publisher',
                                                   citekey => $key,
                                                   starred => 1 });

        $bibitem->add_entry('address', $address);

        if (defined $amsrefs && $amsrefs->use_short_publishers()) {
            $bibitem->add_entry('publisher', $short_name);
        } else {
            $bibitem->add_entry('publisher', $full_name);
        }

        if (defined $amsrefs) {
            $amsrefs->remember_bibitem($bibitem);
        }

        return;
    };
}

######################################################################
##                                                                  ##
##                         PUBLIC INTERFACE                         ##
##                                                                  ##
######################################################################

sub parse_amsrefs_bib($$;$) {
    my $parser = shift;
    my $token = shift;

    my $amsrefs = shift;

    my $starred = $parser->is_starred();

    my $citekey = $parser->read_undelimited_parameter();
    my $type    = $parser->read_undelimited_parameter();
    my $entries = $parser->read_undelimited_parameter();

    my $bibitem = TeX::AMSrefs::BibItem->new({ type    => $type,
                                               citekey => $citekey,
                                               starred => $starred });

    $bibitem->set_container($amsrefs);

    __parse_key_pairs($parser, $bibitem, $entries, $amsrefs);

    if ($starred && defined $amsrefs) {
        $amsrefs->remember_bibitem($bibitem);
    }

    if (wantarray) {
        my $raw_tex = $token;

        if ($starred) {
            $raw_tex .= '*';
        }

        $raw_tex .= "{$citekey}{$type}{$entries}";

        return ($bibitem, $raw_tex);
    } 

    return $bibitem;
}

sub add_amsrefs_handlers($;$) {
    my $parser  = shift;
    my $amsrefs = shift;

    $parser->set_handler(bib =>
                         sub {
                             my $parser = shift;
                             my $token = shift;

                             parse_amsrefs_bib($parser, $token, $amsrefs);

                             return;
                         });

    $parser->set_handler(DefineJournal   => make_journal_def_handler($amsrefs));
    $parser->set_handler(DefineName      => make_name_def_handler($amsrefs));
    $parser->set_handler(DefinePublisher => make_pub_def_handler($amsrefs));

    return;
}

1;

__END__
