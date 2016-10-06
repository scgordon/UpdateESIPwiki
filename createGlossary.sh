CrosswalkHome="/data/bedi/xml"
WikiContent="/data/bedi/scripts/updateBEDIwiki/wikiGlossary" 

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/ConceptGlossaryPaths.xsl \
-o:$WikiContent/Concept_Glossary_$1.txt \
dialect=$1 \
displayFormat=compressedTable \
