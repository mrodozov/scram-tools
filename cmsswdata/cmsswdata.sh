#!/bin/bash -x

cat << \EOF_TOOLFILE > ${TOOLFILES_INSTALL_DIR}/searchpath.xml
    </client>
    <runtime name="CMSSW_DATA_PATH" value="$CMSSWDATA_BASE" type="path"/>
EOF_TOOLFILE

for toolbase in `echo ${CMSSWDATA_PKGREQUIRED} | tr ' ' '\n' | grep 'cms/data-'` ; do
  toolver=`basename $toolbase`
  pack=`echo $toolbase | cut -d/ -f2 | sed 's|data-||;s|-|/|'`
  echo "      <flags CMSSW_DATA_PACKAGE=\"$pack=$toolver\"/>" >> ${TOOLFILES_INSTALL_DIR}/cmsswdata.xml
  echo "    <runtime name=\"CMSSW_SEARCH_PATH\" default=\"\" type=\"path\"/>" >> ${TOOLFILES_INSTALL_DIR}/searchpath.xml
done

cat ${TOOLFILES_INSTALL_DIR}/searchpath.xml >> ${TOOLFILES_INSTALL_DIR}/cmsswdata.xml
echo "  </tool>"      >> ${toolroot}/cmsswdata.xml
rm -f ${TOOLFILES_INSTALL_DIR}/searchpath.xml

