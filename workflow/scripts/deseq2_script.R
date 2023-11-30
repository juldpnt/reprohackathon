
#install.packages("BiocManager")
#BiocManager::install("DESeq2")

# ------------- Preprocess data
countdata <- read.table("tmp/counts.txt", header = TRUE, sep = '\t', row.names = 1)
new_colnames <- c("SRR10379721",
            "SRR10379722",
            "SRR10379723",
            "SRR10379724",
            "SRR10379725",
            "SRR10379726")

# Change column names by accession number
colnames(countdata)[(ncol(countdata)-5):ncol(countdata)] <- new_colnames

# Remove first 6 columns (chr, start, end, strand, length, name)
countdata <- countdata[,7:ncol(countdata)]

# Convert to matrix
countdata <- as.matrix(countdata)
head(countdata)

# Set up the condition vector
(condition <- factor(c(rep("temoin", 3), rep("exp", 3))))

# ------------- Construct DESeq object

library(DESeq2)

(coldata <- data.frame(row.names=colnames(countdata), condition))
dds <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
dds <- DESeq(dds)

# ------------- Get results to make a MA plot

res <- results(dds)
head(res)

# ------------- Plot results with deseq2 and save (not working YET)
list.files()
# Open a PNG file
png("MA_plot.png")

# MA plot
plotMA(res, ylim=c(-2,2))

# Close the PNG file
dev.off()