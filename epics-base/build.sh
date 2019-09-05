#!/bin/bash

EPICS_BASE="$PREFIX/epics/base"
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

# Make with full power!
make -j${CPU_COUNT}

# Link epics/bin and lib to environment bin so they are in $PATH now.
ln -sv ${EPICS_BASE}/lib/${EPICS_HOST_ARCH}/lib*so* ${PREFIX}/lib
# Perl files use relative path that results in error if they are not
# called from right location.
# For now, just link files without extenstion until we find better solution.
for f in $(ls --ignore='*.pl' ${EPICS_BASE}/bin/${EPICS_HOST_ARCH})
do
    ln -sv ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}/$f ${PREFIX}/bin
done

# Deal with environment exports
ACTIVATE_D=$PREFIX/etc/conda/activate.d
DEACTIVATE_D=$PREFIX/etc/conda/deactivate.d

mkdir -p $ACTIVATE_D
mkdir -p $DEACTIVATE_D

# set up
cat << EOF > $ACTIVATE_D/epics-base.sh
#!/bin/env bash
export EPICS_PATH=\$CONDA_PREFIX/epics
export EPICS_BASE=\$EPICS_PATH/base
export EPICS_HOST_ARCH=$EPICS_HOST_ARCH
EOF

# tear down
cat << EOF > $DEACTIVATE_D/epics-base.sh
#!/bin/env bash
unset EPICS_PATH
unset EPICS_BASE
unset EPICS_HOST_ARCH
EOF
