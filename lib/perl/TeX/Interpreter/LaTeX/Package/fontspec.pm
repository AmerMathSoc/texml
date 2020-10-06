package TeX::Interpreter::LaTeX::Package::fontspec;

use strict;
use warnings;

use TeX::Token qw(make_anonymous_token);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::fontspec::DATA{IO});

    $tex->define_csname(newfontface => \&do_newfontface);

    return;
}

sub do_newfontface( $$ ) {
    my $tex   = shift;
    my $token = shift;

    my $font_cmd  = $tex->read_undelimited_parameter();    
    my $font_name = $tex->read_undelimited_parameter();

    $tex->define_csname($font_cmd->index(0)->get_csname(),
                        sub {
                            my $tex   = shift;
                            my $token = shift;

                            $tex->start_xml_element("roman"); # bleah
                            $tex->set_xml_attribute("specific-use", $font_name); # bleaher
                            my $end = sub { $tex->end_xml_element("roman") };

                            $tex->save_for_after(make_anonymous_token($end));

                            return;
                        });

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{fontspec}

\fontencoding{UTF-32}

\let\setmainfont\relax
\newcommand{\setmainfont}[2][]{}

\let\setmathfont\relax
\newcommand{\setmathfont}[2][]{}

\let\addfontfeatures\@gobble

\TeXMLendPackage

\endinput

__END__
