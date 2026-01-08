package TeX::Interpreter::LaTeX::Package::natbib;

use v5.26.0;

# Copyright (C) 2022, 2025, 2026 American Mathematical Society
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

use TeX::Utils::Misc qw(nonempty);

my sub do_resolve_natbib;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&do_resolve_natbib, 1);

    $tex->read_package_data();

    return;
}

sub do_resolve_natbib {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my @refs = $body->findnodes(qq{descendant::natbibref});

    my $num_refs = @refs;

    return if $num_refs == 0;

    my $s = $num_refs == 1 ? "" : "'s";

    $tex->print_nl("Resolving $num_refs natbib \\cite$s");

    if ($num_refs > 256) { # arbitrary cutoff
        $tex->print_nl("(Oh my.  That's a lot.  You might want to make yourself a cup of tea.)\n");
    }

    $tex->begingroup();

    $tex->let_csname('texml@exec@natbib' => 'texml@exec@natbib@resolve');

    for my $ref (@refs) {
        (undef, my $ref_cmd, my $star) = split / /, $ref->getAttribute('specific-use');

        my $tex_cmd = qq{\\${ref_cmd}};

        if (nonempty($star)) {
            $tex_cmd .= '*';
        }

        my $pre  = $ref->getAttribute('pretext');
        my $post = $ref->getAttribute('posttext');

        if (nonempty($post) || nonempty($pre)) {
            $tex_cmd .= '[' . ($post || '') . ']';
        }

        if (nonempty($pre)) {
            $tex_cmd .= '[' . ($pre) . ']';
        }

        my $ref_key = $ref->getAttribute('ref-key');

        $tex_cmd .= qq{{$ref_key}};

        my $new_node = $tex->convert_fragment($tex_cmd);

        $ref->replaceNode($new_node);
    }

    $tex->endgroup();

    return;
}

1;

__DATA__

\ProvidesPackage{natbib}

\let\@listi\@empty

\LoadRawMacros

\@ifpackagewith{natbib}{angle}{%
    \renewcommand\NAT@open{\textlangle}%
    \renewcommand\NAT@close{\textrangle}%
}{}

%% TODO: This assumes maabook has been loaded.  FIX THIS

\AtBeginDocument{\let\MAA@NAT@wrap\XMLgeneratedText}

\def\NAT@@open{\ifNAT@par\XMLgeneratedText\NAT@open\fi}

\def\NAT@@close{\ifNAT@par\XMLgeneratedText\NAT@close\fi}

\def\NAT@separator{\XMLgeneratedText\NAT@sep}%

%% \setcitestyle and \bibpunct

%% As currently implemented, if there are multiple conflicting uses of
%% \bibpunct or \setcitestyle (directly or indirectly through
%% \citestyle), the last one wins.  This is because the values of the
%% various parameters aren't typically used until do_resolve_natbib()
%% is run at the end of the compilation phase.
%%
%% To allow cite style to be modified on the fly, we would have to
%% capture the values of each of these parameters in the <natbibref>
%% element and then restore them in do_resolve_natbib().  It should be
%% straightforward, but I'm going to defer it until we have an actual
%% use case, since this seems pretty unlikely to me.

