<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="@* | processing-instruction() | comment()">
	<xsl:copy/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
  </xsl:template>
  
  <xsl:template match="ns:soHeader">
    <xsl:element name="teiHeader">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:span/@corresp">
    <xsl:attribute name="corresp">
      <xsl:value-of select="replace(.,'-#',' #')"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="ns:annotations">
    <ns:listAnnotation>
      <annotationBlock>
	<xsl:apply-templates select="@* | node()"/>
      </annotationBlock>
    </ns:listAnnotation>
  </xsl:template>

  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>

  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
    <xsl:element name="fileDesc">

      <xsl:copy>
	<xsl:apply-templates select="@* | node()"/>
      </xsl:copy>

      <xsl:element name="publicationStmt">
	<distributor>ATILF (Analyse et Traitement Informatique de la Langue Française)</distributor>
	<idno type="termithIdentifier">linguistique_524-06-10299_tei_35.xml</idno>
	<availability>
		<licence target="http://creativecommons.org/licenses/by/4.0/">
		    <p>The Creative Commons Attribution 4.0 International License applies to this document.</p>
		    <p>Any re-use of this resource should attribute its content to<q>ANR-12-CORD-0029</q>
		    </p>
		</licence>
	</availability>
      </xsl:element>
      
    <xsl:copy-of select="/tei:TEI/tei:teiHeader//tei:sourceDesc"/>
    </xsl:element>
    <xsl:copy-of select="preceding-sibling::tei:encodingDesc"/>
  </xsl:template>

</xsl:stylesheet>
