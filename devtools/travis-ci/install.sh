# Temporarily change directory to $HOME to install software
pushd .
cd $HOME

# Install Miniconda. To upgrade desired version, update version number here
# as well as expected hash below
MINICONDA=Miniconda3-py38_4.9.2-Linux-x86_64.sh
MINICONDA_HOME=$HOME/miniconda
# Hash pulled from https://docs.conda.io/en/latest/miniconda_hashes.html
EXPECTED_SHA256=1314b90489f154602fd794accfc90446111514a5a72fe1f71ab83e07de9504a7
wget -q https://repo.anaconda.com/miniconda/$MINICONDA
if [[ $EXPECTED_SHA256 != $(sha256sum $MINICONDA | cut -d ' ' -f 1) ]]; then
    echo "Miniconda MD5 mismatch"
    exit 1
fi
bash $MINICONDA -b -p $MINICONDA_HOME

# Configure miniconda
export PIP_ARGS="-U"
export PATH=$MINICONDA_HOME/bin:$PATH
conda update --yes conda
conda install --yes conda-build jinja2 anaconda-client pip

# Restore original directory
popd
