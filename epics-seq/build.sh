#!/bin/bash

MODULE_PATH=$PREFIX/epics/${PKG_NAME#epics-}
install -d $MODULE_PATH

echo "INSTALL_LOCATION=$MODULE_PATH" >> configure/CONFIG_SITE
sed -i "s|^EPICS_BASE=.*|EPICS_BASE=$PREFIX/epics/base|" configure/RELEASE

make -j${CPU_COUNT}
