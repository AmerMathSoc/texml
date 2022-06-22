package TeX::Interpreter::LaTeX::Package::amsrefs;

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

use TeX::Utils::Misc qw(nonempty trim);

use TeX::Constants qw(EXPANDED);

use TeX::Command::Executable::Assignment qw(MODIFIER_GLOBAL);

use TeX::Token qw(:catcodes);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro('set@page@range' => \&do_set_page_range);

    $tex->define_pseudo_macro('ModifyBibLabel' => \&do_modify_bib_label);

    return;
}

sub do_set_page_range {
    my $macro = shift;

    my $tex   = shift;
    my $token = shift;

    my $pages = trim($tex->read_undelimited_parameter(EXPANDED));

    my ($fpage, $lpage) = split qr{(?:-|\s|\\ndash)+}, $pages;

    my $tex_text;

    if (nonempty($fpage)) {
        $tex_text .= qq{\\startXMLelement{fpage}$fpage\\endXMLelement{fpage}};
    }

    if (nonempty($lpage)) {
        $tex_text .= qq{\\startXMLelement{lpage}$lpage\\endXMLelement{lpage}};
    }

    return $tex->tokenize($tex_text);
}

sub do_modify_bib_label {
    my $macro = shift;

    my $tex   = shift;
    my $token = shift;

    my $bibkey = trim($tex->read_undelimited_parameter(EXPANDED));

    my $handle = $tex->get_output_handle();

    my $dom = $handle->get_dom();

    my @ref_nodes = $dom->findnodes(qq{descendant::ref[attribute::id="bibr-$bibkey"]});

    if (@ref_nodes == 0) {
        $tex->print_err("Couldn't find a <ref> node for '$bibkey'");

        $tex->error();

        return;
    } elsif (@ref_nodes > 1) {
        $tex->print_err("Found too many <ref> nodes for '$bibkey'");

        $tex->error();

        return;
    }

    my $ref_node = $ref_nodes[0];

    my @label_nodes = $ref_node->getChildrenByTagName('label');
    
    if (@label_nodes == 0) {
        $tex->print_err("Couldn't find a <label> node for '$bibkey'");
    
        $tex->error();
    
        return;
    } elsif (@label_nodes > 1) {
        $tex->print_err("Found too many <label> nodes for '$bibkey'");
    
        $tex->error();
    
        return;
    }

    my $label_node = $label_nodes[0];

    (my $old_label = $label_node->firstChild()) =~ s{^\[(\S+?)\]$}{$1};

    $tex->begingroup();
    $tex->set_catcode(ord('@'), CATCODE_LETTER);
    my $suffix = $tex->convert_fragment(q{\@suffix@format1});
    $tex->endgroup();

    my $new_label = $old_label . $suffix;

    $label_node->removeChild($label_node->firstChild());

    ## TODO: Assumes standard \BibLabel formatting
    $label_node->appendText(qq{[$new_label]});

    my $b = qq{b\@$bibkey};

    my $citesel = $tex->get_macro_expansion_text($b);

    $citesel =~ s{\{$old_label\}}{\{$new_label\}};

    $tex->define_simple_macro($b, $citesel, MODIFIER_GLOBAL);

    return;
}

1;

__DATA__

\ProvidesPackage{amsrefs}

\PassOptionsToPackage{msc-links}{amsrefs}

\LoadRawMacros

\@ifpackagewith{amsrefs}{non-sorted-cites}{%
    \typeout{*** Turning off cite-group sorting}%
    \TeXMLnoSortCites
}{%
    \TeXMLsortCites
}

\AtBeginDocument{%
    \let\PrintBackRefs\@gobble
    \let\BackCite\@gobble
}

\RequirePackage{hyperref}

