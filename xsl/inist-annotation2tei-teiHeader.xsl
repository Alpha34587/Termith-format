<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- modification des Header-->

  <xsl:template match="ns:soHeader"> 
    <xsl:element name="teiHeader"> 
      <xsl:apply-templates select="@* | node()"/> 
    </xsl:element> 
  </xsl:template>

  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>
  
  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
    <xsl:element name="fileDesc">
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
		    <p>Any re-use of this resource should attribute its content to<q>#Termith-project_ANR-12-CORD-0029</q>
		    </p>
		</licence>
	</availability>
      </xsl:element>
      <xsl:element name="sourceDesc">
	<p>annotation générée automatiquement dans le cadre du projet TermITH</p>
      </xsl:element>
    </xsl:element>
    <xsl:if test="preceding-sibling::tei:encodingDesc/*">
    <encodingDesc>
      <xsl:copy-of select="preceding-sibling::tei:encodingDesc/*"/>
    </encodingDesc>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:textDesc">
    <xsl:copy>
	<channel mode="w"/>
	<constitution type="composite"/>
	<derivation type="original"/>
	<xsl:copy-of select="tei:domain"/>
	<factuality type="inapplicable"/>
	<interaction type="inapplicable"/>
	<preparedness type="prepared"/>
	<purpose>La phase 1 porte sur l'évaluation de l'indexation proposée par différentes
	méthodes exploitant la notice bibliographique (partie "teiHeader")</purpose>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
