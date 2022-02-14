<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!--
    Tei-To-Xhtml5

    Copyright © 2017–2021, by Christopher Alan Mosher, Shelton, Connecticut, USA, cmosher01@gmail.com .

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
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
>
    <xsl:output method="xml" version="1.1" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="xhtml:div[@tei='TEI']">
        <xsl:element name="html" namespace="http://www.w3.org/1999/xhtml">
            <xsl:element name="head" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="rel">
                        <xsl:value-of select="'stylesheet'"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="'/assets/styles/nu/mine/mosher/xml/tei.css'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="title" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:value-of select="xhtml:*[@tei='teiHeader']/xhtml:*[@tei='fileDesc']/xhtml:*[@tei='titleStmt']/xhtml:*[@tei='title']/text()" />
                </xsl:element>
                <xsl:element name="script" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="src">
                        <xsl:value-of select="'/assets/scripts/nu/mine/mosher/citation.js'"/>
                    </xsl:attribute>
                    <xsl:attribute name="defer">
                        <xsl:value-of select="'defer'"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body" namespace="http://www.w3.org/1999/xhtml">
                <xsl:element name="header" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates select="xhtml:*[@tei='teiHeader']/xhtml:*[@tei='fileDesc']/xhtml:*[@tei='sourceDesc']"/>
                    <xsl:element name="button" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="id">
                            <xsl:value-of select="'urn:uuid:2329b6e3-7951-40c0-9855-976a2f6baa94'"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:element>
                <xsl:element name="footer" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:element name="hr" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">
                            <xsl:value-of select="'tei tei-hr tei-verticalmargin'"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">
                            <xsl:value-of select="'tei tei-block'"/>
                        </xsl:attribute>
                        <xsl:apply-templates select="xhtml:*[@tei='teiHeader']/xhtml:*[@tei='fileDesc']/xhtml:*[@tei='publicationStmt']/xhtml:*[@tei='availability']"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
