%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "smf-l.cls",
%%%    version   = "1.2b",
%%%    date      = "1998/06/29",
%%%    time      = "14:33:40 EDT",
%%%    checksum  = "22685 33 133 1257",
%%%    author    = "Barbara Beeton",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                       Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the SMF/AMS Texts
%%%                 and Monographs book series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{smf-l}
              [1998/06/29 v1.2b SMF Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\endinput
