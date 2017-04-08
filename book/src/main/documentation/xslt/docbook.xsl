<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:d="http://docbook.org/ns/docbook" exclude-result-prefixes="d" version="1.0">
    <xsl:import href="urn:docbkx:stylesheet" />
  <!--
    Important links:
    - http://www.sagehill.net/docbookxsl/
    - http://docbkx-tools.sourceforge.net/
    - http://www.sagehill.net/docbookxsl/PrintOutput.html
    - http://www.vogella.com/tutorials/DocBook/article.html
  -->
    <xsl:param name="chapter.autolabel">
        0
    </xsl:param>
    <xsl:param name="paper.type">
        A4
    </xsl:param>
    <xsl:param name="title.font.family">
        DejaVuSerif
    </xsl:param>
    <xsl:param name="body.start.indent">
        1mm
    </xsl:param>

    <!-- watermark image if draft -->
    <xsl:param name="draft.watermark.image">
        http://docbook.sourceforge.net/release/images/draft.png
    </xsl:param>

    <!-- add image attributes if not set -->
    <xsl:param name="default.image.width">16cm</xsl:param>
    <xsl:param name="default.image.scalefit">1</xsl:param>
    <xsl:param name="default.image.contentdepth">100%</xsl:param>

    <!-- center images -->
    <xsl:attribute-set name="informalfigure.properties">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="figure.properties">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- page breaks - TODO: use soft breaks http://www.sagehill.net/docbookxsl/PageBreaking.html#SoftPageBreaks -->
    <xsl:template match="processing-instruction('hard-pagebreak')">
        <fo:block break-after='page' />
    </xsl:template>

    <!-- section layout -->
    <xsl:attribute-set name="section.title.level1.properties">
        <xsl:attribute name="border-bottom">0.1mm solid black</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.8cm</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1cm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level2.properties">
        <xsl:attribute name="space-before.minimum">0.8cm</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1cm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2cm</xsl:attribute>
    </xsl:attribute-set>

    <!-- background programmlisting -->
    <xsl:param name="shade.verbatim" select="1" />
    <xsl:attribute-set name="shade.verbatim.style">
        <xsl:attribute name="background-color">#E0E0E0</xsl:attribute>
        <xsl:attribute name="border-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">#575757</xsl:attribute>
        <xsl:attribute name="padding">3pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- set fontsize in programmlisting -->
    <xsl:attribute-set name="monospace.verbatim.properties">
      <xsl:attribute name="font-size">
        <xsl:choose>
          <xsl:when test="processing-instruction('db-font-size')"><xsl:value-of
               select="processing-instruction('db-font-size')"/></xsl:when>
          <xsl:otherwise>65%</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:attribute-set>

    <!-- blue xlink color -->
    <xsl:attribute-set name="xref.properties">
        <xsl:attribute name="color">#0000FF</xsl:attribute>
    </xsl:attribute-set>

    <!-- header content -->
    <xsl:template name="header.content">
        <xsl:param name="pageclass" select="''" />
        <xsl:param name="sequence" select="''" />
        <xsl:param name="position" select="''" />
        <xsl:param name="gentext-key" select="''" />
        <fo:block>
        <!-- sequence can be odd, even, first, blank -->
        <!-- position can be left, center, right -->
            <xsl:choose>
                <xsl:when test="$sequence = 'odd' and $position = 'left'">
                    <fo:block>
                        <fo:inline>
                            Write great documents
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'odd' and $position = 'center'">
                </xsl:when>
                <xsl:when test="$sequence = 'odd' and $position = 'right'">
                    <fo:block>
                        <fo:inline>
                            <fo:external-graphic src="src/main/documentation/docbook/chapters/media/logo.png" content-height="6mm" />
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'even' and $position = 'left'">
                    <fo:block>
                        <fo:inline>
                            Write great documents
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'even' and $position = 'center'">
                </xsl:when>
                <xsl:when test="$sequence = 'even' and $position = 'right'">
                    <fo:block>
                        <fo:inline>
                            <fo:external-graphic src="src/main/documentation/docbook/chapters/media/logo.png" content-height="6mm" />
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'first' and $position = 'left'">
                    <fo:block>
                        <fo:inline>
                            Write great documents
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'first' and $position = 'center'">
                </xsl:when>
                <xsl:when test="$sequence = 'first' and $position = 'right'">
                    <fo:block>
                        <fo:inline>
                            <fo:external-graphic src="src/main/documentation/docbook/chapters/media/logo.png" content-height="6mm" />
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$sequence = 'blank' and $position = 'left'">
                    <fo:page-number />
                </xsl:when>
                <xsl:when test="$sequence = 'blank' and $position = 'center'">
                    <xsl:text>This page intentionally left blank</xsl:text>
                </xsl:when>
                <xsl:when test="$sequence = 'blank' and $position = 'right'">
                </xsl:when>
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <!-- render note, caution, warning, tip, important -->
    <xsl:template match="note" mode="admon.graphic.width">
        <xsl:text>24pt</xsl:text>
    </xsl:template>
    <xsl:template match="*" mode="admon.graphic.width">
        <xsl:text>32pt</xsl:text>
    </xsl:template>
    <xsl:template name="nongraphical.admonition">
        <xsl:variable name="id">
            <xsl:call-template name="object.id" />
        </xsl:variable>
        <fo:block space-before.minimum="0.8em" space-before.optimum="1em" space-before.maximum="1.2em" start-indent="0.25in" end-indent="0.25in" border-top="0.5pt solid black" border-bottom="0.5pt solid black" padding-top="4pt" padding-bottom="4pt" id="{$id}">
            <xsl:if test="$admon.textlabel != 0 or title">
                <fo:block keep-with-next='always' xsl:use-attribute-sets="admonition.title.properties">
                    <xsl:apply-templates select="." mode="object.title.markup" />
                </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="admonition.properties">
                <xsl:apply-templates />
            </fo:block>
        </fo:block>
    </xsl:template>

    <!-- table  cell spacing and cell padding-->
    <xsl:attribute-set name="table.cell.padding">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">4pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
