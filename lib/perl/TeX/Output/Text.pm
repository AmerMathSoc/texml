package TeX::Output::Text;

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
