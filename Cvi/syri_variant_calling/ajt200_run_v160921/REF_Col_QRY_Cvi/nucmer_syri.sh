#!/bin/bash

# Pairwise align assemblies using nucmer v3.1 from the MUMmer4 toolbox with parameter setting “--maxmatch -l 40 -g 90 -c 100 -b 200"
# Filter resulting alignments for alignment length (>100) and identity (>90)
# Call structural rearrangements and local variations using SyRI v1.5 (https://github.com/schneebergerlab/syri).

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# csmit -m 50G -c 5 "bash ./nucmer_syri.sh TAIR10_chr_all_renamed_fa_headers Cvi.chr.all.v2.0_renamed_fa_headers"

REF=$1
QRY=$2

source activate syri

echo $(which nucmer)
echo $(nucmer --version)

nucmer --maxmatch -l 40 -g 90 -c 100 -b 200 ${REF}.fa ${QRY}.fa

mv out.delta ${REF}_${QRY}_out.delta

delta-filter -m -i 90 -l 100 ${REF}_${QRY}_out.delta > ${REF}_${QRY}_out_m_i90_l100.delta

show-coords -THrd ${REF}_${QRY}_out_m_i90_l100.delta > ${REF}_${QRY}_out_m_i90_l100.coords

/home/ajt200/envs_miniconda3/syri_1.5/syri/bin/syri -c ${REF}_${QRY}_out_m_i90_l100.coords \
                                                    -d ${REF}_${QRY}_out_m_i90_l100.delta \
                                                    -r ${REF}.fa -q ${QRY}.fa \
                                                    --prefix ${REF}_${QRY}_ \
                                                    --nc 5 --all -k

source deactivate
