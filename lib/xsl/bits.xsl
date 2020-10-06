<?xml version="1.0" encoding="UTF-8"?>

<!-- Input: texml output -->

<!-- Output: -//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN -->
<!-- (more or less) -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="nlm.xsl"/>

<xsl:output method="xml"
            encoding ="utf-8"
            doctype-public="-//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN"
            doctype-system="BITS-book1.dtd"/>

<xsl:template match="book">
    <book xmlns:xlink="http://www.w3.org/1999/xlink"
          xmlns:mml="http://www.w3.org/1998/Math/MathML"
          xmlns:xi="http://www.w3.org/2001/XInclude"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <xsl:copy-of select="front-matter/book-meta"/>
        <xsl:apply-templates/>
    </book>
</xsl:template>

<xsl:template match="front-matter/book-meta">
    <front-matter-part>
        <book-part-meta>
            <xsl:apply-templates/>
        </book-part-meta>
    </front-matter-part>
</xsl:template>

<xsl:template match="front-matter/book-meta/book-title-group">
    <title-group>
        <xsl:apply-templates/>
    </title-group>
</xsl:template>

<xsl:template match="front-matter/book-meta/book-title-group/book-title">
    <title>
        <xsl:apply-templates/>
    </title>
</xsl:template>

<xsl:template match="front-matter/preface/title"/>

<xsl:template match="front-matter/preface">
    <preface id="{@id}" disp-level="{@disp-level}">
        <book-part-meta>
            <title-group>
                <xsl:copy-of select="title"/>
            </title-group>
        </book-part-meta>
        <named-book-part-body>
            <xsl:apply-templates/>
        </named-book-part-body>
    </preface>
</xsl:template>

<xsl:template match="front-matter/sec">
    <front-matter-part id="{@id}" disp-level="{@disp-level}">
        <book-part-meta>
            <title-group>
                <xsl:copy-of select="title"/>
            </title-group>
        </book-part-meta>
        <named-book-part-body>
            <xsl:apply-templates/>
        </named-book-part-body>
    </front-matter-part>
</xsl:template>

<xsl:template match="front-matter/sec/title"/>

<xsl:template match="book-back/sec">
    <book-part id="{@id}" disp-level="{@disp-level}">
        <book-part-meta>
            <title-group>
                <xsl:copy-of select="title"/>
            </title-group>
        </book-part-meta>
        <body>
            <xsl:apply-templates/>
        </body>
    </book-part>
</xsl:template>

<xsl:template match="book-back/sec/title"/>

<xsl:template match="book-back/sec/ref-list">
    <sec>
        <ref-list>
            <xsl:apply-templates select="@*|node()"/>
        </ref-list>
    </sec>
</xsl:template>

</xsl:stylesheet>
