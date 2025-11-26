package TeX::Utils::SVG;

use v5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

use Cwd;

use File::Basename;
use File::Spec::Functions qw(catdir rel2abs);
use File::Temp qw(tempdir);

## Convert HUP, INT, PIPE and TERM into regular exits so that
## File::Temp's END block will run to clean up temporary files.

use sigtrap handler => sub { exit }, qw(normal-signals);

use TeX::Class;

use TeX::Arithmetic qw(sprint_scaled);

use TeX::Utils::Misc;

use TeXML::CFG;

my $CFG;

use XML::LibXML;

sub DVI_ENGINE() { $CFG->val(__PACKAGE__, 'dvi_engine', 'pdflatex -output-format dvi') }
sub PDF_ENGINE() { $CFG->val(__PACKAGE__, 'pdf_engine', 'xelatex') }
sub DVIPS  () { $CFG->val(__PACKAGE__, 'dvips',         'dvips') }
sub PDFCROP() { $CFG->val(__PACKAGE__, 'pdfcrop',       'pdfcrop') }
sub PDF2SVG() { $CFG->val(__PACKAGE__, 'pdf2svg',       'pdf2svg') }
sub PS2PDF () { $CFG->val(__PACKAGE__, 'ps2pdf',        'ps2pdf') }
sub MATH_SF_FONT () { $CFG->val(__PACKAGE__, 'math_sf_font', 'SourceSansPro-Regular.otf') }

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %base_file_of :ATTR(:name<base_file>);
my %interpreter_of :ATTR(:name<interpreter>);

my %preamble_of  :ATTR(:name<preamble>);
my %docclass_of  :ATTR(:name<docclass>);

my %texinputs_of :ARRAY(:name<texinput>);

my %debug_of :BOOLEAN(:name<debug> :default<0>);

my %use_xetex_of :BOOLEAN(:name<use_xetex> :default<0>);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    if (nonempty(my $base_file = $arg_ref->{base_file})) {
        $self->set_base_file($base_file);

        my $base_dir = dirname(rel2abs($base_file));

        $self->add_texinput("$base_dir//");

        $self->extract_preamble();
    }

    return;
}

######################################################################
##                                                                  ##
##                         PRIVATE METHODS                          ##
##                                                                  ##
######################################################################

sub extract_preamble :PRIVATE {
    my $self = shift;

    my $base_file = $self->get_base_file();

    my $preamble;

    local $_;

    my $tex = $self->get_interpreter();

    my $mode = $tex->is_unicode_input() ? "<:utf8" : "<";

    ## Subtlety be damned.

    open(my $fh, $mode, $base_file) or do {
        die "Can't open $base_file: $!\n";
    };

    while (<$fh>) {
        last if m{\A \s* \\begin\{document\}}smx;

        next if m{\A \s* \\controldates\b}smx;

        $preamble .= $_;

        next if m{\A\s*%};

        m{\\documentclass \s* (?: \[.*?\])? \s* \{(.*?)\}}smx and do {
            $self->set_docclass($1);

            ## Some commands not in the public version of the AMS classes.
            $preamble .= qq{\\providecommand{\\DOI}[1]{}\n};
            $preamble .= qq{\\providecommand{\\datepreposted}[1]{}\n};
            $preamble .= qq{\\providecommand{\\datereceived}[1]{}\n};
        };
    }

    close($fh);

    $self->set_preamble($preamble);

    return;
}

sub add_title {
    my $self = shift;

    my $svg_file = shift;
    my $svg_title = shift;
    my $id = shift;
    my $data_src = shift;

    my $dom = eval { XML::LibXML->load_xml(location => $svg_file, huge => 1) };

    if (! defined $dom) {
        warn "Can't parse SVG file to add title\n";

        return;
    }

    $svg_title =~ s{\\renewcommand\{.*?\}\{.*?\}}{}g;
    $svg_title =~ s{\\setlength\{.*?\}\{.*?\}}{}g;

    $svg_title = trim($svg_title);

    my $root = $dom->documentElement();

    my $title = $dom->createElement("title");

    $title->setAttribute('data-texml-source', $data_src);

    $title->setAttribute(id => $id);

    $title->appendTextNode($svg_title);

    $root->insertBefore($title, $root->firstChild());

    my $state = $dom->toFile($svg_file, 1);

    return;
}

