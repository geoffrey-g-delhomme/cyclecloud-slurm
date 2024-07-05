#!/usr/bin/env bash

if [ ! -d "/shared/cycelcloud/slurm-cluster/tools/miniconda3" ]; then
    echo "Install miniconda"
    mkdir -p /shared/cycelcloud/slurm-cluster/tools/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /shared/cycelcloud/slurm-cluster/tools/miniconda.sh
    sh /shared/cycelcloud/slurm-cluster/tools/miniconda.sh -b -u -p /shared/cycelcloud/slurm-cluster/tools/miniconda3
    rm -rf /shared/cycelcloud/slurm-cluster/tools/miniconda.sh
fi

mkdir -p /shared/cycelcloud/slurm-cluster/modulefiles

if [ ! -f "/shared/cycelcloud/slurm-cluster/modulefiles/conda" ]; then
    echo "Add conda module"
    cat > /shared/cycelcloud/slurm-cluster/modulefiles/conda <<EOF
#%Module 1.0

proc ModulesHelp { } {
    puts stderr "\tThis module allows to declare conda from miniconda.\"
}

module-whatis "This module allows to declare conda from miniconda."

append-path PATH /shared/cycelcloud/slurm-cluster/tools/miniconda3/bin
conflict conda
EOF
fi

sudo apt -y install environment-modules

cat > /shared/cycelcloud/slurm-cluster/.bashrc <<EOF
source /etc/profile.d/modules.sh
module use /shared/cycelcloud/slurm-cluster/modulefiles
module load conda
EOF
chmod a+x /shared/cycelcloud/slurm-cluster/.bashrc

cat >> /etc/bash.bashrc <<EOF
source /shared/cycelcloud/slurm-cluster/.bashrc
EOF
