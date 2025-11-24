%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "cbmath-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/25",
%%%    time      = "15:40:19 EDT",
%%%    checksum  = "10623 36 139 1343",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the CBMS Issues
%%%                 in Mathematics Education series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cbmath-l}
              [1996/10/25 v1.2b CBMATH Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsproc}}
\ProcessOptions

\LoadClass{amsproc}[1996/10/24]

\def\publname{CBMS Issues in Mathematics Education}

\def\ISSN{1047-398X}

\endinput
