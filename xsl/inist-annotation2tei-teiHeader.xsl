<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- traitement du teiHeader -->
  
  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>
  
  <xsl:template match="tei:q/text()[. = 'ANR-12-CORD-0029']">
    <xsl:value-of select="'the #Termith-project,ANR-12-CORD-0029'"/>
  </xsl:template>

  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
      <xsl:copy>
	<xsl:apply-templates select="@* | node()"/>
      </xsl:copy>

      <xsl:element name="publicationStmt">
	<distributor>INIST</distributor>
	<distributor>LINA</distributor>
	<idno type="termithIdentifier">linguistique_524-06-10299_tei_35.xml</idno>
	<availability>
		<licence target="http://creativecommons.org/licenses/by/4.0/">
		    <p>The Creative Commons Attribution 4.0 International License applies to this document.</p>
		    <p>Any re-use of this resource should attribute its content to<q>ANR-12-CORD-0029</q>
		    </p>
		</licence>
	</availability>
      </xsl:element>
      <xsl:element name="notesStmt">
	<note>annotation générée automatiquement dans le cadre du projet TermITH</note>
      </xsl:element>
    <xsl:if test="preceding-sibling::tei:encodingDesc/*">
    <encodingDesc>
      <xsl:copy-of select="preceding-sibling::tei:encodingDesc/*"/>
    </encodingDesc>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
