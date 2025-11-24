#!/usr/bin/perl
# File   : bibleref.perl
# Author : Nicola L.C. Talbot
#          http://theoval.cmp.uea.ac.uk/~nlct/
# This is a LaTeX2HTML style implementing the bibleref package, and
# is distributed as part of that package.
# Copyright 2007 Nicola L.C. Talbot
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3
# of this license of (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3 or later is part of all distributions of LaTeX
# version 2005/12/01 or later.
#
# This work has the LPPL maintenance status `maintained'.
#
# The Current Maintainer of this work is Nicola Talbot.
#
# This work consists of the files bibleref.dtx and bibleref.ins
# and the derived files bibleref.sty, sample.tex, bibleref.perl.

 %bookfullname=();

$synonym{'Gn'}='Gensis';
$synonym{'Ex'}='Exodus';
$synonym{'Lv'}='Leviticus';
$synonym{'Nb'}='Numbers';
$synonym{'Dt'}='Deuteronomy';
$synonym{'Jos'}='Joshua';
$synonym{'Jg'}='Judges';
$synonym{'Rt'}='Ruth';
$synonym{'IS'}='ISamuel';
$synonym{'IIS'}='IISamuel';
$synonym{'IK'}='IKings';
$synonym{'IIK'}='IIKings';
$synonym{'ICh'}='IChronicles';
$synonym{'IICh'}='IIChronicles';
$synonym{'Ezr'}='Ezra';
$synonym{'Ne'}='Nehemiah';
$synonym{'Tb'}='Tobit';
$synonym{'Jdt'}='Judith';
$synonym{'Est'}='Esther';
$synonym{'IM'}='IMaccabees';
$synonym{'IIM'}='IIMaccabees';
$synonym{'Jb'}='Job';
$synonym{'Ps'}='Psalms';
$synonym{'Pr'}='Proverbs';
$synonym{'Qo'}='Ecclesiastes';
$synonym{'Sg'}='SongofSongs';
$synonym{'Ws'}='Wisdom';
$synonym{'Si'}='Ecclesiasticus';
$synonym{'Is'}='Isaiah';
$synonym{'Jr'}='Jeremiah';
$synonym{'Lm'}='Lamentations';
$synonym{'Ba'}='Baruch';
$synonym{'Ezk'}='Ezekiel';
$synonym{'Dn'}='Daniel';
$synonym{'Ho'}='Hosea';
$synonym{'Jl'}='Joel';
$synonym{'Am'}='Amos';
$synonym{'Ob'}='Obadiah';
$synonym{'Jon'}='Jonah';
$synonym{'Mi'}='Micah';
$synonym{'Na'}='Nahum';
$synonym{'Hab'}='Habakkuk';
$synonym{'Zp'}='Zephaniah';
$synonym{'Hg'}='Haggai';
$synonym{'Zc'}='Zechariah';
$synonym{'Ml'}='Malachi';
$synonym{'Mt'}='Matthew';
$synonym{'Mk'}='Mark';
$synonym{'Lk'}='Luke';
$synonym{'Jn'}='John';
$synonym{'Ac'}='Acts';
$synonym{'Rm'}='Romans';
$synonym{'ICo'}='ICorinthians';
$synonym{'IICo'}='IICorinthians';
$synonym{'Ga'}='Galatians';
$synonym{'Ep'}='Ephesians';
$synonym{'Ph'}='Philippians';
$synonym{'Col'}='Colossians';
$synonym{'ITh'}='IThessalonians';
$synonym{'IITh'}='IIThessalonians';
$synonym{'ITm'}='ITimothy';
$synonym{'IITm'}='IITimothy';
$synonym{'Tt'}='Titus';
$synonym{'Phm'}='Philemon';
$synonym{'Heb'}='Hebrews';
$synonym{'Jm'}='James';
$synonym{'IP'}='IPeter';
$synonym{'IIP'}='IIPeter';
$synonym{'IJn'}='IJohn';
$synonym{'IIJn'}='IIJohn';
$synonym{'IIIJn'}='IIIJohn';
$synonym{'Rv'}='Revelation';
$synonym{'Gen'}='Gensis';
$synonym{'Exod'}='Exodus';
$synonym{'Lev'}='Leviticus';
$synonym{'Num'}='Numbers';
$synonym{'Deut'}='Deuteronomy';
$synonym{'Josh'}='Joshua';
$synonym{'Judg'}='Judges';
$synonym{'ISam'}='ISamuel';
$synonym{'IISam'}='IISamuel';
$synonym{'IKgs'}='IKings';
$synonym{'IIKgs'}='IIKings';
$synonym{'IChr'}='IChronicles';
$synonym{'IIChr'}='IIChronicles';
$synonym{'Neh'}='Nehemiah';
$synonym{'IM'}='IMaccabees';
$synonym{'IIM'}='IIMaccabees';
$synonym{'Ps'}='Psalms';
$synonym{'Prov'}='Proverbs';
$synonym{'Eccles'}='Ecclesiastes';
$synonym{'SofS'}='SongofSongs';
$synonym{'Wisd'}='Wisdom';
$synonym{'Ecclus'}='Ecclesiasticus';
$synonym{'Isa'}='Isaiah';
$synonym{'Jer'}='Jeremiah';
$synonym{'Lam'}='Lamentations';
$synonym{'Ezek'}='Ezekiel';
$synonym{'Dan'}='Daniel';
$synonym{'Hos'}='Hosea';
$synonym{'Obad'}='Obadiah';
$synonym{'Mic'}='Micah';
$synonym{'Nah'}='Nahum';
$synonym{'Hab'}='Habakkuk';
$synonym{'Zeph'}='Zephaniah';
$synonym{'Hag'}='Haggai';
$synonym{'Zech'}='Zechariah';
$synonym{'Mal'}='Malachi';
$synonym{'Matt'}='Matthew';
$synonym{'Rom'}='Romans';
$synonym{'ICor'}='ICorinthians';
$synonym{'IICor'}='IICorinthians';
$synonym{'Gal'}='Galatians';
$synonym{'Eph'}='Ephesians';
$synonym{'Phil'}='Philippians';
$synonym{'Col'}='Colossians';
$synonym{'IThess'}='IThessalonians';
$synonym{'IIThess'}='IIThessalonians';
$synonym{'ITim'}='ITimothy';
$synonym{'IITim'}='IITimothy';
$synonym{'Tit'}='Titus';
$synonym{'Philem'}='Philemon';
$synonym{'Heb'}='Hebrews';
$synonym{'Jas'}='James';
$synonym{'IPet'}='IPeter';
$synonym{'IIPet'}='IIPeter';
$synonym{'IJohn'}='IJohn';
$synonym{'IIJohn'}='IIJohn';
$synonym{'IIIJohn'}='IIIJohn';
$synonym{'Rev'}='Revelation';

