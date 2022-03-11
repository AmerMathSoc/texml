package TeX::Primitive::Extension::addCSSclass;

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
