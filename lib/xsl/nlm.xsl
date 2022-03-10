<?xml version="1.0" encoding="UTF-8"?>

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
