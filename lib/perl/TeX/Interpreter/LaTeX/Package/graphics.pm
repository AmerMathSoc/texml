package TeX::Interpreter::LaTeX::Package::graphics;

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

use File::Basename qw(fileparse);

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);

use TeX::KPSE qw(kpse_lookup);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro('includegraphics' => \&do_include_graphics);

    return;
}

sub do_include_graphics {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt = $tex->scan_delimited_parameter(CATCODE_BEGIN_GROUP);

    my $filename = $tex->read_balanced_text(undef, EXPANDED);

    $tex->get_next();

    my $expansion;

    my ($basename, $dir, $suffix) = fileparse($filename, qr{\.[^.]*});

    for my $ext ('.svg', "$suffix.svg",
                 '.png', "$suffix.png",
                 '.jpg', "$suffix.jpg",
                 '.jpeg', "$suffix.jpeg") {
        if (defined (my $path = kpse_lookup("$basename$ext"))) {
            $path =~ s{\A\./}{};

            if ($path =~ m{\.svg$}) {
                $expansion = qq{\\TeXMLImportSVG{$path}};
            } else {
                $expansion = qq{\\TeXMLImportGraphic{$path}};
            }

            last;
        }
    }

    if (! defined $expansion) {
        $expansion = qq{\\TeXMLCreateSVG{\\includegraphics${opt}{${filename}}}};
    }

    return $tex->tokenize($expansion);
}

1;

__DATA__

\ProvidesPackage{graphics}

\@ifpackagewith{graphics}{demo}{%
    \GenericError{%
        (texml)\@spaces\@spaces\@spaces\@spaces
    }{%
        Error: Don't use demo option with graphics%
    }{%
        Just don't.%
    }{blah}%
}{}

\def\resizebox#1#2#3{#3}

%\def\includegraphics#1#{\@includegraphics{#1}}

\@ifpackagewith{graphics}{demo}{%
    \def\@includegraphics#1#2{%
        % \TeXMLCreateSVG{\includegraphics#1{#2}}%
    }%
}{%
    \def\@includegraphics#1#2{%
        \TeXMLCreateSVG{\includegraphics#1{#2}}%
    }%
}

\newcommand{\graphicspath}[1]{}
\let\DeclareGraphicsExtensions\@gobble

\def\scalebox#1{\@ifnextchar[{\@scalebox{#1}}{\@scalebox{#1}[]}}

\def\@scalebox#1[#2]#3{%
    \TeXMLCreateSVG{\scalebox{#1}[#2]{#3}}%
}

\def\reflectbox#1{\TeXMLCreateSVG{\reflectbox{#1}}}

\endinput

__END__
