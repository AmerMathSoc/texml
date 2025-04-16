package TeX::Interpreter::LaTeX::Package::graphics;

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

use strict;

use File::Basename qw(fileparse);

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

use TeX::Token::Constants qw(BEGIN_GROUP END_GROUP);

use TeX::KPSE qw(kpse_lookup);

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro('Gin@setfile' => \&do_gin_setfile);

    return;
}

sub do_gin_setfile {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $type     = $tex->read_undelimited_parameter();
    my $ext      = $tex->read_undelimited_parameter();
    my $filename = $tex->read_undelimited_parameter(EXPANDED);

    my $path = kpse_lookup($filename);

    if (! defined $path) {
        $tex->print_err("Can't find graphic file '$filename'");
        $tex->error();

        return;

    }

    $path =~ s{\A\./}{};

    my $expansion;

    my ($basename, $dir, $suffix) = fileparse($filename, qr{\.[^.]*});

    $suffix =~ s{^\.}{};
    $suffix = lc($suffix);

    if ($suffix eq 'svg') {
        $expansion = $tex->tokenize(qq{\\TeXMLImportSVG{$path}});
    } elsif ($suffix =~ m{^(png|jpg|jpeg)$}i) {
        $expansion = $tex->tokenize(qq{\\TeXMLImportGraphic{$path}});
    } else {
        $expansion = new_token_list;

        $expansion->push($tex->tokenize(q{\TeXMLCreateSVG}));

        $expansion->push(BEGIN_GROUP);

        $expansion->push($tex->get_macro_expansion_text(q{texml@includegraphics}));

        $expansion->push(END_GROUP);
    }

    return $expansion
}

1;

__DATA__

\ProvidesPackage{graphics}

\LoadRawMacros

\def\Gin@extensions{% order here is like dvipdfmx.def, except for PS
  .svg,%
  .pdf,.PDF,.eps,.EPS,.mps,.MPS,.ps,.PS,%
  .png,.PNG,.jpg,.JPG,.jpeg,.JPEG,.jp2,.JP2,.jpf,.JPF,.bmp,.BMP,%
  .pict,.PICT,.psd,.PSD,.mac,.MAC,.TGA,.tga,%
  .gif,.GIF,.tif,.TIF,.tiff,.TIFF,%
}

\@ifpackagewith{graphics}{demo}{%
    \GenericError{%
        (texml)\@spaces\@spaces\@spaces\@spaces
    }{%
        Error: Don't use demo option with graphics%
    }{%
        Just don't.%
    }{blah}%
}{}

\let\LTX@includegraphics\includegraphics

\let\texml@includegraphics\@empty

\def\g@save@includegraphics{%
    \g@addto@macro\texml@includegraphics
}

\def\includegraphics#1#{%
    \begingroup
        \def\texml@includegraphics{\includegraphics#1}%
        \@includegraphics
}

\def\@includegraphics#1{%
        \g@save@includegraphics{{#1}}%
        \let\includegraphics\LTX@includegraphics
        \texml@includegraphics
    \endgroup
}

\def\resizebox#1#2#3{#3}

\def\scalebox#1{\@ifnextchar[{\@scalebox{#1}}{\@scalebox{#1}[]}}

\def\@scalebox#1[#2]#3{%
    \TeXMLCreateSVG{\scalebox{#1}[#2]{#3}}%
}

\def\reflectbox#1{\TeXMLCreateSVG{\reflectbox{#1}}}

\endinput

__END__
