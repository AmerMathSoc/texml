%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "surv-l.cls",
%%%    version   = "1.2a",
%%%    date      = "1996/10/25",
%%%    time      = "17:12:09 EDT",
%%%    checksum  = "11884 29 132 1191",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the AMS Mathematical
%%%                 Surveys and Monographs book series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{surv-l}
              [1996/10/30 v1.2b SURV Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
