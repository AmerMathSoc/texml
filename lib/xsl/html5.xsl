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
