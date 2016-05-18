<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- modification des Header-->

  <xsl:template match="ns:soHeader"> 
    <xsl:element name="teiHeader"> 
      <xsl:apply-templates select="@* | node()"/> 
    </xsl:element> 
  </xsl:template>
  
  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>

  <xsl:template match="@role">
    <xsl:attribute name="role" select="'annotator'"/>
  </xsl:template>
  
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
		    <p>Any re-use of this resource should attribute its content to<q>#Termith-project_ANR-12-CORD-0029</q>
		    </p>
		</licence>
	</availability>
      </xsl:element>
      <xsl:element name="sourceDesc">
	<p>annotation générée automatiquement dans le cadre du projet TermITH</p>
      </xsl:element>
    </xsl:element>
    <xsl:apply-templates select="preceding-sibling::tei:encodingDesc" mode="desc"/>
  </xsl:template>
  
  <xsl:template match="*" mode="desc">
      <xsl:copy>
	<xsl:apply-templates select="@* | node()"/>
      <projectDesc>
	<p>Les annotations morphosyntaxiques s'appliquent au texte intégral du document <ref target="#termithIdentifier"/> et plus précisément au text/body et
	    text/back.</p>
	<p>Le texte est segmenté automatiquement en tokens par un module interne de
	    TermSuite2.0.</p>
	<p>L'étiquetage morphosyntaxique est réalisé par l'étiqueteur TreeTagger. Les jeux
	    d'étiquettes sont ensuite homogénéisé selon la norme MulText.</p>
	<p>Les sorties enrichies de TermSuite2.0 sont enfin projetées dans le texte
	    intégral.</p>
	<p>Les informations morphosyntaxiques sont représentées dans des structures de traits
	    (&lt;fs&gt;) qui contiennent deux traits pour le moment, l'un pour la forme
	    lemmatisée f/@name=&quot;lemma&quot; et l'autre pour l'étiquette grammaticale
	    f/@name=&quot;pos&quot;. Les valeurs de ces traits sont respectivement indiquées
	    dans un élément &lt;string/&gt; et &lt;symbol/&gt;</p>
            </projectDesc>
      </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