sub system {
    my $self = shift;

    my $command = shift;
    my @args    = @_;

    my $cmd = qq{$command @args};

    my $status = CORE::system qq{$command @args};

    if ($status) {
        my $dirname = basename(getcwd());

        my $tex = $self->get_interpreter();

        $tex->print_err("Could not generate SVG: '$command' failed!");

        $tex->print_err("Working files will be left in $dirname");

        $tex->set_help("Skipping this graphic.");

        $tex->error();

        die;
    }

    return;
}

sub generate_svg {
    my $self = shift;

    my $tex_file  = shift;
    my $svg_title = shift;
    my $id = shift;
    my $data_src  = shift;
    my $use_xetex = shift;

    my $base = basename($tex_file, '.tex');

    if ($use_xetex) {
        $self->system(PDF_ENGINE, '-interaction' => 'batchmode', $tex_file);
    } else {
        $self->system(DVI_ENGINE, '-interaction' => 'batchmode', $tex_file);

        $self->system(DVIPS, "$base.dvi", '-o');

        $self->system(PS2PDF, "$base.ps");
    }

    my $svg_file;

    $self->system(PDFCROP, "$base.pdf");

    my $cropped_pdf = "$base-crop.pdf";

    $svg_file = "$base.svg";

    if (-e $cropped_pdf) {
        $self->system(PDF2SVG, $cropped_pdf, $svg_file);
    }

    $self->add_title($svg_file, $svg_title, $id, $data_src);

    return $svg_file;
}

######################################################################
##                                                                  ##
##                          PUBLIC METHODS                          ##
##                                                                  ##
######################################################################

sub __scratch_dir {
    my $self = shift;

    my $tmp_dir = tempdir("texml-svg-XXXXXX",
                          DIR => $ENV{TMPDIR} || "/tmp",
                          CLEANUP => ! $self->is_debug())
        or do {
            die "temp directory error: $!\n";
    };

    my $mask = 02777 & ~umask;

    chmod($mask, $tmp_dir);

    return $tmp_dir;
}

