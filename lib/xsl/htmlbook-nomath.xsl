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

<!-- Output: https://github.com/oreillymedia/HTMLBook -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
        xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="htmlbook.xsl"/>

<xsl:template match="book">
    <html xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.w3.org/1999/xhtml ../schema/htmlbook.xsd"
          xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title><xsl:apply-templates select="front-matter/book-meta/book-title-group/book-title"/></title>
            <link rel="stylesheet" href="epub.css" type="text/css"/>
            <meta name="content-type" http-equiv="content-type" content="text/html; charset=UTF-8"/>
        </head>
        <body data-type="book" class="book">
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="inline-formula">
</xsl:template>

<xsl:template match="disp-formula">
</xsl:template>

</xsl:stylesheet>
