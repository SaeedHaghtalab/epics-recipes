#!/bin/bash

export CALC_PATH=$PREFIX/epics/calc
install -d $CALC_PATH

echo "INSTALL_LOCATION=$CALC_PATH"   >              configure/CONFIG_SITE.local
echo "EPICS_BASE=$PREFIX/epics/base" >              configure/RELEASE.local

sed -i "s|^SUPPORT|# SUPPORT|"                      configure/RELEASE
sed -i "s|^CHECK_RELEASE =.*|CHECK_RELEASE = NO|"   configure/CONFIG_SITE

sed -i "s|^SSCAN|# SSCAN|"                          configure/RELEASE

make -j${CPU_COUNT}