sub convert_tex {
    my $self = shift;

    my $tex_fragment = shift;
    my $id = shift;

    my $tex = shift;

    my $starred = shift;

    $CFG = TeXML::CFG->get_cfg();

    ## The use_xetex flag needs to be a lot more sophisticated.

    my $use_xetex = $self->use_xetex();

    # if ($use_xetex) {
        my $is_external_graphic = $tex_fragment =~ m{\\input};

        if ($is_external_graphic && $tex_fragment =~ m{\.pstex_t}) {
            $use_xetex = 0;
        }

        if ($tex_fragment =~ m{\\psfrag}) {
            $use_xetex = 0;
        }
    # }

    # if (! $use_xetex) {
    #     my $is_external_graphic = $tex_fragment =~ m{\\includegraphics};
    #
    #     $use_xetex = (! $is_external_graphic) && $tex_fragment !~ m{\.pstex_t};
    # }

    my $tmp_dir = $self->__scratch_dir();

    my $cwd = getcwd();

    chdir($tmp_dir) or do {
        die "Can't connect to $tmp_dir: $!\n";
    };

    my $base = "tex2svg";

    my $tex_file = "$base.tex";

    my $mode = $tex->is_unicode_input() ? ">:utf8" : ">";

    open(my $fh, $mode, $tex_file) or do {
        die "Can't open $tex_file\n";
    };

    # Avoid loading the amsfonts package to keep from using up math
    # symbol fonts that we might need later for the stix2 package.

    if (! $use_xetex) {
        my $pkg = $CFG->val(__PACKAGE__, 'stix_dvi_pkg', 'stix2');

        print { $fh } qq{\\RequirePackage{$pkg}\n\n};

        print { $fh } qq{\\csname \@namedef\\endcsname{ver\@stix2.sty}{1900/01/01}\n\n};
    }

    if (nonempty(my $docclass = $self->get_docclass())) {
        print { $fh } qq{\\PassOptionsToClass{noamsfonts}{$docclass}\n\n};
    }

    print { $fh } qq{\\csname \@namedef\\endcsname{ver\@shaderef.sty}{1900/01/01}\n\n};

    ## If images are pushed too far to the right on extra-wide pages,
    ## it seems to confuse pdfcrop.  This has especially been a
    ## problem with tikz images inside equations (cf. mcom3338).  This
    ## helps.

    print { $fh } qq{\\PassOptionsToPackage{fleqn}{amsmath}\n\n};

    my $preamble = $self->get_preamble();

    # if ($is_external_graphic) {
        print { $fh } qq{\\newdimen\\TeXMLrealhsize\n\n};

        $preamble =~ s{\\hsize\b}{\\TeXMLrealhsize}g;
        $preamble =~ s{\\textwidth\b}{\\TeXMLrealhsize}g;
        $preamble =~ s{\\linewidth\b}{\\TeXMLrealhsize}g;
    # }

    print { $fh } $preamble;

    print { $fh } q{\providecommand{\extrarowheight}{\dimen0 }}, "\n";

    if ($use_xetex) {
        print { $fh } qq{\\usepackage{unicode-math}\n};
        print { $fh } qq{\\setmainfont{STIX Two Text}[Ligatures=TeX,Script=Default]\n};
        print { $fh } qq{\\setmathfont{STIX Two Math}\n};
        print { $fh } qq{\\let\\mathbf\\relax\n};
        print { $fh } qq{\\setmathfontface\\mathbf{STIX Two Text Bold}\n};
        print { $fh } qq{\\setmathfontface\\mathit{STIX Two Text Italic}\n};
        printf { $fh } qq{\\setmathfontface\\mathsf{%s}\n}, MATH_SF_FONT;
        print { $fh } qq{\\let\\bm\\mathbfit\n};

        # Override the default graphicx include rule so we can handle
        # filenames like "foo.x.eps".

        print { $fh } qq{\\csname \@namedef\\endcsname{Gin\@rule\@*}#1{{eps}{\\csname Gin\@ext\\endcsname }{#1}}};
    } else {
        # print { $fh } qq{\\usepackage{stix2}\n};
    }

    print { $fh } qq{\\def\\SVG{}\n};
    print { $fh } qq{\\def\\endSVG{}\n};

    print { $fh } qq{\\overfullrule0pt\n\n};

    print { $fh } qq{\\thispagestyle{empty}\n\n};

    print { $fh } qq{{\\makeatletter\\gdef\\AMS\@pagefooter{}}\n\n};

    print { $fh } qq{\\expandafter\\let\\csname enddoc\@text\\endcsname\\relax\n\n};

    my $paper_width = sprint_scaled($tex->TeXML_SVG_paperwidth());

    # if ($is_external_graphic) {
        print { $fh } qq{\\TeXMLrealhsize\\textwidth\n};
        print { $fh } qq{\\paperwidth ${paper_width}pt\n};
        print { $fh } qq{\\textheight22in\n};
        print { $fh } qq{\\paperheight22in\n};
        print { $fh } qq{\\special{papersize=\\the\\paperwidth,\\the\\paperheight}\n};
    # }

    print { $fh } qq{\\usepackage{fullpage}\n\n};

    print { $fh } qq{\\makeatletter\\providecommand{\\KV\@Gin\@alt}[1]{}\\makeatother\n\n};

    print { $fh } qq{\\begin{document}\n\n};

    my $data_src = sprintf qq{%s, l. %s}, $tex->get_file_name(), $tex->input_line_no();

    print { $fh } qq{%% SOURCE: $data_src\n\n};

    print { $fh } qq{\\begin{equation*}\n} if $starred;

    # if ($is_external_graphic) {
        (my $fragment = $tex_fragment) =~ s{\\hsize\b}{\\TeXMLrealhsize}g;
        $fragment =~ s{\\textwidth\b}{\\TeXMLrealhsize}g;
        $fragment =~ s{\\linewidth\b}{\\TeXMLrealhsize}g;

        print { $fh } $fragment, "\n";
    # } else {
    #     print { $fh } $tex_fragment, "\n\n";
    # }

    print { $fh } qq{\\end{equation*}\n} if $starred;

    print { $fh } "\n";

    print { $fh } qq{\\end{document}\n};

    close($fh);

    local $ENV{TEXMFCNF} = undef;

    my @texinputs = ($self->get_texinputs(), "");

    if (my $pre = $CFG->val(__PACKAGE__, 'pre_texinputs')) {
        unshift @texinputs, $pre;
    }

    if (my $post = $CFG->val(__PACKAGE__, 'post_texinputs')) {
        push @texinputs, $post;
    }

    unshift @texinputs, ".";

    local $ENV{TEXINPUTS} = join(":", @texinputs);

    my $svg_file = eval {
        $self->generate_svg($tex_file, $tex_fragment, $id, $data_src, $use_xetex);
    };

    chdir($cwd) or do {
        warn "Can't reconnect to $cwd: $!\n";
    };

    if (! defined $svg_file) {
        if (! $self->is_debug()) {
            CORE::system qq{/bin/cp -r $tmp_dir $cwd};
        }

        return;
    }

    $svg_file = catdir($tmp_dir, $svg_file);

    return -e $svg_file ? $svg_file : undef;
}

1;

__END__
