%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "dimacs-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/25",
%%%    time      = "17:01:17 EDT",
%%%    checksum  = "27176 37 146 1426",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the DIMACS Series in
%%%                 Discrete Mathematics and Theoretical Computer Science.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dimacs-l}
              [1996/10/24 v1.2b DIMACS Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]

\def\publname{DIMACS Series in Discrete Mathematics\newline
              and Theoretical Computer Science}

\def\ISSN{1052-1798}

\endinput
