%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "mmono-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/30",
%%%    time      = "21:56:39 EST",
%%%    checksum  = "44332 32 133 1272",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the AMS Translations
%%%                 of Mathematical Monographs series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmono-l}
              [1996/10/30 v1.2b MMONO Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
