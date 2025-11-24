%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "cmim-l.cls",
%%%    version   = "1.2b",
%%%    date      = "2001/06/14",
%%%    time      = "13:09:53 EDT",
%%%    checksum  = "56597 39 140 1487",
%%%    author    = "Barbara Beeton",
%%%    address   = "American Mathematical Society, PO Box 6248,
%%%                 Providence, RI 02940, USA",
%%%    email     = "tech-support@ams.org (Internet)",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for monographs in the
%%%                 Clay Mathematics Monographs series.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmim-l}
              [2001/06/14 v1.2b CMIM Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[1996/10/24]

\def\@mainsize{11}\def\@ptsize{1}
\def\@typesizes{%
  \or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}%
  \or{\@xipt}{13.5}% normalsize
  \or{\@xiipt}{14}\or{\@xivpt}{17}\or{\@xviipt}{20}%
  \or{\@xxpt}{24}\or{\@xxvpt}{30}}

\endinput
