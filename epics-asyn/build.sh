#!/bin/bash

export ASYN_PATH=$PREFIX/epics/asyn
install -d $ASYN_PATH

echo "INSTALL_LOCATION=$ASYN_PATH" >> configure/CONFIG_SITE

sed -i "s|^EPICS_BASE=.*|EPICS_BASE=$PREFIX/epics/base|" configure/RELEASE
sed -i "s|^IPAC|# IPAC|"                                 configure/RELEASE
sed -i "s|^SNCSEQ|# SCSEQ|"                              configure/RELEASE

sed -i "s|^SUPPORT|# SUPPORT|"                      configure/RELEASE
sed -i "s|^CHECK_RELEASE =.*|CHECK_RELEASE = NO|"   configure/CONFIG_SITE

make -j${CPU_COUNT}
