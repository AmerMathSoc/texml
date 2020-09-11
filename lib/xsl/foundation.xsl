<?xml version="1.0" encoding="UTF-8"?>

<!-- https://github.com/oreillymedia/HTMLBook -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml">

<xsl:output method="html" doctype-public=""/>

<xsl:template match="xhtml:body">
    <article xmlns="http://www.w3.org/1999/xhtml" itemscope="" itemtype="http://schema.org/ScholarlyArticle">
        <xsl:apply-templates select="@*|node()"/>
    </article>
</xsl:template>

<xsl:template match="xhtml:p[@class='author']">
    <p itemscope="" itemtype="http://schema.org/Person" itemprop="author">
        <span itemprop="name"><xsl:apply-templates select="@*|node()"/></span>
    </p>
</xsl:template>

<xsl:template match="xhtml:section[@class='titlepage']/xhtml:h1">
    <h1 xmlns="http://www.w3.org/1999/xhtml" class="title" itemprop="name"><xsl:apply-templates select="@*|node()"/></h1>
</xsl:template>

<xsl:template match="xhtml:section[@class='titlepage']/xhtml:p[@class='author']">
    <p itemscope="" itemprop="author" itemtype="http://schema.org/Person">
        <xsl:apply-templates select="@*|node()"/>
    </p>
</xsl:template>

<xsl:template match="xhtml:section[@class='titlepage']/xhtml:p[@class='affiliation']">
    <p itemscope="" itemprop="affiliation">
        <xsl:apply-templates select="@*|node()"/>
    </p>
</xsl:template>

<xsl:template match="xhtml:section[@class='titlepage']/xhtml:p[@class='email']">
    <p itemscope="" itemprop="email">
        <xsl:apply-templates select="@*|node()"/>
    </p>
</xsl:template>

<xsl:template match="xhtml:h1|xhtml:h2|xhtml:h3|xhtml:h4|xhtml:h5|xhtml:h6">
    <header>
        <xsl:copy select=".">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </header>
</xsl:template>

<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