&do_cmd_brfullname;

sub do_cmd_BRbooknumberstyle{
   local($_) = @_;
   local($num);

   $num = &missing_braces unless
               s/$next_pair_pr_rx/$num=$2;''/eo;

   "$num " . $_;
}

sub do_cmd_BRepistlenumberstyle{
   local($_) = @_;
   local($num);

   $num = &missing_braces unless
               s/$next_pair_pr_rx/$num=$2;''/eo;

   "$num " . $_;
}

sub do_cmd_BRbooknumberstyleI{
   local($_)=@_;
   local($id)=++$global{'max_id'};

   join('',
   &translate_commands("\\BRbooknumberstyle$OP$id${CP}1$OP$id$CP"),$_);
}

sub do_cmd_BRbooknumberstyleII{
   local($_)=@_;
   local($id)=++$global{'max_id'};

   join('',
   &translate_commands("\\BRbooknumberstyle$OP$id${CP}2$OP$id$CP"),$_);
}

sub do_cmd_BRepistlenumberstyleI{
   local($_)=@_;
   local($id)=++$global{'max_id'};

   join('',
   &translate_commands("\\BRepistlenumberstyle$OP$id${CP}1$OP$id$CP"),$_);
}

sub do_cmd_BRepistlenumberstyleII{
   local($_)=@_;
   local($id)=++$global{'max_id'};

   join('',
   &translate_commands("\\BRepistlenumberstyle$OP$id${CP}2$OP$id$CP"),$_);
}

