
#install.packages("BiocManager")
#BiocManager::install("DESeq2")

# ------------- Preprocess data
countdata <- read.table("workflow/tmp/counts.txt", header = TRUE, sep = '\t', row.names = 1)
new_colnames <- c("SRR10379721",
            "SRR10379722",
            "SRR10379723",
            "SRR10379724",
            "SRR10379725",
            "SRR10379726")
colnames(countdata)[(ncol(countdata)-5):ncol(countdata)] <- new_colnames

# Remove first 6 columns (chr, start, end, strand, length, name)
countdata <- countdata[,7:ncol(countdata)]

head(countdata, 5)

(condition <- factor(c(rep("temoin", 3), rep("exp", 3))))
# ------------- Run DESeq2