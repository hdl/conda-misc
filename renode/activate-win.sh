# For MSYS / git bash on Windows (Cygwin isn't supported properly by Conda).
RENODE_BIN_DIR="$(cygpath.exe $CONDA_PREFIX)/Library/renode/exec"
export PATH="$RENODE_BIN_DIR:$PATH"
