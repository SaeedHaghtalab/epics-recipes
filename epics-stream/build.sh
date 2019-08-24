#!/bin/bash

export STREAM_PATH=$PREFIX/epics/stream
install -d $STREAM_PATH

sed -i "s|^PCRE=|# PCRE=|" configure/RELEASE

echo "INSTALL_LOCATION_APP=$STREAM_PATH"    >> configure/RELEASE
echo "EPICS_BASE=$PREFIX/epics/base"        >> configure/RELEASE
echo "ASYN=$PREFIX/epics/asyn"              >> configure/RELEASE
echo "CALC=$PREFIX/epics/calc"              >> configure/RELEASE
echo "PCRE_INCLUDE=$PREFIX/include"         >> configure/RELEASE
echo "PCRE_LIB=$PREFIX/lib"                 >> configure/RELEASE

make -j${CPU_COUNT}