sub do_cmd_BRepistlenumberstyleIII{
   local($_)=@_;
   local($id)=++$global{'max_id'};

   join('',
   &translate_commands("\\BRepistlenumberstyle$OP$id${CP}3$OP$id$CP"),$_);
}

sub do_cmd_BRbookof{
   local($_)=@_;

   $_;
}

sub do_cmd_BRgospel{
   local($_)=@_;

   $_;
}

sub do_cmd_BRepistleto{
   local($_)=@_;

   $_;
}

sub do_cmd_BRepistletothe{
   local($_)=@_;

   $_;
}

sub do_cmd_BRepistleof{
   local($_)=@_;

   $_;
}

sub do_cmd_BRbooktitlestyle{
   local($_)=@_;
   local($title);

   $title = &missing_braces unless
              s/$next_pair_pr_rx/$title=$2;''/eo;

   $title . $_;
}

sub do_cmd_BRchapterstyle{
   local($_)=@_;
   local($num);

   $num = &missing_braces unless
              s/$next_pair_pr_rx/$num=$2;''/eo;

   $num . $_;
}

sub do_cmd_BRversestyle{
   local($_)=@_;
   local($num);

   $num = &missing_braces unless
              s/$next_pair_pr_rx/$num=$2;''/eo;

   $num . $_;
}

sub do_cmd_BRbkchsep{
   local($_)=@_;

   " " . $_;
}

sub do_cmd_BRchvsep{
   local($_)=@_;

   ":" . $_;
}

sub do_cmd_BRchsep{
   local($_)=@_;

   ';' . $_;
}

sub do_cmd_BRvrsep{
   local($_)=@_;

   &translate_commands("--") . $_;
}

sub do_cmd_BRvsep{
   local($_)=@_;

   "," . $_;
}

sub do_cmd_BRperiod{
   local($_)=@_;
   $_;
}

