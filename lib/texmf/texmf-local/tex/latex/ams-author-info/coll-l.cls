%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "coll-l.cls",
%%%    version   = "1.2a",
%%%    date      = "1996/10/25",
%%%    time      = "17:10:58 EDT",
%%%    checksum  = "28935 29 130 1193",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the American
%%%                 Mathematical Society Colloquium Publications.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coll-l}
              [1996/10/30 v1.2b COLL Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
