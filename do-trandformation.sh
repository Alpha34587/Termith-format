#!/bin/bash
 
#extraction of annotation

saxonb-xslt -s:ExampleTermith-draft.xml -xsl:xsl/example-extraction.xsl -ext:on

#convert annotations to tei format

saxonb-xslt -s:samples/candidatsTermes.xml -xsl:xsl/atilf-annotation2tei-main.xsl -o:samples/candidatsTermes.tei

saxonb-xslt -s:samples/lexiqueTransdisciplinaire.xml -xsl:xsl/atilf-annotation2tei-main.xsl -o:samples/lexiqueTransdisciplinaire.tei

saxonb-xslt -s:samples/syntagmeDefinis.xml -xsl:xsl/atilf-annotation2tei-main.xsl -o:samples/syntagmeDefinis.tei

saxonb-xslt -s:samples/wordForms.xml -xsl:xsl/atilf-annotation2tei-main.xsl -o:samples/wordForms.tei

saxonb-xslt -s:samples/indexation-phase1.xml -xsl:xsl/inist-annotation2tei-main.xsl -o:samples/indexation-phase1.tei

saxonb-xslt -s:samples/indexation-phase2.xml -xsl:xsl/inist-annotation2tei-main.xsl -o:samples/indexation-phase2.tei

saxonb-xslt -s:samples/indexation-phase3.xml -xsl:xsl/inist-annotation2tei-main.xsl -o:samples/indexation-phase3.tei
  
saxonb-xslt -s:samples/indexation-phase4.xml -xsl:xsl/inist-annotation2tei-main.xsl -o:samples/indexation-phase4.tei

#merge of annotations

saxonb-xslt -xsl:xsl/fusion-annotation.xsl \
	    -s:ExampleTermith-draft.xml \
	    -o:ExampleTermith-draft.tei \
	    path="samples" \
	    annotationName="wordForms.tei candidatsTermes.tei syntagmeDefinis.tei lexiqueTransdisciplinaire.tei indexation-phase1.tei indexation-phase2.tei indexation-phase3.tei indexation-phase4.tei"