sub do_cmd_brfullname{
local($_) = @_;
$bookname{'Genesis'}='\BRbookof Genesis';
$bookname{'Exodus'}='\BRbookof Exodus';
$bookname{'Leviticus'}='\BRbookof Leviticus';
$bookname{'Numbers'}='\BRbookof Numbers';
$bookname{'Deuteronomy'}='\BRbookof Deuteronomy';
$bookname{'Joshua'}='\BRbookof Joshua';
$bookname{'Judges'}='\BRbookof Judges';
$bookname{'Ruth'}='\BRbookof Ruth';
$bookname{'ISamuel'}='\BRbooknumberstyleI \BRbookof Samuel';
$bookname{'IISamuel'}='\BRbooknumberstyleII \BRbookof Samuel';
$bookname{'IKings'}='\BRbooknumberstyleI \BRbookof Kings';
$bookname{'IIKings'}='\BRbooknumberstyleII \BRbookof Kings';
$bookname{'IChronicles'}='\BRbooknumberstyleI \BRbookof Chronicles';
$bookname{'IIChronicles'}='\BRbooknumberstyleII \BRbookof Chronicles';
$bookname{'Ezra'}='\BRbookof Ezra';
$bookname{'Nehemiah'}='\BRbookof Nehemiah';
$bookname{'Tobit'}='\BRbookof Tobit';
$bookname{'Judith'}='\BRbookof Judith';
$bookname{'Esther'}='\BRbookof Esther';
$bookname{'IMaccabees'}='\BRbooknumberstyleI \BRbookof Maccabees';
$bookname{'IIMaccabees'}='\BRbooknumberstyleII \BRbookof Maccabees';
$bookname{'Job'}='\BRbookof Job';
$bookname{'Psalms'}='\BRbookof Psalms';
$bookname{'Proverbs'}='\BRbookof Proverbs';
$bookname{'Ecclesiastes'}='\BRbookof Ecclesiastes';
$bookname{'SongofSongs'}='\BRbookof Song of Songs';
$bookname{'Wisdom'}='\BRbookof Wisdom';
$bookname{'Ecclesiasticus'}='\BRbookof Ecclesiasticus';
$bookname{'Isaiah'}='\BRbookof Isaiah';
$bookname{'Jeremiah'}='\BRbookof Jeremiah';
$bookname{'Lamentations'}='\BRbookof Lamentations';
$bookname{'Baruch'}='\BRbookof Baruch';
$bookname{'Ezekiel'}='\BRbookof Ezekiel';
$bookname{'Daniel'}='\BRbookof Daniel';
$bookname{'Hosea'}='\BRbookof Hosea';
$bookname{'Joel'}='\BRbookof Joel';
$bookname{'Amos'}='\BRbookof Amos';
$bookname{'Obadiah'}='\BRbookof Obadiah';
$bookname{'Jonah'}='\BRbookof Jonah';
$bookname{'Micah'}='\BRbookof Micah';
$bookname{'Nahum'}='\BRbookof Nahum';
$bookname{'Habakkuk'}='\BRbookof Habakkuk';
$bookname{'Zephaniah'}='\BRbookof Zephaniah';
$bookname{'Haggai'}='\BRbookof Haggai';
$bookname{'Zechariah'}='\BRbookof Zechariah';
$bookname{'Malachi'}='\BRbookof Malachi';
$bookname{'Matthew'}='\BRgospel Matthew';
$bookname{'Mark'}='\BRgospel Mark';
$bookname{'Luke'}='\BRgospel Luke';
$bookname{'John'}='\BRgospel John';
$bookname{'Acts'}='Acts';
$bookname{'Romans'}='\BRepistletothe Romans';
$bookname{'ICorinthians'}='\BRepistlenumberstyleI \BRepistletothe Corinthians';
$bookname{'IICorinthians'}='\BRepistlenumberstyleII \BRepistletothe Corinthians';
$bookname{'Galatians'}='\BRepistletothe Galatians';
$bookname{'Ephesians'}='\BRepistletothe Ephesians';
$bookname{'Philippians'}='\BRepistletothe Philippians';
$bookname{'Colossians'}='\BRepistletothe Colossians';
$bookname{'IThessalonians'}='\BRepistlenumberstyleI \BRepistletothe Thessalonians';
$bookname{'IIThessalonians'}='\BRepistlenumberstyleII \BRepistletothe Thessalonians';
$bookname{'ITimothy'}='\BRepistlenumberstyleI \BRepistleto Timothy';
$bookname{'IITimothy'}='\BRepistlenumberstyleII \BRepistletoTimothy';
$bookname{'Titus'}='\BRepistleto Titus';
$bookname{'Philemon'}='\BRepistleto Philemon';
$bookname{'Hebrews'}='\BRepistletothe Hebrews';
$bookname{'James'}='\BRepistleof James';
$bookname{'IPeter'}='\BRepistlenumberstyleI \BRepistleof Peter';
$bookname{'IIPeter'}='\BRepistlenumberstyleII \BRepistleof Peter';
$bookname{'IJohn'}='\BRepistlenumberstyleI \BRepistleof John';
$bookname{'IIJohn'}='\BRepistlenumberstyleII \BRepistleof John';
$bookname{'IIIJohn'}='\BRepistlenumberstyleIII \BRepistleof John';
$bookname{'Jude'}='\BRepistleof Jude';
$bookname{'Revelation'}='\BRbookof Revelation';
$_;
}

