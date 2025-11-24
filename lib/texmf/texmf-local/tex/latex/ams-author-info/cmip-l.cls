%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "cmip-l.cls",
%%%    version   = "1.0b",
%%%    date      = "2001/04/19",
%%%    time      = "15:18:57 EDT",
%%%    checksum  = "40294 36 135 1321",
%%%    author    = "Barbara Beeton",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the Clay
%%%                 Mathematics Proceedings series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmip-l}
              [2001/04/19 v1.0b CMIP Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]

\def\publname{Clay Mathematics Proceedings}

\def\ISSN{1534-6455}

\endinput
