package TeX::Interpreter::LaTeX::Package::graphics;

use strict;

use File::Basename qw(fileparse);

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);

use TeX::KPSE qw(kpse_lookup);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::graphics::DATA{IO});

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

    for my $ext ('.svg', "$suffix.svg", '.png', "$suffix.png") {
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

\TeXMLprovidesPackage{graphics}

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

\TeXMLendPackage

\endinput

__END__
