package TeX::Node::UnsetNode;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use TeX::Constants qw(:node_params);

use base qw(TeX::Node::AbstractNode);

use TeX::Class;

use TeX::Constants qw(:node_params);

my %height_of     :ATTR(:get<height>     :set<height>     :default(0));
my %width_of      :ATTR(:get<width>      :set<width>      :default(0));
my %depth_of      :ATTR(:get<depth>      :set<depth>      :default(0));
my %span_count_of :ATTR(:get<span_count> :set<span_count> :default(0));
my %contents_of   :ATTR(:get<contents>   :set<contents>);
my %stretch_of    :ATTR(:get<stretch>    :set<stretch>    :default(0.0));
my %shrink_of     :ATTR(:get<shrink>     :set<shrink>     :default(0.0));
my %glue_sign_of  :ATTR(:get<glue_sign>  :set<glue_sign>  :default(normal));
my %glue_order_of :ATTR(:get<glue_order> :set<glue_order> :default(normal));

1;

__END__
