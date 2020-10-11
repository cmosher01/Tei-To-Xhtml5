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
    xmlns:tei="http://www.tei-c.org/ns/1.0"
>
    <xsl:output method="xml" version="1.1" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <!-- remove xml-model processing instructions, because this will no longer be TEI -->
    <xsl:template match="processing-instruction('xml-model')"/>

    <!-- TEI head ==> HTML header -->
    <xsl:template match="tei:head">
        <xsl:element name="header" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI title ==> HTML cite -->
    <xsl:template match="tei:title">
        <xsl:element name="cite" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:title[@level = 'a' or @level = 'u']">
        <xsl:element name="cite" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline tei-nofontstyle'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI ref target=url ==> HTML a href=url -->
    <xsl:template match="tei:ref[@target]">
        <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*[name(.)!='target']"/>
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <!-- if empty content, add target as text -->
            <xsl:choose>
                <xsl:when test="node()">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@target"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- TEI lb ==> HTML br -->
    <xsl:template match="tei:lb">
        <xsl:element name="br" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI pb ==> HTML hr & "beginning of page" -->
    <xsl:template match="tei:pb">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-block'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="hr" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">
                    <xsl:value-of select="'tei tei-block tei-hr tei-verticalmargin'"/>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">
                    <xsl:value-of select="'tei tei-block tei-verticalmargin'"/>
                </xsl:attribute>
                <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="class">
                        <xsl:value-of select="'tei tei-inline tei-editorial'"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="@n">
                            <xsl:value-of select="fn:concat('beginning of page: ',@n)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'beginning of page'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="@type">
                        <xsl:value-of select="fn:concat(' (',@type,')')"/>
                    </xsl:if>
                </xsl:element>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- TEI list/head+item ==> HTML dl/dt+dd -->
    <xsl:template match="tei:list">
        <xsl:element name="dl" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-block'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates mode="list"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:head" mode="list">
        <xsl:element name="dt" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-block'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:item" mode="list">
        <xsl:element name="dd" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-block'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- TEI table/row/cell ==> HTML table/tr/td -->
    <xsl:template match="tei:table">
        <xsl:element name="table" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates mode="table"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row" mode="table">
        <xsl:element name="tr" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates mode="table_row"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell" mode="table_row">
        <xsl:element name="td" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- TEI fw type=x ==> HTML title=x -->
    <xsl:template match="tei:fw[@type]">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI date when=x ==> HTML title=x -->
    <xsl:template match="tei:date[@when]">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="fn:concat('date: ',@when)"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI date when-custom=c datingMethod=m ==> HTML title=c(m) -->
    <xsl:template match="tei:date[@when-custom]">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="fn:concat('date: ',@when-custom,' (',@datingMethod,')')"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI ref=url ==> HTML a href=url -->
    <xsl:template match="*[@ref]">
        <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">
                    <xsl:value-of select="'tei tei-inline'"/>
                </xsl:attribute>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- TEI choice t=x ==> HTML title=x -->
    <xsl:template match="tei:choice[tei:expan|tei:reg|tei:corr]">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="fn:distinct-values((tei:expan,tei:reg,tei:corr))"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:expan|tei:reg|tei:corr">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei'"/>
            </xsl:attribute>
            <xsl:attribute name="hidden">
                <xsl:value-of select="'hidden'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI supplied ==> HTML tei-editorial title -->
    <xsl:template match="tei:supplied">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline tei-editorial'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="fn:local-name()"/>
                <xsl:if test="@* except @tei">
                    <xsl:value-of select="': '"/>
                    <xsl:for-each select="@* except @tei">
                        <xsl:value-of select="fn:concat(fn:local-name(),'=',.,' ')"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI del -->
    <xsl:template match="tei:del">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline tei-del'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- TEI gap/unclear ==> HTML tei-editorial title -->
    <xsl:template match="tei:gap | tei:unclear">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="fn:local-name()"/>
                <xsl:if test="@* except @tei">
                    <xsl:value-of select="': '"/>
                    <xsl:for-each select="@* except @tei">
                        <xsl:value-of select="fn:concat(fn:local-name(),'=',.,' ')"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:if test="fn:not(node())">
                <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
                    <xsl:attribute name="class">
                        <xsl:value-of select="'tei tei-inline tei-editorial'"/>
                    </xsl:attribute>
                    <xsl:value-of select="'…'"/>
                </xsl:element>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <!-- TEI graphic ==> HTML img -->
    <xsl:template match="tei:graphic">
        <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei tei-inline'"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:element name="img" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">
                    <xsl:value-of select="'tei tei-inline tei-limsize'"/>
                </xsl:attribute>
                <xsl:attribute name="src">
                    <xsl:value-of select="@url"/>
                </xsl:attribute>
                <xsl:apply-templates select="@*"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>



    <xsl:template match="tei:teiHeader">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:value-of select="'tei'"/>
            </xsl:attribute>
            <xsl:attribute name="hidden">
                <xsl:value-of select="'hidden'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
