<?xml version="1.0" encoding="UTF-8"?>

<!--
    Copyright (C) 2022 American Mathematical Society

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
<!-- Common pices of -->
<!-- -//NLM//DTD JATS (Z39.96) Journal Publishing DTD v1.1d1 20130915//EN -->
<!-- -//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Peter doesn't want the <p> elements in this context.
     This introduces yet another incompatibility with JATS.
  -->

<!-- xsl:template match="def [local-name(node()[1]) = 'p'] 
                         [local-name(node()[1]/node()[1]) = 'def-list']">
    <def>
        <xsl:apply-templates select="node()[1]/node()[1]"/>
    </def>
</xsl:template -->

<!-- Support for cases.sty -->

<xsl:template match="texml_cases">
    <xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:template match="texml_cases/tr">
    <xsl:apply-templates select="td[position() = 3]"/>
    <xsl:apply-templates select="td[position() = 1]"/>
    <xsl:text>&amp;</xsl:text>
    <xsl:apply-templates select="td[position() = 2]"/>
    <xsl:text>\\</xsl:text>
</xsl:template>

<xsl:template match="texml_cases/tr/tag">
    <xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:template match="texml_cases/tr/td">
    <xsl:apply-templates select="node()"/>
    <!-- xsl:if test="following-sibling::td" -->
    <!-- xsl:if test="position() = 2">
        <xsl:text>&amp;</xsl:text>
    </xsl:if -->
</xsl:template>

<xsl:template match="cite-group">
    <xsl:apply-templates select="@*|node()"/>
</xsl:template>

<!-- With the exception of "verbatim" contexts like <raw-citation>, we
  need to surround inline math by <inline-formula> everywhere *except*
  inside another <tex-math> element.  We used to try to do that in
  TeX::Output::XML, but it is easier to generate the inline-formula
  tags everywhere and then eliminate the unwanted ones here.

  The exception for footnotes is for footnotes inside math.  Those are
  moved outside of the <inline-formula> later in the toolchain.
-->

<!-- xsl:template match="tex-math//inline-formula">
    <xsl:choose>
        <xsl:when test="ancestor::fn">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:when>

        <xsl:otherwise>
            <xsl:text>$</xsl:text>
            <xsl:apply-templates select="tex-math/node()"/>
            <xsl:text>$</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template -->

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
