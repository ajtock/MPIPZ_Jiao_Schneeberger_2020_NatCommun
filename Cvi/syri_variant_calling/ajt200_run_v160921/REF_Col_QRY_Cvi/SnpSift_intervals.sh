#!/bin/bash

# Run snpEff v5.0e on SyRi v1.5 output VCF file

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# csmit -m 100G -c 1 "bash ./SnpSift_intervals.sh TAIR10_chr_all_renamed_fa_headers Cvi.chr.all.v2.0_renamed_fa_headers"

REF=$1
QRY=$2

#source activate syri
#
#echo $(which SnpSift)

java -jar /home/ajt200/miniconda3/envs/syri/share/snpsift-4.3.1t-3/SnpSift.jar \
     intervals ${REF}_genes_QTL1at45_interval.bed \
     -i ${REF}_${QRY}_syri_filt.snpEff.vcf \
     > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf

head -n 38 ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf

grep "HIGH" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HIGH.vcf
grep "MODERATE" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_MODERATE.vcf
grep "LOW" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_LOW.vcf
grep "MODIFIER" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_MODIFIER.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_LOF_AND_HIGH.vcf
grep "NMD" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | grep "NMD" - | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_LOF_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_LOF_NOT_HIGH.vcf
grep "NMD" ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_NMD_NOT_HIGH.vcf

rm ${REF}_${QRY}_syri_filt.SnpSift_interval_QTL1at45_HEADER.vcf

#source deactivate
