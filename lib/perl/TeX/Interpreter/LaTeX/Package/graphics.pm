package TeX::Interpreter::LaTeX::Package::graphics;

use 5.26.0;

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

use File::Basename qw(fileparse);

use TeX::Arithmetic qw(sprint_scaled);

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

use TeX::Token::Constants qw(BEGIN_GROUP END_GROUP);

use Image::Info qw(image_info);

use TeX::KPSE qw(kpse_lookup);

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro('Gread@image' => \&do_Gread_image);

    $tex->define_pseudo_macro('Gin@round' => \&do_Gin_round_dimen);

    return;
}

sub do_Gin_round_dimen {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token = $tex->get_x_token();

    my $meaning = $tex->get_meaning($token);

    my $value = $meaning->read_value($tex, $cur_tok);

    my $pt = sprintf "%.2f", sprint_scaled($value);

    $pt =~ s{\.0+$}{};

    return $tex->tokenize("${pt}pt");
}

# I don't need to use lexical subroutines here, but I want to play
# with them.

my sub image_bbox {
    my $img_file = shift;

    state sub pt_to_bp {
        my $pt = shift;

        $pt =~ s{pt$}{};

        my $bp = ($pt * 72) / 72.27;

        return $bp;
    }

    my $info = image_info($img_file);

    if (my $error = $info->{error}) {
        return (0, 0, 0, 0, undef, $error);
    }

    return (0, 0, pt_to_bp($info->{width}), pt_to_bp($info->{height}),
            $info->{file_media_type})
}

sub do_Gread_image {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $file = $tex->read_undelimited_parameter(EXPANDED);

    my $path = kpse_lookup($file);

    if (! defined $path) {
        $tex->print_err("Can't find graphic file '$file'");
        $tex->error();

        return;
    };

    $path =~ s{\A\./}{};

    $tex->define_simple_macro('Gin@fullpath' => $path);

    my ($llx, $lly, $urx, $ury, $media_type, $error) = image_bbox($path);

    if (defined $error) {
        $tex->print_err("Can't parse image file '$path': $error");

        $tex->error();

        return;
    }

    $tex->define_simple_macro('Gin@media@type' => $media_type);

    $tex->define_simple_macro('Gin@llx', $llx);
    $tex->define_simple_macro('Gin@lly', $lly);

    $tex->define_simple_macro('Gin@urx', $urx);
    $tex->define_simple_macro('Gin@ury', $ury);

    return;
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

\def\Gin@driver{texml.def}

\LoadRawMacros

\let\Gin@alt\@empty

\newdimen\Gin@nat@width
\newdimen\Gin@nat@height

\def\Gin@extensions{%
    .svg,%
    .pdf,.PDF,.eps,.EPS,.mps,.MPS,.ps,.PS,%
    .png,.PNG,%
    .jpg,.JPG,.jpeg,.JPEG,%
    .gif,.GIF,%
}

\@namedef{Gin@rule@.svg}#1{{image}{.svg}{#1}}

\@namedef{Gin@rule@.jpg}#1{{image}{.jpg}{#1}}
\@namedef{Gin@rule@.JPG}#1{{image}{.JPG}{#1}}
\@namedef{Gin@rule@.jpeg}#1{{image}{.jpeg}{#1}}
\@namedef{Gin@rule@.JPEG}#1{{image}{.JPEG}{#1}}
\@namedef{Gin@rule@.png}#1{{image}{.png}{#1}}
\@namedef{Gin@rule@.PNG}#1{{image}{.PNG}{#1}}
\@namedef{Gin@rule@.gif}#1{{image}{.gif}{#1}}
\@namedef{Gin@rule@.GIF}#1{{image}{.GIF}{#1}}

\@namedef{Gin@rule@.mps}#1{{eps}{.mps}{#1}}
\@namedef{Gin@rule@.MPS}#1{{eps}{.MPS}{#1}}
\@namedef{Gin@rule@.pdf}#1{{eps}{.pdf}{#1}}
\@namedef{Gin@rule@.PDF}#1{{eps}{.PDF}{#1}}
\@namedef{Gin@rule@.eps}#1{{eps}{.eps}{#1}}
\@namedef{Gin@rule@.EPS}#1{{eps}{.EPS}{#1}}

\let\Gin@media@type\@empty
\let\Gin@fullpath\@empty

\def\Ginclude@image#1{%
    \startXMLelement{\jats@graphics@element}%
        \setXMLattribute{xlink:href}{\Gin@fullpath}%
        \setXMLattribute{mimetype}{\Gin@media@type}%
        \setXMLattribute{width}{\Gin@round\Gin@req@width}%
        \setXMLattribute{height}{\Gin@round\Gin@req@height}%
        \ifx\Gin@alt\@empty\else
            \startXMLelement{alt-text}%
                \Gin@alt
            \endXMLelement{alt-text}%
        \fi
    \endXMLelement{\jats@graphics@element}%
}

\def\Gread@eps#1{%
    %  These values don't matter, except that urx and ury need to be non-zero
    \def\Gin@llx{0}%
    \def\Gin@lly{0}%
    \def\Gin@urx{1}%
    \def\Gin@ury{1}%
}

\def\Ginclude@eps#1{%
    \expandafter\TeXMLCreateSVG\expandafter{\texml@includegraphics}%
}

\let\LTX@includegraphics\includegraphics

\let\texml@includegraphics\@empty

\def\g@save@includegraphics{%
    \g@addto@macro\texml@includegraphics
}

% \includegraphics =>
%     \Ginclude@graphics =>
%     \Gin@setfile =>
%         Gread@TYPE
%         Gin@viewport@code
%         Gin@req@sizes
%         Ginclude@TYPE

\def\includegraphics{%
    \begingroup
        \def\texml@includegraphics{\includegraphics}%
        \@ifstar
            {\g@save@includegraphics{*}\@includegraphics}%
            \@includegraphics
}

\def\@includegraphics{%
        \@ifnextchar[%]
            \@includegraphics@opt
            \@includegraphics@final
}

\def\@includegraphics@opt[#1]{%
        \g@save@includegraphics{[#1]}%
        \@includegraphics
}

\def\@includegraphics@final#1{%
        \g@save@includegraphics{{#1}}%
        \let\includegraphics\LTX@includegraphics
        [{\tt\meaning\texml@includegraphics}]\par
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
