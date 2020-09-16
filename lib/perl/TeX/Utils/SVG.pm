package TeX::Utils::SVG;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

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

my $CFG = TeXML::CFG->get_cfg();

use XML::LibXML;

my $DVI_ENGINE = $CFG->val(__PACKAGE__, 'dvi_engine', 'pdflatex -output-format dvi');
my $PDF_ENGINE = $CFG->val(__PACKAGE__, 'pdf_engine', 'xelatex');
my $DVIPS   = $CFG->val(__PACKAGE__, 'dvips',         'dvips');
my $PDFCROP = $CFG->val(__PACKAGE__, 'pdfcrop',       'pdfcrop');
my $PDF2SVG = $CFG->val(__PACKAGE__, 'pdf2svg',       'pdf2svg');
my $PS2PDF  = $CFG->val(__PACKAGE__, 'ps2pdf',        'ps2pdf');

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

sub BUILD {
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

    ## Subtlety be damned.

    open(my $fh, "<", $base_file) or do {
        die "Can't open $base_file: $!\n";
    };

    while (<$fh>) {
        last if m{\A \s* \\begin\{document\}}smx;

        $preamble .= $_;

        next if m{\A\s*%};

        m{\\documentclass \s* (?: \[.*?\])? \s* \{(.*?)\}}smx and do {
            $self->set_docclass($1);
        };
    }

    close($fh);

    $self->set_preamble($preamble);

    return;
}

sub add_title {
    my $self = shift;

    my $svg_file = shift;
    my $tex_fragment = shift;
    my $id = shift;

    my $dom = eval { XML::LibXML->load_xml(location => $svg_file, huge => 1) };

    if (! defined $dom) {
        warn "Can't parse SVG file to add title\n";

        return;
    }

    my $root = $dom->documentElement();

    my $title = $dom->createElement("title");

    $title->setAttribute(id => $id);

    $title->appendTextNode($tex_fragment);

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
    my $use_xetex = shift;

    my $base = basename($tex_file, '.tex');

    if ($use_xetex) {
        $self->system($PDF_ENGINE, '-interaction' => 'batchmode', $tex_file);
    } else {
        $self->system($DVI_ENGINE, '-interaction' => 'batchmode', $tex_file);

        $self->system($DVIPS, "$base.dvi", '-o');

        $self->system($PS2PDF, "$base.ps");
    }

    my $svg_file;

    $self->system($PDFCROP, "$base.pdf");

    my $cropped_pdf = "$base-crop.pdf";

    $svg_file = "$base.svg";

    if (-e $cropped_pdf) {
        $self->system($PDF2SVG, $cropped_pdf, $svg_file);
    }

    $self->add_title($svg_file, $svg_title, $id);

    return $svg_file;
}

######################################################################
##                                                                  ##
##                          PUBLIC METHODS                          ##
##                                                                  ##
######################################################################

sub convert_tex {
    my $self = shift;

    my $tex_fragment = shift;
    my $id = shift;

    my $tex = shift;

    my $starred = shift;

    ## The use_xetex flag needs to be a lot more sophisticated.

    my $use_xetex = $self->use_xetex();

    if (! $use_xetex) {
        my $is_external_graphic = $tex_fragment =~ m{\\includegraphics};

        $use_xetex = (! $is_external_graphic) && $tex_fragment !~ m{\.pstex_t};
    }

    my $tmp_dir = tempdir("texml-svg-XXXXXX",
                          DIR => $ENV{TMPDIR} || "/tmp",
                          CLEANUP => ! $self->is_debug())
        or do {
            die "temp directory error: $!\n";
    };

    my $cwd = getcwd();

    chdir($tmp_dir) or do {
        die "Can't connect to $tmp_dir: $!\n";
    };

    my $base = "tex2svg";

    my $tex_file = "$base.tex";

    open(my $fh, ">", $tex_file) or do {
        die "Can't open $tex_file\n";
    };

    # Avoid loading the amsfonts package to keep from using up math
    # symbol fonts that we might need later for the stix2 package.

    if (! $use_xetex) {
        print { $fh } qq{\\RequirePackage{stix2}\n\n};
    }

    if (nonempty(my $docclass = $self->get_docclass())) {
        print { $fh } qq{\\PassOptionsToClass{noamsfonts}{$docclass}\n\n};
    }

    my $preamble = $self->get_preamble();

    # if ($is_external_graphic) {
        print { $fh } qq{\\newdimen\\TeXMLrealhsize\n\n};

        $preamble =~ s{\\hsize\b}{\\TeXMLrealhsize}g;
        $preamble =~ s{\\textwidth\b}{\\TeXMLrealhsize}g;
        $preamble =~ s{\\linewidth\b}{\\TeXMLrealhsize}g;
    # }

    print { $fh } $preamble;

    if ($use_xetex) {
        print { $fh } qq{\\usepackage{unicode-math}\n};
        print { $fh } qq{\\setmainfont{STIX Two Text}[Ligatures=TeX,Script=Default]\n};
        print { $fh } qq{\\setmathfont{STIX Two Math}\n};
        print { $fh } qq{\\let\\bm\\mathbfit\n};
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
        print { $fh } qq{\\paperheight\\paperwidth\n};
        print { $fh } qq{\\special{papersize=\\the\\paperwidth,\\the\\paperheight}\n};
    # }

    print { $fh } qq{\\usepackage{fullpage}\n\n};

    print { $fh } qq{\\begin{document}\n\n};

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

    my @texinputs = (".", $self->get_texinputs(), "");

    local $ENV{TEXINPUTS} = join(":", @texinputs);

    my $svg_file = eval {
        $self->generate_svg($tex_file, $tex_fragment, $id, $use_xetex);
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