sub do_cmd_brabbrvname{
local($_)=@_;
$bookname{'Gensis'}='Gn\BRperiod ';
$bookname{'Exodus'}='Ex\BRperiod ';
$bookname{'Leviticus'}='Lv\BRperiod ';
$bookname{'Numbers'}='Nb\BRperiod ';
$bookname{'Deuteronomy'}='Dt\BRperiod ';
$bookname{'Joshua'}='Jos\BRperiod ';
$bookname{'Judges'}='Jg\BRperiod ';
$bookname{'Ruth'}='Rt\BRperiod ';
$bookname{'ISamuel'}='\BRbooknumberstyleI S\BRperiod ';
$bookname{'IISamuel'}='\BRbooknumberstyleII S\BRperiod ';
$bookname{'IKings'}='\BRbooknumberstyleI K\BRperiod ';
$bookname{'IIKings'}='\BRbooknumberstyleII K\BRperiod ';
$bookname{'IChronicles'}='\BRbooknumberstyleI Ch\BRperiod ';
$bookname{'IIChronicles'}='\BRbooknumberstyleII Ch\BRperiod ';
$bookname{'Ezra'}='Ezr\BRperiod ';
$bookname{'Nehemiah'}='Ne\BRperiod ';
$bookname{'Tobit'}='Tb\BRperiod ';
$bookname{'Judith'}='Jdt\BRperiod ';
$bookname{'Esther'}='Est\BRperiod ';
$bookname{'IMaccabees'}='\BRbooknumberstyleI M\BRperiod ';
$bookname{'IIMaccabees'}='\BRbooknumberstyleII M\BRperiod ';
$bookname{'Job'}='Jb\BRperiod ';
$bookname{'Psalms'}='Ps\BRperiod ';
$bookname{'Proverbs'}='Pr\BRperiod ';
$bookname{'Ecclesiastes'}='Qo\BRperiod ';
$bookname{'SongofSongs'}='Sg\BRperiod ';
$bookname{'Wisdom'}='Ws\BRperiod ';
$bookname{'Ecclesiasticus'}='Si\BRperiod ';
$bookname{'Isaiah'}='Is\BRperiod ';
$bookname{'Jeremiah'}='Jr\BRperiod ';
$bookname{'Lamentations'}='Lm\BRperiod ';
$bookname{'Baruch'}='Ba\BRperiod ';
$bookname{'Ezekiel'}='Ezk\BRperiod ';
$bookname{'Daniel'}='Dn\BRperiod ';
$bookname{'Hosea'}='Ho\BRperiod ';
$bookname{'Joel'}='Jl\BRperiod ';
$bookname{'Amos'}='Am\BRperiod ';
$bookname{'Obadiah'}='Ob\BRperiod ';
$bookname{'Jonah'}='Jon\BRperiod ';
$bookname{'Micah'}='Mi\BRperiod ';
$bookname{'Nahum'}='Na\BRperiod ';
$bookname{'Habakkuk'}='Hab\BRperiod ';
$bookname{'Zephaniah'}='Zp\BRperiod ';
$bookname{'Haggai'}='Hg\BRperiod ';
$bookname{'Zechariah'}='Zc\BRperiod ';
$bookname{'Malachi'}='Ml\BRperiod ';
$bookname{'Matthew'}='Mt\BRperiod ';
$bookname{'Mark'}='Mk\BRperiod ';
$bookname{'Luke'}='Lk\BRperiod ';
$bookname{'John'}='Jn\BRperiod ';
$bookname{'Acts'}='Ac\BRperiod ';
$bookname{'Romans'}='Rm\BRperiod ';
$bookname{'ICorinthians'}='\BRepistlenumberstyleI Co\BRperiod ';
$bookname{'IICorinthians'}='\BRepistlenumberstyleII Co\BRperiod ';
$bookname{'Galatians'}='Ga\BRperiod ';
$bookname{'Ephesians'}='Ep\BRperiod ';
$bookname{'Philippians'}='Ph\BRperiod ';
$bookname{'Colossians'}='Col\BRperiod ';
$bookname{'IThessalonians'}='\BRepistlenumberstyleI Th\BRperiod ';
$bookname{'IIThessalonians'}='\BRepistlenumberstyleII Th\BRperiod ';
$bookname{'ITimothy'}='\BRepistlenumberstyleI Tm\BRperiod ';
$bookname{'IITimothy'}='\BRepistlenumberstyleII Tm\BRperiod ';
$bookname{'Titus'}='Tt\BRperiod ';
$bookname{'Philemon'}='Phm\BRperiod ';
$bookname{'Hebrews'}='Heb\BRperiod ';
$bookname{'James'}='Jm\BRperiod ';
$bookname{'IPeter'}='\BRepistlenumberstyleI P\BRperiod ';
$bookname{'IIPeter'}='\BRepistlenumberstyleII P\BRperiod ';
$bookname{'IJohn'}='\BRepistlenumberstyleI Jn\BRperiod ';
$bookname{'IIJohn'}='\BRepistlenumberstyleII Jn\BRperiod ';
$bookname{'IIIJohn'}='\BRepistlenumberstyleIII Jn\BRperiod ';
$bookname{'Jude'}='Jude';
$bookname{'Revelation'}='Rv\BRperiod ';
$_;
}

