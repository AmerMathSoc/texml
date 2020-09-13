package TeX::Utils::Misc;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use UNIVERSAL;

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(concat
                                empty
                                nonempty
                                trim
                                pluralize
                                file_mimetype
                                file_mtime
                                iso_8601_timestamp
                             ) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{all} } );

use Exception::Class qw(TeX::RunError);

use File::MMagic::XS;

my $MMAGIC = new File::MMagic::XS;

## I don't think these are currently needed for texml.  If they do,
## I'll have to figure out how to specify them in File::MMagic::XS.

# $MMAGIC->addSpecials("image/eps",     qr/\xc5\xd0\xd3\xc6/);
# $MMAGIC->addSpecials("image/svg+xml", qr/<\?xml\b/, qr/<svg\b/);

sub concat {
    return join '', @_;
}

## I'm not completely happy with how complicated nonempty() has
## become, but with so many TeX::TokenList's and PTG::XML::Element's
## running around masquerading as strings, it's either this or be
## careful about inserting explicit calls to to_string() all over the
## place..

sub nonempty(;$) {
    my $string = @_ == 1 ? shift : $_;

    return unless defined $string;

    return $string !~ /^\s*$/ unless ref($string);

    ## Otherwise stringify it and hope for the best.

    no warnings; ## *sigh*  Why is this necessary?

    return "$string" !~ /^\s*$/;
}

sub empty($) {
    my $string = shift;

    return not nonempty $string;
}

sub trim($) {
    my $string = defined $_[0] ? $_[0] : '';

    $string =~ s/\s+/ /g;
    $string =~ s/^ | $//g;

    return $string;
}

sub pluralize( $$;$ ){
    my $singular = shift;
    my $cnt      = shift || 0;

    my $plural   = shift || "${singular}s";

    return $cnt == 1 ? $singular : $plural;
}

sub file_mimetype($) {
    my $filename = shift;

    ## MMAGIC::checktype_filename returns "x-system/x-unix" if the
    ## file has execute bits set, so we bypass it by opening the file
    ## ourselves and calling checktype_filehandle to force MMagic to
    ## look at the contents of the file.

    return unless nonempty $filename;

    open(my $FH, "<", $filename) or do {
        warn "Can't open $filename: $!\n";
        return;
    };

    my $mimetype = $MMAGIC->checktype_filehandle($FH);

    close($FH);

    return $mimetype;
}

sub file_mtime( $ ) {
    my $file = shift;

    return (stat($file))[9];
}

sub iso_8601_timestamp() {
    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime(time);

    return sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ",
                   $year + 1900,
                   $mon + 1,
                   $mday,
                   $hour,
                   $min,
                   $sec);
}

1;

__END__
