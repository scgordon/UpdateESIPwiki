cd wikiGlossary
WikiContent=$(pwd)
cd ../../Crosswalks
CrosswalkHome=$(pwd)

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/ConceptGlossaryPaths.xsl \
-o:$WikiContent/Concepts_Glossary_$1.txt \
dialect=$1 \
displayFormat=compressedTable \
