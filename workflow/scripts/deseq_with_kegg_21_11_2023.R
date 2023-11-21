
setwd("C:/Users/User/Documents/HACKATHON/scripts")

# ------------- Preprocess data
subreadCounts <- read.table("counts_nous.txt", header = TRUE, sep = '\t', row.names = 1)
new_colnames <- c("SRR10379721",
                  "SRR10379722",
                  "SRR10379723",
                  "SRR10379724",
                  "SRR10379725",
                  "SRR10379726")

# Change column names by accession number
colnames(subreadCounts)[(ncol(subreadCounts)-5):ncol(subreadCounts)] <- new_colnames

# Remove first 6 columns (chr, start, end, strand, length, name)
subreadCounts <- subreadCounts[,7:ncol(subreadCounts)]

# Convert to matrix
subreadCounts <- as.matrix(subreadCounts)

# Set up the condition vector
(condition <- factor(c(rep("exp", 3), rep("temoin", 3))))

kegg <- read.table("kegg.txt", header = FALSE, sep = "\t")

kegg <- kegg[,2]

kegg <- sub("sao:", "gene-", kegg)

subreadCounts <- subreadCounts[c(kegg),]

# ------------- Construct DESeq object

library(DESeq2)

(subreadData <- data.frame(row.names=colnames(subreadCounts), condition))
dataSet <- DESeqDataSetFromMatrix(countData = subreadCounts, colData = subreadData, design = ~ condition)






# analyse d'expression différentielle sur notre dds

dataSet <- DESeq(dataSet)

# formatage des résultats sous forme de DataFrame

resultats <- results(dataSet)

rld <- rlogTransformation(dataSet)

resultats$padj <- p.adjust(resultats$pvalue, method = "BH")

de_genes <- subset(resultats, padj < 0.05)

# exportation des résultats sous forme de MA-plot
# Open a PNG file
png("MA_plot.png")

plotMA(resultats, ylim = c(-6,6))

# Close the PNG file
dev.off()

png("PCA_plot.png")

plotPCA(rld, intgroup="condition")

dev.off()

library("EnhancedVolcano")
png("Volcano_plot.png")
EnhancedVolcano(resultats,lab = rownames(resultats), x = 'log2FoldChange', y = 'pvalue')
dev.off()