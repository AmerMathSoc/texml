%%
%% This is file `l3doc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% l3doc.dtx  (with options: `class')
%% 
%% EXPERIMENTAL CODE
%% 
%% Do not distribute this file without also distributing the
%% source files specified above.
%% 
%% Do not distribute a modified version of this file.
%% 
%% File: l3doc.dtx Copyright (C) 1990-2016 The LaTeX3 project
%%
%% It may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License (LPPL), either version 1.3c of this
%% license or (at your option) any later version.  The latest version
%% of this license is in the file
%%
%%    http://www.latex-project.org/lppl.txt
%%
%% This file is part of the "l3kernel bundle" (The Work in LPPL)
%% and all files in that bundle must be distributed together.
%%
%% The released version of this bundle is available from CTAN.
%%
%% -----------------------------------------------------------------------
%%
%% The development version of the bundle can be found at
%%
%%    http://www.latex-project.org/svnroot/experimental/trunk/
%%
%% for those people who are interested.
%%
%%%%%%%%%%%
%% NOTE: %%
%%%%%%%%%%%
%%
%%   Snapshots taken from the repository represent work in progress and may
%%   not work or may contain conflicting material!  We therefore ask
%%   people _not_ to put them into distributions, archives, etc. without
%%   prior consultation with the LaTeX3 Project.
%%
%% -----------------------------------------------------------------------
\let        \filenameOld        \ExplFileName
\let        \filedateOld        \ExplFileDate
\let     \fileversionOld        \ExplFileVersion
\let \filedescriptionOld        \ExplFileDescription
\RequirePackage{expl3,xparse,calc}
\GetIdInfo$Id: l3doc.dtx 6474 2016-04-11 18:09:21Z qinglee $
          {L3 Experimental documentation class}
\ProvidesExplClass
  {\ExplFileName}{\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}
\let        \ExplFileName        \filenameOld
\let        \ExplFileDate        \filedateOld
\let        \ExplFileVersion     \fileversionOld
\let        \ExplFileDescription \filedescriptionOld
\cs_generate_variant:Nn \tl_count:n { f }
\cs_generate_variant:Nn \tl_greplace_all:Nnn { Nx }
\cs_generate_variant:Nn \tl_if_head_eq_charcode:nNTF { o }
\cs_generate_variant:Nn \tl_if_head_eq_charcode:nNT  { o }
\cs_generate_variant:Nn \tl_if_head_eq_charcode:nNF  { o }
\cs_generate_variant:Nn \tl_if_in:NnTF { No }
\cs_generate_variant:Nn \tl_if_in:NnT  { No }
\cs_generate_variant:Nn \tl_if_in:NnF  { No }
\cs_generate_variant:Nn \tl_remove_all:Nn   { Nx }
\cs_generate_variant:Nn \tl_replace_all:Nnn { Nx , Nnx, No , Nno }
\cs_generate_variant:Nn \tl_replace_once:Nnn { Noo }
\cs_generate_variant:Nn \prop_get:NnNTF { Nx }
\cs_generate_variant:Nn \prop_put:Nnn { Nx }
\cs_generate_variant:Nn \prop_gput:Nnn { NVx }
\cs_new_protected:Npn \__codedoc_replace_at_at:N #1
  {
    \tl_if_empty:NF \g__codedoc_module_name_tl
      {
        \exp_args:NNo \__codedoc_replace_at_at_aux:Nn
          #1 \g__codedoc_module_name_tl
      }
  }
\cs_new_protected:Npn \__codedoc_replace_at_at_aux:Nn #1#2
  {
    \tl_replace_all:Non #1 { \token_to_str:N @ } { @ }
    \tl_replace_all:Non #1 { \token_to_str:N _ } { _ }
    \tl_replace_all:Nnn #1 { _ @ @ } { _ _ #2 }
    \tl_replace_all:Nnn #1 {   @ @ } { _ _ #2 }
  }
