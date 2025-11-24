%% This is file `skrapport.cls', generated from `skrapport.tex' (key `class').
%% skrapport Skånings rapportklass
%%
%% Copyright (C) 2012-2016 by Simon Sigurdhsson <sigurdhsson@gmail.com>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Simon Sigurdhsson.
%%
%% This work consists of the file skrapport.tex and the derived files:
%%  * skrapport.cls
%%  * skrapport-colortheme-default.sty
%%  * skrapport-colortheme-unscathed.sty
%%  * skrapport-colortheme-violet.sty
%%  * skrapport-colortheme-cruelwater.sty
%%  * skrapport-colortheme-skdoc.sty
%%  * skrapport-size-common.sty
%%  * skrapport-size10pt.clo
%%  * skrapport-size11pt.clo
%%  * skrapport-size12pt.clo

\RequirePackage{expl3,l3keys2e,xparse,xstring,etoolbox}
\ProvidesExplClass{skrapport}%
    {2016/06/25}{0.12f}{stylish report document class}
\msg_new:nnnn{skrapport}{option-deprecated}{Option~`#1'~deprecated!}
    {Please~use~`#2'~instead.}
\msg_new:nnnn{skrapport}{option-no-effect}{Option~`#1'~deprecated!}
    {It~has~no~effect;~simply~use~nothing~instead.}
\msg_new:nnnn{skrapport}{invalid-paper-size}{Invalid~paper~size~`#1'!}
    {\token_to_str:N\__skrapport_setup_paper:n~was~invoked~with~an~
     invalid~argument;~paper~size~will~remain~unchanged.}
\msg_new:nnnn{skrapport}{invalid-point-size}{Invalid~point~size~`#1'!}
    {\token_to_str:N\__skrapport_setup_ptsize:n~was~invoked~with~an~
     invalid~argument;~cannot~continue~without~setting~a~valid~point~
     size.~Please~fix~the~issue~before~typesetting~again.}
\msg_new:nnnn{skrapport}{invalid-titles}{Invalid~title~type~`#1'!}
    {\token_to_str:N\__skrapport_setup_titles:n~was~invoked~with~an~
     invalid~argument;~falling~back~to~`#2'.}
\msg_new:nnnn{skrapport}{invalid-lang}{Invalid~language~`#1'!}
    {\token_to_str:N\__skrapport_setup_lang:n~was~invoked~with~an~
     invalid~argument;~`babel'~and/or~`polyglossia'~will~remain~
    unloaded.}
\msg_new:nnnn{skrapport}{invalid-font}{Invalid~font~`#1'!}
    {\token_to_str:N\__skrapport_setup_font:n~was~invoked~with~an~
     invalid~argument;~no~font~package~has~been~loaded.~This~may~result~
     in~bad~rendering~due~to~old~Computer~Modern~fonts.}
\msg_new:nnnn{skrapport}{noop-call}{No-op~invokation~of~macro!}
    {\token_to_str:N#1~was~invoked,~but~circumstances~dictate~that~the~
    macro~should~do~nothing.~Will~do~\token_to_str:N\prg_do_nothing:~
    instead.}
\msg_new:nnnn{skrapport}{old-font-deprecated}{Deprecated~macro~\token_to_str:N#1!}
    {The~old~font~macro~\token_to_str:N#1~is~deprecated!~Use~
    \token_to_str:N#2~instead.}
\msg_new:nnnn{skrapport}{color-patch-failed}{Could~not~patch~macro~\token_to_str:N#1!}
    {The~macro~\token_to_str:N#1~could~not~be~patched!~Color~theme~
    support~may~be~incomplete.}
\msg_new:nnnn{skrapport}{license-not-printed}{Detected~\token_to_str:N\license\ but~no~`titlepage'!}
    {The~text~provided~by~\token_to_str:N\license\ is~only~printed~when~
    the~`titlepage'~environment~is~used,~but~it~seems~to~be~missing.}
\msg_new:nnnn{skrapport}{font-requires-xetex}{The~`font=#1'~option~requires~XeTeX~or~luaTeX!}
    {Please~choose~another~font~setup~or~compile~the~document~with~
    either~xelatex~or~lualatex.}
\msg_new:nnnn{skrapport}{tocdepth-too-deep}{TOC~depth~is~too~deep!}
    {The~current~tocdepth,~#1,~is~not~supported.~Please~redefine~the~
    \token_to_str:N#2~macro~to~enable~support.}
\msg_new:nnnn{skrapport}{caption-in-figcenter}{Cannot~use~\token_to_str:N\caption\ here!}
    {The~\token_to_str:N\caption\ macro~can't~be~used~inside~figcenter~environments!~Please~move~the~caption~to~the~enclosing~float~environment.}
\msg_new:nnn{skrapport}{not-implemented}
    {Unimplemented~macro~\token_to_str:N#1!}
\bool_new:N\g__skrapport_draft_bool
\bool_new:N\g__skrapport_color_bool
\bool_new:N\g__skrapport_has_polyglossia_bool
\int_new:N\g__skrapport_grid_lines_int
\cs_new:Npn\__skrapport_setup_paper:n#1{
    \str_case:nnF{#1}{
        {a4}{
            \PassOptionsToPackage{paper=A4}{typearea}
            \int_gset:Nn\g__skrapport_grid_lines_int{40}
        }
        {a5}{
            \PassOptionsToPackage{paper=A5}{typearea}
            \int_gset:Nn\g__skrapport_grid_lines_int{28}
        }
    }{
        \msg_warning:nnn{skrapport}{invalid-paper-size}{#1}
    }
    \AtEndOfClass{\RequirePackage[DIV=calc]{typearea}}
    \AtBeginDocument{\recalctypearea}
}
\cs_new:Npn\__skrapport_setup_ptsize:n#1{
    \str_case:nnF{#1}{
        {10pt}{\int_const:Nn\c__skrapport_ptsize_int{0}}
        {11pt}{\int_const:Nn\c__skrapport_ptsize_int{1}}
        {12pt}{\int_const:Nn\c__skrapport_ptsize_int{2}}
    }{
        \msg_critical:nnn{skrapport}{invalid-point-size}{#1}
    }
    \file_input:n{skrapport-size#1.clo}
}
\cs_new:Nn\__skrapport_setup_twocolumn:{
    \RequirePackage{etoolbox}
    \AtBeginDocument{
        \KOMAoptions{twocolumn=false,DIV=12}
    }
    \int_set:Nn\l_tmpa_int{10+\c__skrapport_ptsize_int}
    \int_set:Nn\l_tmpb_int{12*\l_tmpa_int/10}
    \RequirePackage[fontsize=\l_tmpa_int pt,
                    baseline=\l_tmpb_int pt,
                    lines=\g__skrapport_grid_lines_int]{grid}
    \cs_set_eq:Nc\__skrapport_onecol_abstract:{environment~abstract~code}
    \cs_set_eq:Nc\__skrapport_end_onecol_abstract:{environment~abstract~end~aux~}
    \pretocmd{\__skrapport_onecol_abstract:}{\null}{}{}
    \RenewDocumentEnvironment{abstract}{}{\section*{\abstractname}}{}
    \AfterEndPreamble{\begin{multicols}{2}}
    \AtEndDocument{\end{multicols}}
    \cs_set_eq:NN\__skrapport_onecol_maketitle:\maketitle
    \pretocmd{\maketitle}{\begin{onecol}}{}{}
    \apptocmd{\maketitle}{\end{onecol}}{}{}
    \BeforeBeginEnvironment{titlepage}{
        \begin{onecol}
        \cs_set_eq:cN{environment~abstract~code}\__skrapport_onecol_abstract:
        \cs_set_eq:cN{environment~abstract~end~aux~}\__skrapport_end_onecol_abstract:
        \cs_set_eq:NN\maketitle\__skrapport_onecol_maketitle:
    }
    \AfterEndEnvironment{titlepage}{\end{onecol}}
    \BeforeBeginEnvironment{equation}{\begin{gridenv}}
    \AfterEndEnvironment{equation}{\end{gridenv}}
    \BeforeBeginEnvironment{equation*}{\begin{gridenv}}
    \AfterEndEnvironment{equation*}{\end{gridenv}}
    \BeforeBeginEnvironment{multline}{\begin{gridenv}}
    \AfterEndEnvironment{multline}{\end{gridenv}}
    \BeforeBeginEnvironment{multline*}{\begin{gridenv}}
    \AfterEndEnvironment{multline*}{\end{gridenv}}
    \BeforeBeginEnvironment{gather}{\begin{gridenv}}
    \AfterEndEnvironment{gather}{\end{gridenv}}
    \BeforeBeginEnvironment{gather*}{\begin{gridenv}}
    \AfterEndEnvironment{gather*}{\end{gridenv}}
    \BeforeBeginEnvironment{align}{\begin{gridenv}}
    \AfterEndEnvironment{align}{\end{gridenv}}
    \BeforeBeginEnvironment{align*}{\begin{gridenv}}
    \AfterEndEnvironment{align*}{\end{gridenv}}
    \BeforeBeginEnvironment{flalign}{\begin{gridenv}}
    \AfterEndEnvironment{flalign}{\end{gridenv}}
    \BeforeBeginEnvironment{flalign*}{\begin{gridenv}}
    \AfterEndEnvironment{flalign*}{\end{gridenv}}
    \BeforeBeginEnvironment{alignat}{\begin{gridenv}}
    \AfterEndEnvironment{alignat}{\end{gridenv}}
    \BeforeBeginEnvironment{alignat*}{\begin{gridenv}}
    \AfterEndEnvironment{alignat*}{\end{gridenv}}
    \skip_gset:Nn\c__skrapport_section_pre_skip{-.999\baselineskip}
    \skip_gset:Nn\c__skrapport_section_post_skip{0.001\baselineskip}
    \dim_gset:Nn \c__skrapport_section_indent_dim{\c_zero_dim}
    \cs_set_protected:Nn\__skrapport_section_style:
        {\normalfont\__skrapport_title_style:}
    \DeclareDocumentCommand\section{som}{
        \__skrapport_generic_section:nnnnn{section}{1}{##1}{##2}{##3}
    }
    \skip_gset:Nn\c__skrapport_subsection_pre_skip{\baselineskip}
    \skip_gset:Nn\c__skrapport_subsection_post_skip{-.35\baselineskip}
    \dim_gset:Nn \c__skrapport_subsection_indent_dim{\c_zero_dim}
    \cs_set_protected:Nn\__skrapport_subsection_style:
        {\normalfont\__skrapport_title_style:\unskip}
    \DeclareDocumentCommand\subsection{som}{
        \__skrapport_generic_section:nnnnn{subsection}{2}{##1}{##2}{##3}
    }
    \skip_gset:Nn\c__skrapport_subsubsection_pre_skip{\baselineskip}
    \skip_gset:Nn\c__skrapport_subsubsection_post_skip{-.35\baselineskip}
    \dim_gset:Nn \c__skrapport_subsubsection_indent_dim{\c_zero_dim}
    \cs_set_protected:Nn\__skrapport_subsubsection_style:
        {\normalfont\itshape\__skrapport_title_style:\unskip}
    \DeclareDocumentCommand\subsubsection{som}{
        \__skrapport_generic_section:nnnnn{subsubsection}{3}{##1}{##2}{##3}
    }
    \DeclareDocumentCommand\l@section{mm}{
        \group_begin:
            \skip_vertical:n{.75ex}
            \__skrapport_title_style:
            \__skrapport_toc_line:nnnnn{1}{0em}{1.3em}{##1}{
                \__skrapport_title_style: ##2
            }
        \group_end:
    }
    \cs_new:Npn\__skrapport_xdblfloat:nn##1##2{\@xdblfloat{##1}[##2]}
    \cs_generate_variant:Nn\__skrapport_xdblfloat:nn{nx}
    \RenewDocumentEnvironment{figure}{o}{
        \begin{gridenv}
            \vspace{\intextsep}
            \begin{minipage}{\linewidth}
                \cs_set:Npn\@captype{figure}
                \centering
    }{
            \end{minipage}
            \vspace{\intextsep}
        \end{gridenv}
    }
    \RenewDocumentEnvironment{figure*}{o}{
        \__skrapport_xdblfloat:nx{figure}
            {\IfNoValueTF{##1}{tp}{##1}}
        \dim_set_eq:NN\hsize\textwidth
        \dim_set_eq:NN\linewidth\textwidth
        \centering
    }{
        \end@dblfloat
    }
    \RenewDocumentEnvironment{table}{o}{%
        \begin{gridenv}
            \vspace{\intextsep}
            \begin{minipage}{\linewidth}
                \cs_set:Npn\@captype{table}
                \cs_set_eq:NN\__skrapport_old_caption:\caption
                \RenewDocumentCommand{\caption}{om}{%
                    \skip_set_eq:NN\l_tmpa_skip\abovecaptionskip
                    \skip_set_eq:NN\abovecaptionskip\belowcaptionskip
                    \skip_set_eq:NN\belowcaptionskip\l_tmpa_skip
                    \vspace{\abovecaptionskip}
                    \__skrapport_old_caption:[####1]{####2}
                    \vspace{\belowcaptionskip}
                }
                \centering
    }{
            \end{minipage}
            \vspace{\intextsep}
        \end{gridenv}
    }
    \RenewDocumentEnvironment{table*}{o}{
        \__skrapport_xdblfloat:nx{table}
            {\IfNoValueTF{##1}{tp}{##1}}
        \dim_set_eq:NN\hsize\textwidth
        \dim_set_eq:NN\linewidth\textwidth
        \centering
    }{
        \end@dblfloat
    }
    \newenvironment{onecol}{
        \end{onecol}
        \end{multicols}
        \group_begin:
        \cs_set:Npn\endonecol{
            \group_end:
            \begin{multicols}{2}
            \cs_set_eq:NN\__skrapport_old_onecol:\onecol
            \cs_set:Npn\onecol{
                \cs_set_eq:NN\onecol\__skrapport_old_onecol:
            }
            \begin{onecol}
        }
        \cs_set:Npn\onecol{}
        \begin{onecol}
    }{}
}
\cs_new:Nn\__skrapport_setup_leqno:{
    \RenewDocumentCommand\@eqnnum{}{
        \hbox_to_wd:nn{.01pt}{}
        \hbox_overlap_right:n{
            \normalfont\normalcolor
            \skip_horizontal:n{-\displaywidth}
            (\theequation)
        }
    }
}
\cs_new:Nn\__skrapport_setup_fleqn:{
    \file_input:n{fleqn.clo}
}
\cs_new:Npn\__skrapport_setup_titles:n#1{
    \str_case:nnF{#1}{
        {rm}{\cs_new_protected:Nn\__skrapport_title_style:{\rmfamily}}
        {it}{\cs_new_protected:Nn\__skrapport_title_style:{\itshape}}
        {bf}{\cs_new_protected:Nn\__skrapport_title_style:{\bfseries}}
        {sf}{\cs_new_protected:Nn\__skrapport_title_style:{\sffamily}}
    }{
        \msg_info:nnnn{skrapport}{invalid-titles}{#1}{rm}
        \__skrapport_setup_titles:n{rm}
    }
}
\cs_new:Npn\__skrapport_setup_lang:n#1{
    \str_case:nnF{#1}{
        {sv}{
            \bool_if:NTF\g__skrapport_has_polyglossia_bool{
                \setmainlanguage{swedish}
                \setotherlanguage[variant=british]{english}
            }{
                \RequirePackage[british,swedish]{babel}
            }
            \cs_gset:Nn\__skrapport_RFC_language:{swe}
            \PassOptionsToPackage{iso,swedish}{isodate}
        }
        {en}{
            \bool_if:NTF\g__skrapport_has_polyglossia_bool{
                \setmainlanguage[variant=british]{english}
                \setotherlanguage{swedish}
            }{
                \RequirePackage[swedish,british]{babel}
            }
            \cs_gset:Nn\__skrapport_RFC_language:{eng}
            \PassOptionsToPackage{iso,british}{isodate}
        }
        {de}{
            \bool_if:NTF\g__skrapport_has_polyglossia_bool{
                \setmainlanguage{ngerman}
                \setotherlanguage[variant=british]{english}
            }{
                \RequirePackage[british,ngerman]{babel}
            }
            \cs_gset:Nn\__skrapport_RFC_language:{ger}
            \PassOptionsToPackage{iso,ngerman}{isodate}
        }
    }{
        \msg_info:nnn{skrapport}{invalid-lang}{#1}
    }
    \addto\captionsswedish{
        \cs_gset:Nn\__skrapport_and_word:{och}
        \cs_gset:Nn\__skrapport_Email_word:{E-post}
        \cs_gset:Nn\__skrapport_Comment_word:{Kommentar}
        \cs_gset:Nn\__skrapport_eg_word:{t.ex.}
        \cs_gset:Nn\__skrapport_ie_word:{dvs.}
        \cs_gset:Nn\__skrapport_etc_word:{\emph{etc.}}
        \cs_gset:Nn\__skrapport_cf_word:{jfr.}
        \cs_gset:Nn\__skrapport_viz_word:{dvs.}
    }
    \cs_gset:Npn\dateswedish{
        \cs_gset:Npn\today
            {\int_use:N\year--\int_use:N\month--\int_use:N\day}
    }
    \addto\captionsbritish{
        \cs_gset:Nn\__skrapport_and_word:{and}
        \cs_gset:Nn\__skrapport_Email_word:{Email}
        \cs_gset:Nn\__skrapport_Comment_word:{Comment}
        \cs_gset:Nn\__skrapport_eg_word:{\emph{e.g.}}
        \cs_gset:Nn\__skrapport_ie_word:{\emph{i.e.}}
        \cs_gset:Nn\__skrapport_etc_word:{\emph{etc.}}
        \cs_gset:Nn\__skrapport_cf_word:{\emph{cf.}}
        \cs_gset:Nn\__skrapport_viz_word:{\emph{viz.}}
    }
    \cs_gset:Npn\datebritish{
        \cs_gset:Npn\today
            {\int_use:N\year--\int_use:N\month--\int_use:N\day}
    }
    \addto\captionsngerman{
        \cs_gset:Nn\__skrapport_and_word:{und}
        \cs_gset:Nn\__skrapport_Email_word:{E-Mail}
        \cs_gset:Nn\__skrapport_Comment_word:{Kommentar}
        \cs_gset:Nn\__skrapport_eg_word:{z.~B.}
        \cs_gset:Nn\__skrapport_ie_word:{d.~h.}
        \cs_gset:Nn\__skrapport_etc_word:{usw.}
        \cs_gset:Nn\__skrapport_cf_word:{vgl.}
        \cs_gset:Nn\__skrapport_viz_word:{\emph{viz.}}
    }
    \cs_gset:Npn\datengerman{
        \cs_gset:Npn\today
            {\int_use:N\day.\,\int_use:N\month.\,\int_use:N\year}
    }
}
\cs_new:Npn\__skrapport_setup_font:n#1{
    \PassOptionsToPackage{intlimits}{amsmath}
    \PassOptionsToPackage{full}{textcomp}
    \str_case:nnF{#1}{
        {none}{
            \bool_if:nT{\luatex_if_engine_p: || \xetex_if_engine_p:}{
                \RequirePackage[quiet]{fontspec}
            }
        }
        {kpfonts}{
            \RequirePackage[easyscsl,intlimits,sumlimits]{kpfonts}
        }
        {lmodern}{
            \RequirePackage{lmodern}
        }
        {palatino}{
            \file_if_exist:nTF{tgpagella.sty}{
                \RequirePackage{arev}
                \RequirePackage{pxfonts}
                \RequirePackage{tgpagella}
            }{
                \RequirePackage[osf]{mathpazo}
            }
        }
        {minion}{
            \AtEndOfClass{
                \cs_set_eq:NN\__skrapport_old_vec:\vec
                \cs_undefine:N\vec
                \RequirePackage{MyriadPro}
                \RequirePackage{MinionPro}
                \RequirePackage{MnSymbol}
                \cs_set_eq:NN\vec\__skrapport_old_vec:
            }
        }
        {skdoc}{
            \RequirePackage{PTSerif}
            \RequirePackage[defaultsans,osfigures,scale=0.95]{opensans}
        }
        {word}{
            \bool_if:nF{\luatex_if_engine_p: || \xetex_if_engine_p:}{
                \msg_fatal:nnn{skrapport}{font-requires-xetex}{word}
            }
            \RequirePackage[quiet]{fontspec}
            \setmainfont[Ligatures=TeX]{Cambria}
            \setsansfont[Ligatures=TeX]{Calibri}
            \setmonofont[Scale=0.95]{Consolas}
            \apptocmd{\__skrapport_after_ams_hook:}{
                \setmathfont{Cambria Math}
            }{}{}
        }
    }{
        \msg_warning:nnn{skrapport}{invalid-font}{#1}
    }
    \str_if_eq:nnF{#1}{none}{
        \str_if_eq:nnF{#1}{kpfonts}{
            \str_if_eq:nnF{#1}{word}{
                \RequirePackage{sourcecodepro}
            }
            \AtEndOfClass{
                \RequirePackage{amsmath}
              \str_if_eq:nnF{#1}{minion}{
                    \RequirePackage{amssymb}
                }
                \RequirePackage{textcomp}
            }
        }
    }
}
\cs_new:Nn\__skrapport_setup_parskip:{
    \AtEndOfClass{
        \skip_gset:Nn\parskip{0.5\baselineskip~plus~2pt}
        \dim_gzero:N\parindent
        \skip_gset:Nn\parfillskip{30pt~plus~1fil}
        \cs_gset:Npn\@listI{
            \dim_set_eq:NN\leftmargin\leftmargini
            \dim_set_eq:NN\parsep\parskip
            \dim_zero:N\topsep
            \dim_zero:N\itemsep
        }
        \cs_gset_eq:NN\@listi\@listI
        \dim_gset_eq:NN\leftmargin\leftmargini
        \dim_gset_eq:NN\parsep\parskip
        \dim_gzero:N\topsep
        \dim_gzero:N\itemsep
        \cs_gset:Npn\@listii{
            \dim_set_eq:NN\leftmargin\leftmarginii
            \dim_set_eq:NN\labelwidth\leftmarginii
            \dim_set_eq:NN\parsep\parskip
            \dim_sub:Nn\labelwidth{-\labelsep}
            \dim_zero:N\topsep
            \dim_zero:N\itemsep
        }
        \cs_gset:Npn\@listiii{
            \dim_set_eq:NN\leftmargin\leftmarginiii
            \dim_set_eq:NN\labelwidth\leftmarginiii
            \dim_set_eq:NN\parsep\parskip
            \dim_sub:Nn\labelwidth{-\labelsep}
            \dim_zero:N\topsep
            \dim_zero:N\itemsep
        }
        \dim_gzero:N\partopsep
        \RenewDocumentCommand\@starttoc{m}{
            \group_begin:
            \dim_zero:N\parskip
            \file_if_exist:nT{\c_job_name_tl.##1}{
                \file_input:n{\c_job_name_tl.##1}
            }
            \if@filesw
                \iow_new:c{tf@##1}
                \iow_open:cn{tf@##1}{\c_job_name_tl.##1}
            \fi
            \@nobreakfalse
            \group_end:
        }
    }
}
\cs_new:Nn\__skrapport_setup_math:{
    \file_if_exist:nT{skmath.sty}{\RequirePackage{skmath}}
}
\cs_new:Nn\__skrapport_setup_draft:{
    \bool_if:NTF\g__skrapport_draft_bool{
        \dim_gset:Nn\overfullrule{5pt}
    }{
        \msg_log:nnn{skrapport}{noop-call}{\__skrapport_setup_draft:}
        \prg_do_nothing:
    }
}
\cs_new:Nn\__skrapport_setup_color:{
    \bool_if:NTF\g__skrapport_color_bool{
        \RequirePackage{xcolor}
        \PassOptionsToPackage{
            labelfont+={bf,color=skrapport@captioncolor}
        }{caption}
    }{
        \msg_log:nnn{skrapport}{noop-call}{\__skrapport_setup_color:}
        \prg_do_nothing:
    }
}
\cs_new:Npn\__skrapport_setup_color:n#1{
    \__skrapport_setup_color:
    \bool_if:NTF\g__skrapport_color_bool{
        \AtBeginDocument{\colortheme{#1}}
    }{
        \msg_log:nnn{skrapport}{noop-call}{\__skrapport_setup_color:n}
        \prg_do_nothing:
    }
}
\cs_new:Nn\__skrapport_setup_xelatex:{
    \AtEndOfClass{
        \cs_undefine:N\dblcolon
        \cs_undefine:N\coloneqq
        \cs_undefine:N\Coloneqq
        \cs_undefine:N\eqqcolon
        \RequirePackage{unicode-math}
        \unimathsetup {
            math-style     = ISO,
            bold-style     = ISO,
            sans-style     = italic,
            nabla          = upright,
            partial        = italic,
            vargreek-shape = unicode
        }
    }
    \DeclareDocumentCommand\nobreakspace{}{\leavevmode\nobreak\space}
    \xetex_if_engine:TF{
        \PassOptionsToPackage{quiet}{fontspec}
        \RequirePackage{polyglossia}
        \bool_gset_true:N\g__skrapport_has_polyglossia_bool
    }{
        \bool_gset_false:N\g__skrapport_has_polyglossia_bool
    }
}
\cs_new:Nn\__skrapport_setup_pdftex:{
    \RequirePackage[T1]{fontenc}
    \AtEndOfClass{
        \RequirePackage{isomath}
    }
    \bool_gset_false:N\g__skrapport_has_polyglossia_bool
}
\cs_new:Nn\__skrapport_setup_engine_specific:{
    \bool_if:nTF{\luatex_if_engine_p: || \xetex_if_engine_p:}{
        \__skrapport_setup_xelatex:
    }{
        \__skrapport_setup_pdftex:
    }
}
\cs_generate_variant:Nn\__skrapport_setup_ptsize:n{ x }
\cs_generate_variant:Nn\__skrapport_setup_titles:n{ x }
\cs_generate_variant:Nn\__skrapport_setup_lang:n{ x }
\cs_generate_variant:Nn\__skrapport_setup_font:n{ x }
\keys_define:nn{skrapport}{
    paper .choice:,
    paper / a4 .code:n =
        {\__skrapport_setup_paper:n{a4}},
    paper / a5 .code:n =
        {\__skrapport_setup_paper:n{a5}},
    paper / a4paper .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {paper=a4paper}{paper=a4}
         \keys_set:nn{skrapport}{paper=a4}},
    paper / a5paper .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {paper=a5paper}{paper=a5}
         \keys_set:nn{skrapport}{paper=a4}},
    paper .value_required:,
    a4paper .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {a4paper}{paper=a4}
         \keys_set:nn{skrapport}{paper=a4}},
    a5paper .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {a5paper}{paper=a5}
         \keys_set:nn{skrapport}{paper=a5}},
    ptsize .choices:nn =
        { 10pt, 11pt, 12pt }
        {\__skrapport_setup_ptsize:x{\tl_use:N\l_keys_choice_tl}},
    ptsize .value_required:,
    10pt .meta:n = {ptsize=10pt},
    11pt .meta:n = {ptsize=11pt},
    12pt .meta:n = {ptsize=12pt},
    twocolumn .code:n =
        {\AtEndOfClass{\__skrapport_setup_twocolumn:}},
    onecolumn .code:n =
        {\msg_warning:nnn{skrapport}{option-no-effect}{onecolumn}},
    draft .choice:,
    draft / true .code:n =
        {\bool_gset_true:N\g__skrapport_draft_bool
         \__skrapport_setup_draft:},
    draft / false .code:n =
        {\bool_gset_false:N\g__skrapport_draft_bool},
    draft .default:n = true,
    final .code:n = {\prg_do_nothing:},
    leqno .code:n =
        {\__skrapport_setup_leqno:},
    fleqn .code:n =
        {\__skrapport_setup_fleqn:},
    titles .choices:nn =
        { rm, it, bf, sf }
        {\__skrapport_setup_titles:x{\tl_use:N\l_keys_choice_tl}},
    titles .value_required:,
    rmtitles .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {rmtitles}{titles=rm}
         \keys_set:nn{skrapport}{titles=rm}},
    bftitles .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {bftitles}{titles=bf}
         \keys_set:nn{skrapport}{titles=bf}},
    sftitles .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {sftitles}{titles=sf}
         \keys_set:nn{skrapport}{titles=sf}},
    hanging-titles .bool_gset:N = \g__skrapport_hanging_titles_bool,
    hanging-titles .default:n = true,
    hanging-titles .initial:n = false,
    lang .choices:nn =
        { sv, en, de }
        {\__skrapport_setup_lang:x{\tl_use:N\l_keys_choice_tl}},
    lang .value_required:,
    swe .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {swe}{lang=sv}
         \keys_set:nn{skrapport}{lang=sv}},
    eng .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {eng}{lang=en}
         \keys_set:nn{skrapport}{lang=en}},
    font .choices:nn =
        { none, kpfonts, lmodern, palatino, minion, skdoc, word }
        {\__skrapport_setup_font:x{\tl_use:N\l_keys_choice_tl}},
    font .value_required:,
    nofont .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {nofont}{font=none}
         \keys_set:nn{skrapport}{font=none}},
    kpfonts .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {kpfonts}{font=kpfonts}
         \keys_set:nn{skrapport}{font=kpfonts}},
    lmodern .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {lmodern}{font=lmodern}
         \keys_set:nn{skrapport}{font=lmodern}},
    palatino .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {palatino}{font=palatino}
         \keys_set:nn{skrapport}{font=palatino}},
    minion .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {minion}{font=minion}
         \keys_set:nn{skrapport}{font=minion}},
    skdoc .code:n =
        {\msg_warning:nnnn{skrapport}{option-deprecated}
            {skdoc}{font=skdoc}
         \keys_set:nn{skrapport}{font=skdoc}},
    indent .choice:,
    indent / true .code:n = {\prg_do_nothing:},
    indent / false .code:n = {\__skrapport_setup_parskip:},
    indent .default:n = true,
    noindent .code:n =
        {\msg_warning:nnn{skrapport}{option-no-effect}{noindent}},
    color .code:n =
        {\str_if_eq:nnTF{#1}{false}
            {\bool_gset_false:N\g__skrapport_color_bool}
            {\bool_gset_true:N\g__skrapport_color_bool
             \str_if_eq:nnTF{#1}{true}
                {\__skrapport_setup_color:n{default}}
                {\__skrapport_setup_color:n{#1}}}},
    color .default:n = true,
    nocolor .meta:n = {color=false},
    nomath .choice:,
    nomath / false .code:n = {\__skrapport_setup_math:},
    nomath / true .code:n = {\prg_do_nothing:},
    nomath .default:n = true,
    math .code:n =
        {\msg_warning:nnn{skrapport}{option-no-effect}{math}},
}
\cs_new:Nn\__skrapport_setup_defaults:{
    \bool_new:N\l__skrapport_has_option_indent_bool
    \bool_new:N\l__skrapport_has_option_nomath_bool
    \bool_new:N\l__skrapport_has_option_color_bool
    \bool_new:N\l__skrapport_has_option_font_bool
    \bool_new:N\l__skrapport_has_option_lang_bool
    \bool_new:N\l__skrapport_has_option_titles_bool
    \bool_new:N\l__skrapport_has_option_draft_bool
    \bool_new:N\l__skrapport_has_option_ptsize_bool
    \bool_new:N\l__skrapport_has_option_paper_bool
    \keys_define:nn{skrapport-default}{
        indent .code:n =
            {\bool_set_true:N\l__skrapport_has_option_indent_bool},
        nomath .code:n =
            {\bool_set_true:N\l__skrapport_has_option_nomath_bool},
        color .code:n =
            {\bool_set_true:N\l__skrapport_has_option_color_bool},
        font .code:n =
            {\bool_set_true:N\l__skrapport_has_option_font_bool},
        lang .code:n =
            {\bool_set_true:N\l__skrapport_has_option_lang_bool},
        titles .code:n =
            {\bool_set_true:N\l__skrapport_has_option_titles_bool},
        draft .code:n =
            {\bool_set_true:N\l__skrapport_has_option_draft_bool},
        ptsize .code:n =
            {\bool_set_true:N\l__skrapport_has_option_ptsize_bool},
        paper .code:n =
            {\bool_set_true:N\l__skrapport_has_option_paper_bool},
        nofont .code:n =   {\keys_set:nn{skrapport-default}{font}},
        kpfonts .code:n =  {\keys_set:nn{skrapport-default}{font}},
        lmodern .code:n =  {\keys_set:nn{skrapport-default}{font}},
        palatino .code:n = {\keys_set:nn{skrapport-default}{font}},
        minion .code:n =   {\keys_set:nn{skrapport-default}{font}},
        skdoc .code:n =    {\keys_set:nn{skrapport-default}{font}},
        swe .code:n =      {\keys_set:nn{skrapport-default}{lang}},
        eng .code:n =      {\keys_set:nn{skrapport-default}{lang}},
        rmtitles .code:n = {\keys_set:nn{skrapport-default}{titles}},
        bftitles .code:n = {\keys_set:nn{skrapport-default}{titles}},
        sftitles .code:n = {\keys_set:nn{skrapport-default}{titles}},
        10pt .code:n =     {\keys_set:nn{skrapport-default}{ptsize}},
        11pt .code:n =     {\keys_set:nn{skrapport-default}{ptsize}},
        12pt .code:n =     {\keys_set:nn{skrapport-default}{ptsize}},
        a4paper .code:n =  {\keys_set:nn{skrapport-default}{paper}},
        a5paper .code:n =  {\keys_set:nn{skrapport-default}{paper}},
    }
    \ProcessKeysOptions{skrapport-default}
    \bool_if:NF\l__skrapport_has_option_indent_bool{
        \keys_set:nn{skrapport}{indent=false}
    }
    \bool_if:NF\l__skrapport_has_option_nomath_bool{
        \keys_set:nn{skrapport}{nomath=false}
    }
    \bool_if:NF\l__skrapport_has_option_color_bool{
        \keys_set:nn{skrapport}{color=true}
    }
    \bool_if:NF\l__skrapport_has_option_font_bool{
        \xetex_if_engine:TF{
            \keys_set:nn{skrapport}{font=word}
        }{
            \keys_set:nn{skrapport}{font=kpfonts}
        }
    }
    \bool_if:NF\l__skrapport_has_option_lang_bool{
        \keys_set:nn{skrapport}{lang=sv}
    }
    \bool_if:NF\l__skrapport_has_option_titles_bool{
        \keys_set:nn{skrapport}{titles=bf}
    }
    \bool_if:NF\l__skrapport_has_option_draft_bool{
        \keys_set:nn{skrapport}{draft=false}
    }
    \bool_if:NF\l__skrapport_has_option_ptsize_bool{
        \keys_set:nn{skrapport}{ptsize=11pt}
    }
    \bool_if:NF\l__skrapport_has_option_paper_bool{
        \keys_set:nn{skrapport}{paper=a4}
    }
}
\cs_set_eq:NN\__skrapport_tmpa_cs:\@classoptionslist
\RequirePackage{xkeyval}
\cs_set_eq:NN\__skrapport_tmpb_cs:\@classoptionslist
\cs_set_eq:NN\@classoptionslist\__skrapport_tmpa_cs:
\__skrapport_setup_engine_specific:
\ProcessKeysOptions{skrapport}
\__skrapport_setup_defaults:
\cs_set_eq:NN\@classoptionslist\__skrapport_tmpb_cs:
\cs_undefine:N\__skrapport_tmpa_cs:
\cs_undefine:N\__skrapport_tmpb_cs:
\RequirePackage{calc,isodate,multicol}
\AtEndOfClass{
    \RequirePackage{microtype}
    \frenchspacing
}
\AtBeginDocument{
    \cs_if_exist:NT\urlstyle{\urlstyle{same}}
}
\cs_new:Npn\dim_set_to_wd:Nn#1#2{
    \hbox_set:Nn\l_tmpa_box{#2}
    \dim_set:Nn#1{\box_wd:N\l_tmpa_box}
    \box_clear:N\l_tmpa_box
}
\dim_add:Nn\textwidth{0.5\oddsidemargin}
\dim_add:Nn\textwidth{0.5\evensidemargin}
\dim_add:Nn\oddsidemargin{-0.5\oddsidemargin}
\dim_add:Nn\evensidemargin{-0.5\evensidemargin}
\dim_gset:Nn\lineskip{1pt}
\dim_gset:Nn\normallineskip{1pt}
\cs_set:Npn\baselinestretch{}
\int_gset:Nn\@lowpenalty  {51}
\int_gset:Nn\@medpenalty {151}
\int_gset:Nn\@highpenalty{301}
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{2}
\RenewDocumentCommand\topfraction{}{.75}
\RenewDocumentCommand\bottomfraction{}{.5}
\RenewDocumentCommand\textfraction{}{.25}
\RenewDocumentCommand\floatpagefraction{}{.625}
\RenewDocumentCommand\dbltopfraction{}{.75}
\RenewDocumentCommand\dblfloatpagefraction{}{.625}
\tl_new:N\g__skrapport_title_tl
\DeclareDocumentCommand\title{m}{
    \tl_gset:Nn\g__skrapport_title_tl{#1}
}
\tl_new:N\g__skrapport_date_tl
\tl_gset:Nn\g__skrapport_date_tl{\today}
\DeclareDocumentCommand\date{m}{
    \str_if_eq:nnTF{#1}{today}{
        \tl_gset:Nn\g__skrapport_date_tl{\today}
    }{
        \if_meaning:w \today #1
            \tl_gset:Nn\g__skrapport_date_tl{\today}
        \else:
            \tl_gset:Nn\g__skrapport_date_tl{\printdate{#1}}
        \fi:
    }
}
\cs_new_nopar:Npn\__skrapport_email:n#1{
    \texttt{#1}
}
\AtBeginDocument{
    \cs_if_exist:NT\href{
        \cs_gset_nopar:Npn\__skrapport_email:n#1{
            \href{mailto:#1}{\nolinkurl{#1}}
        }
    }
}
\clist_new:N\g__skrapport_author_clist
\clist_new:N\g__skrapport_email_clist
\DeclareDocumentCommand\author{om}{%
    \clist_gput_right:Nn\g__skrapport_author_clist{#2}
    \clist_gput_right:Nn\g__skrapport_email_clist
        {\IfNoValueTF{#1}{\textemdash}{#1}}
}
\cs_new:Nn\__skrapport_author_list:{
    \clist_use:Nnnn\g__skrapport_author_clist
        {~\__skrapport_and_word:{}~}{,~}{~\__skrapport_and_word:{}~}
}
\cs_new:Nn\__skrapport_email_list:{
    \int_compare:nT{\clist_count:N\g__skrapport_author_clist>\c_zero}{
        \clist_use:Nnnn\g__skrapport_email_clist{\\}{\\}{\\}
    }
}
\tl_new:N\g__skrapport_regarding_tl
\DeclareDocumentCommand\regarding{m}{
    \tl_gset:Nn\g__skrapport_regarding_tl{#1}
}
\bool_new:N\g__skrapport_copyright_unprinted_bool
\AtEndDocument{
    \bool_if:NT\g__skrapport_copyright_unprinted_bool
        {\msg_warning:nn{skrapport}{license-not-printed}}
}
\tl_new:N\g__skrapport_copyright_tl
\DeclareDocumentCommand\license{m}{
    \tl_gset:Nn\g__skrapport_copyright_tl{#1}
    \bool_gset_true:N\g__skrapport_copyright_unprinted_bool
}
\keys_define:nn{skrapport/maketitle}{
    hide .clist_set:N = \l__skrapport_maketitle_hide_clist,
    hide .value_required:,
    nopdfinfo .bool_set_inverse:N = \l__skrapport_maketitle_pdfinfo_bool,
    nopdfinfo .default:n = true,
    nopdfinfo .initial:n = false
}
\cs_new_protected:Nn\__skrapport_smallprint_style:{}
\cs_new_protected:Nn\__skrapport_abstract_style:
    {\__skrapport_title_style:}
\DeclareDocumentCommand\maketitle{o}{
    \clist_clear:N\l__skrapport_maketitle_hide_clist
    \IfNoValueF{#1}{\keys_set:nn{skrapport/maketitle}{#1}}
    \bool_if:NT\l__skrapport_maketitle_pdfinfo_bool{
        \exp_args:NNx\cs_if_exist_use:NT\hypersetup{{
            pdfinfo={
                Title={\tl_use:N\g__skrapport_title_tl},
                Subject={\tl_use:N\g__skrapport_regarding_tl},
                Author={
                    \clist_use:Nnnn\g__skrapport_author_clist{,~}{,~}{,~}
                },
                Lang={\__skrapport_RFC_language:}
            }
        }}
    }
    \par
    \group_begin:
        \RenewDocumentCommand\thefootnote{}{
            \fnsymbol{footnote}
        }
        \RenewDocumentCommand\@makefnmark{}{
            \hbox_overlap_right:n{
                \@textsuperscript{\normalfont\@thefnmark}
            }
        }
        \RenewDocumentCommand\@makefntext{+m}{
            \dim_set:Nn\parindent{1em}\noindent
            \hbox_to_wd:nn{1.8em}{
                \hss\@textsuperscript{\normalfont\@thefnmark}
            }
            ##1
        }
        \newpage
        \int_gzero:N\@topnum
        \__skrapport_maketitle:
        \thispagestyle{plain}
    \group_end:
    \setcounter{footnote}{0}
}
\cs_new:Nn\__skrapport_maketitle:{
    \newpage
    \hbox:n{}
    \begin{flushleft}
        \vspace{-\headsep}
        \clist_if_in:NnF\l__skrapport_maketitle_hide_clist{regarding}{
            \small\__skrapport_smallprint_style:
            \tl_use:N\g__skrapport_regarding_tl
            \clist_if_in:NnF\l__skrapport_maketitle_hide_clist{date}{
                \tl_if_empty:NF\g__skrapport_regarding_tl{,~}
            }
        }
        \clist_if_in:NnF\l__skrapport_maketitle_hide_clist{date}{
            \tl_use:N\g__skrapport_date_tl
        }
        \clist_if_in:NnTF\l__skrapport_maketitle_hide_clist{regarding}{
            \clist_if_in:NnTF\l__skrapport_maketitle_hide_clist{date}
                {}{\par}
        }{\par}
        \vspace{1.5cm}
        {
            \Huge\__skrapport_title_style:
            \tl_use:N\g__skrapport_title_tl
            \par
        }
        \vspace{.125cm}
        {
            \Large\__skrapport_title_style:
            \__skrapport_author_list:
        }
        \vspace{.75cm}
    \end{flushleft}
    \par
    \clist_if_in:NnF\l__skrapport_maketitle_hide_clist{email}{
        \dim_set_to_abstract_or_email_wd:N\l_tmpa_dim
        \bool_gset_false:N\g__skrapport_abstract_used
        \dim_set:Nn\l_tmpb_dim
            {\textwidth-\l_tmpa_dim-\c__skrapport_abstract_separator_dim}
        \begin{minipage}[t]{\l_tmpa_dim}
            \begin{flushright}
                \leavevmode\__skrapport_abstract_style:
                \__skrapport_Email_word:
            \end{flushright}
        \end{minipage}
        \hspace{\c__skrapport_abstract_separator_dim}
        \begin{minipage}[t]{\l_tmpb_dim}
            \__skrapport_email_list:
        \end{minipage}
        \par
    }
}
\bool_new:N\g__skrapport_abstract_used
\AtEndDocument{
    \iow_shipout:Nx\@mainaux{ % !!!
        \exp_not:N\ExplSyntaxOn
        \bool_if:NTF\g__skrapport_abstract_used
            {\exp_not:n{\bool_gset_true:N\g__skrapport_abstract_used}}
            {\exp_not:n{\bool_gset_false:N\g__skrapport_abstract_used}}
        \exp_not:N\ExplSyntaxOff
    }
}
\cs_new:Npn\dim_set_to_abstract_or_email_wd:N#1{
    \dim_set_to_wd:Nn\l_tmpa_dim
        {\__skrapport_abstract_style:\abstractname}
    \dim_set_to_wd:Nn\l_tmpb_dim
        {\__skrapport_abstract_style:\__skrapport_Email_word:}
    \bool_if:NTF\g__skrapport_abstract_used
        {\dim_set:Nn#1{\dim_max:nn{\l_tmpa_dim}{\l_tmpb_dim}}}
        {\dim_set_eq:NN#1\l_tmpb_dim}
}
\dim_const:Nn\c__skrapport_abstract_separator_dim{1em}
\DeclareDocumentEnvironment{abstract}{}{
    \bool_gset_true:N\g__skrapport_abstract_used
    \dim_set_to_abstract_or_email_wd:N\l_tmpa_dim
    \dim_set:Nn\l_tmpb_dim
        {\textwidth-\l_tmpa_dim-\c__skrapport_abstract_separator_dim}
    \begin{minipage}[t]{\l_tmpa_dim}
        \begin{flushright}
            \leavevmode\__skrapport_abstract_style:
            \abstractname
        \end{flushright}
    \end{minipage}
    \hspace{\c__skrapport_abstract_separator_dim}
    \begin{minipage}[t]{\l_tmpb_dim}
}{
    \end{minipage}
}
\cs_new:Npn\ps@skrapport@titlepage{
    \cs_set:Npn\@oddhead{}
    \cs_set:Npn\@evenhead{}
    \cs_set:Npn\@oddfoot{
        \begin{minipage}{\textwidth}
            \raggedleft\small\par
            \__skrapport_smallprint_style:
            \tl_use:N\g__skrapport_copyright_tl
        \end{minipage}
    }
    \cs_set_eq:NN\@evenfoot\@oddfoot
}
\DeclareDocumentEnvironment{titlepage}{}{
    \cleardoublepage\setcounter{page}{1}
}{
    \bool_gset_false:N\g__skrapport_copyright_unprinted_bool
    \thispagestyle{skrapport@titlepage}
    \cleardoublepage\setcounter{page}{1}
}
\setcounter{secnumdepth}{3}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\cs_gset:Npn\thesection{
    \arabic{section}
}
\cs_gset:Npn\thesubsection{
    \thesection.\arabic{subsection}
}
\cs_gset:Npn\thesubsubsection{
    \thesubsection.\arabic{subsubsection}
}
\cs_gset:Npn\theparagraph{
    \thesubsubsection.\arabic{paragraph}
}
\cs_gset:Npn\thesubparagraph{
    \theparagraph.\arabic{subparagraph}
}
\cs_new:Npn\__skrapport_pre_section:n#1{
    \leavevmode\par
    \skip_set:Nn\l_tmpa_skip{#1}
    \@afterindenttrue % !!!
    \dim_compare:nT{\l_tmpa_skip<\c_zero_skip}{
        \skip_set:Nn\l_tmpa_skip{-\l_tmpa_skip}
        \@afterindentfalse % !!!
    }
    \if@nobreak \everypar{} \else
        \addpenalty\@secpenalty % !!!
        \skip_vertical:N\l_tmpa_skip
    \fi
}
\cs_new:Npn\__skrapport_post_section:n#1{
    \skip_set:Nn\l_tmpa_skip{#1}
    \dim_compare:nTF{\l_tmpa_skip>\c_zero_skip}{
        \par\nobreak
        \skip_vertical:N\l_tmpa_skip
        \@afterheading % !!!
    }{
        \@nobreakfalse
        \global\@noskipsectrue
        \skip_horizontal:n{-\l_tmpa_skip}
    }
    \ignorespaces
}
\cs_new:Npn\__skrapport_section_star:nnn#1#2#3{
    \__skrapport_section_star:nnnn{#1}{#2}{#3}{}
}
\cs_new:Npn\__skrapport_section_star:nnnn#1#2#3#4{
    \group_begin:
        #2
        \hbox_set:Nn\l_tmpa_box{{\skip_horizontal:n{#1}#4}}
        \dim_set:Nn\hangindent{#1+\box_wd:N\l_tmpa_box}
        \noindent\box_use_clear:N\l_tmpa_box
        \interlinepenalty\@M % !!!
        #3
    \group_end:
}
\cs_new:Npn\__skrapport_section_nostar:nnnnnn#1#2#3#4#5#6{
    \cs_set:Nn\__skrapport_saved_section:{}
    \int_compare:nF{#2>\value{secnumdepth}}{
        \refstepcounter{#1}
        \cs_set:Nn\__skrapport_saved_section:{
            \bool_if:NTF\g__skrapport_hanging_titles_bool
                {\llap{\use:c{the#1}\hspace{1ex}}}
                {\use:c{the#1}~}
        }
    }
    \__skrapport_section_star:nnnn
        {#3}{#4}{#5}{\__skrapport_saved_section:}
    \use:c{#1mark}{#6}
    \addcontentsline{toc}{#1}{
        \int_compare:nF{#2>\value{secnumdepth}}{
            \protect\numberline{\use:c{the#1}}
        }
        #6
    }
}
\cs_generate_variant:Nn\__skrapport_pre_section:n{c}
\cs_generate_variant:Nn\__skrapport_post_section:n{c}
\cs_generate_variant:Nn\__skrapport_section_star:nnn{ccn}
\cs_generate_variant:Nn\__skrapport_section_nostar:nnnnnn{nnccnn}
\cs_set:Nn\__skrapport_generic_section:nnnnn{
    \__skrapport_pre_section:c{c__skrapport_#1_pre_skip}
    \IfBooleanTF#3{
        \__skrapport_section_star:ccn
            {c__skrapport_#1_indent_dim}
            {__skrapport_#1_style:}
            {#5}
    }{
        \IfNoValueTF{#4}{
            \__skrapport_section_nostar:nnccnn
                {#1}{#2}
                {c__skrapport_#1_indent_dim}
                {__skrapport_#1_style:}
                {#5}
                {#5}
        }{
            \__skrapport_section_nostar:nnccnn
                {#1}{#2}
                {c__skrapport_#1_indent_dim}
                {__skrapport_#1_style:}
                {#5}
                {#4}
        }
    }
    \__skrapport_post_section:c{c__skrapport_#1_post_skip}
}
\skip_const:Nn\c__skrapport_section_pre_skip{-4ex~plus~1ex~minus~-1ex}
\skip_const:Nn\c__skrapport_section_post_skip{.5ex~plus~.5ex}
\dim_const:Nn \c__skrapport_section_indent_dim{\c_zero_dim}
\cs_set_protected:Nn\__skrapport_section_style:
    {\normalfont\LARGE\__skrapport_title_style:}
\DeclareDocumentCommand\section{som}{
    \__skrapport_generic_section:nnnnn{section}{1}{#1}{#2}{#3}
}
\skip_const:Nn\c__skrapport_subsection_pre_skip{-3ex~plus~1ex~minus~-1ex}
\skip_const:Nn\c__skrapport_subsection_post_skip{.25ex~plus~.25ex}
\dim_const:Nn \c__skrapport_subsection_indent_dim{\c_zero_dim}
\cs_set_protected:Nn\__skrapport_subsection_style:
    {\normalfont\Large\__skrapport_title_style:}
\DeclareDocumentCommand\subsection{som}{
    \__skrapport_generic_section:nnnnn{subsection}{2}{#1}{#2}{#3}
}
\skip_const:Nn\c__skrapport_subsubsection_pre_skip{-2ex~plus~.5ex~minus~-.5ex}
\skip_const:Nn\c__skrapport_subsubsection_post_skip{.125ex~plus~.125ex}
\dim_const:Nn \c__skrapport_subsubsection_indent_dim{\c_zero_dim}
\cs_set_protected:Nn\__skrapport_subsubsection_style:
    {\normalfont\large\__skrapport_title_style:}
\DeclareDocumentCommand\subsubsection{som}{
    \__skrapport_generic_section:nnnnn{subsubsection}{3}{#1}{#2}{#3}
}
\skip_const:Nn\c__skrapport_paragraph_pre_skip{1ex~plus~.25ex~minus~-.25ex}
\skip_const:Nn\c__skrapport_paragraph_post_skip{-1em}
\dim_const:Nn \c__skrapport_paragraph_indent_dim{\c_zero_dim}
\cs_set_protected:Nn\__skrapport_paragraph_style:
    {\normalfont\normalsize\__skrapport_title_style:}
\DeclareDocumentCommand\paragraph{som}{
    \__skrapport_generic_section:nnnnn{paragraph}{4}{#1}{#2}{#3}
}
\skip_const:Nn\c__skrapport_subparagraph_pre_skip{1ex~plus~.25ex~minus~-.25ex}
\skip_const:Nn\c__skrapport_subparagraph_post_skip{-1em}
\dim_const:Nn \c__skrapport_subparagraph_indent_dim{\parindent}
\cs_set_protected:Nn\__skrapport_subparagraph_style:
    {\normalfont\normalsize\__skrapport_title_style:\itshape}
\DeclareDocumentCommand\subparagraph{som}{
    \__skrapport_generic_section:nnnnn{subparagraph}{5}{#1}{#2}{#3}
}
\dim_gset:Nn\leftmargini{2em}
\dim_gset_eq:NN\leftmargin\leftmargini
\dim_gset:Nn\leftmarginii{2em}
\dim_gset:Nn\leftmarginiii{1.5em}
\dim_gset:Nn\leftmarginiv{1.5em}
\dim_gset:Nn\leftmarginv{1em}
\dim_gset:Nn\leftmarginvi{1em}
\dim_gset:Nn\labelsep{.5em}
\dim_gset_eq:NN\labelwidth\leftmargini
\dim_gsub:Nn\labelwidth{-\labelsep}
\int_gset:Nn\@beginparpenalty{-\@lowpenalty}
\int_gset:Nn\@endparpenalty  {-\@lowpenalty}
\int_gset:Nn\@itempenalty    {-\@lowpenalty}
\cs_set:Npn\theenumi  {\arabic{enumi}}
\cs_set:Npn\theenumii {\alph{enumii}}
\cs_set:Npn\theenumiii{\roman{enumiii}}
\cs_set:Npn\theenumiv {\Alph{enumiv}}
\cs_new:Npn\labelenumi{\theenumi.}
\cs_new:Npn\labelenumii{\theenumii)}
\cs_new:Npn\labelenumiii{\theenumiii.}
\cs_new:Npn\labelenumiv{\theenumiv.}
\cs_set:Npn\p@enumii{\theenumi}
\cs_set:Npn\p@enumiii{\theenumi(\theenumii)}
\cs_set:Npn\p@enumiv{\p@enumiii\theenumiii}
\cs_set:Npn\labelitemi{\textbullet}
\cs_set:Npn\labelitemii{\normalfont\bfseries\textendash}
\cs_set:Npn\labelitemiii{\textbullet}
\cs_set:Npn\labelitemiv{\normalfont\bfseries\textendash}
\DeclareDocumentEnvironment{description}{}{
    \begin{list}{}{
        \dim_zero:N\labelwidth
        \dim_set:Nn\itemindent{-\leftmargin}
        \cs_set_eq:NN\makelabel\descriptionlabel
    }
}{
    \end{list}
}
\NewDocumentCommand\descriptionlabel{m}{
    \hspace{\labelsep}\normalfont\bfseries #1
}
\NewDocumentEnvironment{quote}{}{
    \begin{list}{}{
        \dim_set_eq:NN\rightmargin\leftmargin
    }
    \item\itshape
}{
    \end{list}
}
\NewDocumentEnvironment{quotation}{}{
    \bigskip
    \begin{quote}
}{
    \end{quote}
    \bigskip
}
\NewDocumentEnvironment{verse}{}{
    \begin{quote}
}{
    \end{quote}
}
\NewDocumentCommand\appendix{}{
    \par
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \cs_gset:Npn\thesection{\Alph{section}}
}
\DeclareDocumentCommand\rm{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\rm}{\textrm}}
\DeclareDocumentCommand\sf{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\sf}{\textsf}}
\DeclareDocumentCommand\tt{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\tt}{\texttt}}
\DeclareDocumentCommand\bf{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\bf}{\textbf}}
\DeclareDocumentCommand\it{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\it}{\textit}}
\DeclareDocumentCommand\sl{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\sl}{\textsl}}
\DeclareDocumentCommand\sc{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\sc}{\textsc}}
\DeclareDocumentCommand\em{}{\msg_error:nnnn{skrapport}{old-font-deprecated}{\em}{\emph}}
\cs_new:Nn\__skrapport_emphstyle:{
    \itshape
    \dim_compare:nF{\fontdimen\c_one\font>\c_zero_dim}{\bfseries}
}
\DeclareDocumentCommand\emph{+m}{
    \ifmmode
        \text{\__skrapport_emphstyle: #1}
    \else
        {\__skrapport_emphstyle: #1}
    \fi
}
\DeclareDocumentCommand\footnoterule{}{}
\DeclareDocumentCommand\@makefntext{+m}{
    \dim_set:Nn\parindent{1em}\noindent
    \hbox_to_wd:nn{1.8em}{\hss\@makefnmark}
    #1
}
\dim_gset:Nn\arraycolsep    {5pt}
\dim_gset:Nn\tabcolsep      {6pt}
\dim_gset:Nn\arrayrulewidth{.4pt}
\dim_gset:Nn\doublerulesep  {2pt}
\dim_gset_eq:NN\tabbingsep\labelsep
\skip_gset_eq:NN{\skip\@mpfootins}{\skip\footins}
\dim_gset:Nn\fboxsep        {3pt}
\dim_gset:Nn\fboxrule      {.4pt}
\newcounter{figure}
\newcounter{table}
\cs_set:Npn\theequation{\arabic{equation}}
\cs_set:Npn\thefigure{\arabic{figure}}
\cs_set:Npn\thetable{\arabic{table}}
\cs_new:Npn  \fps@figure{tb}
\cs_new:Npn\ftype@figure{1}
\cs_new:Npn  \ext@figure{lof}
\cs_new:Npn \fnum@figure{\figurename\ \thefigure}
\cs_new:Npn  \fps@table {tb}
\cs_new:Npn\ftype@table {2}
\cs_new:Npn  \ext@table {lot}
\cs_new:Npn \fnum@table {\tablename\ \thetable}
\cs_new:Npn\__skrapport_xfloat:nn#1#2{\@xfloat{#1}[#2]}
\cs_generate_variant:Nn\__skrapport_xfloat:nn{nx}
\DeclareDocumentEnvironment{figure}{o}{
    \__skrapport_xfloat:nx{figure}
        {\IfNoValueTF{#1}{\fps@figure}{#1}}
    \centering
}{
    \end@float
}
\DeclareDocumentEnvironment{figure*}{o}{
    \__skrapport_xfloat:nx{figure}
        {\IfNoValueTF{#1}{tp}{#1}}
    \centering
}{
    \end@float
}
\DeclareDocumentEnvironment{table}{o}{
    \__skrapport_xfloat:nx{table}
        {\IfNoValueTF{#1}{\fps@table}{#1}}
    \centering
}{
    \end@float
}
\DeclareDocumentEnvironment{table*}{o}{
    \__skrapport_xfloat:nx{table}
        {\IfNoValueTF{#1}{tp}{#1}}
    \centering
}{
    \end@float
}
\cs_generate_variant:Nn\coffin_typeset:Nnnnn{Nnnon}
\DeclareDocumentEnvironment{figcenter}{}{
    \cs_set_eq:NN\l__tmpa_cs\caption
    \cs_set:Npn\caption{\msg_error:nn{skrapport}{caption-in-figcenter}}
    \coffin_clear:N\l_tmpa_coffin
    \hcoffin_set:Nw\l_tmpa_coffin
}{
    \hcoffin_set_end:
    \dim_set:Nn\l_tmpa_dim{(\textwidth - \coffin_wd:N\l_tmpa_coffin)/2}
    \coffin_typeset:Nnnon\l_tmpa_coffin{H}{l}{\dim_use:N\l_tmpa_dim}{0pt}
    \cs_set_eq:NN\caption\l__tmpa_cs
    \cs_undefine:N\l__tmpa_cs
}
\PassOptionsToPackage{font=small,labelfont+=bf,textfont+=it}{caption}
\cs_new_protected:Nn\__skrapport_caption_name_style:{\small\bfseries}
\cs_new_protected:Nn\__skrapport_caption_text_style:{\small\itshape}
\skip_new:N\abovecaptionskip
\skip_set:Nn\abovecaptionskip{10pt}
\skip_new:N\belowcaptionskip
\skip_set:Nn\belowcaptionskip{10pt}
\cs_new:Npn\@makecaption#1#2{
    \skip_vertical:N\abovecaptionskip
    \hbox_set:Nn\l_tmpa_box{
        \color@setgroup % !!!
        {\__skrapport_caption_name_style:#1:~}
        {\__skrapport_caption_text_style:#2}
        \color@endgroup % !!!
    }
    \dim_compare:nTF{\box_wd:N\l_tmpa_box>\hsize}{
        {\__skrapport_caption_name_style:#1:~}
        {\__skrapport_caption_text_style:#2}
        \par
    }{
        \global\@minipagefalse % !!!
        \hbox_to_wd:nn{\hsize}{
            \hfil
            \box_use_clear:N\l_tmpa_box
            \hfil
        }
    }
    \skip_vertical:N\belowcaptionskip
}
\cs_new:Npn\@pnumwidth{1.55em}
\cs_new:Npn\@tocrmarg{2em}
\cs_new:Npn\@dotsep{1.7}
\setcounter{tocdepth}{3}
\DeclareDocumentCommand\tableofcontents{}{
  \section*{\contentsname}
  \makeatletter
  \@starttoc{toc}
  \makeatother
}
\cs_new:Npn\__skrapport_toc_line:nnnnnn#1#2#3#4#5#6{
    \int_compare:nF{#2>\value{tocdepth}}{
        \skip_vertical:n{0pt~plus~.2pt}
        \group_begin:
            \skip_set:Nn\leftskip{#3}
            \skip_set_eq:NN\rightskip\@tocrmarg
            \skip_set:Nn\parfillskip{-\rightskip}
            \dim_set:Nn\parindent{#3}
            \@afterindenttrue % !!!
            \interlinepenalty\@M % !!!
            \leavevmode
            \skip_set:Nn\@tempdima{#4} % !!! (dumb)
            \skip_add:Nn\leftskip{\@tempdima}
            \null\nobreak
            \skip_horizontal:n{-\leftskip}
            {#5}\nobreak
            \str_if_eq:nnTF{#1}{}{
                \hfill
            }{
                \leaders\hbox:n{
                    \(\mkern\@dotsep mu\hbox{#1}\mkern\@dotsep mu\) % !!!
                }
            }
            \hfill\nobreak
            \hbox_to_wd:nn{\@pnumwidth}{ % !!!
                \hfil\normalfont\normalcolor #6
            }
            \par
        \group_end:
    }
}
\cs_new:Npn\__skrapport_toc_line:nnnnn#1#2#3#4#5{
    \__skrapport_toc_line:nnnnnn{}{#1}{#2}{#3}{#4}{#5}
}
\DeclareDocumentCommand\l@section{mm}{
    \group_begin:
        \skip_vertical:n{.75ex}
        \bfseries
        \__skrapport_toc_line:nnnnn{1}{0em}{1.3em}{#1}{#2}
    \group_end:
}
\DeclareDocumentCommand\l@subsection{mm}{
    \group_begin:
        \skip_vertical:n{.35ex}
        \penalty\@secpenalty % !!!
        \__skrapport_toc_line:nnnnnn{.}{2}{1.3em}{2em}{#1}{#2}
    \group_end:
}
\DeclareDocumentCommand\l@subsubsection{mm}{
    \skip_set:Nn\leftskip{3.3em}
    \dim_set_eq:NN\parindent\c_zero_dim
    \group_begin:
        \cs_set_eq:NN\numberline\use_none:n
        \small #1~[#2]
    \group_end:
}
\DeclareDocumentCommand\l@paragraph{mm}{
    \int_compare:nF{4>\value{tocdepth}}{
        \msg_warning:nnnn{skrapport}{tocdepth-too-deep}
            {4}{\l@paragraph}
    }
}
\DeclareDocumentCommand\l@subparagraph{mm}{
    \int_compare:nF{5>\value{tocdepth}}{
        \msg_warning:nnnn{skrapport}{tocdepth-too-deep}
            {5}{\l@subparagraph}
    }
}
\cs_set:Npn\l@figure{}
\cs_set:Npn\l@table{}
\dim_new:N\bibindent
\dim_set:Nn\bibindent{2em}
\DeclareDocumentEnvironment{thebibliography}{m}{
    \section*{\refname}
    \list{\@biblabel{\arabic{enumiv}}}{
        \dim_set_to_wd:Nn\labelwidth{\@biblabel{#1}}
        \dim_set_eq:NN\leftmargin\labelwidth
        \dim_add:Nn\leftmargin{\labelsep}
        \usecounter{enumiv} % !!!
        \cs_set:Nn\p@enumiv{}
        \RenewDocumentCommand\theenumiv{}{\arabic{enumiv}}
    }
    \sloppy
    \int_set:Nn\clubpenalty{4000}
    \int_set_eq:NN\@clubpenalty\clubpenalty
    \int_set:Nn\widowpenalty{4000}
}{
    \cs_set:Nn\@noitemerr{}
    \endlist
}
\DeclareDocumentCommand\newblock{}{
    \skip_horizontal:n{.11em~plus~.33em~minus~.07em}
}
\DeclareDocumentEnvironment{theindex}{}{
    \begin{multicols}{2}[\section*{\indexname}]
    \thispagestyle{plain}
    \dim_zero:N\parindent
    \skip_set:N\parskip{\c_zero_skip~plus~.3pt}
    \dim_zero:N\columnseprule
    \dim_set:Nn\columnsep{35pt}
    \cs_set_eq:NN\item\@idxitem
}{
    \end{multicols}
}
\DeclareDocumentCommand\@idxitem{}{
    \par
    \dim_set:Nn\hangindent{40pt}
}
\DeclareDocumentCommand\subitem{}{
    \@idxitem
    \hspace*{20pt}
}
\DeclareDocumentCommand\subsubitem{}{
    \@idxitem
    \hspace*{30pt}
}
\DeclareDocumentCommand\indexspace{}{
    \par
    \skip_vertical:n{10pt~plus~5pt~minus~3pt}
}
\cs_new:Npn\__skrapport_comment:n#1{
    {\textbf{\__skrapport_Comment_word: :}~#1}
}
\DeclareDocumentCommand\comment{sm}{
    \IfBooleanTF{#1}
        {
            \cs_if_exist_use:NT\colorbox{{red!50}}
                {\__skrapport_comment:n{#2}}
        }
        {\marginpar{\__skrapport_comment:n{#2}}}
}
\ProvideDocumentCommand\com{sm}
    {\IfBooleanTF{#1}{\comment*{#2}}{\comment{#2}}}
\ProvideDocumentCommand\note{sm}
    {\IfBooleanTF{#1}{\comment*{#2}}{\comment{#2}}}
\cs_new:Nn\__skrapport_space_if_not_punctuation:{
    \clist_if_in:noF
        {{,},:,;,!,?,-,),'}
        {\token_to_meaning:N\l_peek_token}
        {\ }
}
\cs_new_nopar:Nn\__skrapport_peek_punctuation:n{
    \mbox{#1}
    \peek_meaning_remove:NTF.{}{
        \peek_meaning:NF\ {
            \peek_after:Nw\__skrapport_space_if_not_punctuation:
        }
    }
}
\cs_generate_variant:Nn\__skrapport_peek_punctuation:n{x}
\DeclareDocumentCommand\eg{}{
    \__skrapport_peek_punctuation:x{\__skrapport_eg_word:}
}
\DeclareDocumentCommand\ie{}{
    \__skrapport_peek_punctuation:x{\__skrapport_ie_word:}
}
\DeclareDocumentCommand\etc{}{
    \__skrapport_peek_punctuation:x{\__skrapport_etc_word:}
}
\DeclareDocumentCommand\cf{}{
    \__skrapport_peek_punctuation:x{\__skrapport_cf_word:}
}
\DeclareDocumentCommand\viz{}{
    \__skrapport_peek_punctuation:x{\__skrapport_viz_word:}
}
\DeclareDocumentCommand\dash{}{
    \cs_if_exist_use:NT\texorpdfstring
    {\unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}{{ - }}
}
\cs_if_exist_use:NT\DeclareUnicodeCharacter{{2014}{\dash}}
\bool_if:NT\g__skrapport_color_bool{
    \apptocmd{\bfseries}
        {\color{skrapport@boldcolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\bfseries}}
    \apptocmd{\itshape}
        {\color{skrapport@italiccolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\itshape}}
    \apptocmd{\__skrapport_title_style:}
        {\color{skrapport@titlecolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\__skrapport_title_style:}}
    \apptocmd{\__skrapport_smallprint_style:}
        {\color{skrapport@smallprintcolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\__skrapport_smallprint_style:}}
    \apptocmd{\__skrapport_abstract_style:}
        {\color{skrapport@titlecolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\__skrapport_abstract_style:}}
    \apptocmd{\quote}
        {\color{skrapport@quotecolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\quote}}
    \apptocmd{\__skrapport_caption_name_style:}
        {\color{skrapport@captioncolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\__skrapport_caption_name_style:}}
    \apptocmd{\__skrapport_emphstyle:}
        {\color{skrapport@emphcolor}}{}
        {\msg_warning:nnn{skrapport}{color-patch-failed}{\__skrapport_emphstyle:}}
    \AtBeginDocument{\@ifpackageloaded{hyperref}{%
        \hypersetup{%
            citebordercolor=skrapport@citecolor,citecolor=skrapport@citecolor,%
            filebordercolor=skrapport@filecolor,filecolor=skrapport@filecolor,%
            linkbordercolor=skrapport@linkcolor,linkcolor=skrapport@linkcolor,%
            menubordercolor=skrapport@menucolor,menucolor=skrapport@menucolor,%
            urlbordercolor=skrapport@urlcolor,urlcolor=skrapport@urlcolor,%
            runbordercolor=skrapport@runcolor,runcolor=skrapport@runcolor%
        }
    }{}}
    \AtBeginDocument{\color{skrapport@defaultcolor}}
    \DeclareDocumentCommand\colortheme{m}{
        \usepackage{skrapport-colortheme-#1}
    }
    \colortheme{default}
}
\dim_set:Nn\columnsep{10pt}
\dim_zero:N\columnseprule
\pagestyle{plain}
\pagenumbering{arabic}
\raggedbottom
\onecolumn
\endinput

