%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "psapm-l.cls",
%%%    version   = "1.2c",
%%%    date      = "1996/11/18",
%%%    time      = "12:27:50 EST",
%%%    checksum  = "32935 36 141 1357",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the AMS Proceedings
%%%                 of Symposia in Applied Mathematics.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{psapm-l}
              [1996/11/18 v1.2c PSAPM Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/25]

\def\publname{Proceedings of Symposia in Applied Mathematics}

\def\ISSN{0160-7634}

\endinput