\cs_new_protected:Npn \__codedoc_verb_get_seq:nN #1#2
  {
    \tl_set:Nx \l__codedoc_tmpa_tl { \tl_to_str:n {#1} }
    \tl_remove_all:Nx \l__codedoc_tmpa_tl
      { \iow_char:N \^^M \iow_char:N \% }
    \tl_remove_all:Nx \l__codedoc_tmpa_tl { \tl_to_str:n { ^ ^ A } }
    \tl_remove_all:Nx \l__codedoc_tmpa_tl { \iow_char:N \^^I }
    \tl_remove_all:Nx \l__codedoc_tmpa_tl { \iow_char:N \^^M }
    \__codedoc_replace_at_at:N \l__codedoc_tmpa_tl
    \exp_args:NNx \seq_set_from_clist:Nn #2
      { \tl_to_str:N \l__codedoc_tmpa_tl }
  }
\cs_new:Npn \__codedoc_signature_base_form:n #1
  { \__codedoc_signature_base_form_aux:n #1 \c_empty_tl }
\cs_new:Npn \__codedoc_signature_base_form_aux:n #1
  {
    \str_case:nnTF {#1}
      {
        { N } { N }
        { c } { N }
        { n } { n }
        { o } { n }
        { f } { n }
        { x } { n }
        { V } { n }
        { v } { n }
      }
      { \__codedoc_signature_base_form_aux:n }
      {#1}
  }
\cs_new:Npn \__codedoc_predicate_from_base:N #1
  {
    \__cs_get_function_name:N #1 _p:
    \__cs_get_function_signature:N #1
  }
\cs_new_protected:Npn \CodedocUseCs #1 { \use:c { \tl_to_str:n {#1} } }
\cs_new:Npn \CodedocUnexpandedTokens #1 #
  { \use:c { CodedocUnexpandedTokens ~ } \__codedoc_exp_not:n }
\cs_new_protected:cpn { CodedocUnexpandedTokens ~ } #1#2 {#2}
\cs_new:Npn \__codedoc_exp_not:n #1 { \exp_not:n { \__codedoc_exp_not:n {#1} } }
\clist_new:N \g_docinput_clist
\seq_new:N \g_doc_functions_seq
\seq_new:N \g_doc_macros_seq
\coffin_new:N \l__codedoc_output_coffin
\coffin_new:N \l__codedoc_names_coffin
\coffin_new:N \l__codedoc_descr_coffin
\coffin_new:N \l__codedoc_syntax_coffin
\box_new:N \g__codedoc_syntax_box
\bool_new:N \l__codedoc_long_name_bool
\dim_new:N \l__codedoc_trial_width_dim
\int_new:N \l__codedoc_nested_macro_int
\bool_new:N \l__codedoc_macro_tested_bool
\prop_new:N \g__codedoc_missing_tests_prop
\seq_new:N \g__codedoc_not_tested_seq
\seq_new:N \g__codedoc_testfiles_seq
\bool_new:N \l__codedoc_macro_internal_bool
\bool_new:N \l__codedoc_macro_aux_bool
\bool_new:N \l__codedoc_macro_TF_bool
\bool_new:N \l__codedoc_macro_pTF_bool
\bool_new:N \l__codedoc_macro_EXP_bool
\bool_new:N \l__codedoc_macro_rEXP_bool
\bool_new:N \l__codedoc_macro_var_bool
\bool_new:N \g__codedoc_lmodern_bool
\bool_new:N \g__codedoc_checkfunc_bool
\bool_new:N \g__codedoc_checktest_bool
\tl_new:N \l__codedoc_tmpa_tl
\tl_new:N \l__codedoc_tmpb_tl
\int_new:N \l__codedoc_tmpa_int
\prop_new:N \l__codedoc_functions_block_prop
\seq_new:N \l__codedoc_function_input_seq
\seq_new:N \l__codedoc_macro_input_seq
\tl_const:Nx \c__codedoc_backslash_tl { \iow_char:N \\ }
\exp_last_unbraced:NNo
  \cs_new_eq:NN \c__codedoc_backslash_token { \c__codedoc_backslash_tl }
\tl_new:N \g__codedoc_function_name_prefix_tl
\tl_new:N \l__codedoc_index_macro_tl
\tl_new:N \l__codedoc_index_key_tl
\tl_new:N \l__codedoc_index_module_tl
\tl_new:N \g__codedoc_module_name_tl
\tl_const:Nn \c__codedoc_iow_rule_tl
  { ======================================== }
\tl_const:Nn \c__codedoc_iow_mid_rule_tl
  { -------------------------------------- }
\box_new:N \l__codedoc_macro_index_box
\box_new:N \l__codedoc_macro_box
\int_new:N \l__codedoc_macro_int
\tl_new:N \l__codedoc_cmd_tl
\tl_new:N \l__codedoc_cmd_index_tl
\bool_new:N \l__codedoc_cmd_replace_bool
\bool_new:N \l__codedoc_in_implementation_bool
\bool_new:N \g__codedoc_typeset_documentation_bool
\bool_new:N \g__codedoc_typeset_implementation_bool
\bool_set_true:N \g__codedoc_typeset_documentation_bool
\bool_set_true:N \g__codedoc_typeset_implementation_bool
\tl_new:N \g__codedoc_base_name_tl
\prop_new:N \l__codedoc_variants_prop
\bool_new:N \l__codedoc_no_label_bool
\cs_new_eq:NN \__codedoc_tmpa:w ?
\cs_new_eq:NN \__codedoc_tmpb:w ?
\DeclareOption { a5paper } { \@latexerr { Option~not~supported } { } }
\DeclareOption { full }
  {
    \bool_gset_true:N \g__codedoc_typeset_documentation_bool
    \bool_gset_true:N \g__codedoc_typeset_implementation_bool
  }
\DeclareOption { onlydoc }
  {
    \bool_gset_true:N \g__codedoc_typeset_documentation_bool
    \bool_gset_false:N \g__codedoc_typeset_implementation_bool
  }
\DeclareOption { check }
  { \bool_gset_true:N \g__codedoc_checkfunc_bool }
\DeclareOption { nocheck }
  { \bool_gset_false:N \g__codedoc_checkfunc_bool }
\DeclareOption { checktest }
  { \bool_gset_true:N \g__codedoc_checktest_bool }
\DeclareOption { nochecktest }
  { \bool_gset_false:N \g__codedoc_checktest_bool }
\DeclareOption { cm-default }
  { \bool_gset_false:N \g__codedoc_lmodern_bool }
\DeclareOption { lm-default }
  { \bool_gset_true:N \g__codedoc_lmodern_bool }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { article } }
\ExecuteOptions { full, a4paper, nocheck, nochecktest, lm-default }
\msg_new:nnn { l3doc } { input-cfg }
  { Local~config~file~l3doc.cfg~loaded. }
\file_if_exist:nT { l3doc.cfg }
  {
    \file_input:nT { l3doc.cfg }
      {
        \cs_if_exist:cF { ExplMakeTitle }
          { \msg_info:nn { l3doc } { input-cfg } }
      }
  }
\ProcessOptions
\LoadClass{article}
\RequirePackage{doc}
\RequirePackage
  {
    array,
    alphalph,
    amsmath,
    amssymb,
    booktabs,
    color,
    colortbl,
    hologo,
    enumitem,
    pifont,
    textcomp,
    trace,
    underscore,
    csquotes,
    fancyvrb,
    verbatim
  }
\raggedbottom
\bool_if:NT \g__codedoc_lmodern_bool
  {
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
    \group_begin:
      \ttfamily
      \DeclareFontShape{T1}{lmtt}{m}{it}{<->ec-lmtto10}{}
    \group_end:
  }
\RequirePackage{hypdoc}
\cs_gset_nopar:Npn \MakePrivateLetters
  {
    \char_set_catcode_letter:N \@
    \char_set_catcode_letter:N \_
    \char_set_catcode_letter:N \:
  }
\setcounter{StandardModuleDepth}{1}
\@addtoreset{CodelineNo}{part}
\tl_replace_once:Nnn \theCodelineNo
  { \HDorg@theCodelineNo }
  { \textcolor[gray]{0.5} { \sffamily\tiny\arabic{CodelineNo} } }
\fvset{gobble=2}
\cs_gset_eq:NN \verbatim \Verbatim
\cs_gset_eq:NN \endverbatim \endVerbatim
\setlength   \textwidth      { 385pt }
\addtolength \marginparwidth {  30pt }
\addtolength \oddsidemargin  {  20pt }
\addtolength \evensidemargin {  20pt }
\cs_new_eq:NN \__codedoc_oldlist:nn \list
\cs_gset_nopar:Npn \list #1 #2
  { \__codedoc_oldlist:nn {#1} { #2 \dim_zero:N \listparindent } }
\setlength \parindent  { 2em }
\setlength \itemindent { 0pt }
\setlength \parskip    { 0pt plus 3pt minus 0pt }
\tl_gset:Nn \partname {File}
\@addtoreset{section}{part}
\cs_gset_nopar:Npn \l@section #1#2
  {
    \ifnum \c@tocdepth >\z@
      \addpenalty\@secpenalty
      \addvspace{1.0em \@plus\p@}
      \setlength\@tempdima{2.5em}  % was 1.5em
      \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode \bfseries
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \endgroup
    \fi
  }
\cs_gset_nopar:Npn \l@subsection
  { \@dottedtocline{2}{2.5em}{2.3em} }  % #2 = 1.5em
\AtBeginDocument
  {
    \MakeShortVerb \"
    \MakeShortVerb \|
  }
\AtEndDocument
  {
    \DeleteShortVerb \"
    \DeleteShortVerb \|
  }
\providecommand*\eTeX{\hologo{eTeX}}
\providecommand*\IniTeX{\hologo{iniTeX}}
\providecommand*\Lua{Lua}
\providecommand*\LuaTeX{\hologo{LuaTeX}}
\providecommand*\pdfTeX{\hologo{pdfTeX}}
\providecommand*\XeTeX{\hologo{XeTeX}}
\providecommand*\pTeX{p\kern-.2em\hologo{TeX}}
\providecommand*\upTeX{up\kern-.2em\hologo{TeX}}
\providecommand*\epTeX{$\varepsilon$-\pTeX}
\providecommand*\eupTeX{$\varepsilon$-\upTeX}
\DeclareExpandableDocumentCommand \cmd { O{} m }
  { \__codedoc_cmd:no {#1} { \token_to_str:N #2 } }
\DeclareExpandableDocumentCommand \cs  { O{} m }
  { \__codedoc_cmd:no {#1} { \c__codedoc_backslash_tl #2 } }
\DeclareExpandableDocumentCommand \tn  { O{} m }
  {
    \__codedoc_cmd:no
      { index = TeX , replace = false , #1 }
      { \c__codedoc_backslash_tl #2 }
  }
\DeclareExpandableDocumentCommand { \meta } { m }
  { \__codedoc_meta:n {#1} }
\newcommand\Arg[1]
  { \texttt{\char`\{} \meta{#1} \texttt{\char`\}} }
\providecommand\marg[1]{ \Arg{#1} }
\providecommand\oarg[1]{ \texttt[ \meta{#1} \texttt] }
\providecommand\parg[1]{ \texttt( \meta{#1} \texttt) }
\DeclareRobustCommand \file {\nolinkurl}
\DeclareRobustCommand \env {\texttt}
\DeclareRobustCommand \pkg {\textsf}
\DeclareRobustCommand \cls {\textsf}
\NewDocumentCommand \EnableDocumentation { }
  { \bool_gset_true:N \g__codedoc_typeset_documentation_bool }
\NewDocumentCommand \EnableImplementation { }
  { \bool_gset_true:N \g__codedoc_typeset_implementation_bool }
\NewDocumentCommand \DisableDocumentation { }
  { \bool_gset_false:N \g__codedoc_typeset_documentation_bool }
\NewDocumentCommand \DisableImplementation { }
  { \bool_gset_false:N \g__codedoc_typeset_implementation_bool }
\NewDocumentEnvironment { documentation } { }
  {
    \bool_if:NTF \g__codedoc_typeset_documentation_bool
      { \bool_set_false:N \l__codedoc_in_implementation_bool }
      { \comment }
  }
  { \bool_if:NF \g__codedoc_typeset_documentation_bool { \endcomment } }
\NewDocumentEnvironment { implementation } { }
  {
    \bool_if:NTF \g__codedoc_typeset_implementation_bool
      { \bool_set_true:N \l__codedoc_in_implementation_bool }
      { \comment }
  }
  { \bool_if:NF \g__codedoc_typeset_implementation_bool { \endcomment } }
\DeclareDocumentEnvironment { variable } { O{} +v }
  {
    \bool_if:NTF \l__codedoc_in_implementation_bool
      { \__codedoc_macro:nnw { var , #1 } {#2} }
      { \__codedoc_function:nnw {#1} {#2} }
  }
  {
    \bool_if:NTF \l__codedoc_in_implementation_bool
      { \__codedoc_macro_end: }
      { \__codedoc_function_end: }
  }
\DeclareDocumentEnvironment { function } { O{} +v }
  { \__codedoc_function:nnw {#1} {#2} }
  { \__codedoc_function_end: }
\DeclareDocumentEnvironment { macro } { O{} +v }
  { \__codedoc_macro:nnw {#1} {#2} }
  { \__codedoc_macro_end: }
\NewDocumentEnvironment { syntax } { }
  { \__codedoc_syntax:w }
  {
    \__codedoc_syntax_end:
    \ignorespacesafterend
  }
\NewDocumentEnvironment { texnote } { }
  {
    \endgraf
    \vspace{3mm}
    \small\textbf{\TeX~hackers~note:}
  }
  {
    \vspace{3mm}
  }
\NewDocumentEnvironment { arguments } { }
  {
    \enumerate [
      nolistsep ,
      label = \texttt{\#\arabic*} ~ : ,
      labelsep = * ,
    ]
  }
  {
    \endenumerate
  }
\keys_define:nn { l3doc/cmd }
  {
    index     .tl_set:N     = \l__codedoc_cmd_index_tl        ,
    replace   .bool_set:N   = \l__codedoc_cmd_replace_bool    ,
  }
\cs_new:Npn \__codedoc_cmd:nn #1#2
  {
    \texorpdfstring
      {
        \CodedocUnexpandedTokens
          { \CodedocUseCs { __codedoc_cmd_aux:nn } {#1} {#2} }
      }
      {#2}
  }
\cs_generate_variant:Nn \__codedoc_cmd:nn { no }
\cs_new_protected:Npn \__codedoc_cmd_aux:nn #1#2
  {
    \bool_set_true:N \l__codedoc_cmd_replace_bool
    \tl_set:Nn \l__codedoc_cmd_index_tl { \q_no_value }
    \keys_set:nn { l3doc/cmd } {#1}
    \tl_set:No \l__codedoc_cmd_tl { \token_to_str:N #2 }
    \bool_if:NT \l__codedoc_cmd_replace_bool
      {
        \tl_set_rescan:Nnn \l__codedoc_tmpb_tl { } { _ }
        \tl_replace_all:Non \l__codedoc_cmd_tl \l__codedoc_tmpb_tl { _ }
        \__codedoc_replace_at_at:N \l__codedoc_cmd_tl
        \tl_replace_all:Nno \l__codedoc_cmd_tl { _ } \l__codedoc_tmpb_tl
      }
    \mode_if_math:T { \mbox }
    {
      \verbatim@font
      \int_compare:nNnF
        { \tl_count:N \l__codedoc_cmd_tl }
        < { \tl_count:f { \tl_to_str:N \l__codedoc_cmd_tl } }
        {
          \tl_set:Nx \l__codedoc_cmd_tl { \tl_to_str:N \l__codedoc_cmd_tl }
          \tl_replace_all:Non \l__codedoc_cmd_tl
            { \token_to_str:N _ } { \_ }
        }
      \tl_replace_all:Nnn \l__codedoc_cmd_tl { ~ } { \@xobeysp }
      \l__codedoc_cmd_tl
    }
    \exp_args:No \__codedoc_key_get:n { \l__codedoc_cmd_tl }
    \quark_if_no_value:NF \l__codedoc_cmd_index_tl
      { \tl_set_eq:NN \l__codedoc_index_module_tl \l__codedoc_cmd_index_tl }
    \__codedoc_special_index_module:ooon
      { \l__codedoc_index_key_tl }
      { \l__codedoc_index_macro_tl }
      { \l__codedoc_index_module_tl }
      { }
  }
\cs_new:Npn \__codedoc_meta:n #1
  {
    \texorpdfstring
      {
        \CodedocUnexpandedTokens
          { \CodedocUseCs { __codedoc_meta_aux:n } {#1} }
      }
      { < #1 > }
  }
\cs_new_protected:Npn \__codedoc_meta_aux:n #1
  {
    \tl_set:Nn \l__codedoc_tmpa_tl {#1}
    \tl_map_inline:nn
      { { 3 } { 4 } { 7 } { 8 } { 11 } { 12 } { 13 } }
      {
        \tl_set_rescan:Nnn \l__codedoc_tmpb_tl
          { \char_set_catcode:nn { `_ } {##1} } { _ }
        \tl_replace_all:Non \l__codedoc_tmpa_tl \l__codedoc_tmpb_tl
          { \__codedoc_ensuremath_sb:n }
      }
    \exp_args:NV \__codedoc_meta_original:n \l__codedoc_tmpa_tl
  }
\cs_new_protected:Npn \__codedoc_ensuremath_sb:n #1
  { \ensuremath { \sb {#1} } }
\cs_new_protected:Npn \__codedoc_meta_original:n #1
  {
    \ensuremath \langle
    \mode_if_math:T { \nfss@text }
    {
      \meta@font@select
      \edef \meta@hyphen@restore
        { \hyphenchar \the \font \the \hyphenchar \font }
      \hyphenchar \font \m@ne
      \language \l@nohyphenation
      #1 \/
      \meta@hyphen@restore
    }
    \ensuremath \rangle
  }
\keys_define:nn { l3doc/function }
  {
    TF .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_TF_bool
      } ,
    EXP .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_EXP_bool
        \bool_set_false:N \l__codedoc_macro_rEXP_bool
      } ,
    rEXP .code:n =
      {
        \bool_set_false:N \l__codedoc_macro_EXP_bool
        \bool_set_true:N \l__codedoc_macro_rEXP_bool
      } ,
    pTF .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_pTF_bool
        \bool_set_true:N \l__codedoc_macro_TF_bool
        \bool_set_true:N \l__codedoc_macro_EXP_bool
        \bool_set_false:N \l__codedoc_macro_rEXP_bool
      } ,
    added .tl_set:N = \l__codedoc_date_added_tl ,
    updated .tl_set:N = \l__codedoc_date_updated_tl ,
    tested .code:n = { } ,
    no-label .bool_set:N = \l__codedoc_no_label_bool ,
  }
\cs_new_protected:Npn \__codedoc_function:nnw #1#2
  {
    \__codedoc_function_typeset_start:
    \__codedoc_function_init:
    \keys_set:nn { l3doc/function } {#1}
    \__codedoc_verb_get_seq:nN {#2} \l__codedoc_function_input_seq
    \__codedoc_function_parse:
    \__codedoc_function_typeset:
    \__codedoc_function_descr_start:w
  }
\cs_new_protected_nopar:Npn \__codedoc_function_end:
  {
    \__codedoc_function_descr_stop:
    \__codedoc_function_assemble:
    \__codedoc_function_typeset_stop:
  }
\cs_new_protected_nopar:Npn \__codedoc_function_typeset_start:
  {
    \par \bigskip \noindent
    \phantomsection
  }
\cs_new_protected_nopar:Npn \__codedoc_function_typeset_stop:
  {
    \par
    \allowbreak
  }
\group_begin:
  \char_set_catcode_active:N \<
  \cs_new_protected:Npn \__codedoc_function_init:
    {
      \coffin_clear:N \l__codedoc_descr_coffin
      \box_gclear:N \g__codedoc_syntax_box
      \coffin_clear:N \l__codedoc_syntax_coffin
      \coffin_clear:N \l__codedoc_names_coffin
      \bool_set_false:N \l__codedoc_macro_TF_bool
      \bool_set_false:N \l__codedoc_macro_pTF_bool
      \bool_set_false:N \l__codedoc_macro_EXP_bool
      \bool_set_false:N \l__codedoc_macro_rEXP_bool
      \bool_set_false:N \l__codedoc_no_label_bool
      \char_set_catcode_active:N \<
      \cs_set_protected_nopar:Npn < ##1 > { \meta {##1} }
  }
\group_end:
\cs_new_protected_nopar:Npn \__codedoc_function_parse:
  {
    \seq_map_function:NN
      \l__codedoc_function_input_seq
      \__codedoc_function_parse_one:n
  }
\cs_new_protected:Npn \__codedoc_function_parse_one:n #1
  {
    \tl_if_head_eq_charcode:nNTF {#1} \c__codedoc_backslash_token
      {
        \tl_gset_eq:NN \g__codedoc_function_name_prefix_tl \c__codedoc_backslash_tl
        \exp_args:No \tl_if_head_eq_charcode:nNTF { \use_none:n #1 } :
          {
            \prop_put:Nxn \l__codedoc_functions_block_prop
              { \use_none:n #1 } { \scan_stop: }
          }
          {
            \exp_args:Nc \__cs_split_function:NN { \use_none:n #1 }
              \__codedoc_function_parse_cs_aux:nnN
          }
      }
      {
        \tl_gclear:N \g__codedoc_function_name_prefix_tl
        \prop_put:Nnn \l__codedoc_functions_block_prop {#1} { \scan_stop: }
      }
  }
\cs_new_protected:Npn \__codedoc_function_parse_cs_aux:nnN #1#2#3
  {
    \prop_get:NnNF
      \l__codedoc_functions_block_prop {#1} \l__codedoc_tmpb_tl
      { \tl_clear:N \l__codedoc_tmpb_tl }
    \prop_put:Nnx \l__codedoc_functions_block_prop {#1}
      {
        \l__codedoc_tmpb_tl ,
        \bool_if:NTF #3 { {#2} } { \scan_stop: }
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_function_typeset:
  {
    \dim_zero:N \l__codedoc_trial_width_dim
    \hcoffin_set:Nn \l__codedoc_names_coffin { \__codedoc_typeset_names: }
    \dim_set:Nn \l__codedoc_trial_width_dim
      { \box_wd:N \l__codedoc_names_coffin }
    \bool_set:Nn \l__codedoc_long_name_bool
      { \dim_compare_p:nNn \l__codedoc_trial_width_dim > \marginparwidth }
  }
\cs_new_protected_nopar:Npn \__codedoc_function_descr_start:w
  {
    \vcoffin_set:Nnw \l__codedoc_descr_coffin { \textwidth }
      \noindent \ignorespaces
  }
\cs_new_protected_nopar:Npn \__codedoc_function_descr_stop:
  { \vcoffin_set_end: }
\cs_new_protected_nopar:Npn \__codedoc_function_assemble:
  {
    \hcoffin_set:Nn  \l__codedoc_syntax_coffin
      { \box_use:N \g__codedoc_syntax_box }
    \bool_if:NTF \l__codedoc_long_name_bool
      {
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {hc} {vc}
          \l__codedoc_syntax_coffin {l} {T}
          {0pt} {0pt}
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {l} {t}
          \l__codedoc_names_coffin  {r} {t}
          {-\marginparsep} {0pt}
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {l} {b}
          \l__codedoc_descr_coffin  {l} {t}
          {0.75\marginparwidth + \marginparsep} {-\medskipamount}
        \coffin_typeset:Nnnnn \l__codedoc_output_coffin
          {\l__codedoc_descr_coffin-l} {\l__codedoc_descr_coffin-t}
          {0pt} {0pt}
      }
      {
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {hc} {vc}
          \l__codedoc_syntax_coffin {l} {t}
          {0pt} {0pt}
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {l} {b}
          \l__codedoc_descr_coffin  {l} {t}
          {0pt} {-\medskipamount}
        \coffin_join:NnnNnnnn
          \l__codedoc_output_coffin {l} {t}
          \l__codedoc_names_coffin  {r} {t}
          {-\marginparsep} {0pt}
        \coffin_typeset:Nnnnn \l__codedoc_output_coffin
          {\l__codedoc_syntax_coffin-l} {\l__codedoc_syntax_coffin-T}
          {0pt} {0pt}
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_typeset_names:
  {
    \small\ttfamily
    \begin{tabular} { @{} l @{} r @{} }
      \toprule
      \__codedoc_typeset_functions:
      \__codedoc_typeset_dates:
      \bottomrule
    \end{tabular}
    \normalfont\normalsize
  }
\cs_new_protected_nopar:Npn \__codedoc_typeset_functions:
  {
    \prop_map_function:NN \l__codedoc_functions_block_prop
      \__codedoc_typeset_functions_auxi:nn
  }
\cs_new_protected:Npn \__codedoc_typeset_functions_auxi:nn #1#2
  {
    \tl_gset:Nn \g__codedoc_base_name_tl {#1}
    \prop_clear:N \l__codedoc_variants_prop
    \clist_map_inline:nn {#2}
      {
        \tl_set:Nx \l__codedoc_tmpa_tl
          { \__codedoc_signature_base_form:n {##1} }
        \prop_get:NoNTF \l__codedoc_variants_prop
          \l__codedoc_tmpa_tl \l__codedoc_tmpb_tl
          { \tl_put_right:Nn \l__codedoc_tmpb_tl { , {##1} } }
          { \tl_set:Nn \l__codedoc_tmpb_tl { {##1} } }
        \prop_put:Noo \l__codedoc_variants_prop
          \l__codedoc_tmpa_tl \l__codedoc_tmpb_tl
      }
    \prop_map_function:NN \l__codedoc_variants_prop
      \__codedoc_typeset_functions_auxii:nn
  }
\cs_new_protected:Npn \__codedoc_typeset_functions_auxii:nn #1#2
  {
    \clist_gset:Nn \g__codedoc_variants_clist {#2}
    \clist_gpop:NN \g__codedoc_variants_clist \l__codedoc_tmpb_tl
    \exp_args:Nc \__codedoc_typeset_functions_auxiii:N
      {
        \g__codedoc_base_name_tl
        \exp_last_unbraced:Nf \token_if_eq_meaning:NNF
          { \tl_head:f { \l__codedoc_tmpb_tl ? } }
          \scan_stop:
          { : \l__codedoc_tmpb_tl }
      }
  }
\cs_new_protected:Npn \__codedoc_typeset_functions_auxiii:N #1
  {
    \bool_if:NT \l__codedoc_macro_pTF_bool
      {
        \tl_set:Nx \l__codedoc_pTF_name_tl
          { \__codedoc_predicate_from_base:N #1 }
        \__codedoc_function_index:x { \l__codedoc_pTF_name_tl }
      }
    \__codedoc_function_index:x
      {
        \cs_to_str:N #1
        \bool_if:NT \l__codedoc_macro_TF_bool { \tl_to_str:n {TF} }
      }
    \bool_if:NT \l__codedoc_macro_pTF_bool
      {
        \exp_args:Nc \__codedoc_typeset_function_block:NN
          { \l__codedoc_pTF_name_tl } \c_false_bool
      }
    \__codedoc_typeset_function_block:NN #1 \l__codedoc_macro_TF_bool
  }
\cs_new_protected:Npn \__codedoc_function_index:x #1
  {
    \tl_set:Nx \l__codedoc_tmpa_tl
      { \g__codedoc_function_name_prefix_tl #1 }
    \seq_gput_right:No \g_doc_functions_seq { \l__codedoc_tmpa_tl }
    \__codedoc_special_index:on { \l__codedoc_tmpa_tl } { usage }
  }
\cs_new_protected:Npn \__codedoc_typeset_function_block:NN #1#2
  {
    \__codedoc_function_label:x
      { \g__codedoc_function_name_prefix_tl \cs_to_str:N #1 }
    \g__codedoc_function_name_prefix_tl \cs_to_str:N #1
    \bool_if:NT #2 { \__codedoc_typeset_TF: }
    \__codedoc_typeset_expandability:
    \clist_if_empty:NF \g__codedoc_variants_clist
      { \__codedoc_typeset_variant_list:NN #1#2 }
    \\
  }
\cs_new_protected_nopar:Npn \__codedoc_typeset_expandability:
  {
    &
    \bool_if:NT \l__codedoc_macro_EXP_bool
      {
        \hspace{\tabcolsep}
        \hyperlink{expstar} {$\star$}
      }
    \bool_if:NT \l__codedoc_macro_rEXP_bool
      {
        \hspace{\tabcolsep}
        \hyperlink{rexpstar} {\ding{73}} % hollow star
      }
  }
\cs_new_protected:Npn \__codedoc_typeset_variant_list:NN #1#2
  {
    \\
    \__codedoc_typeset_aux:n
      {
        \g__codedoc_function_name_prefix_tl
        \__cs_get_function_name:N #1
      }
    :
    \int_compare:nTF { \clist_count:N \g__codedoc_variants_clist == 1 }
      { \clist_use:Nn \g__codedoc_variants_clist { } }
      {
        \textrm(
          \clist_use:Nn \g__codedoc_variants_clist { \textrm| }
        \textrm)
      }
    \bool_if:NT #2 { \__codedoc_typeset_TF: }
    \__codedoc_typeset_expandability:
  }
\cs_new_protected:Npn \__codedoc_function_label:n #1
  {
    % \bool_if:NT \g__codedoc_typeset_implementation_bool
    %   {
    \bool_if:NF \l__codedoc_no_label_bool
      {
        \__codedoc_get_hyper_target:nN {#1} \l__codedoc_tmpa_tl
        \exp_args:No \label { \l__codedoc_tmpa_tl }
      }
    %   }
  }
\cs_generate_variant:Nn \__codedoc_function_label:n { x }
\cs_new_nopar:Npn \__codedoc_typeset_dates:
  {
    \bool_if:nF
      {
        \tl_if_empty_p:N \l__codedoc_date_added_tl &&
        \tl_if_empty_p:N \l__codedoc_date_updated_tl
      }
      { \midrule }
    \tl_if_empty:NF \l__codedoc_date_added_tl
      {
        \multicolumn { 2 } { @{} r @{} }
          { \scriptsize New: \, \l__codedoc_date_added_tl } \\
      }

    \tl_if_empty:NF \l__codedoc_date_updated_tl
      {
        \multicolumn { 2 } { @{} r @{} }
          { \scriptsize Updated: \, \l__codedoc_date_updated_tl } \\
      }
  }
\dim_new:N \l__codedoc_syntax_dim
\cs_new_protected:Npn \__codedoc_syntax:w
  {
    \dim_set:Nn \l__codedoc_syntax_dim
      {
        \textwidth
        \bool_if:NT \l__codedoc_long_name_bool
          { + 0.75 \marginparwidth - \l__codedoc_trial_width_dim }
      }
    \hbox_gset:Nw \g__codedoc_syntax_box
      \small \ttfamily
      \arrayrulecolor{white}
      \begin{tabular} { @{} l @{} }
        \toprule
        \begin{minipage}{\l__codedoc_syntax_dim}
          \raggedright
          \obeyspaces
          \obeylines
  }
\cs_new_protected:Npn \__codedoc_syntax_end:
  {
        \end{minipage}
      \end{tabular}
      \arrayrulecolor{black}
    \hbox_gset_end:
  }
\keys_define:nn { l3doc/macro }
  {
    aux .code:n =
      { \bool_set_true:N \l__codedoc_macro_aux_bool } ,
    internal .code:n =
      { \bool_set_true:N \l__codedoc_macro_internal_bool } ,
    int .code:n =
      { \bool_set_true:N \l__codedoc_macro_internal_bool } ,
    var .code:n =
      { \bool_set_true:N \l__codedoc_macro_var_bool } ,
    TF .code:n =
      { \bool_set_true:N \l__codedoc_macro_TF_bool } ,
    pTF .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_TF_bool
        \bool_set_true:N \l__codedoc_macro_pTF_bool
        \bool_set_true:N \l__codedoc_macro_EXP_bool
        \bool_set_false:N \l__codedoc_macro_rEXP_bool
      } ,
    EXP .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_EXP_bool
        \bool_set_false:N \l__codedoc_macro_rEXP_bool
      } ,
    rEXP .code:n =
      {
        \bool_set_false:N \l__codedoc_macro_EXP_bool
        \bool_set_true:N \l__codedoc_macro_rEXP_bool
      } ,
    tested .code:n =
      {
        \bool_set_true:N \l__codedoc_macro_tested_bool
      } ,
    added .code:n = {} , % TODO
    updated .code:n = {} , % TODO
  }
\cs_new_protected:Npn \__codedoc_macro:nnw #1#2
  {
    \__codedoc_macro_init:
    \keys_set:nn { l3doc/macro } {#1}
    \__codedoc_verb_get_seq:nN {#2} \l__codedoc_macro_input_seq
    \__codedoc_macro_map:N \__codedoc_macro_single:n
    \__codedoc_macro_typeset:
  }
\cs_new_protected_nopar:Npn \__codedoc_macro_init:
  {
    \int_incr:N \l__codedoc_nested_macro_int
    \bool_set_false:N \l__codedoc_macro_aux_bool
    \bool_set_false:N \l__codedoc_macro_internal_bool
    \bool_set_false:N \l__codedoc_macro_TF_bool
    \bool_set_false:N \l__codedoc_macro_pTF_bool
    \bool_set_false:N \l__codedoc_macro_EXP_bool
    \bool_set_false:N \l__codedoc_macro_rEXP_bool
    \bool_set_false:N \l__codedoc_macro_var_bool
    \bool_set_false:N \l__codedoc_macro_tested_bool
    \cs_set_eq:NN \testfile \__codedoc_print_testfile:n
    \box_clear:N \l__codedoc_macro_index_box
    \vbox_set:Nn \l__codedoc_macro_box
      {
        \hbox:n { \strut }
        \vskip \int_eval:n { \l__codedoc_macro_int - 1 } \baselineskip
      }
  }
\cs_new_protected:Npn \__codedoc_macro_map:N #1
  {
    \bool_if:NT \l__codedoc_macro_pTF_bool
      {
        \bool_set_false:N \l__codedoc_macro_TF_bool
        \seq_map_inline:Nn \l__codedoc_macro_input_seq
          {
            \tl_set:Nn \l__codedoc_tmpa_tl {##1}
            \tl_replace_once:Noo \l__codedoc_tmpa_tl
              { \tl_to_str:n { : } } { \tl_to_str:n { _p: } }
            \exp_args:No #1 \l__codedoc_tmpa_tl
          }
        \bool_set_true:N \l__codedoc_macro_TF_bool
      }
    \seq_map_function:NN \l__codedoc_macro_input_seq #1
  }
\cs_new_protected_nopar:Npn \__codedoc_macro_typeset:
  {
    \topsep\MacroTopsep
    \trivlist
    \cs_set:Npn \makelabel ##1
      {
        \llap
          {
            \hbox_unpack_clear:N \l__codedoc_macro_index_box
            \vtop to \baselineskip
              {
                \vbox_unpack_clear:N \l__codedoc_macro_box
                \vss
              }
          }
      }
    \item [ ]
  }
\cs_new_protected:Npn \__codedoc_macro_single:n #1
  {
    \tl_set:Nn \saved@macroname {#1}
    \__codedoc_macro_typeset_one:n {#1}
    \exp_args:Nx \__codedoc_macro_index:n
      {
        #1
        \bool_if:NT \l__codedoc_macro_TF_bool { \tl_to_str:n { TF } }
      }
  }
\cs_new_protected:Npn \__codedoc_macro_index:n #1
  {
    \bool_if:NF \l__codedoc_macro_aux_bool
      { \seq_gput_right:Nn \g_doc_macros_seq {#1} }
    \hbox_set:Nw \l__codedoc_macro_index_box
      % This box only contains targets... it seems inefficient.
      \hbox_unpack_clear:N \l__codedoc_macro_index_box
      \int_gincr:N \c@CodelineNo
      \__codedoc_special_index:nn {#1} { main }
      \DoNotIndex {#1}
      \int_gdecr:N \c@CodelineNo
    \exp_args:NNNo \hbox_set_end:
      \tl_set:Nn \saved@indexname { \l__codedoc_index_key_tl }
  }
\cs_new_protected:Npn \__codedoc_macro_typeset_one:n #1
  {
    \vbox_set:Nn \l__codedoc_macro_box
      {
        \vbox_unpack_clear:N \l__codedoc_macro_box
        \hbox { \llap { \__codedoc_print_macroname:n {#1} \ } }
      }
    \int_incr:N \l__codedoc_macro_int
  }
\cs_new_protected:Npn \__codedoc_print_macroname:n #1
  {
    \strut
    \HD@target

    % TODO: INEFFICIENT(!)
    \exp_args:NNx \seq_if_in:NnTF \g_doc_functions_seq
      { #1 \bool_if:NT \l__codedoc_macro_TF_bool { \tl_to_str:n {TF} } }
      {
        \__codedoc_get_hyper_target:nN {#1} \l__codedoc_tmpa_tl
        \exp_last_unbraced:NNo \hyperref [ \l__codedoc_tmpa_tl ]
      }
      { \use:n }
      {
        \int_compare:nTF { \tl_count:n {#1} <= 28 }
          { \MacroFont } { \MacroLongFont }
        \__codedoc_macroname_prefix:n {#1} \__codedoc_macroname_suffix:
      }
  }
\cs_new_protected:Npn \__codedoc_macroname_prefix:n #1
  {
    \bool_if:NTF \l__codedoc_macro_aux_bool
      { \__codedoc_typeset_aux:n {#1} } {#1}
  }
\cs_new_protected_nopar:Npn \__codedoc_macroname_suffix:
  { \bool_if:NTF \l__codedoc_macro_TF_bool { \__codedoc_typeset_TF: } { } }
\providecommand \MacroLongFont
  {
    \fontfamily{lmtt}\fontseries{lc}\small
  }
\cs_new_protected:Npn \__codedoc_print_testfile:n #1
  {
    \bool_set_true:N \l__codedoc_macro_tested_bool
    \tl_if_eq:nnF {#1} {*}
      {
        \seq_if_in:NnF \g__codedoc_testfiles_seq {#1}
          {
            \seq_gput_right:Nn \g__codedoc_testfiles_seq {#1}
            \par
            \__codedoc_print_testfile_aux:n {#1}
          }
      }
  }
\cs_new_protected:Npn \__codedoc_print_testfile_aux:n #1
  {
    \footnotesize
    (
    \textit
      {
        The~ test~ suite~ for~ this~ command,~
        and~ others~ in~ this~ file,~ is~ \textsf{#1}
      }.
    )\par
  }
\DeclareDocumentCommand \TestFiles {m}
  {
    \par
    \textit
      {
        The~ following~ test~ files~ are~
        used~ for~ this~ code:~ \textsf{#1}.
      }
    \par \ignorespaces
  }
\DeclareDocumentCommand \UnitTested { } { \testfile* }
\DeclareDocumentCommand \TestMissing { m }
  { \__codedoc_test_missing:n {#1} }
\cs_new_protected:Npn \__codedoc_test_missing:n #1
  {
    \tl_set:Nx \l__codedoc_tmpb_tl
      { \seq_use:Nn \l__codedoc_macro_input_seq { , } }
    \prop_if_in:NVTF \g__codedoc_missing_tests_prop \l__codedoc_tmpb_tl
      {
        \prop_get:NVN \g__codedoc_missing_tests_prop \l__codedoc_tmpb_tl
          \l__codedoc_tmpa_tl
      }
      { \tl_clear:N \l__codedoc_tmpa_tl }
    \clist_set:Nx \l__codedoc_tmpa_clist { \l__codedoc_tmpa_tl , #1 }
    \prop_gput:NVV \g__codedoc_missing_tests_prop \l__codedoc_tmpb_tl
      \l__codedoc_tmpa_clist
  }
\cs_new_protected:Npn \__codedoc_macro_end:
  {
    \endtrivlist
    \__codedoc_macro_end_check_tested:
    \int_compare:nNnT \l__codedoc_nested_macro_int = 1
      {
        \__codedoc_macro_end_style:n
          {
            \__codedoc_print_end_definition:
            \__codedoc_print_documented:
          }
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_macro_end_check_tested:
  {
    \bool_if:nT
     {
       \g__codedoc_checktest_bool &&
       ! \l__codedoc_macro_aux_bool &&
       ! \l__codedoc_macro_var_bool &&
       ! \l__codedoc_macro_tested_bool
     }
     {
       \seq_gput_right:Nx \g__codedoc_not_tested_seq
         {
           \seq_use:Nn \l__codedoc_macro_input_seq { , }
           \bool_if:NTF \l__codedoc_macro_pTF_bool {~(pTF)}
             { \bool_if:NT \l__codedoc_macro_TF_bool {~(TF)} }
         }
     }
  }
\cs_new_protected:Npn \__codedoc_macro_end_style:n #1
  {
    \nobreak \noindent
    { \footnotesize ( \emph{#1} ) \par }
  }
\cs_new_protected:Npn \__codedoc_macro_end_wrap_items:N #1
  {
    \bool_if:NT \l__codedoc_macro_TF_bool
      { \seq_set_map:NNn #1 #1 { ##1 TF } }
    \seq_set_map:NNn #1 #1
      {
        \exp_not:n
          {
            \tl_set:Nn \l__codedoc_tmpa_tl {##1}
            \tl_replace_all:Non \l__codedoc_tmpa_tl
              { \token_to_str:N _ } { \_ }
            \texttt { \l__codedoc_tmpa_tl }
          }
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_print_end_definition:
  {
    \group_begin:
    \__codedoc_macro_end_wrap_items:N \l__codedoc_macro_input_seq
    End~ definition~ for~
    \int_compare:nTF { \seq_count:N \l__codedoc_macro_input_seq <= 3 }
      {
        \seq_use:Nnnn \l__codedoc_macro_input_seq
          { \,~and~ } { \,,~ } { \,,~and~ }
        \@.
      }
      { \seq_item:Nn \l__codedoc_macro_input_seq {1}\,~and~others. }
    \group_end:
  }
\cs_new_protected_nopar:Npn \__codedoc_print_documented:
  {
    \bool_if:nT
      {
        ! \l__codedoc_macro_aux_bool &&
        ! \l__codedoc_macro_internal_bool
      }
      {
        \int_set:Nn \l__codedoc_tmpa_int
          { \seq_count:N \l__codedoc_macro_input_seq }
        \int_compare:nNnTF \l__codedoc_tmpa_int = 1 {~This~} {~These~}
        \bool_if:NTF \l__codedoc_macro_var_bool {variable} {function}
        \int_compare:nNnTF \l__codedoc_tmpa_int = 1 {~is~} {s~are~}
        documented~on~page~
        \exp_args:Nx \__codedoc_get_hyper_target:nN
          { \seq_item:Nn \l__codedoc_macro_input_seq { 1 } }
          \l__codedoc_tmpa_tl
        \exp_args:Nx \pageref { \l__codedoc_tmpa_tl } .
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_typeset_TF:
  {
    \hyperlink{explTF}
      {
        \color{black}
        \itshape TF
        \makebox[0pt][r]
          {
            \color{red}
            \underline { \phantom{\itshape TF} \kern-0.1em }
          }
      }
  }
\cs_new_protected:Npn \__codedoc_typeset_aux:n #1
  {
    { \color[gray]{0.7} #1 }
  }
\cs_new_protected:Npn \__codedoc_get_hyper_target:nN #1#2
  {
    \tl_set:Nx #2
      {
        \tl_to_str:n {#1}
        \bool_if:NT \l__codedoc_macro_TF_bool { \tl_to_str:n {TF} }
      }
    \tl_replace_all:Nxn #2 { \iow_char:N \_ } { / }
    \tl_remove_all:Nx   #2 { \iow_char:N \\ }
    \tl_put_left:Nn #2 { doc/function// }
  }
\newcommand*{\DescribeOption}
  {
    \leavevmode
    \@bsphack
    \begingroup
      \MakePrivateLetters
      \Describe@Option
  }
\newcommand*{\Describe@Option}[1]
  {
    \endgroup
    \marginpar{
      \raggedleft
      \PrintDescribeEnv{#1}
    }
    \SpecialOptionIndex{#1}
    \@esphack
    \ignorespaces
  }
\newcommand*{\SpecialOptionIndex}[1]
  {
    \@bsphack
    \begingroup
      \HD@target
      \let\HDorg@encapchar\encapchar
      \edef\encapchar usage
        {
          \HDorg@encapchar hdclindex{\the\c@HD@hypercount}{usage}
        }
      \index
        {
          #1\actualchar{\protect\ttfamily#1}~(option)
          \encapchar usage
        }
      \index
        {
          options:\levelchar#1\actualchar{\protect\ttfamily#1}
          \encapchar usage
        }
    \endgroup
    \@esphack
  }
\font \manual = manfnt \scan_stop:
\cs_gset_nopar:Npn \dbend { {\manual\char127} }
\newenvironment {danger}
  {
    \begin{trivlist}\item[]\noindent
    \begingroup\hangindent=2pc\hangafter=-2
    \cs_set_nopar:Npn \par{\endgraf\endgroup}
    \hbox to0pt{\hskip-\hangindent\dbend\hfill}\ignorespaces
  }
  {
    \par\end{trivlist}
  }
\newenvironment {ddanger}
  {
    \begin{trivlist}\item[]\noindent
    \begingroup\hangindent=3.5pc\hangafter=-2
    \cs_set_nopar:Npn \par{\endgraf\endgroup}
    \hbox to0pt{\hskip-\hangindent\dbend\kern2pt\dbend\hfill}\ignorespaces
  }{
      \par\end{trivlist}
  }
\newenvironment{TemplateInterfaceDescription}[1]
  {
    \subsection{The~object~type~`#1'}
    \begingroup
    \@beginparpenalty\@M
    \description
    \def\TemplateArgument##1##2{\item[Arg:~##1]##2\par}
    \def\TemplateSemantics
      {
        \enddescription\endgroup
        \subsubsection*{Semantics:}
      }
  }
  {
    \par\bigskip
  }
\newenvironment{TemplateDescription}[2]
  {
    \subsection{The~template~`#2'~(object~type~#1)}
    \subsubsection*{Attributes:}
    \begingroup
    \@beginparpenalty\@M
    \description
    \def\TemplateKey##1##2##3##4
      {
        \item[##1~(##2)]##3%
        \ifx\TemplateKey##4\TemplateKey\else
          \hfill\penalty500\hbox{}\hfill Default:~##4%
          \nobreak\hskip-\parfillskip\hskip0pt\relax
        \fi
        \par
      }
    \def\TemplateSemantics
      {
        \enddescription\endgroup
        \subsubsection*{Semantics~\&~Comments:}
      }
  }
  { \par \bigskip }
\newenvironment{InstanceDescription}[4][xxxxxxxxxxxxxxx]
  {
    \subsubsection{The~instance~`#3'~(template~#2/#4)}
    \subsubsection*{Attribute~values:}
    \begingroup
    \@beginparpenalty\@M
    \def\InstanceKey##1##2{\>\textbf{##1}\>##2\\}
    \def\InstanceSemantics{\endtabbing\endgroup
      \vskip-30pt\vskip0pt
      \subsubsection*{Layout~description~\&~Comments:}}
    \tabbing
    xxxx\=#1\=\kill
  }
  { \par \bigskip }
\DeclareDocumentCommand \OnlyDescription { }
  { \bool_gset_false:N \g__codedoc_typeset_implementation_bool }
\DeclareDocumentCommand \AlsoImplementation { }
  { \bool_gset_true:N \g__codedoc_typeset_implementation_bool }
\DeclareDocumentCommand \StopEventually { m }
  {
    \bool_if:NTF \g__codedoc_typeset_implementation_bool
      {
        \@bsphack
        \tl_gset:Nn \g__codedoc_finale_tl { #1 \check@checksum }
        \init@checksum
        \@esphack
      }
      { #1 \endinput }
  }
\DeclareDocumentCommand \Finale { }
  { \tl_use:N \g__codedoc_finale_tl }
\tl_new:N \g__codedoc_finale_tl
\cs_new_protected:Npn \__codedoc_input:n #1
  {
    \tl_gclear:N \g__codedoc_module_name_tl
    \MakePercentIgnore
    \input{#1}
    \MakePercentComment
  }
\DeclareDocumentCommand \DocInput { m }
  {
    \clist_map_inline:nn {#1}
      {
        \clist_put_right:Nn \g_docinput_clist {##1}
        \__codedoc_input:n {##1}
      }
  }
\DeclareDocumentCommand \DocInputAgain { }
  { \clist_map_function:NN \g_docinput_clist \__codedoc_input:n }
\NewDocumentCommand \DocInclude { m }
  {
    \relax\clearpage
    \docincludeaux
    \IfFileExists{#1.fdd}
      { \cs_set_nopar:Npn \currentfile{#1.fdd} }
      { \cs_set_nopar:Npn \currentfile{#1.dtx} }
    \int_compare:nNnTF \@auxout = \@partaux
      { \@latexerr{\string\include\space cannot~be~nested}\@eha }
      { \@docinclude #1 }
  }
\cs_gset:Npn \@docinclude #1
  {
    \clearpage
    \immediate\write\@mainaux{\string\@input{#1.aux}}
    \@tempswatrue
    \if@partsw
      \@tempswafalse
      \cs_set_nopar:Npx \@tempb{#1}
      \@for\@tempa:=\@partlist\do
        {
          \ifx\@tempa\@tempb\@tempswatrue\fi
        }
    \fi
    \if@tempswa
      \cs_set_eq:NN \@auxout                 \@partaux
      \immediate\openout\@partaux #1.aux
      \immediate\write\@partaux{\relax}
      \cs_set_eq:NN \@ltxdoc@PrintIndex      \PrintIndex
      \cs_set_eq:NN \PrintIndex              \relax
      \cs_set_eq:NN \@ltxdoc@PrintChanges    \PrintChanges
      \cs_set_eq:NN \PrintChanges            \relax
      \cs_set_eq:NN \@ltxdoc@theglossary     \theglossary
      \cs_set_eq:NN \@ltxdoc@endtheglossary  \endtheglossary
      \part{\currentfile}
      {
        \cs_set_eq:NN \ttfamily\relax
        \cs_gset_nopar:Npx \filekey
          { \filekey, \thepart = { \ttfamily \currentfile } }
      }
      \DocInput{\currentfile}
      \cs_set_eq:NN \PrintIndex              \@ltxdoc@PrintIndex
      \cs_set_eq:NN \PrintChanges            \@ltxdoc@PrintChanges
      \cs_set_eq:NN \theglossary             \@ltxdoc@theglossary
      \cs_set_eq:NN \endtheglossary          \@ltxdoc@endtheglossary
      \clearpage
      \@writeckpt{#1}
      \immediate \closeout \@partaux
    \else
      \@nameuse{cp@#1}
    \fi
    \cs_set_eq:NN \@auxout \@mainaux
  }
\cs_gset:Npn \codeline@wrindex #1
  {
    \immediate\write\@indexfile
      {
        \string\indexentry{#1}
          { \filesep \int_use:N \c@CodelineNo }
      }
  }
\tl_gclear:N \filesep
\cs_gset_nopar:Npn \docincludeaux
  {
    \tl_set:Nn \thepart { \alphalph { part } }
    \tl_set:Nn \filesep { \thepart - }
    \cs_set_eq:NN \filekey \use_none:n
    \tl_gput_right:Nn \index@prologue
      {
        \cs_gset_nopar:Npn \@oddfoot
          {
            \parbox { \textwidth }
              {
                \strut \footnotesize
                \raggedright { \bfseries File~Key: } ~ \filekey
              }
          }
        \cs_set_eq:NN \@evenfoot \@oddfoot
      }
    \cs_gset_eq:NN \docincludeaux \relax
    \cs_gset_nopar:Npn \@oddfoot
      {
        \cs_if_exist:cTF { ver @ \currentfile }
          { File~\thepart :~{\ttfamily\currentfile}~ }
          {
            \GetFileInfo{\currentfile}
            File~\thepart :~{\ttfamily\filename}~
            Date:~\ExplFileDate\ % space
            Version~\ExplFileVersion
          }
        \hfill \thepage
      }
    \cs_set_eq:NN \@evenfoot \@oddfoot
  }
\group_begin:
  \char_set_catcode_other:N \^^A
  \char_set_catcode_active:N \^^S
  \char_set_catcode_active:N \^^B
  \char_set_catcode_other:N \^^L
  \char_set_catcode_other:N \^^R
  \char_set_lccode:nn { `\^^A } { `\% }
  \char_set_lccode:nn { `\^^S } { `\  }
  \char_set_lccode:nn { `\^^B } { `\\ }
  \char_set_lccode:nn { `\^^L } { `\{ }
  \char_set_lccode:nn { `\^^R } { `\} }
  \tex_lowercase:D
    {
      \group_end:
      \cs_set_protected:Npn \xmacro@code
          #1 ^^A ^^S^^S^^S^^S ^^Bend ^^Lmacrocode^^R
        { \__codedoc_xmacro_code:n {#1} \end{macrocode} }
    }
\group_begin:
  \char_set_catcode_active:N \<
  \char_set_catcode_active:N \>
  \cs_new_protected:Npn \__codedoc_xmacro_code:n #1
    {
      \tl_if_in:nnTF {#1} { < @ @ = }
        { \__codedoc_xmacro_code:w #1 \q_stop }
        {
          \tl_set:Nn \l__codedoc_tmpa_tl {#1}
          \__codedoc_replace_at_at:N \l__codedoc_tmpa_tl
          \tl_use:N \l__codedoc_tmpa_tl
        }
    }
  \cs_new_protected:Npn \__codedoc_xmacro_code:w #1 < @ @ = #2 > #3 \q_stop
    {
      \tl_set:Nn \l__codedoc_tmpa_tl {#1}
      \__codedoc_replace_at_at:N \l__codedoc_tmpa_tl

      \tl_gset:Nn \g__codedoc_module_name_tl {#2}
      \tl_put_right:Nn \l__codedoc_tmpa_tl { < @ @ = #2 > }

      \tl_set:Nn \l__codedoc_tmpb_tl {#3}
      \__codedoc_replace_at_at:N \l__codedoc_tmpb_tl
      \tl_put_right:No \l__codedoc_tmpa_tl { \l__codedoc_tmpb_tl }

      \tl_use:N \l__codedoc_tmpa_tl
    }
\group_end:
\iow_new:N \g__codedoc_func_iow
\tl_new:N \l__codedoc_doc_def_tl
\tl_new:N \l__codedoc_doc_undef_tl
\tl_new:N \l__codedoc_undoc_def_tl
\cs_new_protected_nopar:Npn \__codedoc_show_functions_defined:
  {
    \bool_if:nT
      { \g__codedoc_typeset_implementation_bool && \g__codedoc_checkfunc_bool }
      {
        \iow_term:x { \c__codedoc_iow_separator_tl \iow_newline: }
        \iow_open:Nn \g__codedoc_func_iow { \c_sys_jobname_str .cmds }

        \tl_clear:N \l__codedoc_doc_def_tl
        \tl_clear:N \l__codedoc_doc_undef_tl
        \tl_clear:N \l__codedoc_undoc_def_tl
        \seq_map_inline:Nn \g_doc_functions_seq
          {
            \seq_if_in:NnTF \g_doc_macros_seq {##1}
              {
                \tl_put_right:Nx \l__codedoc_doc_def_tl
                  { ##1 \iow_newline: }
                \iow_now:Nn \g__codedoc_func_iow { > ~ ##1 }
              }
              {
                \tl_put_right:Nx \l__codedoc_doc_undef_tl
                  { ##1 \iow_newline: }
                \iow_now:Nn \g__codedoc_func_iow { ! ~ ##1 }
              }
          }
        \seq_map_inline:Nn \g_doc_macros_seq
          {
            \seq_if_in:NnF \g_doc_functions_seq {##1}
              {
                \tl_put_right:Nx \l__codedoc_undoc_def_tl
                  { ##1 \iow_newline: }
                \iow_now:Nn \g__codedoc_func_iow { ? ~ ##1 }
              }
          }
        \__codedoc_functions_typeout:nN
          {
            Functions~both~documented~and~defined: \iow_newline:
            (In~order~of~being~documented)
          }
          \l__codedoc_doc_def_tl
        \__codedoc_functions_typeout:nN
          { Functions~documented~but~not~defined: }
          \l__codedoc_doc_undef_tl
        \__codedoc_functions_typeout:nN
          { Functions~defined~but~not~documented: }
          \l__codedoc_undoc_def_tl

        \iow_close:N \g__codedoc_func_iow
        \iow_term:x { \c__codedoc_iow_separator_tl }
      }
  }
\AtEndDocument { \__codedoc_show_functions_defined: }
\cs_new_protected:Npn \__codedoc_functions_typeout:nN #1#2
  {
    \tl_if_empty:NF #2
      {
        \typeout
          {
            \c__codedoc_iow_midrule_tl \iow_newline:
            #1 \iow_newline:
            \c__codedoc_iow_midrule_tl \iow_newline:
            #2
          }
        \tl_clear:N #2
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_show_not_tested:
  {
    \bool_if:NT \g__codedoc_checktest_bool
      {
        \tl_clear:N \l__codedoc_tmpa_tl
        \prop_if_empty:NF \g__codedoc_missing_tests_prop
          {
            \cs_set:Npn \__codedoc_tmpa:w ##1##2
              {
                \iow_newline:
                \space\space\space\space \exp_not:n {##1}
                \clist_map_function:nN {##2} \__codedoc_tmpb:w
              }
            \cs_set:Npn \__codedoc_tmpb:w ##1
              {
                \iow_newline:
                \space\space\space\space\space\space * ~ ##1
              }
            \tl_put_right:Nx \l__codedoc_tmpa_tl
              {
                \iow_newline: \iow_newline:
                The~ following~ macro(s)~ have~ incomplete~ tests:
                \iow_newline:
                \prop_map_function:NN
                  \g__codedoc_missing_tests_prop \__codedoc_tmpa:w
              }
          }
        \seq_if_empty:NF \g__codedoc_not_tested_seq
          {
            \cs_set:Npn \__codedoc_tmpa:w ##1
              { \clist_map_function:nN {##1} \__codedoc_tmpb:w }
            \cs_set:Npn \__codedoc_tmpb:w ##1
              {
                \iow_newline:
                \space\space\space\space ##1
              }
            \tl_put_right:Nx \l__codedoc_tmpa_tl
              {
                \iow_newline:
                \iow_newline:
                The~ following~ macro(s)~ do~ not~ have~ any~ tests:
                \iow_newline:
                \seq_map_function:NN
                  \g__codedoc_not_tested_seq \__codedoc_tmpa:w
              }
          }
        \tl_if_empty:NF \l__codedoc_tmpa_tl
          {
            \int_set:Nn \l__codedoc_tmpa_int { \etex_interactionmode:D }
            \errorstopmode
            \ClassError { l3doc } { \l__codedoc_tmpa_tl } { }
            \int_set:Nn \etex_interactionmode:D { \l__codedoc_tmpa_int }
          }
      }
  }
\AtEndDocument { \__codedoc_show_not_tested: }
\g@addto@macro \theindex { \MakePrivateLetters }
\cs_gset:Npn \verbatimchar {&}
\setcounter { IndexColumns } { 2 }
\IndexPrologue
  {
    \part*{Index}
    \markboth{Index}{Index}
    \addcontentsline{toc}{part}{Index}
    The~italic~numbers~denote~the~pages~where~the~
    corresponding~entry~is~described,~
    numbers~underlined~point~to~the~definition,~
    all~others~indicate~the~places~where~it~is~used.
  }
\cs_gset_protected:Npn \SpecialIndex #1
  {
    \@bsphack
    \__codedoc_special_index:nn {#1} { }
    \@esphack
  }
\msg_new:nnn { l3doc } { print-index-howto }
  {
    Generate~the~index~by~executing\\
    \iow_indent:n
      { makeindex~-s~gind.ist~-o~\c_sys_jobname_str.ind~\c_sys_jobname_str.idx }
  }
\tl_gput_right:Nn \PrintIndex
  { \AtEndDocument { \msg_info:nn { l3doc } { print-index-howto } } }
\cs_gset_protected:Npn \it@is@a #1
  {
    \use:x
      {
        \__codedoc_special_index_module:nnnn
          { \quotechar #1 }
          { \quotechar \bslash \quotechar #1 }
          { }
          { }
      }
  }
\cs_new_protected:Npn \__codedoc_special_index:nn #1#2
  {
    \__codedoc_key_get:n {#1}
    \__codedoc_special_index_module:ooon
      { \l__codedoc_index_key_tl }
      { \l__codedoc_index_macro_tl }
      { \l__codedoc_index_module_tl }
      {#2}
  }
\cs_generate_variant:Nn \__codedoc_special_index:nn { o }
\tl_new:N \l__codedoc_index_escaped_macro_tl
\cs_new_protected:Npn \__codedoc_special_index_module:nnnn #1#2#3#4
  {
    \use:x
      {
        \exp_not:n { \__codedoc_special_index_aux:nnnnn {#1} {#2} }
          \str_case_x:nnF {#3}
            {
              { } { { } { } }
              { TeX }
                {
                  { TeX~and~LaTeX2e~commands }
                  { \string\TeX{}~and~\string\LaTeXe{}~commands: }
                }
            }
            { { #3~commands } { \string\pkg{#3}~commands: } }
      }
          {#4}
  }
\cs_generate_variant:Nn \__codedoc_special_index_module:nnnn { ooo }
\cs_new_protected:Npn \__codedoc_special_index_aux:nnnnn #1#2#3#4#5
  {
    \HD@target
    \__codedoc_special_index_set:Nn \l__codedoc_index_escaped_macro_tl {#2}
    \index
      {
        \tl_if_empty:nF { #3 #4 }
          { #3 \actualchar #4 \levelchar }
        #1
        \actualchar
        {
          \token_to_str:N \verbatim@font \c_space_tl
          \l__codedoc_index_escaped_macro_tl
        }
        \encapchar
        hdclindex{\the\c@HD@hypercount}{#5}
      }
  }
\cs_generate_variant:Nn \__codedoc_special_index_aux:nnnnn { o }
\cs_new_protected:Npn \__codedoc_special_index_set:Nn #1#2
  {
    \tl_set:Nx #1 { \tl_to_str:n {#2} }
    \int_compare:nNnTF { \tl_count:n {#2} } < { \tl_count:N #1 }
      {
        \tl_set:Nn #1 {#2}
        \tl_replace_all:Non #1
          { \c__codedoc_backslash_tl }
          { \token_to_str:N \bslash \c_space_tl }
      }
      {
        \exp_args:Nx \tl_map_inline:nn
          { \tl_to_str:N \verbatimchar \token_to_str:N _ }
          {
            \tl_replace_all:Nnn #1 {##1}
              {
                \verbatimchar \c__codedoc_backslash_tl ##1
                \token_to_str:N \verb \quotechar * \verbatimchar
              }
          }
        \tl_map_inline:nn { \actualchar \encapchar \levelchar }
          {
            \tl_replace_all:Nxn #1
              { \tl_to_str:N ##1 } { \quotechar \tl_to_str:N ##1 }
          }
        \tl_set:Nx #1
          {
            \token_to_str:N \verb \quotechar * \verbatimchar
            #1 \verbatimchar
          }
      }
  }
\cs_new_protected:Npn \__codedoc_key_get:n #1
  {
    \tl_set:Nn \l__codedoc_index_macro_tl {#1}
    \tl_set:Nx \l__codedoc_index_key_tl { \tl_to_str:n {#1} }
    \tl_clear:N \l__codedoc_index_module_tl
    \tl_if_head_eq_charcode:oNT
      { \l__codedoc_index_key_tl } \c__codedoc_backslash_token
      { \__codedoc_key_pop: }
    \tl_if_in:NoTF \l__codedoc_index_key_tl { \token_to_str:N : }
      { \__codedoc_key_expl: }
      {
        \tl_if_in:NoTF \l__codedoc_index_key_tl { \token_to_str:N _ }
          { \__codedoc_key_expl: }
          {
            \tl_if_in:NoT \l__codedoc_index_key_tl { \token_to_str:N @ }
              { \tl_set:Nn \l__codedoc_index_module_tl { TeX } }
          }
      }
  }
\cs_new_protected_nopar:Npn \__codedoc_key_pop:
  {
    \tl_set:Nx \l__codedoc_index_key_tl
      { \tl_tail:N \l__codedoc_index_key_tl }
  }
\cs_new_protected_nopar:Npn \__codedoc_key_expl:
  {
    \tl_if_head_eq_charcode:oNTF { \l__codedoc_index_key_tl } .
      { \__codedoc_key_pop: }
      {
        \exp_args:Nx \tl_if_head_eq_charcode:nNT
          { \exp_args:No \str_tail:n \l__codedoc_index_key_tl } _
          {
            \tl_if_head_eq_charcode:oNTF { \l__codedoc_index_key_tl } _
              {
                \__codedoc_key_pop:
                \__codedoc_key_pop:
              }
              {
                \__codedoc_key_pop:
                \__codedoc_key_pop:
                \tl_if_head_eq_charcode:oNT { \l__codedoc_index_key_tl } _
                  { \__codedoc_key_pop: }
              }
          }
      }
    \__codedoc_key_get_module:
  }
\cs_new_protected_nopar:Npn \__codedoc_key_get_module:
  {
    \tl_set_eq:NN \l__codedoc_index_module_tl \l__codedoc_index_key_tl
    \exp_args:No \__codedoc_key_get_module_aux:n { \token_to_str:N : }
    \exp_args:No \__codedoc_key_get_module_aux:n { \token_to_str:N _ }
  }
\cs_new_protected:Npn \__codedoc_key_get_module_aux:n #1
  {
    \cs_set:Npn \__codedoc_tmpa:w ##1 #1 ##2 \q_stop { \exp_not:n {##1} }
    \tl_set:Nx \l__codedoc_index_module_tl
      { \exp_after:wN \__codedoc_tmpa:w \l__codedoc_index_module_tl #1 \q_stop }
  }
\GlossaryPrologue
  {
    \part*{Change~History}
    {\GlossaryParms\ttfamily\hyphenchar\font=`\-}
    \markboth{Change~History}{Change~History}
    \addcontentsline{toc}{part}{Change~History}
  }
\msg_new:nnn { l3doc } { print-changes-howto }
  {
    Generate~the~change~list~by~executing\\
    \iow_indent:n
      { makeindex~-s~gglo.ist~-o~\c_sys_jobname_str.gls~\c_sys_jobname_str.glo }
  }
\tl_gput_right:Nn \PrintChanges
  { \AtEndDocument { \msg_info:nn { l3doc } { print-changes-howto } } }
\bool_if:NTF \g__codedoc_typeset_implementation_bool
  {
    \RecordChanges
    \CodelineIndex
    \EnableCrossrefs
    \AlsoImplementation
  }
  {
    \CodelineNumbered
    \DisableCrossrefs
    \OnlyDescription
  }
%% 
%%
%% End of file `l3doc.cls'.