\renewcommand\bibpunct[7][, ]{%
    \gdef\NAT@open{#2}%
    \gdef\NAT@close{#3}%
    \gdef\NAT@sep{#4}%
    \global\NAT@numbersfalse
    \ifx #5n%
        \global\NAT@numberstrue
        \global\NAT@superfalse
    \else
        \ifx #5s%
            \global\NAT@numberstrue
            \global\NAT@supertrue
    \fi\fi
    %%
    %% Add \XMLgeneratedText around these.
    %%
    \gdef\NAT@aysep{\XMLgeneratedText{#6}}%
    \gdef\NAT@yrsep{\XMLgeneratedText{#7}}%
    \gdef\NAT@cmt{\XMLgeneratedText{#1}}%
    \NAT@@setcites
}

\def\setcitestyle#1{%
    \@for\@tempa:=#1\do{%
        \def\@tempb{round}\ifx\@tempa\@tempb
            \renewcommand\NAT@open{(}%
            \renewcommand\NAT@close{)}%
        \fi
        \def\@tempb{square}\ifx\@tempa\@tempb
            \renewcommand\NAT@open{[}%
            \renewcommand\NAT@close{]}%
        \fi
        \def\@tempb{angle}\ifx\@tempa\@tempb
            %%
            %% Replace $<$ and $>$
            %%
            \renewcommand\NAT@open{\textlangle}%
            \renewcommand\NAT@close{\textrangle}%
        \fi
        \def\@tempb{curly}\ifx\@tempa\@tempb
            \renewcommand\NAT@open{\{}%
            \renewcommand\NAT@close{\}}%
        \fi
        \def\@tempb{semicolon}\ifx\@tempa\@tempb
            \renewcommand\NAT@sep{;}%
        \fi
        \def\@tempb{colon}\ifx\@tempa\@tempb
            \renewcommand\NAT@sep{;}%
        \fi
        \def\@tempb{comma}\ifx\@tempa\@tempb
            \renewcommand\NAT@sep{,}%
        \fi
        \def\@tempb{authoryear}\ifx\@tempa\@tempb
            \NAT@numbersfalse
        \fi
        \def\@tempb{numbers}\ifx\@tempa\@tempb
            \NAT@numberstrue
            \NAT@superfalse
        \fi
        \def\@tempb{super}\ifx\@tempa\@tempb
            \NAT@numberstrue
            \NAT@supertrue
        \fi
        \expandafter\NAT@find@eq\@tempa=\relax\@nil
        \if\@tempc\relax\else
            \expandafter\NAT@rem@eq\@tempc
            \def\@tempb{open}\ifx\@tempa\@tempb
                \xdef\NAT@open{\@tempc}%
            \fi
            \def\@tempb{close}\ifx\@tempa\@tempb
                \xdef\NAT@close{\@tempc}%
            \fi
            %%
            %% Add \XMLgeneratedText around these.
            %%
            \def\@tempb{aysep}\ifx\@tempa\@tempb
                \xdef\NAT@aysep{\noexpand\XMLgeneratedText{\@tempc}}%
            \fi
            \def\@tempb{yysep}\ifx\@tempa\@tempb
                \xdef\NAT@yrsep{\noexpand\XMLgeneratedText{\@tempc}}%
            \fi
            \def\@tempb{notesep}\ifx\@tempa\@tempb
                \xdef\NAT@cmt{\noexpand\XMLgeneratedText{\@tempc}}%
            \fi
            \def\@tempb{citesep}\ifx\@tempa\@tempb
                \xdef\NAT@sep{\@tempc}%
            \fi
        \fi
    }%
    \NAT@@setcites
}

\def\NAT@aysep{\XMLgeneratedText,}%
\def\NAT@yrsep{\XMLgeneratedText,}%
\def\NAT@cmt{\XMLgeneratedText, }

\def\hyper@natlinkstart#1{%
    \startXMLelement{xref}%
    \setXMLattribute{rid}{bibr-#1}%
    \setXMLattribute{ref-type}{bibr}%
}

\def\hyper@natlinkend{%
    \endXMLelement{xref}%
}

\def\hyper@natlinkbreak#1#2{#1}

\providecommand\hyper@natanchorstart[1]{}%
\providecommand\hyper@natanchorend{}%

\def\NAT@anchor#1#2{%
    \setXMLattribute{id}{bibr-#1}%
    \hyper@natanchorstart{#1\@extra@b@citeb}%
        \def\@tempa{#2}%
        \@ifx{\@tempa\@empty}{}{\@biblabel{#2}}%
    \hyper@natanchorend
}%

\def\texml@shadow@natbib#1{%
    \expandafter\let\csname natbib::#1\expandafter\endcsname\csname#1\endcsname
    \@namedef{#1}{\texml@exec@natbib{#1}}%
}

\def\texml@exec@natbib@resolve#1{\@nameuse{natbib::#1}}

\def\texml@exec@natbib#1{%
    \maybe@st@rred{\texml@exec@natbib@{#1}}%
}

\def\texml@exec@natbib@#1{%
    \new@ifnextchar[{\texml@exec@natbib@@{#1}}{\texml@exec@natbib@@{#1}[]}%
}

\def\texml@exec@natbib@@#1[#2]{%
    \new@ifnextchar[{\texml@exec@natbib@@@{#1}{#2}}{\texml@exec@natbib@@@{#1}{#2}[]}%
}

%% #1 = cite cmd
%% #2 = post text
%% #3 = pre text
%% #4 = cite key(s)

\def\texml@exec@natbib@@@#1#2[#3]#4{%
    \leavevmode
    \startXMLelement{natbibref}%
        \setXMLattribute{specific-use}{unresolved #1\ifst@rred\space*\fi}%
        \setXMLattribute{ref-key}{#4}%
        \if##2##\else
            \setXMLattribute{posttext}{\detokenize{#2}}%
        \fi
        \if###3##\else
            \setXMLattribute{pretext}{\detokenize{#3}}%
        \fi
    \endXMLelement{natbibref}%
}

\texml@shadow@natbib{Citealp}
\texml@shadow@natbib{Citealt}
\texml@shadow@natbib{Citeauthor}
\texml@shadow@natbib{Citep}
\texml@shadow@natbib{Citet}
\texml@shadow@natbib{cite}
\texml@shadow@natbib{citealp}
\texml@shadow@natbib{citealt}
\texml@shadow@natbib{citeauthor}
\texml@shadow@natbib{citenum}
\texml@shadow@natbib{citep}
\texml@shadow@natbib{citet}
\texml@shadow@natbib{citeyear}
\texml@shadow@natbib{citeyearpar}

\begingroup
    \catcode`\:=11

    \glet\natbib::NAT@citex\NAT@citex

    \gdef\NAT@citex[#1][#2]#3{%
        \startXMLelement{cite-group}%
            \natbib::NAT@citex[#1][#2]{#3}%
        \endXMLelement{cite-group}%
    }

    \glet\natbib::NAT@citexnum\NAT@citexnum

    \gdef\NAT@citexnum[#1][#2]#3{%
        \startXMLelement{cite-group}%
            \natbib::NAT@citexnum[#1][#2]{#3}%
        \endXMLelement{cite-group}%
    }
\endgroup

\def\NAT@wrout#1#2#3#4#5{%
    \begingroup
        \let~\space
        \bibcite{#5}{{#1}{#2}{{#3}}{{#4}}}%
    \endgroup
    \ignorespaces
}

%% spec/plambeck chapter bibliographies.  This is probably not good
%% enough in general.

\@ifundefined{chapter}{%
    \def\biblist@sec@level{1}%
}{%
    \let\biblist@sec@level\texml@chapter@level
}%

\let\biblist@sec@level\texml@chapter@level

\renewenvironment{thebibliography}[1]{%
    % \if@backmatter
    %     \@clear@sectionstack
    % \else
    %     \backmatter
    % \fi
    %% I'm not sure what to do with \bibpreamble or if it should even be
    %% here to begin with, so I'm going to disable it for now.  Ditto
    %% \bibpostamble below.
    % \ifx\@empty\bibpreamble \else
    %     \begingroup
    %         \bibpreamble\par
    %     \endgroup
    % \fi
% \section*{}%
\@pop@sectionstack{\biblist@sec@level}%
    \def\@listelementname{ref-list}%
    \def\@listitemname{ref}%
    % \def\@listlabelname{label}
    \let\@listlabelname\@empty
    \def\@listdefname{mixed-citation}
    \list{\@biblabel{\the\c@NAT@ctr}}{%
        \@bibsetup{#1}%
        \global\c@NAT@ctr\z@
        \@listXMLidtrue
    }%
     \let\NAT@bibitem@first@sw\@firstoftwo
    \let\citeN\cite
    \let\shortcite\cite
    \let\citeasnoun\cite
    \let\@listpartag\@empty
    \XMLelement{title}{\refname}%
    \@ifundefined{chapter}{}{\@tocwriteb\tocchapter{chapter}{\bibname}}%
}{%
    \bibitem@fin
    %% See above
    % \bibpostamble
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

\endinput

__END__
