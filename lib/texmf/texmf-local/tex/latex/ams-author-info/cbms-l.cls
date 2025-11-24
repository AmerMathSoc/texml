%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "cbms-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/30",
%%%    time      = "22:00:55 EST",
%%%    checksum  = "06339 32 133 1265",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the CBMS Regional
%%%                 Conference Series in Mathematics.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cbms-l}
              [1995/10/30 v1.2b CBMS Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
