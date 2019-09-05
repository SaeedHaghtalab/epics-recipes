#!/bin/bash

export SSCAN_PATH=$PREFIX/epics/sscan
install -d $SSCAN_PATH

echo "INSTALL_LOCATION=$SSCAN_PATH" >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO"           >> configure/CONFIG_SITE.local

echo "EPICS_BASE=$EPICS_PATH/base"  >> configure/RELEASE.local
echo "SNCSEQ=$EPICS_PATH/seq"       >> configure/RELEASE.local
echo "SUPPORT="                     >> configure/RELEASE.local

make -j${CPU_COUNT}
