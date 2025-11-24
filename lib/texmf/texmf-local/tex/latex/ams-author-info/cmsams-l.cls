%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "cmsams-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/25",
%%%    time      = "16:48:24 EDT",
%%%    checksum  = "45397 37 138 1396",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the Conference
%%%                 Proceedings, Canadian Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmsams-l}
              [1996/10/25 v1.2b CMSAMS Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]

\def\publname{Canadian Mathematical Society\newline
              Conference Proceedings\hfil}

\def\ISSN{0731-1036}

\endinput
