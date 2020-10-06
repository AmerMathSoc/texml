package TeX::Primitive::Extension::addCSSclass;

use strict;
use warnings;

use base qw(TeX::Command::Executable);

use TeX::Class;

use TeX::Constants qw(:named_args);

use TeX::Node::XmlClassNode qw(:constants);

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $selector = $tex->read_undelimited_parameter(EXPANDED);
    my $body     = $tex->read_undelimited_parameter(EXPANDED);

#     $tex->DEBUG("selector = '$selector'");
#     $tex->DEBUG("body     = '$body'");

    $tex->add_css_class([ $selector, $body ]);

# my @css_classes = $tex->get_css_classes();
# 
#         for my $item (@css_classes) {
#             my ($selector, $body) = @{ $item };
#     
#             if ($selector eq '@import') {
#                 print STDERR qq{$selector "$body"\n};
#             } else {
#                 print STDERR qq{$selector { $body }\n};
#             }
#         }
#     

    return;
}

1;

__END__
