#!/bin/bash

echo "INSTALL_LOCATION=$PREFIX/epics/${PKG_NAME#epics-}" >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO" >> configure/CONFIG_SITE.local

python ${RECIPE_DIR}/../setup.py
