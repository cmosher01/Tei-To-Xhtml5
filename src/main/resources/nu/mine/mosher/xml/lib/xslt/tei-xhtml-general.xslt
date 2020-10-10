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
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
>
    <xsl:output method="xml" version="1.1" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <!-- DEFAULT: TEI element ==> XHTML div -->
    <xsl:template match="tei:*">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="tei:isInline(.)">
                        <xsl:value-of select="'tei tei-inline'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'tei tei-block'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>



    <xsl:function name="tei:isInline" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:choose>
            <xsl:when test="empty($element)">true</xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="$element">
                    <xsl:choose>
                        <xsl:when test="self::tei:TEI">false</xsl:when>
                        <xsl:when test="self::tei:div">true</xsl:when>
                        <xsl:when test="parent::tei:titlePage">false</xsl:when>
                        <xsl:when test="parent::tei:body">false</xsl:when>
                        <xsl:when test="parent::tei:front">false</xsl:when>
                        <xsl:when test="parent::tei:back">false</xsl:when>
                        <xsl:when test="self::tei:body">false</xsl:when>
                        <xsl:when test="self::tei:front">false</xsl:when>
                        <xsl:when test="self::tei:back">false</xsl:when>
                        <xsl:when test="not(self::*)">true</xsl:when>
                        <xsl:when test="parent::tei:bibl/parent::tei:q">true</xsl:when>
                        <xsl:when test="fn:contains-token(@rend,'inline') and not(tei:p or tei:l)">true</xsl:when>
                        <xsl:when test="self::tei:note[@place='display']">false</xsl:when>
                        <xsl:when test="self::tei:note[@place='block']">false</xsl:when>
                        <xsl:when test="fn:contains-token(@rend,'display') or fn:contains-token(@rend,'block')">false</xsl:when>
                        <xsl:when test="@type='display' or @type='block'">false</xsl:when>
                        <xsl:when test="tei:table or tei:figure or tei:list or tei:lg    or tei:q/tei:l or tei:l or tei:p or tei:biblStruct or tei:sp or tei:floatingText">false</xsl:when>
                        <xsl:when test="self::tei:cit[not(@rend)]">true</xsl:when>
                        <xsl:when test="parent::tei:cit[fn:contains-token(@rend,'display')]">false</xsl:when>
                        <xsl:when test="parent::tei:cit and (tei:p or tei:l)">false</xsl:when>
                        <xsl:when test="self::tei:docAuthor and parent::tei:byline">true</xsl:when>
                        <xsl:when test="self::tei:note[tei:cit/tei:bibl]">false</xsl:when>
                        <xsl:when test="self::tei:note[parent::tei:biblStruct]">true</xsl:when>
                        <xsl:when test="self::tei:note[parent::tei:bibl]">true</xsl:when>
                        <xsl:when test="self::tei:note">true</xsl:when>
                        <xsl:when test="self::tei:abbr">true</xsl:when>
                        <xsl:when test="self::tei:affiliation">true</xsl:when>
                        <xsl:when test="self::tei:altIdentifier">true</xsl:when>
                        <xsl:when test="self::tei:analytic">true</xsl:when>
                        <xsl:when test="self::tei:add">true</xsl:when>
                        <xsl:when test="self::tei:am">true</xsl:when>
                        <xsl:when test="self::tei:author">true</xsl:when>
                        <xsl:when test="self::tei:bibl and not (tei:isInline(preceding-sibling::*[1]))">false</xsl:when>
                        <xsl:when test="self::tei:bibl and not (parent::tei:listBibl)">true</xsl:when>
                        <xsl:when test="self::tei:biblScope">true</xsl:when>
                        <xsl:when test="self::tei:byline">true</xsl:when>
                        <xsl:when test="self::tei:c">true</xsl:when>
                        <xsl:when test="self::tei:cl">true</xsl:when>
                        <xsl:when test="self::tei:choice">true</xsl:when>
                        <xsl:when test="self::tei:collection">true</xsl:when>
                        <xsl:when test="self::tei:country">true</xsl:when>
                        <xsl:when test="self::tei:damage">true</xsl:when>
                        <xsl:when test="self::tei:date">true</xsl:when>
                        <xsl:when test="self::tei:del">true</xsl:when>
                        <xsl:when test="self::tei:depth">true</xsl:when>
                        <xsl:when test="self::tei:dim">true</xsl:when>
                        <xsl:when test="self::tei:dimensions">true</xsl:when>
                        <xsl:when test="self::tei:editor">true</xsl:when>
                        <xsl:when test="self::tei:editionStmt">true</xsl:when>
                        <xsl:when test="self::tei:emph">true</xsl:when>
                        <xsl:when test="self::tei:ex">true</xsl:when>
                        <xsl:when test="self::tei:expan">true</xsl:when>
                        <xsl:when test="self::tei:figure[@place='inline']">true</xsl:when>
                        <xsl:when test="self::tei:figure">false</xsl:when>
                        <xsl:when test="self::tei:floatingText">false</xsl:when>
                        <xsl:when test="self::tei:foreign">true</xsl:when>
                        <xsl:when test="self::tei:forename">true</xsl:when>
                        <xsl:when test="self::tei:g">true</xsl:when>
                        <xsl:when test="self::tei:gap">true</xsl:when>
                        <xsl:when test="self::tei:genName">true</xsl:when>
                        <xsl:when test="self::tei:geogName">true</xsl:when>
                        <xsl:when test="self::tei:gloss">true</xsl:when>
                        <xsl:when test="self::tei:graphic">true</xsl:when>
                        <xsl:when test="self::tei:media">true</xsl:when>
                        <xsl:when test="self::tei:height">true</xsl:when>
                        <xsl:when test="self::tei:hi">true</xsl:when>
                        <xsl:when test="self::tei:idno">true</xsl:when>
                        <xsl:when test="self::tei:imprint">true</xsl:when>
                        <xsl:when test="self::tei:institution">true</xsl:when>
                        <xsl:when test="self::tei:label[not(parent::tei:list)]">true</xsl:when>
                        <xsl:when test="self::tei:locus">true</xsl:when>
                        <xsl:when test="self::tei:mentioned">true</xsl:when>
                        <xsl:when test="self::tei:metamark">true</xsl:when>
                        <xsl:when test="self::tei:mod">true</xsl:when>
                        <xsl:when test="self::tei:monogr">true</xsl:when>
                        <xsl:when test="self::tei:series">true</xsl:when>
                        <xsl:when test="self::tei:msName">true</xsl:when>
                        <xsl:when test="self::tei:name">true</xsl:when>
                        <xsl:when test="self::tei:num">true</xsl:when>
                        <xsl:when test="self::tei:orgName">true</xsl:when>
                        <xsl:when test="self::tei:orig">true</xsl:when>
                        <xsl:when test="self::tei:origDate">true</xsl:when>
                        <xsl:when test="self::tei:origPlace">true</xsl:when>
                        <xsl:when test="self::tei:pc">true</xsl:when>
                        <xsl:when test="self::tei:persName">true</xsl:when>
                        <xsl:when test="self::tei:phr">true</xsl:when>
                        <xsl:when test="self::tei:placeName">true</xsl:when>
                        <xsl:when test="self::tei:ptr">true</xsl:when>
                        <xsl:when test="self::tei:publisher">true</xsl:when>
                        <xsl:when test="self::tei:pubPlace">true</xsl:when>
                        <xsl:when test="self::tei:lb or self::tei:pb">true</xsl:when>
                        <xsl:when test="self::tei:quote and tei:lb">false</xsl:when>
                        <xsl:when test="self::tei:q">true</xsl:when>
                        <xsl:when test="self::tei:quote">true</xsl:when>
                        <xsl:when test="self::tei:ref">true</xsl:when>
                        <xsl:when test="self::tei:region">true</xsl:when>
                        <xsl:when test="self::tei:repository">true</xsl:when>
                        <xsl:when test="self::tei:roleName">true</xsl:when>
                        <xsl:when test="self::tei:rubric">true</xsl:when>
                        <xsl:when test="self::tei:rs">true</xsl:when>
                        <xsl:when test="self::tei:s">true</xsl:when>
                        <xsl:when test="self::tei:said">true</xsl:when>
                        <xsl:when test="self::tei:seg">true</xsl:when>
                        <xsl:when test="self::tei:sic">true</xsl:when>
                        <xsl:when test="self::tei:settlement">true</xsl:when>
                        <xsl:when test="self::tei:space">true</xsl:when>
                        <xsl:when test="self::tei:soCalled">true</xsl:when>
                        <xsl:when test="self::tei:subst">true</xsl:when>
                        <xsl:when test="self::tei:summary">true</xsl:when>
                        <xsl:when test="self::tei:supplied">true</xsl:when>
                        <xsl:when test="self::tei:surname">true</xsl:when>
                        <xsl:when test="self::tei:surplus">true</xsl:when>
                        <xsl:when test="self::tei:term">true</xsl:when>
                        <xsl:when test="self::tei:textLang">true</xsl:when>
                        <xsl:when test="self::tei:title">true</xsl:when>
                        <xsl:when test="self::tei:unclear">true</xsl:when>
                        <xsl:when test="self::tei:w">true</xsl:when>
                        <xsl:when test="self::tei:width">true</xsl:when>
                        <xsl:when test="empty($element/..)">false</xsl:when>
                        <xsl:when test="not(self::tei:p) and tei:isInline($element/..)">true</xsl:when>
                        <xsl:otherwise>false</xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>
