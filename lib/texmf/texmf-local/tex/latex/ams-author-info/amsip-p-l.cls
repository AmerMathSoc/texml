%%% ====================================================================
%%% @LaTeX-file{
%%%   filename  = "amsip-p-l.cls",
%%%   version   = "2.01",
%%%   date      = "2005/03/21",
%%%   time      = "14:11:25 EST",
%%%   checksum  = "10658 42 158 1600",
%%%   author    = "American Mathematical Society",
%%%   address   = "American Mathematical Society,
%%%                Technical Support,
%%%                Publications Technical Group,
%%%                201 Charles Street,
%%%                Providence, RI 02904,
%%%                USA",
%%%   email     = "tech-support@ams.org (Internet)",
%%%   supported = "yes",
%%%   abstract  = "This is a LaTeX documentclass for proceedings volumes
%%%                in the AMS/IP Studies in Advanced Mathematics series.",
%%%   docstring = "The checksum field above contains a CRC-16 checksum
%%%                as the first value, followed by the equivalent of
%%%                the standard UNIX wc (word count) utility output
%%%                of lines, words, and characters.  This is produced
%%%                by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{amsip-p-l}[2005/03/21 v2.01 AMSIP-P Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[2004/08/06]

\def\publname{AMS/IP Studies in Advanced Mathematics}

\def\cAMSIP{American Mathematical Society and International Press}
\copyrightinfo{\number\year}{\cAMSIP}

\def\ISSN{1089-3288}

\endinput
