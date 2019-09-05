#!/bin/bash

MODULE_PATH=$PREFIX/epics/${PKG_NAME#epics-}
install -d $MODULE_PATH

echo "INSTALL_LOCATION=$MODULE_PATH"    >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO"               >> configure/CONFIG_SITE.local

echo "EPICS_BASE=$EPICS_PATH/base"      >> configure/RELEASE.local
echo "ASYN=$EPICS_PATH/asyn"            >> configure/RELEASE.local
echo "SNCSEQ=$EPICS_PATH/seq"           >> configure/RELEASE.local
echo "SUPPORT="                         >> configure/RELEASE.local

make -j${CPU_COUNT}
