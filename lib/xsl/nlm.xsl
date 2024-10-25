<?xml version="1.0" encoding="UTF-8"?>

<!--
    Copyright (C) 2022, 2024 American Mathematical Society

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

    For more details see, https://github.com/AmerMathSoc/texml

    This code is experimental and is provided completely without warranty
    or without any promise of support.  However, it is under active
    development and we welcome any comments you may have on it.

    American Mathematical Society
    Technical Support
    Publications Technical Group
    201 Charles Street
    Providence, RI 02904
    USA
    email: tech-support@ams.org
-->

<!-- http://jats.nlm.nih.gov/publishing/ -->
<!-- Common pieces of -->
<!-- -//NLM//DTD JATS (Z39.96) Journal Publishing DTD v1.1d1 20130915//EN -->
<!-- -//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Delete empty p tags.  Ideally texml wouldn't generate these, but
  getting rid of all of them could be tricky.
  Cf. TeX::Interpreter::__is_empty_par() -->

<!-- Question: Should we remove '@*'?  I.e., should we remove empty
  paragraphs even if they have attributes? Ditto comments. -->

<xsl:template match="p[not(@*|*|comment()|processing-instruction()) 
     and normalize-space()='']"/>

<!-- Default template: copy other content verbatim -->

<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
