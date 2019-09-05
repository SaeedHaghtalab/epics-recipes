#!/bin/bash
# PKG_NAME=epics-seq

SEQ_PATH=$PREFIX/epics/seq
install -d $SEQ_PATH

echo "INSTALL_LOCATION=$SEQ_PATH" >> configure/CONFIG_SITE
sed -i "s|^EPICS_BASE=.*|EPICS_BASE=$PREFIX/epics/base|" configure/RELEASE

make -j${CPU_COUNT}

# # set up
# cat << EOF > $PREFIX/etc/conda/activate.d/$PKG_NAME.sh
# #!/bin/env bash
# export EPICS_SEQ=\$CONDA_PREFIX/$SEQ_PATH
# EOF

# # tear down
# cat << EOF > $PREFIX/etc/conda/deactivate.d/$PKG_NAME.sh
# #!/bin/env bash
# unset EPICS_SEQ
# EOF
