%%% ====================================================================
%%% @LaTeX-file{
%%%   filename  = "amsip-m-l.cls",
%%%   version   = "2.01",
%%%   date      = "2005/03/16",
%%%   time      = "09:54:50 EST",
%%%   checksum  = "07712 35 144 1408",
%%%   author    = "American Mathematical Society",
%%%   address   = "American Mathematical Society,
%%%                Technical Support,
%%%                Publications Technical Group,
%%%                201 Charles Street,
%%%                Providence, RI 02904,
%%%                USA",
%%%   email     = "tech-support@ams.org (Internet)",
%%%   supported = "yes",
%%%   abstract  = "This is a LaTeX documentclass for monographs in the
%%%                AMS/IP Studies in Advanced Mathematics series.",
%%%   docstring = "The checksum field above contains a CRC-16 checksum
%%%                as the first value, followed by the equivalent of
%%%                the standard UNIX wc (word count) utility output
%%%                of lines, words, and characters.  This is produced
%%%                by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{amsip-m-l}[2005/03/16 v2.01 AMSIP-M Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions

\LoadClass{amsbook}[2004/08/06]

\endinput