\def\calc@alpha@suffix{%
    \@tempswafalse
    \compare@stems\previous@stem\current@stem
    \ifsame@stems
        \ifx\previous@year\current@year
            \@tempswatrue
        \fi
    \else
        \begingroup
            \let\name\@firstofone
            \@apply\auto@stringify\amsrefs@textsymbols
            \@apply\auto@stringify\amsrefs@textaccents
            \@ifundefined{amsrefs@stem@\current@stem}{%
                \expandafter\gdef\csname amsrefs@stem@\current@stem\endcsname{}%
            }{%
                \DuplicateBibLabelWarning
            }%
        \endgroup
    \fi
    \if@tempswa
        \global\advance\alpha@suffix\@ne
        \edef\alpha@label@suffix{\@suffix@format\alpha@suffix}%
        \ifnum\alpha@suffix=\tw@
            \double@expand{%
                \noexpand\AtEndDocument{%
                    \noexpand\ModifyBibLabel{\prev@citekey}%
                }%
            }%
        \fi
    \else
        \let\alpha@label@suffix\@empty
        \global\alpha@suffix\@ne
        \@xp\ifx \csname b@\current@citekey @suffix\endcsname \relax
        \else
            \edef\alpha@label@suffix{\@suffix@format\alpha@suffix}%
        \fi
    \fi
}

\def\cite@nobib@test#1#2#3#4#5\@nil#6{%
    \@ifempty{#4}{%
        % \G@refundefinedtrue
        % \UndefinedCiteWarning#6%
        \xdef#6{\@nx\citesel #2#3{%
            \@nx\CitePrintUndefined{\extr@cite#6}}{}{}}%
    }{}%
}

\let\UndefinedCiteWarning\@gobble

\let\cite@compress\cite@print
% \let\process@citelist\process@citelist@unsorted

%% The next three definitions duplicate those in
%% TeX::Interpreter::FMT::latex but are necessary to override the
%% definitions in amsrefs.sty

\def\citeleft{%
    \startXMLelement{cite-group}%
    \XMLgeneratedText[%
}

\def\citeright{%
    \XMLgeneratedText]%
    \endXMLelement{cite-group}%
}

\def\citemid{\XMLgeneratedText{,\space}}

\def\citepunct{\XMLgeneratedText{,\space}}

\def\citeAltPunct{\XMLgeneratedText{;\space}}

% Sidestep an obscure bug in my implementation of conditionals:
\let\bib@selectlanguage\@empty

\let\save@labelwidth\@empty

%% As with \ModifyBibLabel, it's easier if we don't write \bibcite to
%% the .aux file.

