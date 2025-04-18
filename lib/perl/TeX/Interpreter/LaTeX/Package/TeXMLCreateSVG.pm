package TeX::Interpreter::LaTeX::Package::TeXMLCreateSVG;

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

use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

use File::Basename;

use File::Copy;

use File::Spec::Functions qw(catdir);

use TeX::Utils::Misc qw(nonempty empty file_mtime);

use TeX::Utils::SVG;

use TeX::Command::Executable::Assignment qw(:modifiers);

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    # $tex->read_package_data();

    $tex->define_pseudo_macro('TeXMLCreateSVG' => \&do_texml_create_svg);

    return;
}

######################################################################
##                                                                  ##
##                           SVG CREATION                           ##
##                                                                  ##
######################################################################

## TBD: This should be in a separate module, probably unified with
## TeX::Utils::SVG.

use constant SVG_DIR => "Images";

sub do_texml_create_svg {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    ## Ignore explicit *'s and just check for math mode.
    ## URG: This might fail for $\text{\includegraphics{...}}$

    my $starred = $tex->is_starred();

    my $is_mmode = ! $tex->is_mmode();

    my $opt = $tex->scan_optional_argument(); ## NOT CURRENTLY USED

    my $tex_fragment = $tex->read_undelimited_parameter();

    my $scale_factor = 1;

    if ($tex_fragment =~ m{\\includegraphics}) {
        my $svg_mag = $tex->TeXML_SVG_mag();

        $scale_factor = $svg_mag/1000;
    }

    if (defined(my $pinlabel = $tex->get_csname("thelabellist"))) {
        if (defined(my $equiv = $pinlabel->get_equiv())) {
            my $token_list = $equiv->macro_call($tex);

            if (defined $token_list && $token_list->length()) {
                $tex_fragment->unshift($token_list);
            }

            $tex->let_csname('thelabellist', '@empty', MODIFIER_GLOBAL);
        }
    }

    my $md5_sum = md5_hex($tex_fragment->to_string());

    my $id = "img$md5_sum";

    if (! -e SVG_DIR) {
        mkdir SVG_DIR or do {
            $tex->print_err("Unable to create " . SVG_DIR . " directory");

            $tex->error();

            return;
        };
    }

    my $out_file = catdir(SVG_DIR, "$id.svg");

    my $regenerate = $tex->do_svg();

    if (-e $out_file) {
        my $tex_file = $tex->get_file_name();

        my $m_in  = file_mtime($tex_file);
        my $m_out = file_mtime($out_file);

        if (defined $m_in && defined $m_out && $m_in < $m_out) {
            $tex->print_nl("Found up-to-date $out_file.  Not regenerating.");

            $regenerate = 0;
        }
    }

    if ($regenerate) {
        my $svg = $tex->get_svg_agent();

        if ($scale_factor != 1) {
            $tex_fragment = qq{\\scalebox{$scale_factor}{$tex_fragment}};
        }

        my $svg_file = $svg->convert_tex($tex_fragment, $id, $tex, $starred);

        if (empty($svg_file)) {
            $tex->start_xml_element("MISSING_SVG_GRAPHIC");
            $tex->end_xml_element("MISSING_SVG_GRAPHIC");

            return;
        } else {
            copy($svg_file, $out_file) or do {
                $tex->fatal_error("Couldn't copy $svg_file to $out_file: $!");
            };

            $tex->print_nl("Wrote SVG file $out_file");
            $tex->print_ln();
        }
    }

    return unless nonempty($out_file) && -e $out_file;

    my $expansion = qq{\\includegraphics{$out_file}};

    return $tex->tokenize($expansion);
}

1;

__DATA__

\ProvidesPackage{TeXMLCreateSVG}

\RequirePackage{graphicx}

\endinput

__END__