sub do_cmd_braltabbrvname{
local($_)=@_;
$bookname{'Gensis'}='Gen\BRperiod ';
$bookname{'Exodus'}='Exod\BRperiod ';
$bookname{'Leviticus'}='Lev\BRperiod ';
$bookname{'Numbers'}='Num\BRperiod ';
$bookname{'Deuteronomy'}='Deut\BRperiod ';
$bookname{'Joshua'}='Josh\BRperiod ';
$bookname{'Judges'}='Judg\BRperiod ';
$bookname{'Ruth'}='Ruth';
$bookname{'ISamuel'}='\BRbooknumberstyleI Sam\BRperiod ';
$bookname{'IISamuel'}='\BRbooknumberstyleII Sam\BRperiod ';
$bookname{'IKings'}='\BRbooknumberstyleI Kgs\BRperiod ';
$bookname{'IIKings'}='\BRbooknumberstyleII Kgs\BRperiod ';
$bookname{'IChronicles'}='\BRbooknumberstyleI Chr\BRperiod ';
$bookname{'IIChronicles'}='\BRbooknumberstyleII Chr\BRperiod ';
$bookname{'Ezra'}='Ezra';
$bookname{'Nehemiah'}='Neh\BRperiod ';
$bookname{'Tobit'}='Tobit';
$bookname{'Judith'}='Judith';
$bookname{'Esther'}='Esther';
$bookname{'IMaccabees'}='\BRbooknumberstyleI M\BRperiod ';
$bookname{'IIMaccabees'}='\BRbooknumberstyleII M\BRperiod ';
$bookname{'Job'}='Job';
$bookname{'Psalms'}='Ps\BRperiod ';
$bookname{'Proverbs'}='Prov\BRperiod ';
$bookname{'Ecclesiastes'}='Eccles\BRperiod ';
$bookname{'SongofSongs'}='S\BRperiod \ of S\BRperiod ';
$bookname{'Wisdom'}='Wisd\BRperiod ';
$bookname{'Ecclesiasticus'}='Ecclus\BRperiod ';
$bookname{'Isaiah'}='Isa\BRperiod ';
$bookname{'Jeremiah'}='Jer\BRperiod ';
$bookname{'Lamentations'}='Lam\BRperiod ';
$bookname{'Baruch'}='Baruch';
$bookname{'Ezekiel'}='Ezek\BRperiod ';
$bookname{'Daniel'}='Dan\BRperiod ';
$bookname{'Hosea'}='Hos\BRperiod ';
$bookname{'Joel'}='Joel';
$bookname{'Amos'}='Amos';
$bookname{'Obadiah'}='Obad';
$bookname{'Jonah'}='Jonah';
$bookname{'Micah'}='Mic\BRperiod ';
$bookname{'Nahum'}='Nah\BRperiod ';
$bookname{'Habakkuk'}='Hab\BRperiod ';
$bookname{'Zephaniah'}='Zeph\BRperiod ';
$bookname{'Haggai'}='Hag\BRperiod ';
$bookname{'Zechariah'}='Zech\BRperiod ';
$bookname{'Malachi'}='Mal\BRperiod ';
$bookname{'Matthew'}='Matt\BRperiod ';
$bookname{'Mark'}='Mark';
$bookname{'Luke'}='Luke';
$bookname{'John'}='John';
$bookname{'Acts'}='Acts';
$bookname{'Romans'}='Rom\BRperiod ';
$bookname{'ICorinthians'}='\BRepistlenumberstyleI Cor\BRperiod ';
$bookname{'IICorinthians'}='\BRepistlenumberstyleII Cor\BRperiod ';
$bookname{'Galatians'}='Gal\BRperiod ';
$bookname{'Ephesians'}='Eph\BRperiod ';
$bookname{'Philippians'}='Phil\BRperiod ';
$bookname{'Colossians'}='Col\BRperiod ';
$bookname{'IThessalonians'}='\BRepistlenumberstyleI Thess\BRperiod ';
$bookname{'IIThessalonians'}='\BRepistlenumberstyleII Thess\BRperiod ';
$bookname{'ITimothy'}='\BRepistlenumberstyleI Tim\BRperiod ';
$bookname{'IITimothy'}='\BRepistlenumberstyleII Tim\BRperiod ';
$bookname{'Titus'}='Tit\BRperiod ';
$bookname{'Philemon'}='Philem\BRperiod ';
$bookname{'Hebrews'}='Heb\BRperiod ';
$bookname{'James'}='Jas\BRperiod ';
$bookname{'IPeter'}='\BRepistlenumberstyleI Pet\BRperiod ';
$bookname{'IIPeter'}='\BRepistlenumberstyleII Pet\BRperiod ';
$bookname{'IJohn'}='\BRepistlenumberstyleI John';
$bookname{'IIJohn'}='\BRepistlenumberstyleII John';
$bookname{'IIIJohn'}='\BRepistlenumberstyleIII John';
$bookname{'Jude'}='Jude';
$bookname{'Revelation'}='Rev\BRperiod ';
$_;
}

