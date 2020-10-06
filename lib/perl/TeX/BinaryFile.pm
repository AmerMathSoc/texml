package TeX::BinaryFile;

use strict;
use warnings;

use integer;

use Carp;

use TeX::Class;

use Fcntl qw(:seek);

use IO::File;

use TeX::Utils::Misc;
# use PTG::Errors;

my %file_name_of  :ATTR(init_arg => 'file_name', :get<file_name>);
my %filehandle_of :ATTR;
my %buffer_of     :ATTR;
my %mode_of       :ATTR(:get<mode>, :set<mode>);

my %file_position_stack_of :ATTR;

use constant DVI_POINTER_LENGTH => 4;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $file_position_stack_of{$ident} = [];

    return;
}

sub to_string :STRINGIFY {
    my $self = shift;

    return $self->get_file_name();
}

sub __get_filehandle {
    my $self = shift;

    return $filehandle_of{ident $self};
}

sub is_open_for_writing {
    my $self = shift;

    return $self->get_mode() eq 'w';
}

sub open {
    my $self = shift;
    my $mode = shift || 'r';

    if ($mode !~ /^[rw]$/) {
        die "Bad open mode: $mode (should be 'r' or 'w')\n";
    }

    my $class = ref $self;

    my $file_name = $self->get_file_name();

    if (empty $file_name) {
        die "Can't open $class object without a file name\n";
    }

    my $fh = IO::File->new($file_name, $mode) or do {
        die "Could not open $file_name: $!\n";
    };

    $mode_of{ident $self} = $mode;
    $filehandle_of{ident $self} = $fh;

    return 1;
}

sub close {
    my $self = shift;

    my $ident = ident($self);

    my $fh = delete $filehandle_of{$ident};

    return close($fh);
}

sub push_location {
    my $self = shift;

    push @{ $file_position_stack_of{ident $self} }, $self->tell();

    return;
}

sub pop_location {
    my $self = shift;

    my $pos = pop @{ $file_position_stack_of{ident $self} };

    if (! defined $pos) {
        die "Stack underflow on pop_location\n";
    }

    return $self->seek($pos);
}

sub get_file_size {
    my $self = shift;

    return -s $self->__get_filehandle();
}

sub eof {
    my $self = shift;

    return eof($self->__get_filehandle());
}

sub seek {
    my $self = shift;

    my $position = shift;
    my $whence   = shift || SEEK_SET;

    my $pos = $self->__get_filehandle()->seek($position, $whence) or do {
        die "Seek error on $self: $!\n";
    };

    return $pos;
}

sub skip {
    my $self = shift;
    my $num_bytes = shift;

    return $self->seek($num_bytes, SEEK_CUR);
}

sub tell {
    my $self = shift;

    return tell($self->__get_filehandle());
}

sub write_bytes {
    my $self = shift;
    my $bytes = shift;

    my $fh = $self->__get_filehandle();

    print {$fh} $bytes or do {
        die "Error writing ", $self->get_file_name(), ": $!\n";
    };
}

sub read_bytes {
    my $self = shift;

    my $num_bytes = shift;

    my $fh = $self->__get_filehandle();

    if ($num_bytes == 0) {
        croak "Can't read 0 bytes";
    }

    read($fh, my $buffer, $num_bytes) or do {
        die construct_error("read_bytes failed at pos " . $self->tell(), $!);
    };

    return wantarray ? split('', $buffer) : $buffer;
}

sub read_bytes_to {
    my $self = shift;

    my $limit = shift;

    my $num_raw_bytes = $limit - $self->tell();

    if ($num_raw_bytes < 0) {
        die "Can't read backwards!\n";
    } elsif ($num_raw_bytes == 0) {
        return '';
    }

    return $self->read_bytes($num_raw_bytes);
}

sub next_byte {
    my $self = shift;

    my $byte = $self->read_bytes(1);

    return unpack("C", $byte);
}

sub peek_byte {
    my $self = shift;

    my $fh = $self->__get_filehandle();

    read($fh, my $buffer, 1) or do {
        die construct_error("peek_byte failed", $!);
    };

    $self->seek(-1, SEEK_CUR) or die construct_error("seek error", $!);

    return unpack("C", $buffer);
}

sub read_unsigned {
    my $self = shift;
    my $num_bytes = shift || 1;

    my $bytes = $self->read_bytes($num_bytes);

    my $val = 0;

    foreach my $byte (unpack("C$num_bytes", $bytes)) {
        $val = ($val << 8) + $byte;
    }

    return $val;
}

sub read_unsigned_byte {
    my $self = shift;

    return $self->read_unsigned(1);
}

sub read_unsigned_pair {
    my $self = shift;

    return $self->read_unsigned(2);
}

sub read_unsigned_quad {
    my $self = shift;

    return $self->read_unsigned(4);
}

sub read_signed {
    my $self = shift;
    my $num_bytes = shift || 1;

    my $val = $self->next_byte();

    $val -= 256 if $val >= 128;

    $num_bytes--;

    if ($num_bytes > 0) {
        my $bytes = $self->read_bytes($num_bytes);

        foreach my $byte (unpack("C$num_bytes", $bytes)) {
            $val = ($val * 256) + $byte;
        }
    }

    return $val;
}

sub read_signed_byte {
    my $self = shift;

    return $self->read_signed(1);
}

sub read_signed_pair {
    my $self = shift;

    return $self->read_signed(2);
}

sub read_signed_quad {
    my $self = shift;

    return $self->read_signed(4);
}

sub read_pointer {
    my $self = shift;

    return $self->read_signed(DVI_POINTER_LENGTH);
}

sub read_raw_string {
    my $self = shift;
    my $length = shift;

    return '' unless $length > 0;

    my $bytes = $self->read_bytes($length);

    my @bytes = unpack("C*", $bytes);

    return join '', map chr,  @bytes;
}

sub read_string {
    my $self = shift;
    my $size = shift;

    my $string_length;

    if ($size == 4) {
        $string_length = $self->read_signed($size);
    } else {
        $string_length = $self->read_unsigned($size);
    }

    return $self->read_raw_string($string_length);
}

sub write_raw_data {
    my $self = shift;
    my $string = shift;

    my $fh = $self->__get_filehandle();

    $fh->print($string);

    return length $string;
}

sub write_dvi_bytes {
    my $self = shift;
    my @bytes = @_;

    my $string = pack "C*", @bytes;

    $self->write_raw_data($string);

    return scalar @bytes;
}

sub write_dvi_pointer {
    my $self   = shift;
    my $location = shift;

    my $dvi_ptr = pack "N", $location;

    if (length($dvi_ptr) != DVI_POINTER_LENGTH) {
        die "Invalid DVI pointer: $location\n";
    }

    $self->write_raw_data($dvi_ptr);

    return length $dvi_ptr;
}

1;

__END__
