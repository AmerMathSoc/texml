%%
%% This is file `gzt.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gzt.dtx  (with options: `class')
%% -----------------------------------------------------------------------------
%% gzt --- SMF bundle of classes for the French journal "La Gazette des
%%         Math'ematiciens", version 0.95
%% 
%% E-mail: denis.bitouze@lmpa.univ-littoral.fr
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% -----------------------------------------------------------------------------
\def\sectioncommandslist{}%
\let\saved@ifdefinable\@ifdefinable%
\let\saved@@ifdefinable\@@ifdefinable%
\newcommand{\startcustomization}{%
  % Redefine \@ifdefinable
  \renewcommand{\@ifdefinable}[2]{%
    \listadd\sectioncommandslist##1%
    \saved@ifdefinable{##1}{##2}%
  }%
  \renewcommand{\@@ifdefinable}[2]{%
    \listadd\sectioncommandslist##1%
    \saved@@ifdefinable{##1}{##2}%
  }%
}%
\newcommand{\cleancustomization}{%
  \forlistloop{\undef}{\sectioncommandslist}%
  \def\sectioncommandslist{}%
  \let\@ifdefinable\saved@ifdefinable%
  \let\@@ifdefinable\saved@@ifdefinable%
}%
\RequirePackage{silence}%
\WarningFilter{kpfonts}{With 'easyscsl' option}
\RequirePackage{xpatch}%
\patchcmd%
  {\use@@tikzlibrary}%
  {%
    \pgfutil@InputIfFileExists{tikzlibrary\pgf@temp.code.tex}{}{
      \pgfutil@IfFileExists{pgflibrary\pgf@temp.code.tex}{%
        \expandafter\usepgflibrary\expandafter{\pgf@temp}%
      }{%
        \tikzerror{I did not find the tikz library
          '\pgf@temp'. I looked for files named
          tikzlibrary\pgf@temp.code.tex and
          pgflibrary\pgf@temp.code.tex, but neither
          could be found in the current texmf trees.}
      }}%
  }%
  {%
    \@pushfilename
      \pgfutil@InputIfFileExists{tikzlibrary\pgf@temp.code.tex}{}{
        \pgfutil@IfFileExists{pgflibrary\pgf@temp.code.tex}{%
          \expandafter\usepgflibrary\expandafter{\pgf@temp}%
        }{%
          \tikzerror{I did not find the tikz library
            '\pgf@temp'. I looked for files named
            tikzlibrary\pgf@temp.code.tex and
            pgflibrary\pgf@temp.code.tex, but neither
            could be found in the current texmf trees.}
        }}%
    \@popfilename
  }%
  {}{}%
\patchcmd
  {\tcb@input@library@in}
  {%
    \input\tcbpkgprefix#1\relax%
  }
  {%
    \@pushfilename
    \input\tcbpkgprefix#1\relax%
    \@popfilename
  }
  {}{}
\RequirePackage{l3keys2e}
\RequirePackage{xparse}
\ExplSyntaxOn
\ProvidesExplClass
  {gzt}
  {2016/06/10}
  {0.95a}
  {
    SMF~class~for~the~French~journal^^J
    "La~Gazette~des~Math'ematiciens".
  }
\NeedsTeXFormat{LaTeX2e}
\bool_new:N \g__gzt_for_authors_bool
\bool_new:N \g__gzt_cover_bool
\bool_new:N \g__gzt_coverpage_bool
\bool_new:N \g__gzt_inside_pages_bool
\dim_const:Nn \c__gzt_pagegrid_dim { 1mm}
\tl_gset:Nn \g__gzt_frontcover_image_file_tl {\c__gzt_issue_frontcover_default_image_file_tl}
\keys_define:nn { gzt }
{
  pagegrid .dim_gset:N = \g__gzt_pagegrid_dim,
  pagegrid .default:n = {\c__gzt_pagegrid_dim},
  forauthors .code:n = {%
    \bool_gset_true:N \g__gzt_for_authors_bool%
    \bool_gset_true:N \g__gzt_inside_pages_bool%
  },%
  forprinter .bool_gset:N = \g__gzt_for_printer_bool,
  frontcoverimagefile .tl_gset:N = \g__gzt_frontcover_image_file_tl,
  frontcoverimagefile .default:n = {frontcover},
  output .choice:,
  output / frontcover .code:n = {%
    \bool_gset_true:N \g__gzt_for_printer_bool%
    \bool_gset_true:N \g__gzt_cover_bool%
  },%
  output / coverpage .code:n = {%
    \bool_gset_true:N \g__gzt_coverpage_bool%
  },%
  output / insidepages .code:n = {%
    \bool_gset_true:N \g__gzt_for_printer_bool%
    \bool_gset_true:N \g__gzt_inside_pages_bool%
  },%
  output / backcover .code:n = {%
    \bool_gset_true:N \g__gzt_for_printer_bool%
  },%
  output / web .code:n = {%
  },%
}%
\ProcessKeysOptions { gzt }
\PassOptionsToClass{openany,english,french}{book}
\LoadClass { book }
\PassOptionsToPackage{table,cmyk}{xcolor}%
\PassOptionsToPackage{export}{adjustbox}%
\PassOptionsToPackage{english,french}{translator}
\PassOptionsToPackage{english,french}{babel}
\PassOptionsToPackage{english,french}{varioref}
\PassOptionsToPackage{english,french}{cleveref}
\RequirePackage[group=false]{standalone}%
\RequirePackage{datatool}%
\pdftex_if_engine:TF
  {
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
  }{
    \RequirePackage{fontspec}
  }
\RequirePackage[sfmath,easyscsl,noDcommand]{kpfonts}
\RequirePackage[pagestyles]{titlesec}%
\RequirePackage{multicol}%
\RequirePackage{graphicx}%
\RequirePackage{import}%
\RequirePackage{longtable}%
\bool_if:nT { \g__gzt_for_authors_bool } {
  \RequirePackage{draftwatermark}[2006/06/30]%
}
\RequirePackage{adjustbox}%
\RequirePackage{zref-totpages}
\RequirePackage{lastpage}
\RequirePackage{zref-xr}%
\RequirePackage{ragged2e}%
\RequirePackage{xspace}%
\RequirePackage{textcase}%
\RequirePackage{epigraph}%
\RequirePackage[autostyle]{csquotes}%
\RequirePackage[backend=biber,datamodel=gzt,defernumbers=true,autolang=other]{biblatex}%
\@ifpackagelater{biblatex}{2016/01/01}{%
  \ExecuteBibliographyOptions{giveninits}
}{
  \ExecuteBibliographyOptions{firstinits}
}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{nccparskip}
\RequirePackage{multirow}
\RequirePackage{varioref}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{esvect}
\RequirePackage{everypage}
\RequirePackage{translator}%
\RequirePackage{geometry}
\RequirePackage{babel}%
\RequirePackage{eurosym}%
\RequirePackage{iflang}[2007/11/11]%
\RequirePackage{tableof}%
\RequirePackage{etoc}%
\RequirePackage[babel=true]{microtype}%
\RequirePackage[nodayofweek]{datetime}%
\RequirePackage[inline]{enumitem}%
\RequirePackage{fixltx2e}%
\RequirePackage{afterpage}
\RequirePackage{xcolor}%
\cs_set_eq:NN \__gzt_orig_preamblecmds \@preamblecmds
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{tcolorbox}
\RequirePackage{tikzpagenodes}
\RequirePackage{tkz-euclide}
\RequirePackage[foreground]{pagegrid}%
\RequirePackage{amsthm}
\RequirePackage{thmtools}
\cs_set_eq:NN \@preamblecmds \__gzt_orig_preamblecmds
\RequirePackage{placeins}%
\RequirePackage[hidelinks,hypertexnames=false]{hyperref}%
\RequirePackage[numbered]{bookmark}%
\RequirePackage[nowarn]{glossaries}%
\RequirePackage{cleveref}%
\makeglossaries
\setglossarystyle{indexhypergroup}
\setacronymstyle{long-sc-short}
\pdftex_if_engine:T
  {
    \renewcommand\familydefault{\sfdefault}
    \renewcommand{\ttdefault}{lmtt}
  }
\tl_remove_all:Nn \@preamblecmds { \do \DeclareMathOperator }
\tl_remove_all:Nn \@preamblecmds { \do \newacronym }
\tl_remove_all:Nn \@preamblecmds { \do \@declmathop }
\tl_remove_all:Nn \@preamblecmds { \do \usetikzlibrary }
\msg_new:nnnn{gzt}{issue-number-needed}{Option~`#1'~needed!}
  {Please~specify~`#1=<number>',
    ~otherwise~`<number>'~will~be~set~to
    ~`\int_use:N\c__gzt_first_issue_number_int'.}
\msg_new:nnnn{gzt}{unknown-choice}{Choice~`#3'~invalid!}
  {Please~specify~#1=#2.}
\int_new:N \g__gzt_editors_in_chief_int
\int_new:N \g__gzt_item_in_rubric_int
\int_new:N \g__gzt_articles_int
\int_new:N \g__gzt_question_int
\int_const:Nn \c__gzt_first_issue_number_int { 143 }
\int_const:Nn \c__gzt_first_issue_year_int   { 2015 }
\int_const:Nn \c__gzt_first_issue_month_int  { 1 }
\int_const:Nn \c__gzt_interval_in_months_int { 3 }
\tl_const:Nn \c__gzt_journal_short_title_string_tl {Gazette}
\tl_const:Nn \c__gzt_journal_title_string_tl {
  \c__gzt_journal_short_title_string_tl{}~des~Math\'ematiciens%
}
\tl_const:Nn \c__gzt_class_name_tl {gzt}
\tl_const:Nn \c__gzt_article_class_name_tl {gztarticle}
\tl_const:Nn \c__gzt_editors_in_chief_string_tl
{
  \int_compare:nNnTF { \g__gzt_editors_in_chief_int } > { 1 }
  { \c__gzt_editorsinchief_string_tl }
  { \c__gzt_editorinchief_string_tl }
}
\tl_const:Nn \c__gzt_editorinchief_string_tl {R\'edacteur~en~chef }
\tl_const:Nn \c__gzt_editorsinchief_string_tl {R\'edacteurs~en~chef }
\tl_const:Nn \c__gzt_editors_string_tl {R\'edacteurs }
\tl_const:Nn \c__gzt_editorial_board_string_tl {Comit\'e~de~r\'edaction}
\tl_const:Nn \c__gzt_editorial_secretariat_string_tl {Secr\'etariat~de~r\'edaction}
\tl_const:Nn \c__gzt_phone_string_tl {T\'el.}
\tl_const:Nn \c__gzt_fax_string_tl {Fax}
\tl_const:Nn \c__gzt_informations_string_tl {Renseignements}
\tl_const:Nn \c__gzt_publishingdirector_string_tl {Directeur~de~la~publication}
\tl_const:Nn \c__gzt_issn_string_tl {\textsc{issn}}
\tl_const:Nn \c__gzt_isbn_string_tl {\textsc{isbn}}
\tl_const:Nn \c__gzt_latexclass_string_tl {Classe~\LaTeX{}}
\tl_const:Nn \c__gzt_printer_string_tl {Impression}
\tl_const:Nn \c__gzt_configuration_file_string_tl {gzt.cfg}
\tl_const:Nn \c__gzt_artistic_director_string_tl {Conception~graphique}
\tl_const:Nn \c__gzt_editorial_string_tl {\'Editorial}
\tl_const:Nn \c__gzt_editorinchief_signatory_string_tl {\c__gzt_editorinchief_string_tl~de~la~\c__gzt_journal_title_string_tl}
\tl_const:Nn \c__gzt_toc_string_tl {Sommaire}
\tl_const:Nn \c__gzt_president_message_string_tl {Mot~du~pr\'esident}
\tl_const:Nn \c__gzt_president_signatory_string_tl {pr\'esident~de~la~\g__gzt_smf_short_string_tl}
\tl_const:Nn \c__gzt_editorinchief_message_date_string_tl {Le~\displaydate{__gzt_editorinchief_message_date}}
\tl_const:Nn \c__gzt_president_message_date_string_tl {Le~}
\tl_const:Nn \c__gzt_frontcover_header_string_tl {
  \l__gzt_uppercased_date_format\displaydate{__gzt_date}
  \space
  \textendash{}
  \space
  \No\int_use:N\g__gzt_issue_number_int%
}
\tl_const:Nn \c__gzt_pdftitle_string_tl {
  \c__gzt_journal_title_string_tl
  % \space
  % \textendash{}
  % \space
  % \l__gzt_uppercased_date_format{\displaydate{__gzt_date}}
  \space
  \textendash{}
  \space
  N^^c2^^b0\int_use:N\g__gzt_issue_number_int
}
\tl_const:Nn \c__gzt_frontmatter_directory_string_tl {frontmatter}
\tl_const:Nn \c__gzt_backmatter_directory_string_tl {backmatter}
\tl_const:Nn \c__gzt_editorial_file_string_tl {\c__gzt_frontmatter_directory_string_tl/editorial}
\tl_const:Nn \c__gzt_president_message_file_string_tl {\c__gzt_frontmatter_directory_string_tl/presidentmessage}
\tl_const:Nn \c__gzt_issue_path_string_tl {\int_use:N \g__gzt_issue_number_int}
\tl_const:Nn \c__gzt_images_directory_string_tl {images}
\tl_const:Nn \c__gzt_issue_images_path_string_tl {% \c__gzt_issue_path_string_tl/
  \c__gzt_images_directory_string_tl}
\tl_const:Nn \c__gzt_issue_frontcover_default_image_file_tl {frontcover}
\tl_const:Nn \c__gzt_issue_backcover_text_file_string_tl {backcover}
\tl_const:Nn \c__gzt_backcover_page_file_string_tl {\c__gzt_backmatter_directory_string_tl/\c__gzt_issue_backcover_text_file_string_tl}
\tl_const:Nn \c__gzt_acronyms_file_string_tl {\c__gzt_class_name_tl acronyms}
\tl_const:Nn \c__gzt_authors_instructions_file_extension_tl {ain}
\tl_const:Nn \c__gzt_authors_instructions_file_tl {\c_job_name_tl.\c__gzt_authors_instructions_file_extension_tl}
\tl_const:Nn \c__gzt_about_frontcover_string_tl {\`A~propos~de~la~couverture.}
\tl_const:Nn \c__gzt_credit_frontcover_string_tl {cr\'edit}
\tl_const:Nn \c__gzt_authors_instructions_string_tl {Instructions~aux~auteurs}
\tl_const:Nn \c__gzt_preliminary_version_string_tl {%
  Ce~document~est~une~{\'e}preuve~vous~permettant~de~contr{\^o}ler~l'int{\'e}grit{\'e}~du~
  texte~d'origine~(et~de~la~bibliographie~s'il~y~en~a~une)~de~votre~article~
  {\`a}~para{\^\i}tre~dans~le~prochain~num{\'e}ro~de~la~\gzt*{}.~La~mise~en~page~
  actuelle~n'est~pas~d{\'e}finitive\,:~votre~article~pourra~en~particulier~ne~pas~
  d{\'e}buter~en~haut~d'une~page.%
}
\tl_const:Nn \c__gzt_tellme_extra_title_string_tl {...\space}
\tl_const:Nn \c__gzt_minitoc_rubric_title_separator_string_tl {\space\textendash}
\tl_const:Nn \c__gzt_mathematics_rubric_string_tl {Math\'ematiques}
\tl_const:Nn \c__gzt_dossier_rubric_string_tl {Dossier}
\tl_const:Nn \c__gzt_community_rubric_string_tl {Vie~de~la~communaut\'e}
\tl_const:Nn \c__gzt_interview_rubric_string_tl {Entretien}
\tl_const:Nn \c__gzt_teaching_rubric_string_tl {Diffusion~des~savoirs}
\tl_const:Nn \c__gzt_parity_rubric_string_tl {Parit\'e}
\tl_const:Nn \c__gzt_tellme_rubric_string_tl {Raconte-moi}
\tl_const:Nn \c__gzt_information_rubric_string_tl {Information}
\tl_const:Nn \c__gzt_rearviewmirror_rubric_string_tl {R\'etroviseur}
\tl_const:Nn \c__gzt_tribute_rubric_string_tl {Carnet}
\tl_const:Nn \c__gzt_books_rubric_string_tl {Livres}
\tl_const:Nn \c__gzt_latex_rubric_string_tl {Astuces~\LaTeX{}}
\tl_const:Nn \c__gzt_forum_rubric_string_tl {Tribune~libre}
\tl_const:Nn \c__gzt_published_with_help_of_string_tl {Publi\'e~avec~le~concours~de~:}
\tl_const:Nn \c__gzt_advertisement_directory_string_tl {advertisement/}
\tl_const:Nn \c__gzt_advertisement_string_tl {Publicit\'e}
\tl_const:Nn \c__gzt_moralreport_rubric_string_tl {Rapport~moral}
\tl_const:Nn \c__gzt_smf_short_string_tl {\textsc{smf}}
\tl_const:Nn \c__gzt_smf_short_pdf_string_tl {SMF}
\tl_const:Nn \c__gzt_smf_string_tl {Soci\'et\'e~Math\'ematique~de~France}
\tl_const:Nn \c__gzt_cad_short_string_tl {c.-\`a-d.}
\tl_const:Nn \c__gzt_cad_string_tl {c'est-\`a-dire}
\tl_const:Nn \c__gzt_Cad_short_string_tl {C.-\`a-d.}
\tl_const:Nn \c__gzt_Cad_string_tl {C'est-\`a-dire}
\tl_const:Nn \c__gzt_footer_string_tl {
  \c__gzt_footer_size_font_tl
  \textcolor{__gzt_smf_number_color}{\MakeTextUppercase{\c__gzt_smf_short_string_tl}}
  \space
  \textcolor{__gzt_date_color}{
    \textendash{}\space
    \MakeTextUppercase{\c__gzt_journal_short_title_string_tl}
    \bool_if:nF { \g__gzt_inside_frontcover_bool || \g__gzt_backmatter_bool || \g__gzt_for_authors_bool }
    {
      \space\textendash{}\space
      \l__gzt_uppercased_date_format\displaydate{__gzt_date}
      \space
      \textendash{}\space
      \textcolor{__gzt_smf_number_color}{\No\int_use:N\g__gzt_issue_number_int}
    }
  }
}
\tl_const:Nn \c__gzt_smf_logo_file_string_tl {logo_SMF}
\tl_const:Nn \c__gzt_issue_bib_file_suffix_string_tl {__gzt}
\tl_const:Nn \c__gzt_issue_bib_file_string_tl {\c_job_name_tl\c__gzt_issue_bib_file_suffix_string_tl.bib}
\tl_const:Nn \c__gzt_issue_bib_path_string_tl {\c__gzt_issue_bib_file_string_tl}
\tl_const:Nn \c__gzt_issue_bib_key_tl {\int_use:N \g__gzt_issue_number_int}
\tl_const:Nn \c__gzt_interview_title_string_tl {En~apart\'e~avec~}
\tl_const:Nn \c__gzt_aside_string_tl {--}
\tl_const:Nn \c__gzt_draftwatermark_string_tl {draft}
\tl_const:Nn \c__gzt_compiled_string_tl {
  \IfLanguageName{french}{
    Compil\'e~le~
  }{
    Compiled~on~
  }
}
\bool_new:N \g__gzt_frontcover_bool
\bool_new:N \g__gzt_inside_frontcover_bool
\bool_new:N \g__gzt_inside_backcover_bool
\bool_new:N \g__gzt_frontmatter_bool
\bool_new:N \g__gzt_rubric_bool
\bool_new:N \g__gzt_interview_rubric_bool
\bool_new:N \g__gzt_tellme_rubric_bool
\bool_new:N \g__gzt_rearviewmirror_rubric_bool
\bool_new:N \g__gzt_books_rubric_bool
\bool_new:N \g__gzt_mainmatter_bool
\bool_new:N \g__gzt_backmatter_bool
\bool_new:N \g__gzt_backcover_bool
\bool_new:N \g__gzt_previous_article_with_bibliography_or_minibio_bool
\bool_new:N \g__gzt_advertisement_bool
\bool_new:N \g__gzt_multicols_bool
\bool_new:N \g__gzt_refsection_bool
\dim_const:Nn \c__gzt_rubrics_abstract_width_dim { 85mm}
\dim_const:Nn \c__gzt_rubrics_head_text_abstract_width_dim { 50mm}
\dim_const:Nn \c__gzt_rubrics_head_text_no_abstract_width_dim
{ \c__gzt_rubrics_abstract_width_dim + \c__gzt_rubrics_head_text_abstract_width_dim}
\dim_new:N \l__gzt_rubrics_head_text_width_dim
\dim_const:Nn \c__gzt_layoutheight_dim { 270mm}
\dim_const:Nn \c__gzt_layoutwidth_dim  { 210mm}
\dim_const:Nn \c__gzt_printer_layoutoffset_dim { 5mm}
\bool_if:NTF {\g__gzt_for_printer_bool} {
  \dim_const:Nn \c__gzt_potential_layoutoffset_dim { \c__gzt_printer_layoutoffset_dim}
}{
  \dim_const:Nn \c__gzt_potential_layoutoffset_dim {\c_zero_dim}
}
\int_const:Nn \c__gzt_thresold_a_int {68}
\int_const:Nn \c__gzt_thresold_b_int {80}
\int_const:Nn \c__gzt_thresold_c_int {88}
\int_const:Nn \c__gzt_thresold_d_int {96}
\int_const:Nn \c__gzt_thresold_e_int {104}
\int_const:Nn \c__gzt_thresold_f_int {120}
\dim_const:Nn \c__gzt_bindingoffset_a_dim {3mm}
\dim_const:Nn \c__gzt_bindingoffset_b_dim {3.5mm}
\dim_const:Nn \c__gzt_bindingoffset_c_dim {3.9mm}
\dim_const:Nn \c__gzt_bindingoffset_d_dim {4.1mm}
\dim_const:Nn \c__gzt_bindingoffset_e_dim {4.5mm}
\dim_const:Nn \c__gzt_bindingoffset_f_dim {5mm}
\zexternaldocument[self]{\jobname}%
\int_new:N \g__gzt_total_pages_number_int%
\int_new:N \g__gzt_total_inside_pages_number_int%
\int_gset:Nn \g__gzt_total_pages_number_int { \zref@extractdefault{selfLastPage}{abspage}{0} }
\int_gset:Nn \g__gzt_total_inside_pages_number_int { \g__gzt_total_pages_number_int - 4 }
\int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_a_int}
{
  \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c_zero_dim }
}{
  \int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_b_int}
  {
    \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_a_dim }
  }{
    \int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_c_int}
    {
      \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_b_dim }
    }{
      \int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_d_int}
      {
        \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_c_dim }
      }{
        \int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_e_int}
        {
          \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_d_dim }
        }{
          \int_compare:nNnTF {\g__gzt_total_inside_pages_number_int}<{\c__gzt_thresold_f_int}
          {
            \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_e_dim }
          }{
            \dim_const:Nn \c__gzt_printer_bindingoffset_dim { \c__gzt_bindingoffset_f_dim }
          }
        }
      }
    }
  }
}
\bool_if:NTF {\g__gzt_cover_bool} {
  \dim_const:Nn \c__gzt_potential_bindingoffset_dim { \c__gzt_printer_bindingoffset_dim }
}{
  \dim_const:Nn \c__gzt_potential_bindingoffset_dim {\c_zero_dim}
}
\dim_const:Nn \c__gzt_paperheight_dim { \c__gzt_layoutheight_dim+2\c__gzt_potential_layoutoffset_dim}
\bool_if:NTF {\g__gzt_cover_bool} {
  \dim_const:Nn \c__gzt_paperwidth_dim  {
    \c__gzt_layoutwidth_dim
    +
    \c__gzt_potential_layoutoffset_dim
    +\c__gzt_potential_bindingoffset_dim
  }
}{
  \dim_const:Nn \c__gzt_paperwidth_dim  {
    \c__gzt_layoutwidth_dim
    +
    2
    \c__gzt_potential_layoutoffset_dim
    +\c__gzt_potential_bindingoffset_dim
  }
}
\dim_const:Nn \c__gzt_frontcover_image_width_dim {
    \c__gzt_layoutwidth_dim
    +
    \c__gzt_printer_layoutoffset_dim
}
\dim_const:Nn \c__gzt_topmargin_dim   { 31mm}
\dim_const:Nn \c__gzt_topmargin_frontcover_dim {
  \c__gzt_topmargin_dim
  + 30mm
}
\dim_const:Nn \c__gzt_topmargin_inside_cover_dim   {
  \c__gzt_topmargin_dim
  +10mm
}
\dim_const:Nn \c__gzt_topmargin_front_matter_dim   {
  \c__gzt_topmargin_inside_cover_dim
}
\dim_const:Nn \c__gzt_headsep_dim     { 24mm}
\dim_const:Nn \c__gzt_headsep_frontcover_dim {
  \c__gzt_headsep_dim
  +31mm
  % -\c__gzt_potential_layoutoffset_dim
}
\dim_const:Nn \c__gzt_headsep_inside_frontcover_dim {
  \c__gzt_headsep_dim
  +7mm
}
\dim_const:Nn \c__gzt_headsep_front_matter_dim {
  \c__gzt_headsep_inside_frontcover_dim
}
\dim_const:Nn \c__gzt_headheight_dim  { \c_zero_dim }
\dim_const:Nn \c__gzt_botmargin_dim   { 30mm}
\dim_const:Nn \c__gzt_footskip_dim    { 26mm}
\dim_const:Nn \c__gzt_extra_margin_dim { 5mm }
\dim_const:Nn \c__gzt_innermargin_dim { 15mm - \c__gzt_potential_bindingoffset_dim + \c__gzt_extra_margin_dim}
\dim_const:Nn \c__gzt_outermargin_dim { 30mm - \c__gzt_extra_margin_dim }
\dim_const:Nn \c__gzt_inside_cover_box_width_dim { 165mm }%
\dim_const:Nn \c__gzt_innermargin_inside_cover_dim {
  (\c__gzt_layoutwidth_dim - \c__gzt_inside_cover_box_width_dim)/2
  - \c__gzt_potential_bindingoffset_dim
  % + \c__gzt_adjustmargin_dim
}
\dim_const:Nn \c__gzt_outermargin_inside_cover_dim {
  (\c__gzt_layoutwidth_dim - \c__gzt_inside_cover_box_width_dim)/2
  % - \c__gzt_adjustmargin_dim
}
\dim_const:Nn \c__gzt_innermargin_backcover_dim { 10mm }
\dim_const:Nn \c__gzt_outermargin_backcover_dim { \c__gzt_innermargin_backcover_dim }
\dim_const:Nn \c__gzt_topmargin_backcover_dim { \c__gzt_innermargin_backcover_dim }
\dim_const:Nn \c__gzt_bottommargin_backcover_dim { \c__gzt_innermargin_backcover_dim }
\dim_const:Nn \c__gzt_frontcover_image_height_dim { 160mm}
\dim_const:Nn \c__gzt_radius_arc_dim { 85mm }%
\dim_const:Nn \c__gzt_frontmatter_headtext_xshift_dim { 19mm }%
\dim_const:Nn \c__gzt_frontmatter_headtext_o_xshift_dim {
  -\c__gzt_frontmatter_headtext_xshift_dim  -\c__gzt_potential_layoutoffset_dim%
}%
\dim_const:Nn \c__gzt_frontmatter_headtext_e_xshift_dim {
  \c__gzt_frontmatter_headtext_xshift_dim  +\c__gzt_potential_layoutoffset_dim%
}%
\dim_const:Nn \c__gzt_frontmatter_headtext_yshift_dim { -6.5mm-\c__gzt_potential_layoutoffset_dim }%
\dim_const:Nn \c__gzt_header_line_width_dim    { 0.25mm}
\dim_const:Nn \c__gzt_header_line_yshift_dim { -1mm-\c__gzt_header_line_width_dim}%
\dim_const:Nn \c__gzt_footer_background_height_dim    { 10mm + \c__gzt_potential_layoutoffset_dim }
\dim_const:Nn \c__gzt_front_matter_extra_innermargin_dim    { 28mm }
\dim_const:Nn \c__gzt_front_matter_extra_outermargin_dim    { 7mm }
\dim_const:Nn \c__gzt_inside_cover_offset_dim { \c_zero_dim }%
\dim_const:Nn \c__gzt_pictogram_width_dim { 23mm }%
\dim_const:Nn \c__gzt_header_xshift_dim { \c__gzt_pictogram_width_dim-6mm }%
\dim_const:Nn \c__gzt_header_yshift_dim { 5mm }%
\dim_const:Nn \c__gzt_xshift_arccircle_A_dim { \c__gzt_rubrics_abstract_width_dim+\c__gzt_innermargin_dim+10mm+\c__gzt_potential_layoutoffset_dim }%
\dim_const:Nn \c__gzt_yshift_arccircle_A_dim { -22mm-\c__gzt_potential_layoutoffset_dim }%
\dim_const:Nn \c__gzt_xshift_arccircle_B_dim {%
  (\c__gzt_rubrics_abstract_width_dim+\c__gzt_innermargin_dim)/2%
  % \c__gzt_innermargin_dim+(\c__gzt_rubrics_abstract_width_dim/2)%
  % \c__gzt_xshift_arccircle_A_dim/2
}%
\dim_const:Nn \c__gzt_yshift_arccircle_B_dim { -\c__gzt_potential_layoutoffset_dim }%
\dim_const:Nn \c__gzt_xshift_arccircle_C_dim { \c__gzt_potential_layoutoffset_dim-5mm }%
\dim_const:Nn \c__gzt_yshift_arccircle_C_dim { -19.75mm-\c__gzt_potential_layoutoffset_dim }%
\dim_const:Nn \c__gzt_book_review_frontcover_extend_dim { 12mm }%
\dim_const:Nn \c__gzt_tcb_left_dim { 4mm }%
\dim_const:Nn \c__gzt_tcb_boxsep_dim { 1mm }%
\dim_const:Nn \c__gzt_tikz_dot_diameter_dim { 0.33mm }%
\dim_const:Nn \c__gzt_tikz_dot_spacing_dim { 1.05mm }%
\dim_const:Nn \c__gzt_rubric_extra_xoffset_dim { -\c__gzt_innermargin_dim/2 }%
\dim_const:Nn \c__gzt_rubric_xoffset_dim { 14.5mm }%
\dim_const:Nn \c__gzt_boxed_issue_number_width_dim { 30mm}
\dim_const:Nn \c__gzt_boxed_issue_number_height_dim { 8mm}
\dim_new:N \l__gzt_thumbnail_width_dim
\dim_set:Nn \l__gzt_thumbnail_width_dim {30mm}
\dim_new:N \g__gzt_abstract_box_width_dim
\dim_new:N \c__gzt_original_parindent_dim
\dim_set_eq:NN \c__gzt_original_parindent_dim \parindent
\dim_new:N \l__gzt_between_rubric_head_text_and_abstract_dim
\dim_new:N \g__gzt_minitoc_circle_diameter_dim
\dim_new:N \g__gzt_minitoc_textwidth_dim
\dim_new:N \g__gzt_minitoc_xshift_dim
\dim_new:N \g__gzt_minitoc_yshift_dim
\dim_set:Nn \g__gzt_minitoc_circle_diameter_dim {142mm}
\dim_set:Nn \g__gzt_minitoc_textwidth_dim {65mm}
\dim_set:Nn \g__gzt_minitoc_xshift_dim {-22mm}
\dim_set:Nn \g__gzt_minitoc_yshift_dim {30mm}
\dim_const:Nn \c__gzt_minitoc_from_circle_xshift_dim {-15mm}
\dim_const:Nn \c__gzt_minitoc_from_circle_yshift_dim {-\c__gzt_minitoc_from_circle_xshift_dim}
\dim_const:Nn \c__gzt_footer_height_font_dim {3mm}
\dim_const:Nn \c__gzt_minitoc_list_labelsep_dim {1em}
\dim_const:Nn \c__gzt_authors_photos_width_dim {16mm}
\dim_const:Nn \c__gzt_authors_photos_box_width_dim {\c__gzt_authors_photos_width_dim
  + 2mm}
\dim_new:N \l__gzt_minibio_width_dim
\geometry{%
  papersize={\c__gzt_paperwidth_dim,\c__gzt_paperheight_dim}
}
\bool_if:NTF {\g__gzt_cover_bool} {
  \tl_const:Nn \c__gzt_frontcover_geometry_tl {%
    ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
    ,layoutvoffset=\c__gzt_potential_layoutoffset_dim
    ,bindingoffset=\c__gzt_potential_bindingoffset_dim
    ,top=\c__gzt_topmargin_frontcover_dim
    ,headsep=\c__gzt_headsep_frontcover_dim
    ,headheight=\c__gzt_headheight_dim
    ,bottom=\c_zero_dim
    ,footskip=\c_zero_dim
    ,outer=\c_zero_dim
    ,inner=\c__gzt_potential_layoutoffset_dim
    ,nomarginpar%
  }%
}{
  \tl_const:Nn \c__gzt_frontcover_geometry_tl {%
    ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
    ,layoutoffset=\c__gzt_potential_layoutoffset_dim
    ,bindingoffset=\c__gzt_potential_bindingoffset_dim
    ,top=\c__gzt_topmargin_frontcover_dim
    ,headsep=\c__gzt_headsep_frontcover_dim
    ,headheight=\c__gzt_headheight_dim
    ,bottom=\c_zero_dim
    ,footskip=\c_zero_dim
    ,hmargin=\c__gzt_potential_layoutoffset_dim
    ,nomarginpar%
  }%
}
\bool_if:NTF {\g__gzt_cover_bool} {
  \tl_const:Nn \c__gzt_inside_cover_geometry_tl {%
    ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
    ,layoutvoffset=\c__gzt_potential_layoutoffset_dim
    ,bindingoffset=\c__gzt_potential_bindingoffset_dim
    ,top=\c__gzt_topmargin_inside_cover_dim
    ,headheight=\c__gzt_headheight_dim
    ,headsep=\c__gzt_headsep_inside_frontcover_dim
    ,bottom=\c__gzt_botmargin_dim
    ,footskip=\c__gzt_footskip_dim
    ,inner=\c__gzt_innermargin_inside_cover_dim-\c__gzt_potential_layoutoffset_dim
    ,outer=\c__gzt_outermargin_inside_cover_dim+\c__gzt_potential_layoutoffset_dim
    ,nomarginpar%
  }%
}{
  \tl_const:Nn \c__gzt_inside_cover_geometry_tl {%
    ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
    ,layoutoffset=\c__gzt_potential_layoutoffset_dim
    ,bindingoffset=\c__gzt_potential_bindingoffset_dim
    ,top=\c__gzt_topmargin_inside_cover_dim
    ,headheight=\c__gzt_headheight_dim
    ,headsep=\c__gzt_headsep_inside_frontcover_dim
    ,bottom=\c__gzt_botmargin_dim
    ,footskip=\c__gzt_footskip_dim
    ,inner=\c__gzt_innermargin_inside_cover_dim
    ,outer=\c__gzt_outermargin_inside_cover_dim
    ,nomarginpar%
  }%
}
\tl_const:Nn \c__gzt_front_matter_geometry_tl {%
  ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
  ,layoutoffset=\c__gzt_potential_layoutoffset_dim
  % ,bindingoffset=\c__gzt_potential_bindingoffset_dim
  ,top=\c__gzt_topmargin_front_matter_dim%
  ,headheight=\c__gzt_headheight_dim
  ,headsep=\c__gzt_headsep_front_matter_dim
  ,bottom=\c__gzt_botmargin_dim
  ,footskip=\c__gzt_footskip_dim%
  ,inner=\c__gzt_innermargin_dim+\c__gzt_front_matter_extra_innermargin_dim%
  ,outer=\c__gzt_outermargin_dim+\c__gzt_front_matter_extra_outermargin_dim%
  ,nomarginpar%
}%
\tl_const:Nn \c__gzt_main_geometry_tl {%
  ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
  ,layoutoffset=\c__gzt_potential_layoutoffset_dim
  % ,bindingoffset=\c__gzt_potential_bindingoffset_dim
  ,top=\c__gzt_topmargin_dim-15mm%
  ,headheight=\c__gzt_headheight_dim
  ,headsep=\c__gzt_headsep_dim-18mm
  ,bottom=\c__gzt_botmargin_dim
  ,footskip=\c__gzt_footskip_dim
  ,inner=\c__gzt_innermargin_dim
  ,outer=\c__gzt_outermargin_dim
}%
\tl_const:Nn \c__gzt_backcover_geometry_tl {%
  ,layoutsize={\c__gzt_layoutwidth_dim,\c__gzt_layoutheight_dim}
  ,layoutoffset=\c__gzt_potential_layoutoffset_dim
  % ,bindingoffset=\c__gzt_potential_bindingoffset_dim
  ,top=\c__gzt_topmargin_backcover_dim%
  % ,top=\c__gzt_topmargin_dim-15mm%
  % ,headheight=\c__gzt_headheight_dim
  % ,headsep=\c__gzt_headsep_dim-18mm
  ,bottom=\c__gzt_bottommargin_backcover_dim
  % ,footskip=\c__gzt_footskip_dim
  ,inner=\c__gzt_innermargin_backcover_dim
  ,outer=\c__gzt_outermargin_backcover_dim
}
\skip_const:Nn \c__gzt_editorial_presidentmessage_parskip_skip { 12pt plus 2pt minus .8pt }%
\skip_const:Nn \c__gzt_mainmatter_parskip_skip { 2pt plus .5pt minus .2pt }%
\int_new:N \g__gzt_issue_number_int
\int_new:N \g__gzt_issue_month_int
\int_new:N \g__gzt_issue_year_int
\tl_new:N \g__gzt_frontcover_image_options_tl
\keys_define:nn { gzt/issuesetup }
{
  number .int_gset:N = \g__gzt_issue_number_int,
  month .int_gset:N = \g__gzt_issue_month_int,
  year .int_gset:N = \g__gzt_issue_year_int,
  number .value_required:,
  month .value_required:,
  year .value_required:,
  number .initial:n = 0,
  frontcoverimageoptions .tl_gset:N = \g__gzt_frontcover_image_options_tl
}
\tl_new:N \l__gzt_journal_publisher_tl
\tl_new:N \l__gzt_journal_address_tl
\tl_new:N \l__gzt_journal_phone_tl
\tl_new:N \l__gzt_journal_fax_tl
\tl_new:N \l__gzt_journal_email_tl
\tl_new:N \l__gzt_journal_url_tl
\tl_new:N \l__gzt_journal_issn_tl
\tl_new:N \l__gzt_journal_isbn_tl
\keys_define:nn { gzt/journalsetup }
{
  publisher .tl_set:N = \l__gzt_journal_publisher_tl,
  address .tl_set:N = \l__gzt_journal_address_tl,
  phone .tl_set:N = \l__gzt_journal_phone_tl,
  fax .tl_set:N = \l__gzt_journal_fax_tl,
  email .tl_set:N = \l__gzt_journal_email_tl,
  url .tl_set:N = \l__gzt_journal_url_tl,
  issn .tl_set:N = \l__gzt_journal_issn_tl,
  isbn .tl_set:N = \l__gzt_journal_isbn_tl,
  publisher .value_required:,
  address .value_required:,
  phone .value_required:,
  fax .value_required:,
  email .value_required:,
  url .value_required:,
  issn .value_required:,
  isbn .value_required:,
}
\keys_define:nn { gzt/title }
{
  short .tl_gset:N = \g__gzt_short_title_tl,
  minishort .tl_gset:N = \g__gzt_mini_short_title_tl,
  notintoc .bool_gset:N = \g__gzt_title_not_in_toc_bool,
  short .value_required:,
  minishort .value_required:,
}
\keys_define:nn { gzt/subtitle }
{
  short .tl_gset:N = \g__gzt_short_subtitle_tl,
  minishort .tl_gset:N = \g__gzt_mini_short_subtitle_tl,
  notintoc .bool_gset:N = \g__gzt_subtitle_not_in_toc_bool,
  short .value_required:,
  minishort .value_required:,
}
\keys_define:nn { gzt/rubric }
{
  abstract .tl_gset:N = \g__gzt_rubric_abstract_tl,
  title .tl_gset:N = \g__gzt_rubric_title_tl,
  pictogram .tl_gset:N = \g__gzt_rubric_pictofile_tl,
  abstract .value_required:,
  title .value_required:,
  pictogram .value_required:,
}
\keys_define:nn { gzt/minitoc }
{
  list .bool_gset:N = \g__gzt_minitoc_list_bool,
  help .bool_gset:N = \g__gzt_minitoc_help_bool,
  diameter .dim_gset:N = \g__gzt_minitoc_circle_diameter_dim,
  textwidth .dim_gset:N = \g__gzt_minitoc_textwidth_dim,
  xshift .dim_gset:N = \g__gzt_minitoc_xshift_dim,
  yshift .dim_gset:N = \g__gzt_minitoc_yshift_dim,
  diameter .value_required:,
  textwidth .value_required:,
  xshift .value_required:,
  yshift .value_required:,
}
\keys_define:nn { gzt/authors }
{
  affiliation .tl_gset:N = \g__gzt_people_affiliation_tl,
  email .tl_gset:N = \g__gzt_people_email_tl,
  minibio .tl_gset:N = \g__gzt_people_minibio_tl,
  photo .tl_gset:N = \g__gzt_people_photo_tl,
  webpage .tl_gset:N = \g__gzt_people_webpage_tl,
  affiliation .value_required:,
  email .value_required:,
  minibio .value_required:,
  photo .value_required:,
  webpage .value_required:,
}
\tl_new:N \g__gzt_interviewee_minibio_tl
\tl_new:N \g__gzt_interviewee_photo_tl
\tl_new:N \g__gzt_interviewee_first_last_name_tl
\keys_define:nn { gzt/interviewees }
{
  minibio .tl_gset:N = \g__gzt_interviewee_minibio_tl,
  photo .tl_gset:N = \g__gzt_interviewee_photo_tl,
  minibio .value_required:,
  photo .value_required:,
}
\tl_new:N \g__gzt_bookreview_frontcover_tl
\tl_new:N \g__gzt_bookreview_bibkey_tl
\keys_define:nn { gzt/bookreview }
{
  frontcover .tl_gset:N = \g__gzt_bookreview_frontcover_tl,
  bibkey .tl_gset:N = \g__gzt_bookreview_bibkey_tl,
  frontcover .value_required:,
  bibkey .value_required:,
}
\tl_new:N \g__gzt_bookadvertisement_frontcover_tl
\tl_new:N \g__gzt_bookadvertisement_bibkey_tl
\keys_define:nn { gzt/bookadvertisement }
{
  frontcover .tl_gset:N = \g__gzt_bookadvertisement_frontcover_tl,
  bibkey .tl_gset:N = \g__gzt_bookadvertisement_bibkey_tl,
  frontcover .value_required:,
  bibkey .value_required:,
}
\tl_new:N \l__gzt_newtheorem_style_tl
\keys_define:nn { gzt/newtheorem }
{
  frenchtitle .tl_set:N = \l__gzt_newtheorem_frenchtitle_tl,
  englishtitle .tl_set:N = \l__gzt_newtheorem_englishtitle_tl,
  frenchtitle .value_required:,
  englishtitle .value_required:,
  %
  style .choice:,
  style / theorem .code:n = {\tl_set:Nn \l__gzt_newtheorem_style_tl {theorem}},
  style / definition .code:n = {\tl_set:Nn \l__gzt_newtheorem_style_tl {definition}},
  style / proof .code:n = {\tl_set:Nn \l__gzt_newtheorem_style_tl {proof}},
  style / unknown .code:n =
  \msg_error:nnxxx { gzt } { unknown-choice }
  { style } % Name of choice key
  { theorem~or~definition~or~proof } % Valid choices
  { \exp_not:n {#1} } % Invalid choice given
}
\definecolorset{cmyk}{__gzt_}{_color}{
  generic_dark,1,.60,.10,0; % kind of blue (!)
  light_generic_dark,1,.35,0,0 % kind of blue (!), light
}
\colorlet{__gzt_generic_light_color}{black!50}
\colorlet{__gzt_dark_generic_light_color}{black!60}
\colorlet{__gzt_description_label_light_color}{__gzt_dark_generic_light_color}
\colorlet{__gzt_minitoc_color}{__gzt_generic_light_color}
\colorlet{__gzt_cover_itemize_label_color}{__gzt_light_generic_dark_color}
\colorlet{__gzt_default_text_color}{black}
\colorlet{__gzt_head_text_color}{black!65}
\colorlet{__gzt_rubric_head_text_color}{__gzt_head_text_color}
\colorlet{__gzt_bibliography_minibios_acknowledgments_bg_color}{black!10}
\colorlet{__gzt_headrule_color}{__gzt_generic_light_color!65}
\colorlet{__gzt_circlerule_color}{__gzt_generic_dark_color!65}
\colorlet{__gzt_frontmatter_text_color}{black!75}
\colorlet{__gzt_people_color}{__gzt_generic_dark_color}
\colorlet{__gzt_arrayrule_color}{__gzt_generic_dark_color}
\colorlet{__gzt_acknowledgements_color}{__gzt_generic_dark_color}
\colorlet{__gzt_question_color}{__gzt_generic_dark_color}
\colorlet{__gzt_boxed_issue_number_bg_color}{__gzt_generic_dark_color}
\colorlet{__gzt_rule_in_toc_color}{__gzt_generic_dark_color}
\colorlet{__gzt_rubric_in_toc_color}{__gzt_generic_dark_color}
\colorlet{__gzt_article_in_toc_color}{__gzt_frontmatter_text_color}
\colorlet{__gzt_rubric_title_color}{__gzt_generic_light_color}
\colorlet{__gzt_article_title_color}{__gzt_generic_dark_color}
\colorlet{__gzt_section_color}{__gzt_generic_dark_color}
\colorlet{__gzt_subsection_color}{__gzt_generic_dark_color!90}
\colorlet{__gzt_subsubsection_color}{__gzt_generic_dark_color!80}
\colorlet{__gzt_rubric_abstract_color}{__gzt_generic_dark_color}
\colorlet{__gzt_article_abstract_color}{__gzt_generic_light_color}
\colorlet{__gzt_dotfill_color}{__gzt_generic_dark_color}
\colorlet{__gzt_about_frontcover_title_color}{__gzt_generic_dark_color}
\colorlet{__gzt_reflected_text_color}{__gzt_generic_dark_color}
\colorlet{__gzt_inside_frontcover_frame_bg_color}{__gzt_generic_dark_color!8}
\colorlet{__gzt_inside_frontcover_frame_title_color}{__gzt_generic_dark_color}
\colorlet{__gzt_footer_bg_color}{black!10}
\colorlet{__gzt_float_title_color}{__gzt_generic_dark_color}
\colorlet{__gzt_float_title_bg_color}{__gzt_generic_dark_color!10}
\colorlet{__gzt_float_frame_color}{__gzt_generic_dark_color!20}
\colorlet{__gzt_chapter_color}{__gzt_generic_dark_color}
\colorlet{__gzt_smf_number_color}{__gzt_generic_dark_color}
\colorlet{__gzt_date_color}{__gzt_generic_light_color}
\colorlet{__gzt_table_head_color}{__gzt_generic_dark_color!25}
\colorlet{__gzt_book_review_frame_bg_color}{__gzt_generic_dark_color!8}
\colorlet{__gzt_book_advertisement_bg_color}{white}
\colorlet{__gzt_book_advertisement_frame_color}{__gzt_generic_dark_color}
\AtBeginEnvironment{multicols}{
  \bool_gset_true:N \g__gzt_multicols_bool
}
\AtEndEnvironment{multicols}{
  \bool_gset_false:N \g__gzt_multicols_bool
}
\AtBeginEnvironment{refsection}{
  \bool_gset_true:N \g__gzt_refsection_bool
}
\AtEndEnvironment{refsection}{
  \bool_gset_false:N \g__gzt_refsection_bool
}
\tl_const:Nn \c__gzt_footer_size_font_tl {
  \fontsize{\c__gzt_footer_height_font_dim}{\c_zero_dim}\selectfont%
}
\tl_new:N \g__gzt_smf_short_string_tl
\tl_new:N \g__gzt_smf_string_tl
\tl_gset:Nn \g__gzt_smf_short_string_tl {
  % \cs_if_exist:cTF {texorpdfstring}
  % {
    \texorpdfstring{\c__gzt_smf_short_string_tl}{\c__gzt_smf_short_pdf_string_tl}
  % }{%
  %   \c__gzt_smf_short_pdf_string_tl
  % }%
}
\tl_gset:Nn \g__gzt_smf_string_tl {
  % \cs_if_exist:cTF {texorpdfstring}
  % {
  % \texorpdfstring{Soci\'et\'e~Math\'ematique~de~France}{\c__gzt_smf_string_tl}
  \c__gzt_smf_string_tl
  % }{%
  %   \acrlong*{smf}
  % }%
}
\tl_new:N \l__gzt_gzt_short_string_tl
\tl_new:N \l__gzt_gzt_string_tl
\tl_set:Nn \l__gzt_gzt_short_string_tl {
  \cs_if_exist:cTF {texorpdfstring}
  {
    \texorpdfstring{\emph{\c__gzt_journal_short_title_string_tl}}{\c__gzt_journal_short_title_string_tl}
  }{%
    \emph{\c__gzt_journal_short_title_string_tl}
  }%
}
\tl_set:Nn \l__gzt_gzt_string_tl {
  \cs_if_exist:cTF {texorpdfstring}
  {
    \texorpdfstring{\emph{\c__gzt_journal_title_string_tl}}{\c__gzt_journal_title_string_tl}
  }{%
    \emph{\c__gzt_journal_title_string_tl}
  }%
}
\tl_new:N \g__gzt_pdftitle_string_tl
\tl_new:N \g__gzt_pdfauthor_string_tl
\tl_gset:Nn \g__gzt_pdftitle_string_tl {
  \c__gzt_pdftitle_string_tl
}
\tl_gset:Nn \g__gzt_pdfauthor_string_tl {
  \g__gzt_smf_string_tl
}
\AtEndPreamble{%
  \hypersetup{%
    pdftitle=\g__gzt_pdftitle_string_tl,
    pdfauthor=\g__gzt_pdfauthor_string_tl%
  }
}
\DTLnewdb{__gzt_authors}
\cs_new_protected:Nn \__gzt_authors:nnnnnn
  {
    \DTLnewrow{__gzt_authors}%
    \DTLnewdbentry{__gzt_authors}{first-last-name}{#1}%
    \DTLnewdbentry{__gzt_authors}{affiliation}{#2}%
    \DTLnewdbentry{__gzt_authors}{email}{#3}%
    \DTLnewdbentry{__gzt_authors}{minibio}{#4}%
    \DTLnewdbentry{__gzt_authors}{photo}{#5}%
    \DTLnewdbentry{__gzt_authors}{webpage}{#6}%
  }
\cs_new_protected:Nn \__gzt_email:n
  {
    \href{mailto:#1}{\nolinkurl{#1}}%
  }
\cs_generate_variant:Nn \__gzt_authors:nnnnnn { nVVVVV }
\cs_new_protected:Nn \__gzt_display_author:nnnnn
{
  \begin{tabular}[t]{p{\c__gzt_authors_photos_box_width_dim}p{0.75\linewidth}}
    \tl_if_empty:nF {#5}
    {%
    \begin{adjustbox}{valign=t}
      \includegraphics[width=\c__gzt_authors_photos_width_dim]{#5}
    \end{adjustbox}%
    }
    &
      \begin{description}[leftmargin=1em,style=nextline,nosep]
      \item[\textcolor{__gzt_people_color}{\DeclareNameAlias{labelname}{default}\citeauthor{#1}}]
        \tl_if_empty:nF {#2}
        {%
          #2%
          \par%
          \smallskip%
        }
        \tl_if_empty:nF {#3}
        {%
          \href{mailto:#3}{\nolinkurl{#3}}%
          \par%
          \smallskip%
        }
        \tl_if_empty:nF {#4}
        {%
          #4
        }
      \end{description}
  \end{tabular}
}
\cs_generate_variant:Nn \__gzt_display_author:nnnnn { VVVVV }
\DTLnewdb{__gzt_interviewees}
\cs_new_protected:Nn \__gzt_interviewees:nnn
  {
    \DTLnewrow{__gzt_interviewees}%
    \DTLnewdbentry{__gzt_interviewees}{first-last-name}{#1}%
    \DTLnewdbentry{__gzt_interviewees}{minibio}{#2}%
    \DTLnewdbentry{__gzt_interviewees}{photo}{#3}%
  }
\cs_generate_variant:Nn \__gzt_interviewees:nnn { nVV }
\DTLnewdb{people}
\tl_new:N \l__gzt_crossref_tl
\cs_new_protected:Nn \__gzt_people:nnnnnnnn
{
  \DTLnewrow{people}%
  \DTLnewdbentry{people}{first-last-name}{#1}%
  \DTLnewdbentry{people}{affiliation}{#2}%
  \DTLnewdbentry{people}{email}{#3}%
  \DTLnewdbentry{people}{minibio}{#4}%
  \DTLnewdbentry{people}{photo}{#5}%
  \DTLnewdbentry{people}{speciality}{#6}%
  \DTLnewdbentry{people}{role}{#7}%
  \DTLnewdbentry{people}{webpage}{#8}%
  \int_if_exist:cF {g__gzt_#7_int}
  {
    \int_new:c {g__gzt_#7_int}
  }
  \int_incr:c {g__gzt_#7_int}
  \tl_if_in:nnTF { #7 } { author } {
    \tl_set:Nn \l__gzt_crossref_tl {\c__gzt_issue_bib_key_tl -art-\int_use:N \g__gzt_articles_int}
  } {
    \tl_set:Nn \l__gzt_crossref_tl {\c__gzt_issue_bib_key_tl}
  }
  \tl_set:Nn \l__gzt_people_first_last_name_tl {#1}
  \iow_now:Nx \g__gzt_bib_out_iow {%
    @article{
      \c__gzt_issue_bib_key_tl -#7- \int_use:c {g__gzt_#7_int},
      \iow_newline:
      author={\exp_not:V\l__gzt_people_first_last_name_tl},
      \iow_newline:
      options={skipbib},
      \iow_newline:
      crossref  = {\l__gzt_crossref_tl}
      \iow_newline:
    }
    \iow_newline:
  }%
}
\cs_generate_variant:Nn \__gzt_people:nnnnnnnn { nVVVVnxV }
\cs_new_protected:Nn \__gzt_display_academic_signature:n
{
  \bigskip
    #1
}
\cs_new_protected:Nn \__gzt_display_people_by_role:n
{
  \DTLforeach*[\DTLiseq{\l__gzt_people_role_tl}{#1}]{people}{%
    \l__gzt_firstlastname=first-last-name%
    ,\l__gzt_people_affiliation_tl=affiliation%
    ,\l__gzt_people_email_tl=email%
    ,\l__gzt_people_minibio_tl=minibio%
    ,\l__gzt_people_photo_tl=photo%
    ,\l__gzt_people_speciality=speciality%
    ,\l__gzt_people_role_tl=role%
    ,\l__gzt_people_webpage_tl=webpage%
  }{%
    \tl_if_in:NnTF \l__gzt_people_role_tl { editor } {
    \item[
      \textcolor{__gzt_people_color}{%
        \__gzt_citeauthor_no_firstinits:n {\c__gzt_issue_bib_key_tl -#1- \exp_not:V\DTLcurrentindex}%
      }
      \tl_if_in:NnF \l__gzt_people_speciality { NoValue } { ~(\l__gzt_people_speciality) }
      ]
      \l__gzt_people_affiliation_tl%
      \newline%
      \href{mailto:\l__gzt_people_email_tl}{\nolinkurl{\l__gzt_people_email_tl}}%
      \DTLiflastrow{%
      }{%
        \medskip%
      }
    }{
      \tl_if_in:NnTF \l__gzt_people_role_tl { author } {
        \footnotesize%
        % \noindent%
        \dim_set:Nn \l__gzt_minibio_width_dim {\linewidth-1em - \c__gzt_authors_photos_box_width_dim}
        \tl_if_empty:NTF \l__gzt_people_photo_tl
        {%
          \dim_add:Nn \l__gzt_minibio_width_dim {\c__gzt_authors_photos_box_width_dim}
        }{%
          \begin{adjustbox}{valign=t,minipage=\c__gzt_authors_photos_box_width_dim}
            \includegraphics[width=\c__gzt_authors_photos_width_dim]{\l__gzt_people_photo_tl}
          \end{adjustbox}%
          \quad%
        }
        \begin{adjustbox}{valign=t,minipage=\l__gzt_minibio_width_dim}
          \begin{description}[leftmargin=1em,style=nextline]
            \item[%
              \textcolor{__gzt_people_color}{%
                \__gzt_citeauthor_no_firstinits:n {\c__gzt_issue_bib_key_tl -#1- \exp_not:V\DTLcurrentindex}%
              }%
              ]
              \tl_if_empty:NF \l__gzt_people_affiliation_tl
              {%
                \mbox{}%
                \par%
                \vspace{-2ex}%
                \l__gzt_people_affiliation_tl%
              }
              \tl_if_empty:NF \l__gzt_people_email_tl
              {%
                \par%
                \href{mailto:\l__gzt_people_email_tl}{\nolinkurl{\l__gzt_people_email_tl}}%
              }
              \tl_if_empty:NF \l__gzt_people_webpage_tl
              {%
                \par%
                \url{\l__gzt_people_webpage_tl}%
              }
              \tl_if_empty:NF \l__gzt_people_minibio_tl
              {%
                \par%
                \smallskip%
                \l__gzt_people_minibio_tl
              }
            \end{description}
          \end{adjustbox}
        \DTLiflastrow{%
        }{
          \DTLpar%
          \medskip%
        }
      }{
        \__gzt_citeauthor_no_firstinits:n {\c__gzt_issue_bib_key_tl -#1-
          \exp_not:V\DTLcurrentindex}%
        \tl_if_empty:NF \l__gzt_people_email_tl
        {
          \space(\href{mailto:\l__gzt_people_email_tl}{\nolinkurl{\l__gzt_people_email_tl}})
        }
      }
    }
  }
}
\cs_new_protected:Nn \__gzt_reflected_text:n
{
  \begin{tikzpicture}
    \tikzset{__gzt_reflect_node/.style={%
        anchor=base,%
        inner~sep=0,%
        line~width=0,%
        font=\Huge,
        color=__gzt_reflected_text_color%
      }%
    }%
    \node[__gzt_reflect_node]{#1};
    \node[scope~fading=south,opacity=0.2,yscale=-1,__gzt_reflect_node]{#1};
  \end{tikzpicture}
}
\tl_new:N \g__gzt_display_frontcover_tl%
\tl_gset:Nn \g__gzt_display_frontcover_tl {%
  \bool_gset_true:N \g__gzt_frontcover_bool
  \pagenumbering{roman}%
  \pagestyle{__gzt_frontcover_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_frontcover_geometry_tl}%
  \noindent%
  \bool_if:NTF {\g__gzt_cover_bool} {
    \hspace*{-\c__gzt_potential_layoutoffset_dim}
  }{
    \hspace*{-2\c__gzt_potential_layoutoffset_dim}
  }
  \exp_after:wN\includegraphics\exp_after:wN[\g__gzt_frontcover_image_options_tl]{\g__gzt_frontcover_image_file_tl}
  \begin{tikzpicture}[remember~picture, overlay]
    \coordinate (__gzt_circle_minitoc_center) at
    ([xshift=\g__gzt_minitoc_xshift_dim-\c__gzt_potential_layoutoffset_dim,yshift=\g__gzt_minitoc_yshift_dim+\c__gzt_potential_layoutoffset_dim]current~page.south~east) ;
    \node[name=__gzt_circle_minitoc,shape=circle,inner~sep=\c_zero_dim,fill=white,text~width=\g__gzt_minitoc_circle_diameter_dim] at
    (__gzt_circle_minitoc_center) {};
    \node[text~width=\g__gzt_minitoc_textwidth_dim,anchor=north~west] at
    ([xshift=\c__gzt_minitoc_from_circle_xshift_dim,yshift=\c__gzt_minitoc_from_circle_yshift_dim]$ (__gzt_circle_minitoc.north)!.5!(__gzt_circle_minitoc.west) $)
    {
      \large
      \color{__gzt_minitoc_color}
      \bool_if:NF {\g__gzt_frontcover_minitoc_tl} {
        \g__gzt_frontcover_minitoc_tl
      }
    };
    \bool_if:NT {\g__gzt_minitoc_help_bool} {
      \fill[red] (__gzt_circle_minitoc_center) circle (2pt);
    }
  \end{tikzpicture}
  \bool_if:NT {\g__gzt_cover_bool} {
    \small
    \begin{tikzpicture}[remember~picture, overlay]
      \node[name=__gzt_binding_sw,inner~sep=\c_zero_dim,fill=white,rotate=90,anchor=west] at
      ([xshift=0.45\c__gzt_potential_bindingoffset_dim,yshift=15mm+\c__gzt_potential_layoutoffset_dim]current~page.south~west) {
        \No\int_use:N\g__gzt_issue_number_int
      };
      \node[name=__gzt_binding_w,inner~sep=\c_zero_dim,fill=white,rotate=90] at
      ([xshift=0.45\c__gzt_potential_bindingoffset_dim]current~page.west) {
        \MakeUppercase{\c__gzt_journal_title_string_tl}
      };
      \node[name=__gzt_binding_nw,inner~sep=\c_zero_dim,fill=white,rotate=90,anchor=east] at
      ([xshift=0.45\c__gzt_potential_bindingoffset_dim,yshift=-15mm-\c__gzt_potential_layoutoffset_dim]current~page.north~west) {
        \l__gzt_uppercased_date_format\displaydate{__gzt_date}
      };
    \end{tikzpicture}
  }
  \vfill%
  \noindent%
  \hspace*{10mm}%
  \hspace*{-\c__gzt_potential_layoutoffset_dim}
  \includegraphics[height=22.5mm]{\c__gzt_smf_logo_file_string_tl}%
  \vfill%
  \clearpage%
  \bool_gset_false:N \g__gzt_frontcover_bool
}
\tl_new:N \g__gzt_display_inside_frontcover_tl%
\tl_gset:Nn \g__gzt_display_inside_frontcover_tl {%
  \bool_gset_true:N \g__gzt_inside_frontcover_bool%
  \pagestyle{__gzt_inside_frontcover_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_inside_cover_geometry_tl}%
  \small%
  \setlength{\columnseprule}{2pt}
  \renewcommand{\columnseprulecolor}{\color{white}}
  \begin{__gzt_inside_cover_tcb}[__gzt_tcb_inside_frontcover_style]
    \begin{multicols}{2}
      \setlength{\columnsep}{1mm}
      \begin{description}[leftmargin=1em]
      \item[\c__gzt_editors_in_chief_string_tl] \
        \begin{description}[leftmargin=1em,style=nextline]
          \__gzt_display_people_by_role:n {editorinchief}
        \end{description}
        \bigskip
        \par
      \item[\c__gzt_editors_string_tl] \
        \begin{description}[leftmargin=1em,style=nextline]
          \__gzt_display_people_by_role:n {editor}
        \end{description}
      \end{description}
    \end{multicols}
    \setlength{\columnseprule}{1pt}
    \tcblower
    \begin{tabular}{@{}m{.75\c__gzt_inside_cover_box_width_dim}@{}m{.2\c__gzt_inside_cover_box_width_dim-2\tabcolsep}@{}}
      \begin{description}[leftmargin=1em]
      \item[\c__gzt_editorial_secretariat_string_tl{}~:] \ \par%
        \l__gzt_journal_publisher_tl%
        % \par%
        \space\textendash{}\space%
        \__gzt_display_people_by_role:n { secretary }\par
        \l__gzt_journal_address_tl\par%
        \c__gzt_phone_string_tl{}~:~\l__gzt_journal_phone_tl{} \space\textendash{}\space
        \c__gzt_fax_string_tl{}~:~\l__gzt_journal_fax_tl\par%
        \href{mailto:\l__gzt_journal_email_tl}{\nolinkurl{\l__gzt_journal_email_tl}}%
        % \newline%
        \space\textendash{}\space
        \url{\l__gzt_journal_url_tl}
      \item[\c__gzt_publishingdirector_string_tl{}~:]
        \__gzt_display_people_by_role:n { president }
      \item[\c__gzt_issn_string_tl{}~:] \l__gzt_journal_issn_tl
        \tl_if_empty:NF \l__gzt_journal_isbn_tl
        {%
        \item[\c__gzt_isbn_string_tl{}~:] \l__gzt_journal_isbn_tl
        }
        \bool_if:NT {\g__gzt_no_inside_backcover_bool} {
        \item[\c__gzt_latexclass_string_tl{}~:]
          \__gzt_display_people_by_role:n { classdesigner }
        \item[\c__gzt_artistic_director_string_tl{}~:]
          \__gzt_display_people_by_role:n { graphicdesigner }
        \item[\c__gzt_printer_string_tl{}~:] \g__gzt_printer_text_tl
        }
      \end{description}
      \bool_if:NT {\g__gzt_no_inside_backcover_bool} {
      \g__gzt_font_designer_text_tl
      }
      &
        \hspace*{\fill}%
        \includegraphics[height=20mm]{\c__gzt_smf_logo_file_string_tl}%
    \end{tabular}
    % \\
    % \c__gzt_font_string_tl
    \bigskip
    \tl_if_empty:NF \g__gzt_about_frontcover_tl
    {%
      \\
      \begin{adjustbox}{valign=t,minipage=.75\c__gzt_inside_cover_box_width_dim+.2\c__gzt_inside_cover_box_width_dim-2\tabcolsep}
        \begin{description}[leftmargin=1em,font=\color{__gzt_about_frontcover_title_color}]
        \item[\g__gzt_about_frontcover_string_tl] \g__gzt_about_frontcover_tl
          \bool_if:NT {\g__gzt_credit_frontcover_bool} {
            \space(\c__gzt_credit_frontcover_string_tl{}~:~%
            \DTLforeach*[\DTLiseq{\l__gzt_people_role_tl}{frontcovercredit}]{people}{%
              \l__gzt_firstlastname=first-last-name%
              ,\l__gzt_people_role_tl=role%
            }{%
              \__gzt_citeauthor_no_firstinits:n
              {\c__gzt_issue_bib_key_tl -frontcovercredit- \exp_not:V\DTLcurrentindex}%
            }%
            ).%
          }
        \end{description}
      \end{adjustbox}
    }
  \end{__gzt_inside_cover_tcb}
  \clearpage%
  \pagenumbering{arabic}%
  \bool_gset_false:N \g__gzt_inside_frontcover_bool
}
\tl_new:N \g__gzt_display_inside_backcover_tl%
\tl_gset:Nn \g__gzt_display_inside_backcover_tl {%
  \bool_gset_true:N \g__gzt_inside_backcover_bool%
  \cleardoublepage%
  \pagestyle{__gzt_inside_backcover_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_inside_cover_geometry_tl}%
  \bool_if:NTF {\g__gzt_no_inside_backcover_bool} {
    \hbox{}
  }{%
    \small%
    \begin{__gzt_inside_cover_tcb}[__gzt_tcb_inside_backcover_style]
      \file_if_exist:nT { \c__gzt_authors_instructions_file_tl } {%
        % \begin{multicols}{2}
        %   \setlength{\columnsep}{1mm}
        \file_input:n {\c__gzt_authors_instructions_file_tl}
        % \end{multicols}
        % \setlength{\columnseprule}{1pt}
        \tcblower
      }
      \begin{description}[leftmargin=1em]
      \item[\c__gzt_latexclass_string_tl{}~:]
        \__gzt_display_people_by_role:n { classdesigner }
      \item[\c__gzt_artistic_director_string_tl{}~:]
        \__gzt_display_people_by_role:n { graphicdesigner }
      \item[\c__gzt_printer_string_tl{}~:] \g__gzt_printer_text_tl
      \end{description}
      \g__gzt_font_designer_text_tl
    \end{__gzt_inside_cover_tcb}
  }
  \bool_gset_false:N \g__gzt_inside_backcover_bool
}
\tl_new:N \g__gzt_display_backcover_tl%
\tl_gset:Nn \g__gzt_display_backcover_tl {%
  \bool_gset_true:N \g__gzt_backcover_bool
  \pagestyle{__gzt_backcover_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_backcover_geometry_tl}%
  \file_if_exist:nTF { \c__gzt_backcover_page_file_string_tl } {%
    \file_input:n {\c__gzt_backcover_page_file_string_tl}
  }{%
    \hbox{}
  }
}
\NewDocumentCommand \editorinchief {ommm}
{
  \int_incr:N \g__gzt_editors_in_chief_int
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{editorinchief}{}
}
\NewDocumentCommand \editor {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{editor}{}
}

\NewDocumentCommand \president {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{president}{}
}
\NewDocumentCommand \classdesigner {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{classdesigner}{}
}
\NewDocumentCommand \classmaintainer {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{classmaintainer}{}
}
\NewDocumentCommand \fontdesigner {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{fontdesigner}{}
}
\NewDocumentCommand \graphicdesigner {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{graphicdesigner}{}
}
\NewDocumentCommand \secretary {ommm}
{
  \__gzt_people:nnnnnnnn {#2}{#3}{#4}{}{}{#1}{secretary}{}
}
\NewDocumentCommand \issuesetup { m } {
  \keys_set:nn { gzt/issuesetup } {frontcoverimageoptions={width=\c__gzt_frontcover_image_width_dim},#1}
  \int_compare:nNnT {\g__gzt_issue_number_int}<{1}
  {
    \int_set:Nn \g__gzt_issue_number_int { \c__gzt_first_issue_number_int }
    \msg_warning:nnn{gzt}{issue-number-needed}{number}
  }
  \int_compare:nNnT {\g__gzt_issue_month_int * \g__gzt_issue_year_int}<{1}
  {
    \int_new:N \g__gzt_issue_age_in_months_int%
    \int_gset:Nn \g__gzt_issue_age_in_months_int
    {
      \c__gzt_first_issue_month_int
      + \c__gzt_interval_in_months_int
      * ( \int_use:N \g__gzt_issue_number_int - \c__gzt_first_issue_number_int )
    }
  }
  \int_compare:nNnT {\g__gzt_issue_month_int}<{1}
  {
    \int_gset:Nn \g__gzt_issue_month_int
    {
      \int_mod:nn { \g__gzt_issue_age_in_months_int } { 12 }
    }
  }
  \int_compare:nNnT {\g__gzt_issue_year_int}<{1}
  {
    \int_new:N \g__gzt_issue_age_in_years_int%
    \int_gset:Nn \g__gzt_issue_age_in_years_int
    {%
      \int_div_truncate:nn { \g__gzt_issue_age_in_months_int } { 12 }
    }%
    \int_gset:Nn \g__gzt_issue_year_int
    {
      \g__gzt_issue_age_in_years_int + \c__gzt_first_issue_year_int
    }
  }%
}
\NewDocumentCommand \journalsetup { m } {
  \keys_set:nn { gzt/journalsetup } { #1 }
}
\RenewDocumentCommand \date { mmm } {
  \newdate{__gzt_president_message_date}{#1}{#2}{#3}%
}
\NewDocumentCommand \interviewee { om } {
  \tl_if_empty:nT \g__gzt_title_tl {
    \tl_gset:Nn \g__gzt_title_tl {
      \c__gzt_interview_title_string_tl
      \DeclareNameAlias{labelname}{default}\citeauthor{\c__gzt_issue_bib_key_tl -art-\int_use:N
        \g__gzt_articles_int}
    }
  }
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/interviewees } { #1 }
  }
  \tl_set:Nn \l__gzt_people_first_last_name_tl {#2}
  \__gzt_people:nVVVVnxV
  {#2}
  {\g__gzt_people_affiliation_tl}
  {\g__gzt_people_email_tl}
  {\g__gzt_people_minibio_tl}
  {\g__gzt_people_photo_tl}
  {}
  {interviewee-art-\int_use:N \g__gzt_articles_int}
  {}
  % \maketitle
}
\NewDocumentCommand \academicsignature { m } {
  \__gzt_display_academic_signature:n {#1}
}
\cs_new_protected:Nn \__gzt_uppercased_monthname_french:n
{
  \@orgargctr=#1\relax
  \ifcase\@orgargctr
  \PackageError{datetime}{Invalid~month~number~\the\@orgargctr}{%
    Month~numbers~should~go~from~1~(janvier)~to~12~(decembre)}%
  \or JANVIER%
  \or F\'EVRIER%
  \or MARS%
  \or AVRIL%
  \or MAI%
  \or JUIN%
  \or JUILLET%
  \or AO\^UT%
  \or SEPTEMBRE%
  \or OCTOBRE%
  \or NOVEMBRE%
  \or D\'ECEMBRE%
  \else
  \PackageError{datetime}{Invalid~month~number~\the\@orgargctr}{%
    Month~numbers~should~go~from~1~(janvier)~to~12~(decembre)}%
  \fi
}
\newdate{__gzt_date}
  {1}
  {\int_use:N \g__gzt_issue_month_int}
  {\int_use:N \g__gzt_issue_year_int}
\newdateformat{l__gzt_uppercased_date_format}{
  \__gzt_uppercased_monthname_french:n {\THEMONTH}~\THEYEAR
}
\AtBeginDocument{%
\tl_new:N \g__gzt_bib_issue_date_tl
\tl_gset:Nn \g__gzt_bib_issue_date_tl {
  \int_use:N \g__gzt_issue_year_int-
  \int_compare:nNnT {\g__gzt_issue_month_int}<{10}
  {
    0
  }
  \int_use:N \g__gzt_issue_month_int
}
  \iow_now:Nx \g__gzt_bib_out_iow {%
    @periodical{\c__gzt_issue_bib_key_tl,\iow_newline:
      issuetitle   = {\exp_not:f\c__gzt_journal_title_string_tl},\iow_newline:
      date         = {\g__gzt_bib_issue_date_tl},\iow_newline:
      number       = \int_use:N \g__gzt_issue_number_int,\iow_newline:
      % issn         = {\l__gzt_journal_issn_tl},\iow_newline:
      options      = {skipbib}\iow_newline:
    }
    \iow_newline:
  }%
}
\tl_new:N \g__gzt_title_tl
\RenewDocumentCommand \title { o m } {
  \int_gincr:N \g__gzt_articles_int
  \tl_gclear:N \g__gzt_short_title_tl
  \tl_gclear:N \g__gzt_short_subtitle_tl
  \bool_gset_false:N \g__gzt_title_not_in_toc_bool
  %
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/title } { #1 }
  }
  \tl_gset:Nn \g__gzt_title_tl {#2}
  \bool_if:nT \g__gzt_tellme_rubric_bool
  {
    \tl_put_left:Nx \g__gzt_title_tl {\c__gzt_tellme_extra_title_string_tl}
  }
  \tl_if_empty:NT \g__gzt_short_title_tl {%
    \tl_gset_eq:NN \g__gzt_short_title_tl \g__gzt_title_tl
  }
}
\tl_new:N \g__gzt_subtitle_tl
\NewDocumentCommand \subtitle { o m } {
  \bool_gset_false:N \g__gzt_subtitle_not_in_toc_bool
  %
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/subtitle } { #1 }
  }
  \tl_gset:Nn \g__gzt_subtitle_tl {#2}
  \tl_if_empty:NT \g__gzt_short_subtitle_tl {%
    \tl_gset_eq:NN \g__gzt_short_subtitle_tl \g__gzt_subtitle_tl
  }
}
\RenewDocumentCommand \author { o m } {
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/authors } { #1 }
  }
  \tl_gset:Nn \l__gzt_people_first_last_name_tl {#2}
  \__gzt_people:nVVVVnxV
  {#2}
  {\g__gzt_people_affiliation_tl}
  {\g__gzt_people_email_tl}
  {\g__gzt_people_minibio_tl}
  {\g__gzt_people_photo_tl}
  {}
  {author-art-\int_use:N \g__gzt_articles_int}
  {\g__gzt_people_webpage_tl}
}
\iow_new:N \g__gzt_bib_out_iow
\ior_new:N \g__gzt_bib_out_ior
\tl_new:N \g__gzt_bib_out_tl
\file_if_exist:nTF { \c__gzt_issue_bib_path_string_tl }
{
  \ior_open:Nn \g__gzt_bib_out_ior { \c__gzt_issue_bib_path_string_tl }
  \ior_str_map_inline:Nn \g__gzt_bib_out_ior
  { \tl_gput_right:Nn \g__gzt_bib_out_tl {#1 \par } }
  \ior_close:N \g__gzt_bib_out_ior
}{
  \typeout{no file! rerun}
}
\iow_open:Nn \g__gzt_bib_out_iow { \c__gzt_issue_bib_path_string_tl }
\tl_new:N \g__gzt_abstract_body_tl
\NewDocumentEnvironment{abstract}{}
  {\CollectAbstract}
  {\endCollectAbstract}
\NewEnviron{CollectAbstract}
  {
    \tl_gset_eq:NN \g__gzt_abstract_body_tl \BODY
  }
\tl_new:N \g__gzt_mainmatter_switch_tl%
\tl_gset:Nn \g__gzt_mainmatter_switch_tl {
  \bool_gset_false:N \g__gzt_frontmatter_bool
  \bool_gset_true:N \g__gzt_mainmatter_bool
  \SetParskip{\c__gzt_mainmatter_parskip_skip}
  \pagestyle{__gzt_mainmatter_ps}%
}
\tl_new:N \g__gzt_article_acknowledgements_tl%
\cs_new_protected:Nn \__gzt_article_acknowledgements:n
{
  \tl_gset:Nn \g__gzt_article_acknowledgements_tl { #1 }
}
\tl_new:N \g__gzt_about_frontcover_tl%
\bool_new:N \g__gzt_credit_frontcover_bool%
\tl_new:N \g__gzt_about_frontcover_string_tl%
\cs_new_protected:Nn \__gzt_about_frontcover:nnn
{
  \tl_if_empty:nF {#1}{%
    \bool_gset_true:N \g__gzt_credit_frontcover_bool
    \__gzt_people:nnnnnnnn {#1}{}{}{}{}{}{frontcovercredit}{}
  }
  \tl_gset:Nn \g__gzt_about_frontcover_string_tl { #2 }
  \tl_gset:Nn \g__gzt_about_frontcover_tl { #3 }
}
\tl_new:N \g__gzt_rubric_abstract_box_tl%
\tl_new:N \l__gzt_rubric_head_text_box_tl%
\cs_new_protected:Nn \__gzt_rubric:nnn
{
  \newpage%
  \tl_gclear:N \g__gzt_rubric_abstract_tl
  \tl_gset:Nn \g__gzt_rubric_title_tl {#2}
  \tl_gset:Nn \g__gzt_rubric_pictofile_tl {#3}
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/rubric } { #1 }
  }
  \g__gzt_mainmatter_switch_tl
  \bool_gset_true:N \g__gzt_mainmatter_bool
  \clearpage
  \bool_gset_true:N \g__gzt_rubric_bool%
  \bool_gset_false:N \g__gzt_interview_rubric_bool
  \bool_gset_false:N \g__gzt_tellme_rubric_bool
  \bool_gset_false:N \g__gzt_rearviewmirror_rubric_bool
  \bool_gset_false:N \g__gzt_books_rubric_bool
  \bool_gset_false:N \g__gzt_previous_article_with_bibliography_or_minibio_bool
  \bool_if:nF { \g__gzt_for_authors_bool } {
    \int_zero:N \g__gzt_item_in_rubric_int
    \phantomsection
    \par
    \addcontentsline{toc}{part}{\g__gzt_rubric_title_tl}
    \thispagestyle{__gzt_rubric_ps}
    \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_main_geometry_tl}%
    \tl_if_empty:NTF \g__gzt_rubric_abstract_tl
    {
      \dim_set:Nn \l__gzt_rubrics_head_text_width_dim { \c__gzt_rubrics_head_text_no_abstract_width_dim }
    }
    {
      \dim_set:Nn \l__gzt_rubrics_head_text_width_dim { \c__gzt_rubrics_head_text_abstract_width_dim }
      \tl_gset:Nn \g__gzt_rubric_abstract_box_tl {
        \begin{adjustbox}{valign=t,minipage=\c__gzt_rubrics_abstract_width_dim}
          \raggedright%
          \large%
          \color{__gzt_rubric_abstract_color}%
          \g__gzt_rubric_abstract_tl%
        \end{adjustbox}
      }
    }
    \tl_set:Nn \l__gzt_rubric_head_text_box_tl {
      \begin{adjustbox}{valign=t,minipage=\l__gzt_rubrics_head_text_width_dim}
        \mbox{}%
        \checkoddpage%
        \ifoddpage%
        \raggedleft%
        \else
        \raggedright%
        \fi%
        \color{__gzt_rubric_title_color}%
        \fontsize{20}{20}\fontseries{bx}\fontshape{sc}\selectfont%
        \g__gzt_rubric_title_tl%
      \end{adjustbox}
    }
    \noindent%
    \mbox{}%
    \checkoddpage%
    \ifoddpage%
    \hspace*{\c__gzt_rubric_extra_xoffset_dim}
    \tl_if_empty:NF \g__gzt_rubric_abstract_tl
    {
      \g__gzt_rubric_abstract_box_tl
    }
    \hfill%
    \l__gzt_rubric_head_text_box_tl
    \hspace*{\c__gzt_rubric_xoffset_dim}%
    \else%
    \hspace*{\c__gzt_rubric_xoffset_dim}%
    \l__gzt_rubric_head_text_box_tl
    \tl_if_empty:NF \g__gzt_rubric_abstract_tl
    {
      \hfill%
      \g__gzt_rubric_abstract_box_tl
      \hspace*{\c__gzt_rubric_extra_xoffset_dim}
    }
    \fi%
  }
  \afterpage{%
    \bool_gset_false:N \g__gzt_rubric_bool%
  }
  \ignorespaces
}
\tl_new:N \g__gzt_article_bib_key_tl%
\tl_new:N \l__gzt_people_first_last_names_tl
\tl_new:N \g__gzt_authors_first_last_names_tl%
\tl_new:N \l__gzt_interviewees_first_last_names_tl%
\tl_new:N \g__gzt_citeauthor_no_firstinits%
\tl_new:N \g__gzt_citeauthor_tl%
\tl_new:N \g__gzt_citeinterviewee_tl%
\tl_new:N \g__gzt_blx_given_first_inits_tl%
\@ifpackagelater{biblatex}{2016/01/01}{%
  \tl_set:Nn \g__gzt_blx_given_first_inits_false_tl
  {%
    \togglefalse{blx@giveninits}%
  }
}{
  \tl_set:Nn \g__gzt_blx_given_first_inits_false_tl
  {%
    \togglefalse{blx@firstinits}%
  }
}
\cs_new_protected:Nn \__gzt_citeauthor_no_firstinits:n {%
  \tl_gset:Nn \g__gzt_citeauthor_tl {%
    \DeclareNameAlias{labelname}{default}%
    \group_begin:
    \g__gzt_blx_given_first_inits_false_tl
    \citeauthor{#1}
    \group_end:
  }%
  \cs_if_exist:cTF {texorpdfstring}
  {
    \texorpdfstring{\g__gzt_citeauthor_tl}{}
  }{%
    \g__gzt_citeauthor_tl
  }%
}
\cs_set_eq:NN \__gzt_orig_multinamedelim \multinamedelim
\cs_set_eq:NN \__gzt_orig_finalnamedelim \finalnamedelim
\cs_new_protected:Nn \__gzt_itemized_citeauthor:n
{
  \cs_set_eq:NN \multinamedelim \item
  \cs_set_eq:NN \finalnamedelim \multinamedelim
  \AtNextCitekey{\defcounter{maxnames}{100}}
  \begin{itemize}[label=\textbullet,noitemsep]
  \item \citeauthor{#1}
  \end{itemize}
  \cs_set_eq:NN \multinamedelim \__gzt_orig_multinamedelim
  \cs_set_eq:NN \finalnamedelim \__gzt_orig_finalnamedelim
}
\tl_new:N \l__gzt_bullet_and_rule_tl
\tl_new:N \l__gzt_authors_box_tl
\tl_new:N \l__gzt_abstract_box_tl
\tl_new:N \l__gzt_bullet_and_rule_odd_tl
\tl_new:N \l__gzt_bullet_and_rule_even_tl
\tl_new:N \l__gzt_title_box_tl
\RenewDocumentCommand \maketitle { s } {
  \FloatBarrier%
\int_gincr:N \g__gzt_item_in_rubric_int
\dim_set_eq:NN \parindent \c__gzt_original_parindent_dim
\glsresetall
\setcounter{section}{0}
\setcounter{figure}{0}
\setcounter{table}{0}
\setcounter{footnote}{0}
\setcounter{equation}{0}
\setcounter{theorem}{0}
\setcounter{corollary}{0}
\setcounter{conjecture}{0}
\setcounter{proposition}{0}
\setcounter{lemma}{0}
\setcounter{axiom}{0}
\setcounter{definition}{0}
\setcounter{remark}{0}
\setcounter{example}{0}
\setcounter{notation}{0}
\tl_gset:Nn \g__gzt_article_bib_key_tl {%
  \c__gzt_issue_bib_key_tl
  -art-
  \int_use:N \g__gzt_articles_int
}
\DTLforeach*[\DTLiseq{\l__gzt_people_role_tl}{author-art-\int_use:N \g__gzt_articles_int}]{people}{%
  \l__gzt_people_first_last_name_tl=first-last-name%
  ,\l__gzt_people_role_tl=role%
}{%
  \tl_if_in:NnT \l__gzt_people_role_tl { author } {
    \DTLiffirstrow{%
      \tl_put_right:Nx
      \l__gzt_people_first_last_names_tl
      {\exp_not:V\l__gzt_people_first_last_name_tl}
    }{
      \tl_put_right:Nx
      \l__gzt_people_first_last_names_tl
      {~and~\exp_not:V\l__gzt_people_first_last_name_tl}
    }
  }
}
\DTLforeach*[\DTLiseq{\l__gzt_people_role_tl}{interviewee-art-\int_use:N \g__gzt_articles_int}]{people}{%
  \l__gzt_people_first_last_name_tl=first-last-name%
  ,\l__gzt_people_role_tl=role%
}{%
  \tl_if_in:NnT \l__gzt_people_role_tl { interviewee } {
    \DTLiffirstrow{%
      \tl_put_right:Nx
      \l__gzt_people_first_last_names_tl
      {\exp_not:V\l__gzt_people_first_last_name_tl}
    }{
      \tl_put_right:Nx
      \l__gzt_people_first_last_names_tl
      {~and~\exp_not:V\l__gzt_people_first_last_name_tl}
    }
  }
}
\tl_if_empty:NF \g__gzt_title_tl {%
  \iow_now:Nx \g__gzt_bib_out_iow {%
    @article{
      \g__gzt_article_bib_key_tl,
      \iow_newline:
      title={\exp_not:V\g__gzt_title_tl},
      \iow_newline:
      \tl_if_empty:NF \g__gzt_subtitle_tl {%
        subtitle={\exp_not:V\g__gzt_subtitle_tl},
        \iow_newline:
      }
      \tl_if_eq:NNF { \g__gzt_short_title_tl } { \g__gzt_title_tl } {%
        shorttitle={\exp_not:V\g__gzt_short_title_tl},
        \iow_newline:
      }%
      \tl_if_empty:NF \l__gzt_people_first_last_names_tl
      {
        author={\exp_not:V\l__gzt_people_first_last_names_tl},
        \iow_newline:
      }
      options={skipbib},
      \iow_newline:
      crossref  = {\c__gzt_issue_bib_key_tl}
    }
    \iow_newline:
  }%
}%
\tl_set:Nn \l__gzt_bullet_and_rule_odd_tl
{%
  \begin{tikzpicture}[remember~picture,overlay]
    \draw[fill=__gzt_circlerule_color,draw=__gzt_circlerule_color,line~width=0.7mm]
    ([xshift=-\c__gzt_innermargin_dim-\c__gzt_potential_layoutoffset_dim]0,0 -| current~page.west) -- (\linewidth,0);%
    \fill[__gzt_circlerule_color] (\linewidth-2\pgflinewidth,0) circle [radius=2.75mm];
  \end{tikzpicture}%
}%
\tl_set:Nn \l__gzt_bullet_and_rule_even_tl
{%
  \begin{tikzpicture}[remember~picture,overlay]
    \draw[fill=__gzt_circlerule_color,draw=__gzt_circlerule_color,line~width=0.7mm]
    (0,0 -| current~page.east) -- (0,0);%
    \fill[__gzt_circlerule_color] (0,0) circle [radius=2.75mm];
  \end{tikzpicture}%
}%
\tl_set:Nn \l__gzt_title_box_tl
{%
  \noindent%
  \hspace*{18mm}%
  \begin{adjustbox}{minipage=\linewidth-18mm,valign=t}
    \raggedright%
    \color{__gzt_article_title_color}%
    \fontsize{20}{25}\selectfont%
    \bfseries%
    \g__gzt_title_tl
    \tl_if_empty:NF \g__gzt_subtitle_tl {%
      \par%
      \g__gzt_subtitle_tl
    }
  \phantomsection
  \par%
  \bool_if:NTF {\g__gzt_title_not_in_toc_bool} {
    \bookmark[page=\thepage,level=chapter]{\g__gzt_short_title_tl}
  }{
    \addcontentsline{toc}{chapter}{%
      \tl_if_empty:NTF \g__gzt_short_title_tl {%
        \g__gzt_title_tl%
      }{
        \g__gzt_short_title_tl%
      }
      \bool_if:NF {\g__gzt_subtitle_not_in_toc_bool} {
        \bool_if:nF { \tl_if_empty_p:N \g__gzt_short_subtitle_tl || \g__gzt_interview_rubric_bool || \g__gzt_rearviewmirror_rubric_bool }
        {
          \space\textendash{}\space\g__gzt_short_subtitle_tl
        }
      }
      \bool_if:nF { \tl_if_empty_p:N \l__gzt_people_first_last_names_tl || \g__gzt_interview_rubric_bool || \g__gzt_rearviewmirror_rubric_bool }
      {
        \textsl{
          \cs_if_exist:cTF {texorpdfstring}
          {
            \texorpdfstring{%
              \space\textendash{}\space\citeauthor{\g__gzt_article_bib_key_tl}
            }{}
          }{%
            \space\textendash{}\space\citeauthor{\g__gzt_article_bib_key_tl}
          }%
        }
      }
    }
  }
  \end{adjustbox}
}
  \dim_gset:Nn \g__gzt_abstract_box_width_dim {0.75\linewidth}
  % \bool_if:nT { \tl_if_empty_p:N \l__gzt_people_first_last_names_tl }
  % {
  %   \dim_gset:Nn \g__gzt_abstract_box_width_dim {\linewidth}
  % }
  \tl_set:Nn \l__gzt_abstract_box_tl
  {%
    \begin{adjustbox}{minipage=\g__gzt_abstract_box_width_dim,max~width=\g__gzt_abstract_box_width_dim,valign=t}
      \mbox{}
      \tl_if_exist:NT \g__gzt_abstract_body_tl
      {%
        \raggedright%
        \bfseries%
        \color{__gzt_article_abstract_color}%
        \g__gzt_abstract_body_tl
      }%
    \end{adjustbox}
  }%
  \tl_set:Nn \l__gzt_authors_box_tl
  {%
    \begin{adjustbox}{minipage=0.3\linewidth,min~width=0.3\linewidth,valign=t}
      \bool_if:nTF { \tl_if_empty_p:N \l__gzt_people_first_last_names_tl || \g__gzt_interview_rubric_bool }
      {
        \mbox{}
      }
      {
        \color{__gzt_people_color}%
        \__gzt_itemized_citeauthor:n {\g__gzt_article_bib_key_tl}
      }
    \end{adjustbox}
  }
    \bool_if:nTF {
      \int_compare_p:nNn { \g__gzt_item_in_rubric_int } = { 1 }
    }
    {
      \mbox{}
      \par
      \bool_if:nTF {
        \tl_if_empty_p:N \g__gzt_rubric_abstract_tl
      }{
        \xleaders\vbox {
          \bigskip%
        }%
        \vskip\bigskipamount%
      }{
        \xleaders\vbox {
          \smallskip%
        }%
        \vskip\smallskipamount%
      }
    }
    {
      \bool_if:NTF {\g__gzt_previous_article_with_bibliography_or_minibio_bool}
      {
        \xleaders\vbox {
          \mbox{}
          \par
          \medskip%
        }%
        \vskip\medskipamount%
      }
      {
        \xleaders\vbox {
          \mbox{}
          \par
          \smallskip%
        }%
        \vskip\smallskipamount%
      }
    }
    \bool_gset_false:N \g__gzt_previous_article_with_bibliography_or_minibio_bool
\bool_if:NT {\g__gzt_for_authors_bool} {
  \hypersetup{%
    pdftitle=\g__gzt_short_title_tl,
    pdfauthor=\l__gzt_people_first_last_names_tl
  }
}
  \bool_if:nF { \g__gzt_for_authors_bool } {
    % \xleaders\vbox {
      %   \bigskip%
      % }%
      %   \vskip\bigskipamount%
      \noindent%
      \checkoddpage%
      \ifoddpage%
      \l__gzt_bullet_and_rule_odd_tl
      \else%
      \l__gzt_bullet_and_rule_even_tl
      \fi%
      \bigskip%
    }%
    \par
    \nopagebreak[4]
  \l__gzt_title_box_tl
  \normalsize%
  \nopagebreak[3]
  \bool_if:nF { \tl_if_empty_p:N \g__gzt_abstract_body_tl && (\tl_if_empty_p:N \l__gzt_people_first_last_names_tl || \g__gzt_interview_rubric_bool || \g__gzt_rearviewmirror_rubric_bool)}
  {%
    \par%
    \bigskip
    \bigskip
    \large%
    \mbox{}%
    \checkoddpage%
    \ifoddpage%
    \l__gzt_abstract_box_tl
    \hspace*{11mm}%
    \l__gzt_authors_box_tl
    \else%
    \hspace*{-.85\c__gzt_outermargin_dim}%
    \l__gzt_authors_box_tl
    \hspace*{11mm}%
    \l__gzt_abstract_box_tl
    \fi%
  }
  \tl_gclear:N \g__gzt_title_tl
  \tl_gclear:N \g__gzt_subtitle_tl
  \tl_gclear:N \g__gzt_abstract_body_tl
  \normalsize%
  \bigskip
  \tl_if_empty:NF \g__gzt_abstract_body_tl
  % {%
  %   \tl_if_empty:NF \l__gzt_people_first_last_names_tl
  %   {%
  %     \bigskip
  %   }
  % }
  {
    \bigskip
  }
  \bool_if:nT \g__gzt_interview_rubric_bool
  {
    \dim_zero:N \parindent
    % \tl_if_empty:NF \l__gzt_people_photo_tl
    % {
    %   \begin{adjustbox}{center}
    %     \includegraphics[height=50mm]{\l__gzt_people_photo_tl}
    %   \end{adjustbox}
    % }
  }
  \color{__gzt_default_text_color}%
  \IfBooleanF {#1}%
  {
    \bool_if:nF { \g__gzt_multicols_bool || \g__gzt_rearviewmirror_rubric_bool }
    {
      \begin{multicols}{2}%
      }
    }
  }
\bool_if:nT { \g__gzt_for_authors_bool }
{
  \AtEndDocument{%
    \bool_if:NT {\g__gzt_multicols_bool} {
    \end{multicols}%
  }
}
}
\AtEndPreamble{\file_input:n {\c__gzt_configuration_file_string_tl}}
\file_if_exist:nT { \c__gzt_acronyms_file_string_tl } {%
  \AtEndPreamble{\loadglsentries{\c__gzt_acronyms_file_string_tl}}
}
\@ifpackageloaded{etoc}{%
  \newif\ifShowPartPageInToc % used before \part{Livres}
  \newtoks\toctabletok
  \newcommand*\appendtotok[2]{% #1=toks variable, #2=macro, expands only once #2
    #1\expandafter\expandafter\expandafter {\expandafter\the\expandafter #1#2}}
  \newcommand*\PreparePart{%
    \edef\toctablepiece {%
      \ExceptFirstPart {\noexpand\\[-1.5mm]}%
      \unexpanded{%
        \color{__gzt_rubric_in_toc_color}\scshape\fontseries{bx}\selectfont%
      }%
      \unexpanded\expandafter{\etocthelinkedname}&
      % \ifShowPartPageInToc
      \unexpanded{\bfseries\color{__gzt_rubric_in_toc_color}}%
      \unexpanded\expandafter{\etocthelinkedpage}%
      % \fi
      \noexpand\\}%
    \gdef\ExceptFirstPart ##1{##1}%
  }
  \newcommand*\PrepareChapter{%
    \edef\toctablepiece {%
      \unexpanded{\color{__gzt_article_in_toc_color}\small}%
      \unexpanded\expandafter{\etocthelinkedname}&
      \unexpanded{\color{__gzt_article_in_toc_color}\small}
      \unexpanded\expandafter{\etocthelinkedpage}%
      \noexpand\\[1mm]}%
  }
  \etocsetstyle{part}{}{}
  {\PreparePart \appendtotok\toctabletok\toctablepiece}
  {}
  \etocsetstyle{chapter}{}{}
  {\PrepareChapter \appendtotok\toctabletok\toctablepiece}
  {}
  \etocsettocstyle
  {%
    \setlength\LTleft{\c_zero_dim}
    \setlength\LTright{\c_zero_dim}
    \gdef\ExceptFirstPart ##1{}%
    \toctabletok {%\hypersetup{hidelinks}%
      \begin{longtable}{@{\extracolsep{\fill}}p{115mm}@{\quad}!{\color{__gzt_rule_in_toc_color}\vrule width 0.2mm}@{}r@{}}}%
        }
        {\global\toctabletok\expandafter{%
        \the\toctabletok\end{longtable}
        }
      }
    }{}
\tl_new:N \g__gzt_boxed_issue_number_tl%
\tl_gset:Nn \g__gzt_boxed_issue_number_tl {%
  \tcbox{\Large\No\g__gzt_issue_number_int}
}
\cs_new_protected:Nn \__gzt_boxed_issue_number:nn
{
  \noindent%
  \raisebox{\baselineskip}{%
    \tl_if_empty:nF {#1} {%
      \makebox[\c_zero_dim][r]{%
      % \hspace*{\l__gzt_thumbnail_width_dim}%
        \begin{adjustbox}{valign=t}
          \includegraphics[width=\l__gzt_thumbnail_width_dim]{#1}%
        \end{adjustbox}%
      }%
    }%
    \begin{adjustbox}{valign=t}
      \begin{tcolorbox}[%
        enhanced,%
        title=\No\int_use:N \g__gzt_issue_number_int,%
        fonttitle=\Large,%
        colback=white,%
        sharp~corners=all,%
        height=33mm,%
        boxrule=\c_zero_dim,%
        % frame~hidden,%
        attach~boxed~title~to~top~left,%
        tikznode~boxed~title={minimum~width=\c__gzt_boxed_issue_number_width_dim},%
        boxed~title~style={%
          size=minimal,%
          height=\c__gzt_boxed_issue_number_height_dim,%
          center~upper,%
          before={},%
          colback=__gzt_boxed_issue_number_bg_color,%
          sharp~corners=all,%
          frame~hidden,%
          valign=center,%
        }%
        ]
        \__gzt_reflected_text:n { #2 }%
      \end{tcolorbox}
    \end{adjustbox}%
  }%
  \par%
}
\cs_new_protected:Nn \__gzt_before_frontmatter_stuff:
{
  \bool_gset_true:N \g__gzt_frontmatter_bool%
  \pagestyle{__gzt_frontmatter_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_front_matter_geometry_tl}%
}
\cs_new_protected:Nn \__gzt_after_frontmatter_stuff:
{
  \color{__gzt_default_text_color}
  \normalsize%
  \clearpage%
  \bool_gset_false:N \g__gzt_frontmatter_bool%
}
\cs_new_protected:Nn \__gzt_before_editorial_presidentmessage:nn
{
  \__gzt_before_frontmatter_stuff: {}
  \__gzt_boxed_issue_number:nn {#1}{#2}
  \color{__gzt_frontmatter_text_color}%
  \fontsize{11}{13.6}\selectfont
  \RaggedRight
}
\cs_new_protected:Nn \__gzt_after_editorial_presidentmessage:
{
  \justifying
  \bigskip
  \par
}
\cs_new_protected:Nn \__gzt_before_display_editorial:
{
  \__gzt_before_editorial_presidentmessage:nn {}{\c__gzt_editorial_string_tl}
}
\cs_new_protected:Nn \__gzt_after_display_editorial:
{
  \__gzt_after_editorial_presidentmessage: {}
  \hspace*{\fill}%
  \DTLforeach*[\DTLiseq{\l__gzt_people_role_tl}{editorinchief}]{people}{%
    \l__gzt_firstlastname=first-last-name%
    ,\l__gzt_people_role_tl=role%
  }{%
    \__gzt_citeauthor_no_firstinits:n {\c__gzt_issue_bib_key_tl -editorinchief- \exp_not:V\DTLcurrentindex}%
  }
  %
  \__gzt_after_frontmatter_stuff: {}
}
\cs_new_protected:Nn \__gzt_display_editorial:
{
  \__gzt_before_display_editorial: {}
  \file_input:n {\c__gzt_editorial_file_string_tl}
  \__gzt_after_display_editorial: {}
}
\NewDocumentCommand \editorial {}
{
  \bool_if:NF {\g__gzt_for_authors_bool} {
    \__gzt_display_editorial: {}
  }
}
\cs_new_protected:Nn \__gzt_display_toc:
{
  \__gzt_before_frontmatter_stuff: {}
  \__gzt_boxed_issue_number:nn {\g__gzt_frontcover_image_file_tl}{\c__gzt_toc_string_tl}
  \phantomsection
  \hypertarget{__gzt_toc}{}
  \bookmark[dest=__gzt_toc,level=part]{\c__gzt_toc_string_tl}
  \etocsettocdepth.toc{chapter}%
  \tableofcontents
  \the\toctabletok
  \__gzt_after_frontmatter_stuff: {}
}
\NewDocumentCommand \gzttableofcontents {}
{
  \bool_if:NF {\g__gzt_for_authors_bool} {
    \__gzt_display_toc: {}
  }
}
\tl_new:N \g__gzt_frontcover_minitoc_tl%
\tl_new:N \l__gzt_minitoc_label_tl%
\cs_new_protected:Nn \__gzt_frontcover_minitoc:n
{
  \tl_gset:Nn \g__gzt_frontcover_minitoc_tl {#1}
}
\NewDocumentCommand \minitoc { O{} m }
{
  \keys_set:nn { gzt/minitoc } { #1 }
  \__gzt_frontcover_minitoc:n {#2}
}
\newlist{__gzt_minitoc_list}{itemize}{1}
\setlist[__gzt_minitoc_list]{itemsep=2ex,label=\textcolor{__gzt_cover_itemize_label_color}\textbullet}
\NewDocumentEnvironment{minitoclist}{}
{%
  \cs_set_eq:NN \__gzt_orig_item \item
  \RenewDocumentCommand \item { s O{} }{%
    \tl_set:Nn \l__gzt_minitoc_label_tl {##2}
    \__gzt_orig_item\textbf{##2}
    \IfBooleanT {##1}
    {
      \c__gzt_minitoc_rubric_title_separator_string_tl
    }
  }
  \begin{__gzt_minitoc_list}
}{
  \end{__gzt_minitoc_list}
  \cs_set_eq:NN \item \__gzt_orig_item
}
\cs_new_protected:Nn \__gzt_before_display_presidentmessage:
{
  \__gzt_before_editorial_presidentmessage:nn {\c__gzt_smf_logo_file_string_tl}{\c__gzt_president_message_string_tl}
  \phantomsection
  \par%
  \addcontentsline{toc}{part}{\g__gzt_smf_short_string_tl}%
  \addcontentsline{toc}{chapter}{\c__gzt_president_message_string_tl}%
}
\cs_new_protected:Nn \__gzt_after_display_presidentmessage:
{
  \__gzt_after_editorial_presidentmessage: {}
  %
  \hspace*{\fill}%
  \c__gzt_president_message_date_string_tl%
  \displaydate{__gzt_president_message_date}%
  \\[1.5mm]
  \hspace*{\fill}%
  \__gzt_display_people_by_role:n { president }%
  ,\space
  \c__gzt_president_signatory_string_tl
  %
  \__gzt_after_frontmatter_stuff: {}
}
\cs_new_protected:Nn \__gzt_display_president_message:
{
  \__gzt_before_display_presidentmessage: {}
  \file_input:n {\c__gzt_president_message_file_string_tl}
  \__gzt_after_display_presidentmessage: {}
}
\NewDocumentCommand \presidentmessage {}
{
  \bool_if:NF {\g__gzt_for_authors_bool} {
    \__gzt_display_president_message: {}
  }
}
\titleformat{\chapter}%
[block]
{\Huge\bfseries}
{}
{\c_zero_dim}
{\scshape}%
\titleformat{\section}
{%
  \raggedright%
  \bfseries%
  \color{__gzt_section_color}
}
{\fontsize{20}{15}\selectfont\thesection.\enspace}
{-3pt}
{\fontsize{13}{15}\selectfont}
\titleformat{\subsection}
{%
  \fontsize{11}{16}\selectfont%
  \bfseries%
  \color{__gzt_subsection_color}%
}
{\thesubsection\ \textendash{}\ }
{\c_zero_dim}
{}
\titleformat{\subsubsection}
{%
  \fontsize{11}{16}\selectfont%
  \bfseries%
  \color{__gzt_subsubsection_color}%
}
{}
{\c_zero_dim}
{}
\AtBeginDocument{%
  \graphicspath{{\c__gzt_issue_images_path_string_tl//}{../\c__gzt_issue_images_path_string_tl//}}
  % \glsdisablehyper
  \g__gzt_mainmatter_switch_tl
  % \bool_gset_false:N \g__gzt_frontmatter_bool
  % \bool_gset_true:N \g__gzt_mainmatter_bool
  % \SetParskip{\c__gzt_mainmatter_parskip_skip}
  % \pagestyle{__gzt_mainmatter_ps}%
  \exp_after:wN\newgeometry\exp_after:wN{\c__gzt_main_geometry_tl}%
}
\AtBeginDocument{%
  \dim_if_exist:NTF \g__gzt_pagegrid_dim {%
    \pagegridsetup{%
      enable,%
      step=\g__gzt_pagegrid_dim%
    }
  }{%
    \pagegridsetup{%
      disable%
    }
  }
  % \bool_if:NTF {\g__gzt_for_authors_bool} {
  %   \thispagestyle{empty}
  %   \includegraphics{gzt-logo}
  %   \hfill
  %   \includegraphics[height=22.5mm]{\c__gzt_smf_logo_file_string_tl}%
  %   \par
  %   \vfill
  %   \begin{adjustbox}{valign=c,minipage=\linewidth}
  %     \Large%
  %     \c__gzt_preliminary_version_string_tl%
  %   \end{adjustbox}
  %   \vfill
  %   \newpage
  % }{
  %   \bool_if:NF {\g__gzt_inside_pages_bool} {
  %     \g__gzt_display_frontcover_tl
  %     \g__gzt_display_inside_frontcover_tl
  %   }
  % }
  \bool_if:NF {\g__gzt_for_authors_bool} {
    \bool_if:NF {\g__gzt_inside_pages_bool} {
      \g__gzt_display_frontcover_tl
      \bool_if:NTF {\g__gzt_coverpage_bool} {
        \AfterEndPreamble{\end{document}}
      }{
        \g__gzt_display_inside_frontcover_tl
      }
    }
  }
}
\tl_new:N \g__gzt_background_footer_tl
\tl_gset:Nn \g__gzt_background_footer_tl {%
  \draw [__gzt_footer_bg_color,fill]
  (current~page.south~west)
  rectangle ([yshift=\c__gzt_footer_background_height_dim]current~page.south~east)
  ;
}
\tl_new:N \l__gzt_frontmatter_head_text_tl
\tl_set:Nn \l__gzt_frontmatter_head_text_tl {%
  \includegraphics{gzt-logo}
}
\tl_new:N \g__gzt_frontmatter_page_headrule_tl
\tl_gset:Nn \g__gzt_frontmatter_page_headrule_tl {%
  \draw [__gzt_headrule_color,line~width=\c__gzt_header_line_width_dim]
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~west -| current~page.north~west)
  --
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~east -| current~page.north~east)
  ;%
}
\tl_new:N \g__gzt_frontmatter_headtext_tl
\tl_gset:Nn \g__gzt_frontmatter_headtext_tl {%
  \mbox{}%
  \checkoddpage%
  \ifoddpage%
    \node[
    anchor=north~east,%
    align=center,%
    fill=white,%
    inner~xsep=3.5mm,%
    outer~sep=\c_zero_dim,%
    ] at
    ([%
    xshift=\c__gzt_frontmatter_headtext_o_xshift_dim,%
    yshift=\c__gzt_frontmatter_headtext_yshift_dim%
    ]current~page.north~east) {%
      \l__gzt_frontmatter_head_text_tl
    }%
    ;
  \else%
    \node[%
    anchor=north~west,%
    align=center,%
    fill=white,%
    inner~xsep=3.5mm,%
    outer~sep=\c_zero_dim,%
    ] at
    ([%
    xshift=\c__gzt_frontmatter_headtext_e_xshift_dim,%
    yshift=\c__gzt_frontmatter_headtext_yshift_dim%
    ]current~page.north~west) {%
      \l__gzt_frontmatter_head_text_tl
    }%
    ;
  \fi%
}
\tl_new:N \g__gzt_mainmatter_oddpage_headrule_tl
\tl_gset:Nn \g__gzt_mainmatter_oddpage_headrule_tl {%
  \draw [__gzt_headrule_color,line~width=\c__gzt_header_line_width_dim]
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~east)
  --
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~west -| current~page.north~west)
  ;
}
\tl_new:N \g__gzt_mainmatter_evenpage_headrule_tl
\tl_gset:Nn \g__gzt_mainmatter_evenpage_headrule_tl {%
  \draw [__gzt_headrule_color,line~width=\c__gzt_header_line_width_dim]
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~west)
  --
  ([yshift=\c__gzt_header_line_yshift_dim]current~page~header~area.south~east -| current~page.north~east)
  ;
}
\ExplSyntaxOff
\tcbuselibrary{breakable,skins,hooks,xparse,theorems,listingsutf8}
\usetikzlibrary{babel,fadings,positioning,calc}
\tcbset{%
  new/blend into/tables/.style={%
    use counter*=table,%
    list inside=lot,
    /tcb/code={\appto\tcb@new@colopt{,before title={\fnum@table\space\textendash{}\space}}}},%
  new/blend into/figures/.style={%
    use counter*=figure,%
    list inside=lof,
    /tcb/code={\appto\tcb@new@colopt{,before title={\fnum@figure\space\textendash{}\space}}}},%
}
\newcommand\gzt@arcthroughthreepoints[4][]%
{
  % \NoAutoSpacing%
  \coordinate (middle1) at ($(#2)!.5!(#3)$);
  \coordinate (middle2) at ($(#3)!.5!(#4)$);
  \coordinate (aux1) at ($(middle1)!1!90:(#3)$);
  \coordinate (aux2) at ($(middle2)!1!90:(#4)$);
  \coordinate (center) at ($(intersection of middle1--aux1 and middle2--aux2)$);
  \filldraw[fill=white,draw=__gzt_headrule_color,line width=0.25mm,#1]
  let \p1=($(#2)-(center)$),
  \p2=($(#4)-(center)$),
  \n0={veclen(\p1)},       % Radius
  \n1={atan2(\y1,\x1)}, % angles
  \n2={atan2(\y2,\x2)},
  \n3={\n2>\n1?\n2:\n2+360}
  in (#2) arc(\n1:\n3:\n0);
  % \foreach \p in {#2,#3,#4,center}
  % \fill[red] (\p) circle(2pt);
}
\ExplSyntaxOn
\tl_new:N \g__gzt_rubric_page_head_tl
\tl_gset:Nn \g__gzt_rubric_page_head_tl {%
  \bool_if:nF { \g__gzt_for_authors_bool } {
    \tikz[remember~picture,overlay] {
      \path (current~page.north~west |- current~page~header~area.south~west) coordinate (__gzt_pwest);
      \path (current~page.north~east |- current~page~header~area.south~east) coordinate (__gzt_peast);
      \draw [__gzt_headrule_color,line~width=\c__gzt_header_line_width_dim]
      ([yshift=\c__gzt_header_line_yshift_dim]__gzt_pwest)
      --
      ([yshift=\c__gzt_header_line_yshift_dim]__gzt_peast)
      ;%
      \tl_if_empty:NF \g__gzt_rubric_abstract_tl {%
        \mbox{}%
        \checkoddpage%
        \ifoddpage%
        \coordinate (__gzt_A) at ([xshift=\c__gzt_xshift_arccircle_A_dim,yshift=\c__gzt_yshift_arccircle_A_dim]current~page.north~west);
        \coordinate (__gzt_B) at ([xshift=\c__gzt_xshift_arccircle_B_dim,yshift=\c__gzt_yshift_arccircle_B_dim]current~page.north~west) ;
        \coordinate (__gzt_C) at ([xshift=\c__gzt_xshift_arccircle_C_dim,yshift=\c__gzt_yshift_arccircle_C_dim]current~page.north~west) ;
        \gzt@arcthroughthreepoints{__gzt_A}{__gzt_B}{__gzt_C};
        \else%
        \coordinate (__gzt_A) at ([xshift=-\c__gzt_xshift_arccircle_A_dim,yshift=\c__gzt_yshift_arccircle_A_dim]current~page.north~east);
        \coordinate (__gzt_B) at ([xshift=-\c__gzt_xshift_arccircle_B_dim,yshift=\c__gzt_yshift_arccircle_B_dim]current~page.north~east) ;
        \coordinate (__gzt_C) at ([xshift=-\c__gzt_xshift_arccircle_C_dim,yshift=\c__gzt_yshift_arccircle_C_dim]current~page.north~east) ;
        \gzt@arcthroughthreepoints{__gzt_C}{__gzt_B}{__gzt_A};
        \fi%
      }
    }
  }
}
\newpagestyle{__gzt_frontcover_ps}[]{%
  \sethead
  {}%
  {%
    \adjustbox{stack=c}{
      {\Large
        \c__gzt_frontcover_header_string_tl
      }\\[7mm]
      \adjustbox{scale=2.08}{
        \l__gzt_frontmatter_head_text_tl
      }%
    }%
  }%
  {}%
  %
  \setfoot%
  {}%
  {}%
  {}%
}%
\newpagestyle{__gzt_inside_frontcover_ps}[]{%
  \sethead%
  [
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  ]%
  []%
  []%
  {}%
  {
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  }%
  {}%
  %
  \setfoot%
  []%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {}%
}%
\newpagestyle{__gzt_frontmatter_ps}[]{%
  \widenhead*{\c__gzt_front_matter_extra_innermargin_dim}{\c__gzt_front_matter_extra_outermargin_dim}
  \sethead%
  [
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  ]%
  []%
  []%
  {}%
  {
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  }%
  {}%
  %
  \setfoot%
  [\c__gzt_footer_size_font_tl\thepage]%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {\c__gzt_footer_size_font_tl\thepage}%
}%
\newpagestyle{__gzt_rubric_ps}[]{%
  \widenhead{\c_zero_dim}{\c_zero_dim}
  \sethead%
  [
  ]%
  [
  ]%
  [
    \g__gzt_rubric_page_head_tl%
    \bool_if:nF { \g__gzt_for_authors_bool } {
      \adjustbox{raise={\c__gzt_header_yshift_dim}{\height},lap=-\c__gzt_header_xshift_dim-\linewidth}{%
        \includegraphics[width=\c__gzt_pictogram_width_dim]{\g__gzt_rubric_pictofile_tl}%
      }%
    }%
  ]%
  {
    \g__gzt_rubric_page_head_tl%
  }%
  {}%
  {%
    \bool_if:nF { \g__gzt_for_authors_bool } {
      \adjustbox{raise={\c__gzt_header_yshift_dim}{\height},lap=\c__gzt_header_xshift_dim}{%
        \includegraphics[width=\c__gzt_pictogram_width_dim]{\g__gzt_rubric_pictofile_tl}%
      }%
    }%
  }%
  %
  \setfoot%
  [\c__gzt_footer_size_font_tl\thepage]%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {\c__gzt_footer_size_font_tl\thepage}%
}%
\newpagestyle{__gzt_advertisement_ps}[]{%
  \widenhead{\c_zero_dim}{\c_zero_dim}
  \sethead%
  [
  \tikz[remember~picture,overlay] {\g__gzt_mainmatter_evenpage_headrule_tl}
  ]%
  [%
  \adjustbox{raise={\c__gzt_header_yshift_dim}{\height}}{%
    \large\bfseries\scshape\color{__gzt_head_text_color}\c__gzt_advertisement_string_tl%
    }%
    ]%
  []%
  {}%
  {%
    \adjustbox{raise={\c__gzt_header_yshift_dim}{\height}}{%
      \large\bfseries\scshape\color{__gzt_head_text_color}\c__gzt_advertisement_string_tl%
    }
  }%
  {
    \tikz[remember~picture,overlay] {\g__gzt_mainmatter_oddpage_headrule_tl}
  }%
  %
  \setfoot%
  [\c__gzt_footer_size_font_tl\thepage]%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {\c__gzt_footer_size_font_tl\thepage}%
}
\newpagestyle{__gzt_blank_pages_ps}[]{%
  \sethead
  {}%
  {}%
  {}%
  %
  \setfoot%
  [\c__gzt_footer_size_font_tl\thepage]%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {\c__gzt_footer_size_font_tl\thepage}%
}%
\newpagestyle{__gzt_inside_backcover_ps}[]{%
  \sethead%
  [
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  ]%
  []%
  []%
  {}%
  {
    \tikz[remember~picture,overlay] {%
      \g__gzt_frontmatter_page_headrule_tl%
      \g__gzt_frontmatter_headtext_tl%
    }%
  }%
  {}%
  %
  \setfoot%
  []%
  [%
    \uppercase{\c__gzt_footer_string_tl}
  ]%
  []%
  {}%
  {%
    \uppercase{\c__gzt_footer_string_tl}%
  }%
  {}%
}%
\newpagestyle{__gzt_backcover_ps}[]{%
  \sethead
  {}%
  {}%
  {}%
  %
  \setfoot%
  {}%
  {}%
  {}%
}%
\AddEverypageHook{%
 \bool_if:nF { \g__gzt_frontcover_bool || \g__gzt_backcover_bool }{
    \bool_if:NF {\g__gzt_advertisement_bool} {
      \tikz[remember~picture,overlay] { \g__gzt_background_footer_tl }%
    }%
  }%
}
\newpagestyle{__gzt_mainmatter_ps}[]{%
  \widenhead{\c_zero_dim}{\c_zero_dim}
  \sethead%
  [
  \tikz[remember~picture,overlay] {\g__gzt_mainmatter_evenpage_headrule_tl}
  ]%
  [%
  \adjustbox{raise={\c__gzt_header_yshift_dim}{\height}}{%
    \large\bfseries\scshape\color{__gzt_head_text_color}\g__gzt_rubric_title_tl%
    }%
    ]%
  []%
  {}%
  {%
    \bool_if:nF {
      \g__gzt_rearviewmirror_rubric_bool || \g__gzt_books_rubric_bool
    }{
      \adjustbox{raise={\c__gzt_header_yshift_dim}{\height}}{%
        \bfseries\color{__gzt_head_text_color}\g__gzt_short_title_tl%
      }
    }
  }%
  {
    \tikz[remember~picture,overlay] {\g__gzt_mainmatter_oddpage_headrule_tl}
  }%
  %
\bool_if:nTF { \g__gzt_for_authors_bool } {
    \setfoot%
    [\c__gzt_footer_size_font_tl\thepage]%
    [%
    \uppercase{\c__gzt_footer_string_tl}
    ]%
    [\c__gzt_footer_size_font_tl \c__gzt_compiled_string_tl\today]%
    {\c__gzt_footer_size_font_tl \c__gzt_compiled_string_tl\today}%
    {%
      \uppercase{\c__gzt_footer_string_tl}%
    }%
    {\c__gzt_footer_size_font_tl\thepage}%
  }{
    \setfoot%
    [\c__gzt_footer_size_font_tl\thepage]%
    [%
    \uppercase{\c__gzt_footer_string_tl}
    ]%
    []%
    {}%
    {%
      \uppercase{\c__gzt_footer_string_tl}%
    }%
    {\c__gzt_footer_size_font_tl\thepage}%
  }
}
\NewDocumentCommand \acknowledgements { +m } {
  \__gzt_article_acknowledgements:n {#1}%
}
\NewDocumentCommand \printminibios {} {
  \bool_if:NT {\g__gzt_multicols_bool} {
    \end{multicols}%
  }
  \FloatBarrier%
  \begin{__gzt_minibiographies_acknowledgments_tcbox}
    \__gzt_display_people_by_role:n { author-art-\int_use:N \g__gzt_articles_int }
    \tl_if_empty:NF \g__gzt_article_acknowledgements_tl
    {%
      \par%
      \bigskip%
      \begin{adjustbox}{valign=t,minipage=\linewidth}
        \color{__gzt_acknowledgements_color}%
        \g__gzt_article_acknowledgements_tl
      \end{adjustbox}
  }
  \end{__gzt_minibiographies_acknowledgments_tcbox}
  \bool_gset_true:N \g__gzt_previous_article_with_bibliography_or_minibio_bool
  %
  \tl_gclear:N \g__gzt_people_affiliation_tl
  \tl_gclear:N \g__gzt_people_email_tl
  \tl_gclear:N \g__gzt_people_minibio_tl
  \tl_gclear:N \g__gzt_people_photo_tl
  \tl_gclear:N \g__gzt_people_webpage_tl
  \tl_gclear:N \g__gzt_article_acknowledgements_tl
  \DTLgcleardb{__gzt_authors}
  \DTLgcleardb{__gzt_interviewees}
}
\let\printauthorsdetails\printminibios
\cs_set_eq:NN \__gzt_printbibliography \printbibliography
\RenewDocumentCommand \printbibliography { s O{} } {
  \bool_if:NT {\g__gzt_multicols_bool} {
    \end{multicols}%
  }
  \FloatBarrier%
  \begin{__gzt_bibliography_tcbox}
    \__gzt_printbibliography[heading=subbibliography,resetnumbers,#2]
  \end{__gzt_bibliography_tcbox}
  %
  \IfBooleanF {#1}
  {
    \nopagebreak[0]
    \printauthorsdetails
  }
}
\deftranslation[to=French]{__gzt_century}{si\`ecle}%
\deftranslation[to=English]{__gzt_century}{century}%
\deftranslation[to=French]{__gzt_first}{\ier}%
\deftranslation[to=English]{__gzt_first}{\up{st}\xspace}%
\deftranslation[to=French]{__gzt_nth}{\ieme}%
\deftranslation[to=English]{__gzt_nth}{\up{th}\xspace}%
\deftranslation[to=French]{__gzt_bc}{avant~J.-C}%
\deftranslation[to=English]{__gzt_bc}{BC}%
\cs_new_protected:Nn \__gzt_century:n
{
  \textsc{
    \int_to_roman:n {\int_abs:n {#1}}
  }%
  \int_compare:nNnTF { \int_abs:n {#1} } > { 1 }{\translate{__gzt_nth}}{\translate{__gzt_first}}
}
\cs_new_protected:Nn \__gzt_century_suffix:n
{
  \translate{__gzt_century}%
  \int_compare:nNnT { #1 } < { 0 }{
    \space
    \translate{__gzt_bc}
    \IfLanguageName {french}{
      \@ifnextchar.%
      {
      }{
        .\xspace
      }%
    }
  }{
  }
}
\cs_new_protected:Nn \__gzt_advertisement:nn
 {
   \vfill
   \begin{center}
     \dim_set:Nn \fboxsep {\c_zero_dim}
     \fbox{%
       \includegraphics[max~size={\linewidth}{\textheight},#1]{#2}
     }
   \end{center}
   \vfill
 }
\NewDocumentCommand \advertisement { O{} m }
 {
   \__gzt_advertisement:nn {#1}{#2}
 }
\cs_new_protected:Nn \__gzt_fullpageadvertisement:nn
 {
  \newpage
  \thispagestyle{__gzt_advertisement_ps}
  \begin{minipage}[c][\textheight][c]{\textwidth}%
    \centering\includegraphics[max~size={\linewidth}{\textheight},#1]{#2}%
  \end{minipage}%
 }
\NewDocumentCommand \fullpageadvertisement { O{} m }
{
   \__gzt_fullpageadvertisement:nn {#1}{#2}
}
\NewDocumentCommand \aboutfrontcover { O{} O{\c__gzt_about_frontcover_string_tl} m }
{
  \__gzt_about_frontcover:nnn {#1}{#2}{#3}%
}
\cs_new_protected:Nn \__gzt_prepare_rubric:nnn {%
  \newpage%
  \tl_gclear:N \g__gzt_rubric_abstract_tl
  \tl_gset:Nn \g__gzt_rubric_title_tl {#2}
  \tl_gset:Nn \g__gzt_rubric_pictofile_tl {#3}
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/rubric } { #1 }
  }
  \__gzt_rubric:nnn
  {\g__gzt_rubric_abstract_tl}{\g__gzt_rubric_title_tl}{\g__gzt_rubric_pictofile_tl}%
}
\NewDocumentCommand \rubric {O{}mm}
{
  \__gzt_rubric:nnn {#1}{#2}{#3}%
}
\NewDocumentCommand \mathematics {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_mathematics_rubric_string_tl}{picto-mathematics}
}
\NewDocumentCommand \dossier {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_dossier_rubric_string_tl}{picto-dossier}
}
\NewDocumentCommand \community {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_community_rubric_string_tl}{picto-hands}
}
\NewDocumentCommand \interview {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_interview_rubric_string_tl}{picto-interview}
  \bool_gset_true:N \g__gzt_interview_rubric_bool
}
\NewDocumentCommand \teaching {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_teaching_rubric_string_tl}{picto-teaching}
}
\NewDocumentCommand \parity {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_parity_rubric_string_tl}{picto-parity}
}
\NewDocumentCommand \tellme {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_tellme_rubric_string_tl}{picto-tellme}
  \bool_gset_true:N \g__gzt_tellme_rubric_bool
}
\NewDocumentCommand \information {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_information_rubric_string_tl}{picto-information}
}
\NewDocumentCommand \rearviewmirror {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_rearviewmirror_rubric_string_tl}{picto-rearviewmirror}
  \bool_gset_true:N \g__gzt_rearviewmirror_rubric_bool
}
\NewDocumentCommand \tribute {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_tribute_rubric_string_tl}{picto-tribute}
}
\NewDocumentCommand \books {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_books_rubric_string_tl}{picto-books}
  \bool_gset_true:N \g__gzt_books_rubric_bool
  \vspace{1.5\c__gzt_book_review_frontcover_extend_dim}
}
\NewDocumentCommand \latextips {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_latex_rubric_string_tl}{}
}
\NewDocumentCommand \forum {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_forum_rubric_string_tl}{picto-forum}
}
\NewDocumentCommand \moralreport {O{}}
{
  \__gzt_rubric:nnn {#1}{\c__gzt_moralreport_rubric_string_tl}{\c__gzt_smf_logo_file_string_tl}
}
\DeclareCiteCommand{\citeinterviewee}{}{%
  \printnames{interviewee}%
}
{}{}
\DeclareCiteCommand{\citereviewer}{}{%
  \g__gzt_blx_given_first_inits_false_tl
  \printnames{reviewer}%
}
{}{}
\DeclareCiteCommand{\citereviewerinstitution}{}{%
  \printlist{reviewerinstitution}%
}
{}{}
\DeclareCiteCommand{\__gzt_cite_public_price}{}{%
  \printfield{publicprice}%
}
{}{}
\DeclareCiteCommand{\__gzt_cite_smf_price}{}{%
  \printfield{smfprice}%
}
{}{}
\DeclareCiteCommand{\citecopublisher}{}{%
  \printlist{copublisher}%
}
{}{}
\DeclareCiteCommand{\citefrenchabstract}{}{%
  \printfield{frenchabstract}%
}
{}{}
\DeclareCiteCommand{\__gzt_cite_englishabstract}{}{%
  \printfield{englishabstract}%
}
{}{}
\NewDocumentCommand \email {m}
{
  \__gzt_email:n {#1}%
}
\cs_new_protected:Nn \__gzt_question:n
{
  \int_incr:N \g__gzt_question_int
  {%
    \par%
    \bigskip%
    \color{__gzt_question_color}
    #1%
    \par%
  }%
}
\NewDocumentCommand \question {m}
{
  \__gzt_question:n {#1}%
}
\NewDocumentCommand \smf { s } {
  \IfBooleanTF {#1}
  {
    \g__gzt_smf_string_tl
  }
  {
    \g__gzt_smf_short_string_tl
  }
  \xspace
}
\DeclareExpandableDocumentCommand \surname { m } {
  \textsc{#1}
}
\NewDocumentCommand \cad { s } {
  \IfBooleanTF {#1}
  {
    \c__gzt_cad_string_tl
  }
  {
    \c__gzt_cad_short_string_tl
  }
  \xspace
}
\NewDocumentCommand \Cad { s } {
  \IfBooleanTF {#1}
  {
    \c__gzt_Cad_string_tl
  }
  {
    \c__gzt_Cad_short_string_tl
  }
  \xspace
}
\NewDocumentCommand \gzt { s } {
  \IfBooleanTF {#1}
  {
    \l__gzt_gzt_string_tl
  }
  {
    \l__gzt_gzt_short_string_tl
  }
  \xspace
}
\NewDocumentCommand \gztcl {}
{%
  \textsl{\texttt{\c__gzt_class_name_tl}}
  \xspace
}
\NewDocumentCommand \gztarticlecl {}
{%
  \textsl{\texttt{\c__gzt_article_class_name_tl}}
  \xspace
}
\NewDocumentCommand \century { s m } {%
  \__gzt_century:n {#2}%
  \IfBooleanTF {#1}
  {
    \int_compare:nNnT { #2 } < { 0 }{
      \__gzt_century_suffix:n {#2}%
    }
  }
  {
    \__gzt_century_suffix:n {#2}%
  }
}
\NewDocumentCommand \aside { s m } {%
  \IfBooleanTF {#1}
  {
    \c__gzt_aside_string_tl{}~#2
  }
  {
    \c__gzt_aside_string_tl{}~#2~\c__gzt_aside_string_tl
  }
}
\tl_new:N \g__gzt_font_designer_text_tl%
\cs_new_protected:Nn \__gzt_font_designer_text:n
{
  \tl_gset:Nn \g__gzt_font_designer_text_tl { #1 }
}
\NewDocumentCommand \fontdesignertext {m}
{
  \__gzt_font_designer_text:n {#1}%
}
\tl_new:N \g__gzt_printer_text_tl%
\cs_new_protected:Nn \__gzt_printer_text:n
{
  \tl_gset:Nn \g__gzt_printer_text_tl { #1 }
}
\NewDocumentCommand \printertext {m}
{
  \__gzt_printer_text:n {#1}%
}
\renewcommand{\textflush}{flushepinormal}
\cs_set_eq:NN \__gzt_orig_epigraph \epigraph
\cs_new_protected:Nn \__gzt_epigraph:nn
{
  \bool_if:nTF { \tl_if_empty_p:n {#2}  }
  {
    \setlength{\epigraphrule}{\c_zero_dim}
  }
  {
    \setlength{\epigraphrule}{.4\p@}
  }
  \__gzt_orig_epigraph{%
    \emph{%
      \enquote{%
        #1%
      }%
    }%
  }%
  {%
    #2
  }
}
\RenewDocumentCommand \epigraph { m m }
{
  \__gzt_epigraph:nn {#1}{#2}%
}
\NewDocumentEnvironment{authorsinstructions}{}
{%
  \begingroup
  \tcbverbatimwrite{\c__gzt_authors_instructions_file_tl}
}%
{
  \endtcbverbatimwrite
  \endgroup
}
\lstdefinestyle{__gzt_lst_style}{%
  escapechar=+,
  language=[LaTeX]TeX,
  texcsstyle=*\bfseries,
  breaklines=true,
  basicstyle=\normalfont\ttfamily,
  columns=flexible,
  inputencoding=utf8/latin1
}%
\DeclareTotalTCBox{\gztverb}{ v }{verbatim,blank,fuzzy~halo=0pt~with~__gzt_light_generic_dark_color!8}{#1}
\NewTCBListing{gztcode}{ O{} }{%
  listing~style=__gzt_lst_style,
  listing~only,
  enlarge~top~by=\medskipamount,
  breakable,
  #1%
}
\DeclareTColorBox[blend~into=figures]{gztfigure}{ O{} }
{
  #1%
  % ,title={#2}%
  ,width=\linewidth%
  ,__gzt_tcb_floats_style%
}
\DeclareTColorBox[blend~into=figures]{gztfigure*}{ O{} }
{
  #1%
  ,float*
  % ,title={#2}%
  ,width=\textwidth%
  ,__gzt_tcb_floats_style%
}
\DeclareTColorBox[blend~into=tables]{gzttable}{ O{} }
{
  #1%
  % ,title={#2}%
  ,width=\linewidth%
  ,__gzt_tcb_floats_style%
}
\DeclareTColorBox[blend~into=tables]{gzttable*}{ O{} }
{
  #1%
  ,float*
  % ,title={#2}%
  ,width=\textwidth%
  ,__gzt_tcb_floats_style%
}
\DeclareTColorBox{gztscan}{ O{} }
{
  #1%
  % ,title={#2}%
  ,width=\textwidth%
  ,__gzt_tcb_floats_style%
  ,size=tight%
}
\DeclareTColorBox{__gzt_book_review}{ O{} }
{
  overlay~unbroken~and~first={%
    \node at (frame.north~west) {
      {
        \makebox[\c_zero_dim][l]{%
          \adjustbox{raise={-2\height+\c__gzt_book_review_frontcover_extend_dim}{\c_zero_dim}}{%
            \includegraphics[width=20mm]{\g__gzt_bookreview_frontcover_tl}%
          }%
        }
      }
    };
  },
  __gzt_tcb_book_review_box_style,
  #1
}
\DeclareTColorBox{__gzt_bibliography_tcbox}{ O{} }
{
  __gzt_tcb_bibliography_style,
  #1
}
\DeclareTColorBox{__gzt_minibiographies_acknowledgments_tcbox}{ O{} }
{
  __gzt_tcb_minibiographies_acknowledgments_style,
  #1
}
\DeclareTColorBox{inset}{ O{} }
{
  __gzt_tcb_minibiographies_acknowledgments_style,
  #1
}
\NewDocumentEnvironment{bookreview}{ O{} m }
{
  \keys_set:nn { gzt/bookreview } { #2 }
  \begin{__gzt_book_review}[#1]
    \xpatchfieldformat{title}{mkbibemph}{textbf}{}{}%
    \xpretonameformat{author}{\color{__gzt_people_color}}{}{}%
    \g__gzt_blx_given_first_inits_false_tl
    \noindent\fullcite{\g__gzt_bookreview_bibkey_tl}
    \vspace{10mm}
    \tcblower
}{
  \begin{flushright}
    % \g__gzt_reviewer_tl
    \bigskip
    \citereviewer{\g__gzt_bookreview_bibkey_tl}\\
    \citereviewerinstitution{\g__gzt_bookreview_bibkey_tl}
  \end{flushright}
    % \vspace*{10mm}
    \mbox{}
  \end{__gzt_book_review}
}
\DeclareTColorBox{__gzt_book_advertisement}{ O{} }
{
  __gzt_tcb_book_advertisement_box_style,
  #1
}
\DeclareTColorBox{__gzt_inside_cover_tcb}{ O{} }
{
  #1
}
\NewDocumentCommand \bookadvertisement {O{} m}
{
  \newpage{}
  \mbox{}
  \vfill
  \begin{__gzt_book_advertisement}[#1]
    \fullcite{#2}
    \par
    \bigskip
    \tcblower
      \includegraphics[height=22.5mm]{\c__gzt_smf_logo_file_string_tl}%
      \par{}
      \smallskip%
      \url{\l__gzt_journal_url_tl}
  \end{__gzt_book_advertisement}
  \vfill
  \newpage
  \bool_gset_false:N \g__gzt_advertisement_bool
  \bool_gset_true:N \g__gzt_mainmatter_bool
}
\cs_generate_variant:Nn \tl_if_eq:nnT { NnT }
\NewDocumentCommand \gztinput { m m } {%
  \startcustomization%
  \bool_if:NF {\g__gzt_refsection_bool} {
    \begin{refsection}
    }
    \bool_if:NF { \g__gzt_backcover_bool } {
      \tl_if_in:NnT
      { \c__gzt_advertisement_directory_string_tl } { #1 } {%
        \newpage
        \thispagestyle{__gzt_advertisement_ps}
      }
    }
    \inputfrom{#1}{#2}
    \bool_if:NT {\g__gzt_multicols_bool} {
      \end{multicols}%
    }
    \bool_if:NT {\g__gzt_refsection_bool} {
      \end{refsection}
    }
    \cleancustomization%
}
\bool_if:NF {\g__gzt_coverpage_bool} {
  \bool_if:NF {\g__gzt_inside_pages_bool} {
    \preto\@enddocumenthook{
      \bool_gset_true:N \g__gzt_backmatter_bool
      \g__gzt_display_inside_backcover_tl
      \newpage
      \g__gzt_display_backcover_tl
    }%
  }%
}%
\bool_if:NF {\g__gzt_coverpage_bool} {
  \bool_if:nF { \g__gzt_for_authors_bool } {
    \bool_if:nT { \g__gzt_inside_pages_bool } {
      \AtEndDocument{%
        \prg_replicate:nn
        { \int_mod:nn { 4 - \int_mod:nn { \getpagerefnumber{LastPage} } { 4 } } { 4 } }
        { \thispagestyle{__gzt_blank_pages_ps}\null\clearpage }
      }
    }
  }
}
\pgfplotsset{%
  /pgf/number~format/.cd,
  use~comma,
  1000~sep={\,},
  min~exponent~for~1000~sep=4
}%
\defbibheading{bibassection}[\bibname]{\section*{#1}}%
\renewcommand{\bibfont}{\normalfont\footnotesize}
\exp_after:wN\addbibresource\exp_after:wN{\c__gzt_issue_bib_path_string_tl}
\@ifpackagelater{biblatex}{2016/01/01}{%
  \DeclareNameFormat{giveninits-last}{%
    \nameparts{#1}
    \usebibmacro{name:given-family}
    {\namepartfamily}
    {\namepartgiveni}
    {\namepartprefix}
    {\namepartsuffix}%
  }
}{
  \DeclareNameFormat{giveninits-last}{%
    \usebibmacro{name:first-last}{#1}{#4}{#5}{#7}%
    \usebibmacro{name:andothers}%
  }
}
\DeclareNameAlias{labelname}{giveninits-last}
\renewcommand*\bibnamedelimc{\addnbspace}
\renewcommand*\bibnamedelimd{\addnbspace}
\renewbibmacro{in:}{%
  \ifentrytype{article}{}{\printtext{\bibstring{in}\intitlepunct}}}
\renewbibmacro*{journal}{%
  \iffieldundef{shortjournal}%
    {%
      \iffieldundef{journaltitle}
        {}
        {%
          \printtext[journaltitle]%
            {%
              \printfield[titlecase]{journaltitle}%
              \setunit{\subtitlepunct}%
              \printfield[titlecase]{journalsubtitle}%
             }%
         }%
    }%
    {\printtext[journaltitle]{\printfield[titlecase]{shortjournal}}}%
}
\renewbibmacro*{volume+number+eid}{%
  \printfield{volume}%
  \setunit{\addcomma\space}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}}
\DeclareFieldFormat[article]{volume}{\mkbibbold{#1}}
\DeclareFieldFormat[book]{volume}{\mkbibbold{#1}}
\DeclareFieldFormat[article]{number}{\bibstring{number}#1}
\DeclareLanguageMapping{french}{gzt}% use the new abbreviations
\ifkp@easyscsl
\DeclareRobustCommand{\itshape}{\not@math@alphabet\itshape\mathit%
  \ifthenelse{\equal{\f@shape}{\scdefault}}{\fontshape{scsl}}{%
    \fontshape\itdefault}\selectfont}
\fi
\DeclareMathAlphabet\mathfrak{U}{euf}{m}{n}
\SetMathAlphabet\mathfrak{bold}{U}{euf}{b}{n}
\@ifpackageloaded{draftwatermark}{%
  \SetWatermarkColor{gray!10}%
  \SetWatermarkFontSize{30mm}%
  \SetWatermarkText{\MakeUppercase{\c__gzt_draftwatermark_string_tl}}%
}{%
}
\tikzset{
  __gzt_dots/.style={
    line~width=\c__gzt_tikz_dot_diameter_dim,
    line~cap=round,
    dash~pattern=on~0pt~off~\c__gzt_tikz_dot_spacing_dim
  },
  __gzt_tcb_segmentation_style/.style={
    __gzt_dots,
    draw=__gzt_dotfill_color,
    shorten~>=~\c__gzt_tcb_left_dim+\c__gzt_tcb_boxsep_dim,
    shorten~<=~\c__gzt_tcb_left_dim+\c__gzt_tcb_boxsep_dim,
  }
}
\tcbset{
  copyright/.style={overlay={\node[rotate=90,anchor=south~west,font=\tiny]
      at (frame.south~east) {\copyright{}~#1};}}
}
\tcbset{%
  __gzt_tcb_floats_style/.style={%
    enhanced%
    ,every~float=\centering%
    ,coltitle=__gzt_generic_dark_color%
    ,colbacktitle=__gzt_float_title_bg_color%
    ,colback=white%
    ,colframe=__gzt_float_frame_color%
    ,center~upper%
    ,sharp~corners=all%
    ,boxrule=0.3mm%
    ,separator~sign~dash
    % ,attach~boxed~title~to~bottom~center
    % ,minipage~boxed~title*=-6mm
    % ,boxed~title~style={
    % enhanced
    % ,boxrule=0mm%
    % ,sharp~corners=all%
  }%
}
\tcbset{%
  __gzt_tcb_book_review_box_style/.style={%
    enhanced,%
    colback=__gzt_book_review_frame_bg_color,%
    breakable,%
    height=50mm,%
    boxrule=\c_zero_dim,
    sharp~corners=all,%
    skin=enhancedlast,
    leftupper=25mm,
    enlarge~bottom~finally~by=-1mm,
    middle=4mm,
    segmentation~style={__gzt_tcb_segmentation_style}%
  }
}
\tcbset{%
  __gzt_tcb_book_advertisement_box_style/.style={%
    enhanced,%
    colframe=__gzt_book_advertisement_frame_color,%
    colback=__gzt_book_advertisement_bg_color,%
    center~lower,
    sharp~corners=all,%
    % skin=enhancedlast,
    % middle=4mm,
    lower~separated=false,
    % segmentation~style={__gzt_tcb_segmentation_style}%
  }
}
\tcbset{%
  __gzt_tcb_inside_cover_style/.style={%
    % split=0.6,%
    colback=__gzt_inside_frontcover_frame_bg_color,%
    colbacktitle=__gzt_inside_frontcover_frame_bg_color,%
    sharp~corners=all,%
    center~title,%
    coltitle=__gzt_inside_frontcover_frame_title_color,%
    fonttitle=\bfseries\large,%
    boxrule=\c_zero_dim,%
    toptitle=3mm,%
    bottomtitle=4mm,%
    frame~hidden,%
    enhanced,%
    height=\c__gzt_layoutheight_dim-\c__gzt_topmargin_inside_cover_dim-\c__gzt_botmargin_dim,
    width=\c__gzt_inside_cover_box_width_dim,
    middle=4mm,
    segmentation~style={__gzt_tcb_segmentation_style}%
  },
  __gzt_tcb_inside_frontcover_style/.style={%
    __gzt_tcb_inside_cover_style,
    enlarge~left~by=-\c__gzt_inside_cover_offset_dim,
    title=\c__gzt_editorial_board_string_tl
  },
  __gzt_tcb_inside_backcover_style/.style={%
    __gzt_tcb_inside_cover_style,
    enlarge~left~by=\c__gzt_inside_cover_offset_dim,
    title=\file_if_exist:nT { \c__gzt_authors_instructions_file_tl } {%
      \c__gzt_authors_instructions_string_tl
    }
  }
}
\tcbset{%
  __gzt_tcb_bibliography_style/.style={%
    colback=__gzt_bibliography_minibios_acknowledgments_bg_color,
    breakable,
    boxrule=\c_zero_dim,
    sharp~corners=all,%
    enhanced
  }
}
\tcbset{%
  __gzt_tcb_minibiographies_acknowledgments_style/.style={%
    colback=__gzt_bibliography_minibios_acknowledgments_bg_color,
    breakable,
    boxrule=\c_zero_dim,
    extras~unbroken~and~last={drop~lifted~shadow},
    sharp~corners=all,%
    skin=enhancedlast,
    height~fixed~for=middle,
  }
}
\tcbset{%
  enlargepage~flexible=\baselineskip,
  left=\c__gzt_tcb_left_dim,
  boxsep=\c__gzt_tcb_boxsep_dim,
}
\setlist[1]{labelindent=\parindent}
\setlist[itemize]{label=\textendash{}, nosep}
\setlist{%
  labelwidth=\widthof{\textendash},
  itemsep=0.4ex plus 0.2ex minus 0.2ex,
  parsep=0.4ex plus 0.2ex minus 0.2ex,
  topsep=0.8ex plus 0.4ex minus 0.4ex,
  partopsep=0.4ex plus 0.2ex minus 0.2ex,
  leftmargin=!%
}
\setlist[description]{
  font=
  \bool_if:nTF { \g__gzt_books_rubric_bool || \g__gzt_inside_frontcover_bool || \g__gzt_inside_backcover_bool }
  {
    \color{black}
  }{
    \color{__gzt_description_label_light_color}
  }
  \bfseries
}
\DeclarePlainStyle{^^c2^^ab~}{~^^c2^^bb}{`}{'}
\setcounter{topnumber}{3}
\renewcommand{\topfraction}{0.8}
\addtolength{\skip\footins}{.25\baselineskip}
\setlength{\columnsep}{7mm}%
\renewcommand{\thesection}{\arabic{section}}%
\@ifpackageloaded{siunitx}{%
  \sisetup{locale=FR}
}
\arrayrulecolor{__gzt_arrayrule_color}%
\addto\captionsfrench{\def\tablename{{\scshape Tableau}}}%
\RenewDocumentCommand \vec { m } {
  \vv{#1}
}
\cs_set_eq:NN \__gzt_orig_usetikzlibrary \usetikzlibrary
\RenewDocumentCommand \usetikzlibrary { m } {
  \shorthandoff{:}%
  \__gzt_orig_usetikzlibrary{#1}
  \shorthandon{:}%
  % \begingroup
  % \NoAutoSpacing
  % \__gzt_orig_usetikzlibrary{#1}
  % \endgroup
}
\cs_new_protected:Nn \__gzt_bilingual:nnn
{
  \deftranslation[to=French]{#1}{#2}%
  \deftranslation[to=English]{#1}{#3}%
}
\cs_new_protected:Nn \__gzt_new_theorem:nnnn
{
  % \__gzt_bilingual:nnn {#2}{#3}{#4}
  \deftranslation[to=French]{#2}{#3}%
  \deftranslation[to=English]{#2}{#4}%
  \declaretheorem[%
  #1,%
  name=\translate{#2}
  ]{#2}
  \declaretheorem[%
  #1,%
  name=\translate{#2},
  numbered=no
  ]{#2*}
}
\cs_generate_variant:Nn \__gzt_new_theorem:nnnn { nnVV }
\declaretheoremstyle[spaceabove=3pt,notefont=\bfseries,bodyfont=\itshape]{theorem}
\declaretheoremstyle[spaceabove=3pt,notefont=\bfseries,bodyfont=\normalfont]{definition}
\declaretheoremstyle[spaceabove=3pt,bodyfont=\normalfont,qed=\ensuremath{\qedsymbol},headfont=\normalfont\itshape,numbered=no]{proof}
\RenewDocumentCommand \newtheorem { O{} m }
{
  \tl_clear:N \l__gzt_newtheorem_style_tl
  \tl_clear:N \l__gzt_newtheorem_frenchtitle_tl
  \tl_clear:N \l__gzt_newtheorem_englishtitle_tl
  \tl_set:Nn \l__gzt_newtheorem_englishtitle_tl {
    \MakeUppercase #2
  }
  \tl_set:Nf \l__gzt_newtheorem_frenchtitle_tl {
    \l__gzt_newtheorem_englishtitle_tl
  }
  \tl_set:Nn \l__gzt_newtheorem_style_tl {
    theorem
  }
  \IfNoValueF {#1}
  {
    \keys_set:nn { gzt/newtheorem } { #1 }
  }
  % \tl_if_eq:VVF { \l__gzt_newtheorem_englishtitle_tl } { \MakeUppercase #2 }
  %   {%
  %     \tl_show:N \l__gzt_newtheorem_englishtitle_tl
  %     \tl_show:N \l__gzt_newtheorem_frenchtitle_tl
  %     \tl_if_eq:NNF { \l__gzt_newtheorem_frenchtitle_tl } { \l__gzt_newtheorem_englishtitle_tl }
  %     {%
  %     \tl_set:Nf \l__gzt_newtheorem_frenchtitle_tl {
  %       \l__gzt_newtheorem_englishtitle_tl
  %     }
  %   }
  % }
  % \tl_show:N \l__gzt_newtheorem_style_tl
  % \tl_show:N \l__gzt_newtheorem_frenchtitle_tl
  % \tl_show:N \l__gzt_newtheorem_englishtitle_tl
  \__gzt_new_theorem:nnVV {style=\l__gzt_newtheorem_style_tl}{#2}{\l__gzt_newtheorem_frenchtitle_tl}{\l__gzt_newtheorem_englishtitle_tl}
}
\newtheorem[frenchtitle=Th\'eor\`eme]{theorem}
\newtheorem[frenchtitle=Corollaire]{corollary}
\newtheorem{conjecture}
\newtheorem{proposition}
\newtheorem[frenchtitle=Lemme]{lemma}
\newtheorem[frenchtitle=Axiome]{axiom}
\newtheorem[style=definition,frenchtitle=D\'efinition]{definition}
\newtheorem[style=definition,frenchtitle=Remarque]{remark}
\newtheorem[style=definition,frenchtitle=Exemple]{example}
\newtheorem[style=definition]{notation}
\let\proof\relax
\newtheorem[style=proof,frenchtitle=Preuve]{proof}
\cs_new_protected:Nn \__gzt_clone_theorem:nn
{
  \NewDocumentEnvironment{#1}{}
  {
    \begin{#2}
    }
    {
    \end{#2}
  }
  \NewDocumentEnvironment{#1*}{}
  {
    \begin{#2*}
    }
    {
    \end{#2*}
  }
}
\__gzt_clone_theorem:nn {theoreme} {theorem}
\__gzt_clone_theorem:nn {corollaire}{corollary}
\__gzt_clone_theorem:nn {lemme}{lemma}
\__gzt_clone_theorem:nn {axiome}{axiom}
\__gzt_clone_theorem:nn {remarque}{remark}
\__gzt_clone_theorem:nn {exemple}{example}
\__gzt_clone_theorem:nn {preuve}{proof}
\DeclareMathOperator{\cotan}{cotan}
\DeclareMathOperator{\Arccos}{Arccos}
\DeclareMathOperator{\Arcsin}{Arcsin}
\DeclareMathOperator{\Arctan}{Arctan}
\DeclareMathOperator{\Argch}{Argch}
\DeclareMathOperator{\Argsh}{Argsh}
\DeclareMathOperator{\Argth}{Argth}
\cs_set_eq:NN \__gzt_orig_arccos \arccos
\cs_set_eq:NN \__gzt_orig_arcsin \arcsin
\cs_set_eq:NN \__gzt_orig_arctan \arctan
\RenewDocumentCommand \arccos {} {
  \IfLanguageName {french}{\Arccos}{\__gzt_orig_arccos}%
}
\RenewDocumentCommand \arcsin {} {
  \IfLanguageName {french}{\Arcsin}{\__gzt_orig_arcsin}%
}
\RenewDocumentCommand \arctan {} {
  \IfLanguageName {french}{\Arctan}{\__gzt_orig_arctan}%
}
\DeclareMathOperator{\ch}{ch}
\DeclareMathOperator{\sh}{sh}
\cs_set_eq:NN \__gzt_orig_tanh \tanh
\RenewDocumentCommand \tanh {} {
  \IfLanguageName {french}{\operatorname{th}}{\__gzt_orig_tanh}%
}
\cs_set_eq:NN \__gzt_orig_log \log
\cs_set_eq:NN \__gzt_orig_lg \lg
\RenewDocumentCommand \log { s } {
    \IfBooleanTF {#1}
  {
    \__gzt_orig_log
  }
  {
    \ln
  }
}
\RenewDocumentCommand \lg { s } {
    \IfBooleanTF {#1}
  {
    \__gzt_orig_lg
  }
  {
    \ln
  }
}
\cs_set_eq:NN \__gzt_orig_leq \leq
\cs_set_eq:NN \__gzt_orig_geq \geq
\RenewDocumentCommand \le {} {%
  \IfLanguageName {french}{\leqslant}{\__gzt_orig_leq}%
}
\RenewDocumentCommand \leq {} {%
  \IfLanguageName {french}{\leqslant}{\__gzt_orig_leq}%
}
\RenewDocumentCommand \ge {} {%
  \IfLanguageName {french}{\geqslant}{\__gzt_orig_geq}%
}
\RenewDocumentCommand \geq {} {%
  \IfLanguageName {french}{\geqslant}{\__gzt_orig_geq}%
}
\NewDocumentCommand \N {} {\mathbb{N}}
\NewDocumentCommand \Z {} {\mathbb{Z}}
\NewDocumentCommand \D {} {\mathbb{D}}
\NewDocumentCommand \Q {} {\mathbb{Q}}
\NewDocumentCommand \R {} {\mathbb{R}}
\NewDocumentCommand \C {} {\mathbb{C}}
\NewDocumentCommand \K {} {\mathbb{K}}
\ExplSyntaxOff

%% ----------------------------------------------------------------------------
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
%% The Current Maintainer of this work is Denis Bitouz'e.
%% 
%% This work consists of the file  gzt.dtx
%%           and the derived files gzt.cls,
%%                                 gztarticle.cls,
%%                                 gzt.ins,
%%                                 gzt.pdf,
%%                                 and a number of configuration files.
%%
%% End of file `gzt.cls'.
