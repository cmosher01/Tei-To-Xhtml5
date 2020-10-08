<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!--
    Tei-To-Xhtml5

    Copyright © 2017–2020, by Christopher Alan Mosher, Shelton, Connecticut, USA, cmosher01@gmail.com .

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
-->
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:exsl="http://exslt.org/common"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
>
    <xsl:output method="xml" version="1.1" encoding="UTF-8"/>

    <xsl:template match="element()[@facs[starts-with(.,'#')]]" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@* except @facs"/>
            <xsl:apply-templates select="exsl:node-set(fn:element-with-id(fn:substring(@facs,2)))" mode="noID"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@xml:id" mode="noID"/>

    <xsl:template match="@*|node()" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:facsimile" mode="#all">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="tei">
                <xsl:value-of select="fn:local-name()"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-hidden'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
