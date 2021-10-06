#!/applications/R/R-4.0.0/bin/Rscript

# Usage:
# ./extract_SnpSift_ann_genes.R Cvi.chr.all.v2.0_renamed_fa_headers TAIR10_chr_all_renamed_fa_headers HIGH

#ref <- "TAIR10_chr_all_renamed_fa_headers"
#qry <- "Cvi.chr.all.v2.0_renamed_fa_headers"
#ann <- "HIGH"

args <- commandArgs(trailingOnly = T)
ref <- args[1]
qry <- args[2]
ann <- args[3]

library(stringr)

vcf <- read.table(paste0(ref, "_", qry, "_syri_filt.SnpSift_intervals_", ann, ".vcf"),
                  header = T, skip = 37, comment.char = "")

if(ann %in% c("LOF_AND_HIGH")) {
  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "=\\(ATCVI-\\dG[0-9]+"))
  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "=\\("), "", unlist(geneIDs)))
} else {
  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "\\|ATCVI-\\dG[0-9]+"))
  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "\\|"), "", unlist(geneIDs)))
}
print(geneIDs)
print(length(geneIDs))

