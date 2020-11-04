package TeX::AMSrefs::BibItem;

use strict;
use warnings;

use Carp;

use PTG::Class;

use TeX::AMSrefs::BibItem::Entry;

use PTG::Errors;
use PTG::Utils;

use Text::Wrap;

my %ADDITIVE_FIELD = array_to_hash qw(author editor translator
                                      contribution isbn issn review
                                      partial);

my %SIMPLE_FIELD = array_to_hash qw(address book booktitle conference
                                    copula date doi edition eprint
                                    fulljournal hyphenation institution
                                    journal label language name note
                                    number organization pages part place
                                    publisher reprint school series
                                    setup status subtitle title
                                    translation type url volume xref
                                    transition
                                    msc);

my @CANONICAL_ORDER = qw(label copula author editor translator
                         contribution title subtitle part edition
                         series journal volume number pages publisher
                         address place institution organization
                         booktitle school date doi eprint conference
                         book reprint partial translation language
                         note status type url isbn issn review setup
                         hyphenation);

my %FIELD_EQUIVALENT = (year  => 'date',
                        place => 'address',
    );

my %XREF_FIELD_TRANSLATION = (title => 'booktitle');

## This is awkward and confusing.  See add_entry().

my %XREF_FIELD = ( author     => [ 'name' ],
                   editor     => [ 'name' ],
                   translator => [ 'name' ],
                   journal    => [ 'journal' ],
                   publisher  => [ 'publisher', 'address'],
    );

my %COMPOUND_FIELD = array_to_hash qw(book conference contribution
                                      partial reprint translation);

## \DefineSimpleKey{prop}{inverted}
## \DefineSimpleKey{prop}{language}

my %type_of    :ATTR(init_arg => 'type'    :set<type> :get<type>);
my %citekey_of :ATTR(init_arg => 'citekey' :set<citekey> :get<citekey>);
my %starred_of :ATTR(:set<starred>);
my %inner_of   :ATTR();

my %entries_of :ATTR();

my %container_of :ATTR(:set<container> :get<container>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $entries_of{$ident} = {
        transition => TeX::AMSrefs::BibItem::Entry->new({ key   => 'transition',
                                                          value => '' }),
    };

    $inner_of{$ident}   = $arg_ref->{inner};
    $starred_of{$ident} = $arg_ref->{starred};

    return;
}

no warnings qw(redefine);

sub clone {
    my $self = shift;

    my $class = ref($self);

    my $clone = $class->new( { type    => $self->get_type(),
                               citekey => $self->get_citekey() });

    $clone->set_container($self->get_container);

    $entries_of{ident $clone} = { %{ $entries_of{ident $self} } };

    return $clone;
}

sub is_inner() {
    my $self = shift;

    return $inner_of{ident $self};
}

sub is_starred() {
    my $self = shift;

    return $starred_of{ident $self};
}

sub set_inner() {
    my $self = shift;

    my $innerness = shift;

    $inner_of{ident $self} = $innerness;
}

sub get_entries {
    my $self = shift;

    my $entries = $entries_of{ident $self};

    return wantarray ? %{ $entries } : $entries;
}

sub find_xref {
    my $self = shift;

    my $xref_key = $entries_of{ident $self}->{xref};

    return unless defined $xref_key;

    my $container = $self->get_container();

    return unless defined $container;

    return $container->retrieve_xref($xref_key);
}

sub retrieve_xreffed_bibitem {
    my $self = shift;

    my $xref_key = shift;

    if (eval { $xref_key->isa("TeX::AMSrefs::BibItem") }) {
        return $xref_key;
    } else {
        my $container = $self->get_container();

        if (! defined $container) {
            error("No AMSrefs container to resolve xref '$xref_key' ",
                  "in ", $self->get_citekey(), "\n");

            return $xref_key;
        }

        my $xref = $container->retrieve_xref($xref_key);

        if (defined $xref) {
            return $xref;
        } else {
            error "Xref '$xref_key' undefined\n";
        }
    }
}

sub get_field {
    my $self = shift;

    my $field = shift;

    my $ident = ident $self;

    my $value = $entries_of{$ident}{$field};

    return unless defined $value;

    if (ref($value) eq 'ARRAY') {
        return wantarray ? @{ $value } : $value;
    } else {
        return $value;
    }
}

sub has_field {
    my $self = shift;

    my $field = shift;

    return defined $entries_of{ident $self}{$field};
}

sub resolve_xrefs {
    my $self = shift;

    my $xref_key = $self->get_xref();

    return unless nonempty $xref_key;

    if (! defined $self->get_container()) {
        error("No AMSrefs container to resolve xref '$xref_key' ",
              "in ", $self->get_citekey(), "\n");
    }

    if (my $xref = $self->find_xref()) {
        my %xref_entries = $xref->get_entries();

        my $entries = $self->get_entries();

        while (my ($key, $entry) = each %xref_entries) {
            if ($SIMPLE_FIELD{$key}) {
                my $new_key = $XREF_FIELD_TRANSLATION{$key} || $key;

                if (! defined $self->get_field($new_key)) {
                    $entries->{$new_key} = $entry;
                }
            } elsif ($ADDITIVE_FIELD{$key}) {
                for my $value (@{ $entry }) {
                    push @{ $entries->{$key} }, $value;
                }
            } else {
                error "Unknown key in xref: '$key'\n";
            }
        }
    }

    return;
}

