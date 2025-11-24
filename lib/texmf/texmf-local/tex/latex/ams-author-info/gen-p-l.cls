%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "gen-p-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/25",
%%%    time      = "16:54:19 EDT",
%%%    checksum  = "61971 36 140 1357",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for a typical proceedings
%%%                 series of the American Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gen-p-l}
              [1996/01/25 v1.2b GEN-P Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]

\def\publname{Unspecified Book Proceedings Series}

\def\ISSN{????-????}

\endinput
