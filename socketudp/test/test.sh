#!/bin/bash
source /disk2/miniconda3/etc/profile.d/conda.sh
conda activate base
echo "which python3 in shell script "
which python3
python3 test.py
