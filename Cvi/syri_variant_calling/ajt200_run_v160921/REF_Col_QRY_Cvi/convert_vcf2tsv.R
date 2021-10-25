#!/applications/R/R-4.0.0/bin/Rscript

# Usage:
# ./convert_vcf2tsv.R TAIR10_chr_all_renamed_fa_headers Cvi.chr.all.v2.0_renamed_fa_headers LOF_NMD_AND_HIGH

#ref <- "TAIR10_chr_all_renamed_fa_headers"
#qry <- "Cvi.chr.all.v2.0_renamed_fa_headers"
#ann <- "LOF_NMD_AND_HIGH"

args <- commandArgs(trailingOnly = T)
ref <- args[1]
qry <- args[2]
ann <- args[3]

options(stringsAsFactors = F)
library(stringr)

vcf <- read.table(paste0(ref, "_", qry, "_syri_filt.SnpSift_interval_QTL1at45_", ann, ".vcf"),
                  header = T, skip = 37, comment.char = "", colClasses = "character")
colnames(vcf)[1] <- "CHROM"

#if(ann %in% c("LOF_AND_HIGH", "LOF_NMD_AND_HIGH")) {
#  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "=\\(AT\\dG[0-9]+"))
#  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "=\\("), "", unlist(geneIDs)))
#} else {
#  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "\\|AT\\dG[0-9]+"))
#  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "\\|"), "", unlist(geneIDs)))
#}
#print(geneIDs)
#print(length(geneIDs))

write.table(vcf,
            file = paste0(ref, "_", qry, "_syri_filt.SnpSift_interval_QTL1at45_", ann, ".tsv"),
            quote = F, sep = "\t", row.names = F, col.names = T)
