package TeX::Interpreter::LaTeX::Package::tcolorbox;

use v5.26.0;

# Copyright (C) 2022, 2026 American Mathematical Society
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

use TeX::Utils::KeyPairs;

my sub do_tcolorbox_opts;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname('texml@tcb@process@opts' => \&do_tcolorbox_opts);

    return;
}

sub do_tcolorbox_opts {
    my $tex   = shift;
    my $token = shift;

    my $opt_arg = $tex->read_undelimited_parameter();

    # Set defaults.

    $tex->let_csname('texml@tcb@title' => '@empty');

    $tex->define_simple_macro('texml@tcb@colframe' => 'black');
    $tex->define_simple_macro('texml@tcb@colback'  => 'lightgray');

    if ($opt_arg) {
        my $opts = parse_key_pairs($tex, $opt_arg);

        while (my ($k, $v) = each $opts->%*) {
            $tex->define_simple_macro("texml\@tcb\@$k" => $v);
        }
    }

    return;
}

sub do_endtcolorbox {
    my $tex   = shift;
    my $token = shift;

    $tex->end_par();

    $tex->end_xml_element('boxed-text');

    $tex->end_par();

    return;
}

1;

__DATA__

\ProvidesPackage{tcolorbox}

\RequirePackage{xcolor}

\providecommand{\tcbuselibrary}[1]{}

\newenvironment{tcolorbox}[1][]{%
    \par
    \texml@tcb@process@opts{#1}%
    \startXMLelement{boxed-text}
    \setXMLattribute{content-type}{tcolorbox}%
    \setXMLattribute{position}{anchor}%
    \setXMLattribute{border-width}{medium}%
    \setXMLattribute{border-style}{solid}%
    \set@texml@color@attribute{border-color}{\texml@tcb@colframe}%
    \set@texml@color@attribute{background-color}{\texml@tcb@colback}%
    \ifx\texml@tcb@title\@empty\else
        \par
        \startXMLelement{caption}\par
        \thisxmlpartag{title}\texml@tcb@title\par
        \endXMLelement{caption}\par
    \fi
    \par
}{%
    \par
    \endXMLelement{boxed-text}
    \par
}

\endinput

__END__

<caption> (title attribute)
colframe, colback
