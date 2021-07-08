#!/bin/bash -x

cat << \EOF_TOOLFILE > ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml
    </client>
    <runtime name="CMSSW_DATA_PATH" value="$CMSSWDATA_BASE" type="path"/>
EOF_TOOLFILE

for toolbase in `echo ${CMSSWDATA_PKGREQUIRED} | tr ' ' '\n' | grep 'cms/data-'` ; do
  toolver=`basename $toolbase`
  pack=`echo $toolbase | cut -d/ -f2 | sed 's|data-||;s|-|/|'`
  echo "      <flags CMSSW_DATA_PACKAGE=\"$pack=$toolver\"/>" >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
  echo "    <runtime name=\"CMSSW_SEARCH_PATH\" default=\"\" type=\"path\"/>" >> ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml
done

cat ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
echo "  </tool>"      >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
rm -f ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml

