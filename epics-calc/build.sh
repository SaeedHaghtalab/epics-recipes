#!/bin/bash

echo "INSTALL_LOCATION=$PREFIX/epics/${PKG_NAME#epics-}" > configure/CONFIG_SITE.local
sed -i "s|^CHECK_RELEASE =.*|CHECK_RELEASE = NO|" configure/CONFIG_SITE

python ${RECIPE_DIR}/../setup.py