sub get_inner_item {
    my $self = shift;
    my $key  = shift;

    return unless $self->has_field($key);

    my $field = $self->get_field($key)->get_value();

    if (eval { $field->isa('TeX::AMSrefs::BibItem') }) {
        return $field;
    } else {
        my $container = $self->get_container();

        if (defined $container) {
            my $inner_item = $container->retrieve_xref($field);

            if (defined $inner_item) {
                return $inner_item;
            } else {
                error "Xref '$field' undefined\n";
                return;
            }
        } else {
            error("No AMSrefs container to resolve xref '$field'",
                  " in ", $self->get_citekey(), "\n");
        }
    }
}

sub add_entry {
    my $self = shift;

    my $key = shift;
    my $value = shift;

    my $atts = shift;

    my $entries = $self->get_entries();

    my $new_key = $FIELD_EQUIVALENT{$key} || $key;

    if (my $xref_fields = $XREF_FIELD{$new_key}) {

        ## The value might already be a reference, either a
        ## TeX::AMSrefs::BibItem, meaning it's a compound field, or a
        ## TeX::AMSrefs::BibItem::Entry, meaning we're inheriting it
        ## from another entry via the recursive call below.  In either
        ## case, we just copy the field.  Otherwise, we check to see
        ## if it's a lowercase string.

        if (! ref($value) && $value eq lc($value)) {
            my $container = $self->get_container();

            if (defined $container) {
                my $xref = $container->retrieve_xref($value);

                if (defined $xref) {
                    my @xref_fields = @{ $xref_fields };

                    ## This is awkward and confusing.

                    if (@xref_fields == 1) {
                        my $field = $xref_fields[0];

                        if (my $entry = $xref->get_field($field)) {
                            $self->add_entry($new_key, $entry, $atts);
                        }
                    } else {
                        for my $field (@xref_fields) {
                            if (my $entry = $xref->get_field($field)) {
                                $self->add_entry($field, $entry, $atts);
                            }
                        }
                    }

                    return;
                } else {
                    my $cite_key = $self->get_citekey();

                    error "Abbreviation '$value' undefined in $new_key in $cite_key\n";
                }
            } else {
                error("No AMSrefs container to resolve abbreviation '$value'",
                      " in ", $self->get_citekey(), "\n");
            }
        }
    }

    my $entry;

    ## If the value isn't already a BibItem::Entry, wrap it in one.

    if (! eval { $value->isa('TeX::AMSrefs::BibItem::Entry') }) {
        $entry = TeX::AMSrefs::BibItem::Entry->new({ key   => $new_key,
                                                     value => $value });
    } else {
        $entry = $value;
    }

    if (defined $atts) {
        while (my ($att, $att_value) = each %{ $atts }) {
            $entry->set_attribute($att, $att_value);
        }
    }

    if ($SIMPLE_FIELD{$new_key}) {
        $entries->{$new_key} = $entry;
    } elsif ($ADDITIVE_FIELD{$new_key}) {
        push @{ $entries->{$new_key} }, $entry;
    } else {
        error "Unknown key: '$key'\n";
    }

    return $entry;
}

sub delete_entry {
    my $self = shift;

    my $key = shift;

    delete $entries_of{ident $self}->{$key};

    return;
}

sub __canonicalize_fields {
    my $self = shift;
    my $level = shift;

    my $indent1 = "    " x ($level + 1);
    my $indent2 = "    " x ($level + 2);

    my @output;

    my $container = $self->get_container();

    for my $key (@CANONICAL_ORDER) {
        my $field = $self->get_field($key);
        
        next unless defined $field;

        my @fields = $SIMPLE_FIELD{$key} ? ($field) : @{ $field };

        for my $entry (@fields) {
            my $value = $entry->get_value();
            my %atts  = $entry->get_all_attributes();

            if ($COMPOUND_FIELD{$key}) {
                if (! eval { $value->isa(__PACKAGE__) }) {
                    $value = $self->retrieve_xreffed_bibitem($value);
                }
            }

            if (eval { $value->isa(__PACKAGE__) }) {
                push @output, "$indent1$key={";

                push @output, $value->__canonicalize_fields(1);

                push @output, "$indent1},";
            } else {
                my $output = "$key={$value}";

                if (%atts) {
                    my @atts;

                    while (my ($att, $attval) = each %atts) {
                        push @atts, "$att={$attval}";
                    }

                    $output .= "*{" . join(",", @atts) . "}";
                }

                push @output, wrap($indent1, $indent2, $output . ",");
            }
        }
    }

    return @output;
}

sub get_canonical_tex_source {
    my $self = shift;

    my $citekey = $self->get_citekey();
    my $type    = $self->get_type();

    my @source_lines = ("\\bib{$citekey}{$type}{");

    push @source_lines, $self->__canonicalize_fields(0);

    push @source_lines, "}";

    return join "\n", @source_lines;
}

sub AUTOMETHOD {
    my ($self, $obj_ID, @other_args) = @_;

    my $method_name = $_;

    if ( $method_name =~ m/\A (get|has)_(.*) /x ) {
        my $method_type = $1;
        my $field_name  = $2;

        if (! ( $ADDITIVE_FIELD{$field_name} || $SIMPLE_FIELD{$field_name} )) {
            if ($field_name =~ /(.*)s$/ && $ADDITIVE_FIELD{$1}) {
                $field_name = $1;
            } else {
                return sub {
                    carp "Unknown field: $field_name";
                }
            }
        }

        if ( $method_type eq 'get' ) {
            return sub {
                return $self->get_field($field_name);
            }
        } elsif ( $method_type eq 'has' ) {
            return sub {
                return defined $self->get_field($field_name);
            }
        }
    }

    carp "Can't call $method_name on ", ref $self, " object";

    return;   # The call is declined by not returning a sub ref
}

1;

__END__
