#!/bin/bash

MODULE_PATH=$PREFIX/epics/${PKG_NAME#epics-}
install -d $MODULE_PATH

set -a
source ${RECIPE_DIR}/CONFIG_SITE
set +a


sed -i "s|^CHECK_RELEASE =.*|CHECK_RELEASE = NO|"               configure/CONFIG_SITE
sed -i "s|^#INSTALL_LOCATION=.*|INSTALL_LOCATION=$MODULE_PATH|" configure/CONFIG_SITE

echo "EPICS_BASE="EPICS_BASE=$EPICS_PATH/base"  >> configure/RELEASE.local

make -j${CPU_COUNT}