\def\amsrefs@lbibitem[#1]#2{%
    \begingroup
        \def\CurrentBib{#2}%
        \def\thebib{#1}%
        \@nmbrlistfalse
        \item\leavevmode
        \amsrefs@bibcite{#2}{{#1}{}}%
    \endgroup
    \ignorespaces
}

\def\amsrefs@bibitem#1{%
    \def\CurrentBib{#1}%
    \item
    \double@expand{%
        \noexpand\amsrefs@bibcite{#1}{{\the\value{\@listctr}}{}}%
    }%
    \ignorespaces
}

\def\citesel@write#1#2#3#4#5{%
    % \toks@{{#3}{#4}}%
    % \immediate\write\@auxout{\string\bibcite{\CurrentBib}{\the\toks@}}%
}

\renewcommand\@biblist[1][]{%
    \if@backmatter
        \@clear@sectionstack
    \else
        \backmatter
    \fi
    \stepcounter{bib@env}
    \biblistfont
    \let\@bibitem\amsrefs@bibitem
    \let\@lbibitem\amsrefs@lbibitem
    \def\@listelementname{ref-list}%
    \def\@listitemname{ref}%
    % \def\@listlabelname{label}%
    \let\@listlabelname\@empty
    \def\@listdefname{mixed-citation}
    \let\TeXML@setliststyle\@empty
    \typeout{Entering biblist}%
    \list{\BibLabel}{%
        % \def\@listconfig{\addXMLclass{thebibliography}}%
        \@listXMLidtrue
        \@nmbrlisttrue
        \def\@listctr{bib}%
        % \let\makelabel\bib@mklab
        #1\relax
    }%
    \par
    \startXMLelement{title}%
    \refname
    \ifx\chaptername\appendixname
        \addcontentsline{toc}{chapter}{\protect\tocappendix{}{}{\refname}{\@currentXMLid}}%
    \else
        \addcontentsline{toc}{chapter}{\protect\tocchapter{}{}{\refname}{\@currentXMLid}}%
    \fi
    \endXMLelement{title}%
    \let\@listpartag\@empty
    \@ifstar{\@biblistsetup}{}%
}

\renewenvironment{bibsection}[1][\refname]{%
    % \backmatter
    \protected@edef\refname{#1}%
}{}

\renewenvironment{bibchapter}[1][\bibname]{%
    % \backmatter
    \protected@edef\refname{#1}%
}{}

\let\current@raw@bib\@empty

\gdef\raw@bbl@write#1{%
    \begingroup
        \edef\@tempa{#1}%
        \expandafter\vdef\expandafter\@tempa\expandafter{\@tempa}%
        \@tempa\UnicodeLineFeed
    \endgroup
}

% \bib => \BibItem
%      => \@bibdef==\normal@bibdef
%      => \bib@exec==\bib@print
%      => \bib@cite
%      => \item (<ref>)
%      => \BibLabel (<label>...</label>)

\def\BibItem#1#2#3{%
    \typeout{Processing \string\bib{#1}{#2}}%
    \gdef\current@raw@bib{\bib{#1}{#2}{#3}}%
    \vdef\@tempa{#1}%
    \edef\@tempa{%
        \edef\@nx\@tempa{\@nx\@xp\@nx\zap@space\@tempa\space\@nx\@empty}%
    }%
    \@tempa
    \edef\@tempb{%
        \@nx\@bibdef\@xp\@nx\csname setbib@#2\endcsname{#2}{\@tempa}%
    }%
    \@tempb{#3}%
}

\def\BibLabel{%
    \setXMLattribute{id}{bibr-\CurrentBib}%
%%
%% If the formatting of the label changes, it should also change in
%% do_modify_bib_label().
%%
    \startXMLelement{label}[\thebib]\endXMLelement{label}%
    \ifx\current@raw@bib\@empty\else
        \begingroup
            \suppressligatures=1
            \let\@bibdef\copy@bibdef
            \let\bbl@write\raw@bbl@write
            \startXMLelement{raw-citation}%
            \setXMLattribute{type}{amsrefs}%
            \current@raw@bib
            \endXMLelement{raw-citation}%
        \endgroup
        \global\let\current@raw@bib\@empty
    \fi
}

\def\copy@bibdef@a#1#2#3#4{%
    \@open@bbl@file
    \process@xrefs{#4}%
    \bbl@write{%
        \string\bib\if@tempswa*\fi{#3}{#2}\string{\iffalse}\fi
    }%
    \RestrictedSetKeys{\global\let\rsk@set\bbl@copy}\@empty
        {\bbl@write{\iffalse{\fi\string}}%
         \endgroup}{#4}%
}

\def\parse@MR#1 (#2)#3\@nil{%
    \def\MR@url{https://www.ams.org/mathscinet-getitem?mr=#1}%
    \def\@tempd{#1}%
    \def\@tempe{#2}%
}%

\def\MRhref#1#2{%
    \begingroup
        \parse@MR#1 ()\@empty\@nil%
        \href{\MR@url}{%
            \@tempd
            \ifx\@tempe\@empty
            \else
                \ (\@tempe)%
            \fi
        }%
    \endgroup
}

% \def\ar@hyperlink{\format@cite}
% 
% \def\format@cite#1{%
%     \startXMLelement{xref}%
%     \setXMLattribute{rid}{\strip@cite@prefix#1}%
%     \setXMLattribute{ref-type}{bibr}%
%     #1%
%     \endXMLelement{xref}%
% }

\def\format@jats@cite#1#2{%
    \startXMLelement{xref}%
    \setXMLattribute{rid}{bibr-\strip@cite@prefix#1}%
    \setXMLattribute{ref-type}{bibr}%
    \setXMLattribute{specific-use}{cite}%
    #1%
    \@ifnotempty{#2}{\citemid#2}%
    \endXMLelement{xref}%
}

\DeclareRobustCommand{\CitePrintUndefined}[1]{%
    \if@TeXMLend\else
        \setXMLattribute{specific-use}{unresolved cite}%
    \fi
    \texttt{?#1}%
}

\def\cite@cj#1#2{%
        \leavevmode
            \begingroup
                \cite@cb#1% write info to aux file
                \ar@SK@cite#1%
                \@citeleft
                \format@jats@cite{#1}{#2}%
                \citeright
            \endgroup
            \ignorespaces % ignore spaces inside \citelist
        \cite@endgroup
}

\def\strip@cite@prefix#1{%
    \expandafter\@gobblethree\string#1%
}

\providecommand{\DOIURLPrefix}{https://doi.org/}

\renewcommand{\PrintDOI}[1]{%
    DOI \href{\DOIURLPrefix#1}{#1}%
}

\catcode`\'=11

\def\PrintConferenceDetails@{%
    \ifnum\lastkern=\@ne\else\space\fi(%
    \ifx\@empty\bib'address
    \else
        \bib'address
    \fi
    \ifx\@empty\bib'date
    \else
        \SwapBreak{,}\space
        \print@date
    \fi
    )%\spacefactor\sfcode`\,%
}

\catcode`\'=12

\def\parse@arXiv#1 [#2]#3\@nnil{%
    \def\arXiv@number{#1}%
    \def\arXiv@category{#2}%
    \def\arXiv@url{https://arxiv.org/abs/#1}%
}

\providecommand{\arXiv}[1]{%
    \begingroup
        \parse@arXiv#1 []\@nil\@nnil
        \href{\arXiv@url}{%
            \texttt{arXiv:\arXiv@number
                \ifx\arXiv@category\@empty\else
                    \space[\arXiv@category]%
                \fi
            }%
        }%
    \endgroup
}

\endinput

\let\current@person@type\@empty

\catcode`\'=11

\renewcommand{\PrintAuthors}[1]{%
    \ifx\previous@primary\current@primary
        \sameauthors\@empty
    \else
        \def\current@bibfield{\bib'author}%
        \def\current@person@type{author}%
        \PrintNames{}{}{#1}%
    \fi
}

\catcode`\'=12

\BibSpec{nameLE}{
    +{}{\startXMLelement{person-group}}{transition}
    +{}{\setXMLattribute{person-group-type}{\current@person@type}}{transition}
    +{}{\startXMLelement{name}}{transition}
    +{}{\XMLelement{surname}}{surname}
    +{}{\XMLelement{given-names}}{given}
    +{}{\XMLelement{suffix}}{jr}
    +{}{\endXMLelement{name}}{transition}
    +{}{\endXMLelement{person-group}}{transition}
}

\BibSpec{nameBE}{
    +{}{\startXMLelement{person-group}}{transition}
    +{}{\setXMLattribute{person-group-type}{\current@person@type}}{transition}
    +{}{\startXMLelement{name}}{transition}
    +{}{\setXMLattribute{name-style}{eastern}}{transition}
    +{}{\XMLelement{surname}}{surname}
    +{}{\XMLelement{given-names}}{given}
    +{}{\XMLelement{suffix}}{jr}
    +{}{\endXMLelement{name}}{transition}
    +{}{\endXMLelement{person-group}}{transition}
}

\BibSpec{nameinverted}{
    +{}{\startXMLelement{person-group}}{transition}
    +{}{\setXMLattribute{person-group-type}{\current@person@type}}{transition}
    +{}{\startXMLelement{name}}{transition}
    +{}{\XMLelement{surname}}{surname}
    +{}{\XMLelement{given-names}}{given}
    +{}{\XMLelement{suffix}}{jr}
    +{}{\endXMLelement{name}}{transition}
    +{}{\endXMLelement{person-group}}{transition}
}

\BibSpec{article}{%
    +{} {\PrintAuthors}               {author}
    +{} {\PrintDate}                  {date}
    +{} {\XMLelement{article-title}}  {title}
    +{} { }                            {part}
    +{} { \textit}                     {subtitle}
    +{} { \parenthesize}               {language}
    +{} { \PrintContributions}         {contribution}
    +{} { \PrintPartials}              {partial}
    +{} {\XMLelement{source}}          {journal}
    +{} {\XMLelement{volume}}          {volume}
    +{} {\XMLelement{issue}}           {number}
    +{} {\set@page@range}              {pages}
    +{} { }                            {status}
    +{} { \PrintDOI}                   {doi}
    +{} { available at \eprint}        {eprint}
    +{} { \PrintTranslation}           {translation}
    +{} { \PrintReprint}               {reprint}
    +{} { }                            {note}
    +{} {}                             {transition}
    +{} {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \XMLelement{source}}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{}  { \parenthesize}               {language}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext\XMLelement{volume}}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\endinput

__END__
