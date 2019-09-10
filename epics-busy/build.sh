#!/bin/bash

echo "INSTALL_LOCATION=${PREFIX}/epics/base" >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO" >> configure/CONFIG_SITE.local

python ${RECIPE_DIR}/../setup.py