<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="inline-formula[@content-type='math/tex'">
    <script type="math/tex">
        <xsl:apply-templates select="@*|node()"/>
    </script>
</xsl:template>

<xsl:template match="disp-formula[@content-type='math/tex'">
    <script type="math/tex; mode=display">
        <xsl:apply-templates select="@*|node()"/>
    </script>
</xsl:template>

<xsl:template match="italic">
    <em><xsl:apply-templates select="@*|node()"/></em>
</xsl:template>

<xsl:template match="monospace">
    <kbd><xsl:apply-templates select="@*|node()"/></kbd>
</xsl:template>

<xsl:template match="bold">
    <strong><xsl:apply-templates select="@*|node()"/></strong>
</xsl:template>

<xsl:template match="roman">
    <span style="font-style: normal""><xsl:apply-templates select="@*|node()"/></span>
</xsl:template>

<xsl:template match="sc">
    <span style="font-style: small-caps""><xsl:apply-templates select="@*|node()"/></span>
</xsl:template>

<xsl:template match="styled-content[@style-type='oblique']">
    <span style="font-style: oblique""><xsl:apply-templates select="@*|node()"/></span>
</xsl:template>

</xsl:stylesheet>
