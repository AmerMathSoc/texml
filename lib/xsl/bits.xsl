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

<!-- Input: texml output -->

<!-- Output: -//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN -->
<!-- (more or less) -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml"
            encoding ="utf-8"
            doctype-public="-//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN"
            doctype-system="BITS-book1.dtd"/>

<xsl:template match="book">
    <book xmlns:xlink="http://www.w3.org/1999/xlink">
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

<!-- Default template: copy other content verbatim -->

<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
