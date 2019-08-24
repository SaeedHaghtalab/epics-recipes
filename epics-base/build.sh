#!/bin/bash

BASE_PATH=epics/base
EPICS_BASE="$PREFIX/$BASE_PATH"
EPICS_HOST_ARCH="$(startup/EpicsHostArch)"

install -d $EPICS_BASE
install -d $PREFIX/bin
install -d $PREFIX/lib

echo "INSTALL_LOCATION=${EPICS_BASE}" >> configure/CONFIG_SITE.local

# EPICS assumes gcc suit has /usr/bin prefix.
# If non-system gcc is used, e.g. rh-devtoolset,
# find out its location /opt/rh/devtoolset-2/root/usr/bin.
# GNG_DIR has "bin" stripped.
GNU_DIR=$(dirname $(dirname $(which gcc)))
if [ "$GNU_DIR" != "/usr" ]; then
    echo "GNU_DIR="$GNU_DIR >> configure/CONFIG_COMMON
fi

make -j${CPU_COUNT}

# link epics bin and lib to environment
ln -s ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}/*       ${PREFIX}/bin
ln -s ${EPICS_BASE}/lib/${EPICS_HOST_ARCH}/lib*so* ${PREFIX}/lib

# deal with env export
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d

ACTIVATE=$PREFIX/etc/conda/activate.d/epics_base.sh
DEACTIVATE=$PREFIX/etc/conda/deactivate.d/epics_base.sh

# set up
cat << EOF > $ACTIVATE
#!/bin/env bash
export EPICS_BASE=\$CONDA_PREFIX/$BASE_PATH
export EPICS_HOST_ARCH=$EPICS_HOST_ARCH
EOF

# tear down
cat << EOF > $DEACTIVATE
#!/bin/env bash
unset EPICS_BASE
unset EPICS_HOST_ARCH
EOF

# clean up after self
unset ACTIVATE
unset DEACTIVATE
