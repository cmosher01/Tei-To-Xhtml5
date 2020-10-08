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
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
>
    <xsl:output method="xml" version="1.1" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="xhtml:div[@tei='TEI']">
        <xsl:element name="html" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'fontFeatures unicodeWebFonts solarizedLight'"/>
            </xsl:attribute>
            <xsl:element name="head" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="meta" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="charset">
                        <xsl:value-of select="'utf-8'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="rel">
                        <xsl:value-of select="'stylesheet'"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:value-of select="'text/css'"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="'style.css'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="title" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:value-of select="xhtml:div[@tei='teiHeader']/xhtml:div[@tei='fileDesc']/xhtml:div[@tei='titleStmt']/xhtml:cite[@tei='title']/text()" />
                </xsl:element>
            </xsl:element>
            <xsl:element name="body" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="header" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:element name="nav" namespace="http://www.w3.org/1999/xhtml">
                        (
                        <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
                            <xsl:attribute name="href">
                                <xsl:value-of select="'?tei=TRUE'"/>
                            </xsl:attribute>
                            view source
                        </xsl:element>
                        )
                    </xsl:element>
                </xsl:element>
                <xsl:element name="header" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates select="xhtml:div[@tei='teiHeader']/xhtml:div[@tei='fileDesc']/xhtml:div[@tei='sourceDesc']"/>
                </xsl:element>
                <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:element>
                <xsl:element name="footer" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:element name="hr" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">
                            <xsl:value-of select="'tei'"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">
                            <xsl:value-of select="'copyright'"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="xhtml:div[@tei='teiHeader']/xhtml:div[@tei='fileDesc']/xhtml:div[@tei='publicationStmt']/xhtml:span[@tei='availability']"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
