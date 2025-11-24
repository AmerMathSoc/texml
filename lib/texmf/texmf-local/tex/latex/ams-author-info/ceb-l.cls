%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "ceb-l.cls",
%%%    version   = "2.02",
%%%    date      = "2007/08/28",
%%%    time      = "17:00:37 EDT",
%%%    checksum  = "17209 32 141 1341",
%%%    author    = "Publications Technical Group",
%%%    address   = "American Mathematical Society, 201 Charles Street,
%%%                 Providence, RI 02904-2294, USA",
%%%    email     = "tech-support@ams.org",
%%%    supported = "yes",
%%%    abstract  = "This is a LaTeX documentclass for the Current
%%%                 Events Bulletin distributed at Joint Mathematics
%%%                 Meetings by the American Mathematical Society.",
%%%    docstring = "The checksum field above contains a CRC-16 checksum
%%%                 as the first value, followed by the equivalent of
%%%                 the standard UNIX wc (word count) utility output
%%%                 of lines, words, and characters.  This is produced
%%%                 by Robert Solovay's checksum utility.",
%%% }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ceb-l}[2007/08/28 v2.02 Current Events Author Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions

\LoadClass{amsart}[1996/10/24]

\endinput
