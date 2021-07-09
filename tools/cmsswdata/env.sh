#!/bin/bash -x

cat << \EOF_TOOLFILE > ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
<tool name="cmsswdata" version="@TOOL_VERSION@">
  <client>
    <environment name="CMSSWDATA_BASE" default="@TOOL_ROOT@"/>
    <environment name="CMSSW_DATA_PATH" default="$CMSSWDATA_BASE"/>
EOF_TOOLFILE

cat << \EOF_TOOLFILE > ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml
    </client>
    <runtime name="CMSSW_DATA_PATH" value="$CMSSWDATA_BASE" type="path"/>
EOF_TOOLFILE

cmssw_s_path=$(echo $TOOL_ROOT | sed "s|/cms/cmsswdata.*||g")

for toolbase in `echo ${CMSSWDATA_PKGREQUIRED} | tr ' ' '\n' | grep 'cms/data-'` ; do
  toolver=`basename $toolbase`
  pack=`echo $toolbase | cut -d/ -f2 | sed 's|data-||;s|-|/|'`
  echo "      <flags CMSSW_DATA_PACKAGE=\"$pack=$toolver\"/>" >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
  echo "    <runtime name=\"CMSSW_SEARCH_PATH\" default=\"${cmssw_s_path}/${toolbase}\" type=\"path\"/>" >> ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml
done

cat ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
echo "  </tool>"      >> ${SCRAM_TOOL_SOURCE_DIR}/cmsswdata.xml
rm -f ${SCRAM_TOOL_SOURCE_DIR}/searchpath.xml
