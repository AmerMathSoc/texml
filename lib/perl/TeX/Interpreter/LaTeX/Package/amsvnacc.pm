package TeX::Interpreter::LaTeX::Package::amsvnacc;

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

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{amsvnacc}

\UCSchardef\Abreac  "1EAE
\UCSchardef\abreac  "1EAF
\UCSchardef\Acirgr  "1EA6
\UCSchardef\acirgr  "1EA7
\UCSchardef\Ecirac  "1EBE
\UCSchardef\ecirac  "1EBF
\UCSchardef\Ecirti  "1EC4
\UCSchardef\ecirti  "1EC5
\UCSchardef\Ecirud  "1EC6
\UCSchardef\ecirud  "1EC7
\UCSchardef\Ocirac  "1ED0
\UCSchardef\ocirac  "1ED1
\UCSchardef\Ocirgr  "1ED2
\UCSchardef\ocirgr  "1ED3
\UCSchardef\Ocirud  "1ED8
\UCSchardef\ocirud  "1ED9
\UCSchardef\Ohornac "1EDA
\UCSchardef\ohornac "1EDB
\UCSchardef\Ohorngr "1EDC
\UCSchardef\ohorngr "1EDD
\UCSchardef\Ohornud "1EE2
\UCSchardef\ohornud "1EE3
\UCSchardef\Ohorn   "01A0
\UCSchardef\ohorn   "01A1
\UCSchardef\Uhornac "1EE8
\UCSchardef\uhornac "1EE9
\UCSchardef\Uhorngr "1EEA
\UCSchardef\uhorngr "1EEB
\UCSchardef\Uhornti "1EEE
\UCSchardef\uhornti "1EEF
\UCSchardef\Uhorn   "01AF
\UCSchardef\uhorn   "01B0
\UCSchardef\xAcirgr "1EA6
\UCSchardef\xacirgr "1EA7
\UCSchardef\xOcirgr "1ED2
\UCSchardef\xocirgr "1ED3

\endinput

__END__