sub brs_default{
   local($tmp)='';
   &do_cmd_brfullname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   "$num " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   "$num " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ":" . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   \';\' . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
}

sub brs_jerusalem{
   local($tmp)='';
   &do_cmd_brabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   "$num " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   "$num " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ":" . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   \'; \' . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
}

sub brs_anglosaxon{
   local($tmp)='';
   &do_cmd_braltabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", &fRoman($num), $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", &fRoman($num), $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "." . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   \'; \' . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ".$_";';
   $tmp .= '}';
}

sub brs_JEH{
   local($tmp)='';
   &do_cmd_braltabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   &froman($num) . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", ".", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   \'; \' . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ".$_";';
   $tmp .= '}';
}

sub brs_MHRA{
   local($tmp)='';
   &do_cmd_brfullname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   $num = &froman($num);';
   $tmp .= '   $num = &translate_commands("\\\\textsc${OP}$id${CP}$num${OP}$id${CP}");';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   $num = &froman($num);';
   $tmp .= '   $num = &translate_commands("\\\\textsc${OP}$id${CP}$num${OP}$id${CP}");';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   &froman($num) . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", ".", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "; " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
}

sub brs_NTG{
   local($tmp)='';
   &do_cmd_braltabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   &froman($num) . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join("", ",", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "; " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
}

sub brs_MLA{
   local($tmp)='';
   &do_cmd_braltabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   &froman($num) . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join("", ".", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "; " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ".$_";';
   $tmp .= '}';
}

sub brs_chicago{
   local($tmp)='';
   &do_cmd_braltabbrvname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   join(" ", $num, $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   &froman($num) . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;\'\'/eo;';
   $tmp .= '   $num . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join("", ":", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "; " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   &translate_commands("--") . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   "," . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ".$_";';
   $tmp .= '}';
}

sub brs_long{
   local($tmp)='';
   &do_cmd_brfullname;

   $tmp .= 'sub do_cmd_BRbooknumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   "\\Ordinalstringnum$OP$id$CP$num$OP$id$CP " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistlenumberstyle{';
   $tmp .= '   local($_) = @_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '               s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   "\\Ordinalstringnum$OP$id$CP$num$OP$id$CP " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbookof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", "Book of",$_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRgospel{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", "Gospel according to St",$_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleto{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", "Epistle to",$_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistletothe{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", "Epistle to the", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRepistleof{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   join(" ", "Epistle of",$_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbooktitlestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($title);';
   $tmp .= '   $title = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$title=$2;\'\'/eo;';
   $tmp .= '   $title . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchapterstyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   join(" ", "chapter \\numberstring$OP$id$CP$num$OP$id$CP", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRversestyle{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   local($num,$id);';
   $tmp .= '   $num = &missing_braces unless';
   $tmp .= '              s/$next_pair_pr_rx/$num=$2;$id=$1;\'\'/eo;';
   $tmp .= '   join(" ", "chapter \\numberstring$OP$id$CP$num$OP$id$CP", $_);';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRbkchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ", " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " verse " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRchsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   \', \' . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvrsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   " to " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRvsep{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   ", " . $_;';
   $tmp .= '}';
   eval($tmp);
   $tmp='';
   $tmp .= 'sub do_cmd_BRperiod{';
   $tmp .= '   local($_)=@_;';
   $tmp .= '   $_;';
   $tmp .= '}';
}

sub do_bibleref_default{
   &brs_default;
}

sub do_bibleref_jerusalem{
   &brs_jerusalem;
}

sub do_bibleref_anglosaxon{
   &brs_anglosaxon;
}

sub do_bibleref_JEH{
   &brs_JEH;
}

sub do_bibleref_MHRA{
   &brs_MHRA;
}

sub do_bibleref_NTG{
   &brs_NTG;
}

sub do_bibleref_MLA{
   &brs_MLA;
}

sub do_bibleref_chicago{
   &brs_chicago;
}

sub do_bibleref_text{
   &brs_chicago;
}

sub do_cmd_newbiblerefstyle{
   local($_)=@_;
   local($style,$cmds);
   $style = &missing_braces unless
              s/$next_pair_pr_rx/$style=$2;''/eo;

   &write_warnings("\n\\newbiblerefstyle not implemented");

   $_;
}

sub do_cmd_setbooktitle{
   local($_)=@_;
   local($name,$title);

   $name = &missing_braces unless
              s/$next_pair_pr_rx/$name=$2;''/eo;
   $title = &missing_braces unless
              s/$next_pair_pr_rx/$title=$2;''/eo;

   if (defined $bookname{$name})
   {
      $bookname{$name}=$title;
   }
   else
   {
      &write_warnings("\nUnknown book '$name'");
   }

   $_;
}

sub do_cmd_biblerefstyle{
   local($_)=@_;
   local($style);
   $style = &missing_braces unless
               s/$next_pair_pr_rx/$style=$2;''/eo;

   if (defined "&brs_$style")
   {
      eval("&brs_$style");
   }
   else
   {
      &write_warnings("\nUnknown biblerefstyle '$style'");
   }
   $_;
}

sub do_cmd_bibleverse{
   local($_)=@_;
   local($book,$id);
   local($bibleverse)='';
   $book = &missing_braces unless
              s/$next_pair_pr_rx/$book=$2;$id=$1;''/eo;

   if (defined $bookname{$book} or defined $synonym{$book})
   {
      $book = $synonym{$book} unless defined $bookname{$book};

      $book = $bookname{$book};
      $book = "\\BRbooktitlestyle$OP$id$CP$book$OP$id$CP";
      $bibleverse .= $book;
      $first=1;

      while (s/^(-?)\(([^:]*):([^\)]*)\)//)
      {
         if ($1 eq '-')
         {
            $bibleverse .= "\\BRvrsep ";
         }
         else
         {
            $bibleverse .= ($first ? "\\BRbkchsep " : "\\BRchsep ");
         }
         $first=0;
         $id = ++$global{'max_id'};
         $bibleverse .= "\\BRchapterstyle$OP$id$CP$2$OP$id$CP" if ($2);
         $verses = $3;
         if ($verses)
         {
            $bibleverse .= "\\BRchvsep ";
            @verses = split /,/, $verses;

            for (my $i = 0; $i <=$#verses; $i++)
            {
               $verse = $verses[$i];

               $bibleverse .= "\\BRvsep " if ($i > 0);

               if ($verse=~m/(\d+)-(\d+)/)
               {
                  $id = ++$global{'max_id'};
                  $bibleverse .= "\\BRversestyle$OP$id$CP$1$OP$id$CP";
                  $bibleverse .= "\\BRvrsep ";
                  $id = ++$global{'max_id'};
                  $bibleverse .= "\\BRversestyle$OP$id$CP$2$OP$id$CP";
               }
               else
               {
                  $id = ++$global{'max_id'};
                  $bibleverse .= "\\BRversestyle$OP$id$CP$verse$OP$id$CP";
               }
            }
         }
      }

      $bibleverse = &translate_commands($bibleverse);
   }
   else
   {
      &write_warnings("\nUnknown book '$book'");
   }
   join('', $bibleverse, $_);
}

1;
