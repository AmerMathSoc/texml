%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "gen-m-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1996/10/30",
%%%    time      = "21:59:43 EST",
%%%    checksum  = "04105 32 135 1281",
%%%    author    = "Michael Downes",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for a typical monograph
%%%                 series of the American Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gen-m-l}
              [1996/10/30 v1.2b GEN-M Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
