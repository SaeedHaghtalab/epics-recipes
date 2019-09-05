#!/bin/bash

export BUSY_PATH=$PREFIX/epics/busy
install -d $BUSY_PATH

echo "INSTALL_LOCATION=$BUSY_PATH"  >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO"           >> configure/CONFIG_SITE.local

echo "ASYN=$EPICS_PATH/asyn"        >> configure/RELEASE.local
echo "EPICS_BASE=$EPICS_PATH/base"  >> configure/RELEASE.local
echo "SUPPORT="                     >> configure/RELEASE.local
echo "AUTOSAVE="                    >> configure/RELEASE.local

make -j${CPU_COUNT}
