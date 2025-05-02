package TeX::Interpreter::LaTeX::Class::cln;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use warnings;

use TeX::Utils::Misc qw(empty);

use TeX::Utils::LibXML;

## CLN is the only series that needs a <contrib-group/> in the
## <collection-meta/>, so rather than trying to figure out how to
## generalize it in \output@collection@meta, let's just implement it
## as a hook.

my sub add_cln_executive_editor {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    my $editor = $tex->expansion_of('CLN@series@editor');

    return if empty($editor);

    my $dom = $xml->get_dom();

    my $title_group = find_unique_node($dom, qq{/book/collection-meta/title-group});

    my $meta = $title_group->parentNode();

    my $contrib_group = new_xml_element("contrib-group");

    $meta->insertAfter($contrib_group, $title_group);

    $contrib_group->setAttribute("content-type", "executive editors");

    my $contrib = append_xml_element($contrib_group, "contrib");

    $contrib->setAttribute("contrib-type", "executive editor");

    append_xml_element($contrib, 'string-name', $editor);

    return;
}

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->add_output_hook(\&add_cln_executive_editor);

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{cln}

\LoadClass{amsbook}

\seriesinfo{cln}{}{}

\def\AMS@publname{Courant Lecture Notes}

\publisherName{Courant Institute of Mathematical Sciences}
\publisherAddress{New York University\\New York, New York}

\def\CLNseriesEditor{\gdef\CLN@series@editor}

\glet\CLN@series@editor\@empty

% \CLNseriesEditor{Jalal Shatah}

\def\AMS@pissn{1529-9031}
\def\AMS@eissn{2472-4467}

\def\AMS@series@url{https://www.ams.org/cln/}

\endinput

__END__
