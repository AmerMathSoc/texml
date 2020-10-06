package TeX::Output::Text;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use TeX::Class;

use base qw(TeX::Output::Buffer);

use TeX::Interpreter;

my %file_handle_of :ATTR(:name<file_handle>);

sub open_document {
    my $self = shift;

    my $tex = $self->get_tex_engine();

    my $filename = $tex->get_output_file_name();

    ## TODO: Allow encoding to be set.

    open(my $fh, ">:utf8", $filename) or do {
        die "Can't open output file $filename: $!\n";
    };

    $self->set_file_handle($fh);

    $self->set_empty(1);

    return;
}

sub close_document {
    my $self = shift;

    $self->flush_buffer();

    close($self->get_file_handle());

    $self->delete_file_handle();

    return;
}

sub clear_buffer {
    my $self = shift;

    my $text = $self->get_buffer();

    $self->set_buffer("");

    return $text;
}

sub flush_buffer {
    my $self = shift;

    my $text = $self->clear_buffer();

    ## This used to read "if (nonempty($text))" but that had the
    ## disadvantage of suppressing some newlines that we wanted to
    ## include in the output, so now we keep all non-zero-length
    ## strings.  This is probably going to need to be refined.

    if (defined($text) && length($text)) {
        $self->write($text);

        $self->set_empty(0);

        $self->set_num_newlines(0);
    }

    return;
}

sub write {
    my $self = shift;

    my $fh = $self->get_file_handle();

    print { $fh } @_;

    return;
}

1;

__END__
