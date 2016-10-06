#!/bin/bash
#
# This script creates wiki text for a single spiral.
# The output is a file with the name spiralCode.txt in the directory
# wikiSpirals.
#
cd wikiSpirals
WikiContent=$(pwd)
cd ../../Crosswalks
CrosswalkHome=$(pwd)



if [ $# != 0 ]; then

echo CrosswalkHome is $CrosswalkHome

for var in "$@";
do
echo spiralCode is "$var"
echo output is $OutputHome/wikiSpirals/"$var".txt

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/crosswalks.xsl \
displayFormat=compressedWiki \
spiralDisplayListString="$var" \
dialectDisplayListString=19110,ACDD,ADIwg,BDP,CSDGM,DCAT,DCITE,DIF,DIF-10,Dryad,ECHO,ECS,EML,HCLS,HDF5.1,ISO,ISO-1,MODS,Mercury,NUG,OGC-SOS,Onedcx,PROV,RDA-CISL,SERF,THREDDS,UMM,WSDL \
fileNamePattern=*.xml \
recordSetPath=$OutputHome \
> $WikiContent/"$var".txt
done
else
echo 'writeWikiSpiral spiralCode spiralCode SpiralCode'
fi
