#!/bin/bash -x

toolfolder=$1

cat << \EOF_TOOLFILE > ${toolfolder}/cmsswdata.xml
  <tool name="cmsswdata" version="%v">
    <client>
      <environment name="CMSSWDATA_BASE" default="@CMSSWDATA_ROOT@"/>
      <environment name="CMSSW_DATA_PATH" default="$CMSSWDATA_BASE"/>
EOF_TOOLFILE

cat << \EOF_TOOLFILE > ${toolfolder}/searchpath.xml
    </client>
    <runtime name="CMSSW_DATA_PATH" value="$CMSSWDATA_BASE" type="path"/>
EOF_TOOLFILE

echo $CMSSWDATA_PKGREQUIRED

for toolbase in `echo ${CMSSWDATA_PKGREQUIRED} | tr ' ' '\n' | grep 'cms/data-'` ; do
  toolver=`basename $toolbase`
  pack=`echo $toolbase | cut -d/ -f2 | sed 's|data-||;s|-|/|'`
  echo "      <flags CMSSW_DATA_PACKAGE=\"$pack=$toolver\"/>" >> ${toolfolder}/cmsswdata.xml
  echo "    <runtime name=\"CMSSW_SEARCH_PATH\" default=\"\" type=\"path\"/>" >> ${toolfolder}/searchpath.xml
done

cat ${toolfolder}/searchpath.xml >> ${toolfolder}/cmsswdata.xml
echo "  </tool>"      >> ${toolroot}/cmsswdata.xml
rm -f ${toolfolder}/searchpath.xml

