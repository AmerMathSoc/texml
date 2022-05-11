package TeX::Interpreter::LaTeX::Package::hhline;

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

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_latex_package("hhline", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::hhline::DATA{IO});

    $tex->define_csname('HH@loop' => \&do_HH_loop);

    return;
}

sub do_HH_loop {
    my $tex = shift;

    my $this_table = $tex->get_macro_expansion_text('@thistable');

    my $row_number = $tex->alignrowno();

    my $css_prop = 'border-bottom';
    $css_prop = 'border-top';

    if ($row_number == 0) {
        $css_prop = 'border-top';
        $row_number++;
    }

    my $cur_align = $tex->get_cur_alignment();

    my $width = $tex->get_macro_expansion_text('current@border@width');
    my $style = $tex->get_macro_expansion_text('current@border@style');
    my $color = $tex->get_macro_expansion_text('current@border@color');

    my $col = 0;

    # | : - ~ work pretty well
    # = t b   kind of work
    # #       doesn't work

    while (my $token = $tex->get_next()) {
        my $char = $token->get_char();

        last if $char eq '`';

        next if $char eq '|' || $char eq ':' || $char eq ' ';

        # I don't know how to implement # in CSS, so just ignore it.

        next if $char eq '#';

        $col++;

        next if $char eq '~';

        my $top_row = $cur_align->top_row($row_number, $col);

        # my $css_selector = qq{$this_table TR:nth-child($top_row)};

        ## For our purposes, t and b are equivalent to =.  I think.

        if ($char eq '-') {
            # $tex->__DEBUG("Setting $css_prop on $top_row, column $col");

            $tex->set_column_css_property($col, $css_prop,
                                          qq{$width solid $color});
        }
        elsif ($char eq '=' || $char eq 't' || $char eq 'b') {
            # $tex->__DEBUG("Adding $css_prop on $top_row, column $col");

            $tex->set_column_css_property($col, $css_prop,
                                          qq{$width double $color});
        }
        else {
            $tex->print_err("Unexpected token '$token' in hhline");

            $tex->set_help("Don't do that");

            $tex->error();
        }
    }

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{hhline}

\def\hhline@hhline#1{%
    \HH@xexpast\relax#1*0x\@@%
    \toks@{}%
    \expandafter\HH@let\@tempa`%
}

\def\hhline#1{%
    \noalign{\hhline@hhline{#1}}%
}

\TeXMLendPackage

\endinput

__END__
