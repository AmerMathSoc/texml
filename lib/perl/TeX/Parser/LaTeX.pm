package TeX::Parser::LaTeX;

use strict;

use version; our $VERSION = qv '1.5.0';

use base qw(TeX::Parser);

use Carp;

use PTG::Class;

#use TeX::KPSE  qw(kpse_lookup);
use TeX::Token qw(:factories);
use TeX::Token::Constants qw(:all);
use TeX::WEB2C qw(:catcodes);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    for my $char_code (0..8, 11, 14..31) {
        $self->set_catcode($char_code, CATCODE_INVALID);
    }

    $self->set_handler('@firstofone'  => \&do_at_firstofone);
    $self->set_handler('@firstoftwo'  => \&do_at_firstoftwo);
    $self->set_handler('@gobble'      => \&do_at_gobble);
    $self->set_handler('@gobbletwo'   => \&do_at_gobbletwo);
    $self->set_handler('@secondoftwo' => \&do_at_secondoftwo);

    $self->set_handler(begin => \&do_begin);
    $self->set_handler(end   => \&do_end);
    # $self->set_handler(include => \&do_include);
    # $self->set_handler(input   => \&do_input);

    $self->let('@iden' => '@firstofone');

    return;
}

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub is_starred {
    my $self = shift;

    my $next_token = $self->peek_next_token();

    if (defined $next_token && $next_token == STAR) {
        $self->consume_next_token();

        return 1;
    }

    return;
}

sub scan_optional_argument {
    my $self = shift;

    if (my @args = $self->read_macro_parameters(OPT_ARG)) {
        return $args[1];
    }

    return;
}

sub let {
    my $self = shift;

    my $alias = shift;
    my $target = shift;

    $self->set_handler($alias => $self->get_handler($target));

    return;
}

sub do_at_firstofone {
    my $self = shift;

    my $arg = $self->read_undelimited_parameter();

    $self->insert_tokens($arg);

    return;
}

sub do_at_firstoftwo {
    my $self = shift;

    my $arg = $self->read_undelimited_parameter();

    $self->read_undelimited_parameter();

    $self->insert_tokens($arg);

    return;
}

sub do_at_secondoftwo {
    my $self = shift;

    $self->read_undelimited_parameter();

    my $arg = $self->read_undelimited_parameter();

    $self->insert_tokens($arg);

    return;
}

sub do_at_gobble {
    my $self = shift;

    $self->read_undelimited_parameter();

    return;
}

sub do_at_gobbletwo {
    my $self = shift;

    $self->read_undelimited_parameter();
    $self->read_undelimited_parameter();

    return;
}

sub do_begin( $$ ) {
    my $parser = shift;
    my $csname = shift;

    my $envname = $parser->read_undelimited_parameter();

    if (defined $envname) {
        $parser->insert_tokens(make_csname_token($envname));
    } else {
        croak("Missing argument for \\$csname");
    }

    return;
}

sub do_end( $$ ) {
    my $parser = shift;
    my $csname = shift;

    my $envname = $parser->read_undelimited_parameter();

    if (defined $envname) {
        $parser->insert_tokens(make_csname_token("end$envname"));
    } else {
        croak("Missing argument for \\$csname");
    }

    return;
}

sub __process_included_file {
    my $parser = shift;

    my $token_list = shift;

    my $file_name = $token_list->to_string();

    if (empty $file_name) {
        my $line = $parser->get_line_no();

        carp("Null filename on line $line.");

        return;
    }

    my $basename = basename($file_name);

    ## Don't try to read the pstricks or xy packages.  This is ugly,
    ## but it avoids problems with authors write "\input pstricks" or
    ## "\input xy" instead of "\usepackage{pstricks}" or
    ## "\usepackage{xy}".

    if ( $basename =~ /^pstricks(\.tex)?/ || $basename =~ /^xy(\.tex)?/ ) {
        # $LOG->notify("Skipping file $file_name\n");

        return;
    }

    my $path = kpse_lookup($file_name);

    if (empty $path) {
        $path = kpse_lookup("$file_name.tex");
    }

    if (! defined $path) {
        my $line = $parser->get_line_no();

        carp("Can't find file $file_name on line $line.");

        return;
    }

    $parser->push_input();

    $parser->bind_to_file($path);

    $parser->parse();

    $parser->pop_input();

    return;
}

sub do_include($$) {
    my $parser = shift;
    my $csname = shift;

    my $file_name = $parser->read_undelimited_parameter();

    $parser->__process_included_file($file_name);

    return;
}

sub do_input($$) {
    my $parser = shift;
    my $csname = shift;

    my $next = $parser->peek_next_token();

    my $file_name;

    if ($next == CATCODE_BEGIN_GROUP) {
        $file_name = $parser->read_undelimited_parameter();
    } else {
        $file_name = $parser->scan_file_name();
    }

    $parser->__process_included_file($file_name);

    return;
}

1;

__END__
