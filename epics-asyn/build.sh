#!/bin/bash

MODULE_PATH=$PREFIX/epics/${PKG_NAME#epics-}
install -d $MODULE_PATH

echo "INSTALL_LOCATION=$MODULE_PATH" >> configure/CONFIG_SITE

sed -i "s|^EPICS_BASE=.*|EPICS_BASE=$PREFIX/epics/base|" configure/RELEASE
sed -i "s|^IPAC|# IPAC|"                                 configure/RELEASE
sed -i "s|^SNCSEQ|# SCSEQ|"                              configure/RELEASE

sed -i "s|^SUPPORT|# SUPPORT|"                      configure/RELEASE
sed -i "s|^CHECK_RELEASE =.*|CHECK_RELEASE = NO|"   configure/CONFIG_SITE

make -j${CPU_COUNT}
