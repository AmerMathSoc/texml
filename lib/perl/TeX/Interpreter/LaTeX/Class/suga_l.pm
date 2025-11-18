package TeX::Interpreter::LaTeX::Class::suga_l;

use v5.26.0;

use utf8;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use TeX::Utils::Misc;

use TeX::Command::Executable::Assignment qw(:modifiers);

my sub do_oa;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    $tex->define_csname(oa => \&do_oa);

    return;
}

sub do_oa {
    my $tex   = shift;
    my $token = shift;

    my $oa = $tex->read_undelimited_parameter();

    return; ## TBD: DISABLED UNTIL WE'RE READY FOR THIS DOWNSTREAM

    my $text = trim($oa->to_string());

    $tex->define_simple_macro('AMS@articlenote', $text, MODIFIER_GLOBAL);

    my $t = $tex->expansion_of('AMS@articlenote');

    # \oa{This article originally appeared in Japanese in S\=ugaku
    # {\bf 73} 1 (2021), 240--266.}

    # \oa{This article originally appeared in Japanese in S\={u}gaku
    # \textbf{71} (2019), 302--324.}

    my sub __error {
        $tex->print_err("Invalid \\oa text '$text'");

        $tex->error();

        return;
    }

    unless ($text =~ s{\AThis article originally appeared in Japanese in }{}sm) {
        __error();

        return;
    }

    unless ($text =~ s{\AS.*gaku }{}sm) {
        __error();

        return;
    }

    my $volume;
    my $issue;
    my $year;
    my $start_page;
    my $end_page;

    unless ($text =~ s{(\{\\bf|\\textbf\{)\s*}{}sm) {
        __error();

        return;
    }

    if ($text =~ s{\A(\d+)\}\s+}{}sm) {
        $volume = $1;
    } else {
        __error();

        return;
    }

    if ($text =~ s{\A(\d+)\s*}{}sm) {
        $issue = $1;
    }

    if ($text =~ s{\A\((\d+)\),\s*}{}sm) {
        $year = $1;
    } else {
        __error();

        return;
    }

    if ($text =~ s{\A(\d+)(?:-+(\d+))?}{}sm) {
        $start_page = $1;
        $end_page   = $2;
    } else {
        __error();

        return;
    }

    if (nonempty($volume)) {
        $tex->define_simple_macro('AMS@orig@volume', $volume);
    }

    if (nonempty($issue)) {
        $tex->define_simple_macro('AMS@orig@issue', $issue);
    }

    if (nonempty($year)) {
        $tex->define_simple_macro('AMS@orig@year', $year);
    }

    if (nonempty($start_page)) {
        $tex->define_simple_macro('AMS@orig@start@page', $start_page);
    }

    if (nonempty($end_page)) {
        $tex->define_simple_macro('AMS@orig@end@page', $end_page);
    }

    return;
}

1;

__DATA__

\ProvidesClass{suga-l}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ProcessOptions\relax

\LoadClass{amsart}[1996/10/24]

\RequirePackage{AMStrans}

\gdef\AMS@publkey{suga}

\def\AMS@publname{Sugaku Expositions}

\def\AMS@eissn{2473-585X}
\def\AMS@pissn{0898-9583}

\def\AMS@series@url{https://www.ams.org/aboutsuga/}

\def\JATS@subject@group{Research article}
\def\JATS@subject@group@type{display-channel}

% https://www.jstage.jst.go.jp/browse/sugaku/

\def\AMS@orig@publname{数学}
\def\AMS@orig@issn{1883-6127}

\endinput

__END__
