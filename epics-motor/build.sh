#!/bin/bash

export MOTOR_PATH=$PREFIX/epics/motor
install -d $MOTOR_PATH

echo "INSTALL_LOCATION=$MOTOR_PATH" >> configure/CONFIG_SITE.local
echo "CHECK_RELEASE = NO"           >> configure/CONFIG_SITE.local

echo "EPICS_BASE=$EPICS_PATH/base"  >> configure/RELEASE.local
echo "ASYN=$EPICS_PATH/asyn"        >> configure/RELEASE.local
echo "SNCSEQ=$EPICS_PATH/seq"       >> configure/RELEASE.local
echo "BUSY=$EPICS_PATH/busy"        >> configure/RELEASE.local
echo "SUPPORT="                     >> configure/RELEASE.local

make -j${CPU_COUNT}
