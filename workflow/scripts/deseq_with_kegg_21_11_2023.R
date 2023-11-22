setwd("C:/Users/User/Documents/HACKATHON/scripts")

# Importing the count matrix
subreadCounts <- read.table("/counts.txt", header = TRUE, sep = '\t', row.names = 1)

# Setting new column names
new_colnames <- c("SRR10379721",
                  "SRR10379722",
                  "SRR10379723",
                  "SRR10379724",
                  "SRR10379725",
                  "SRR10379726")

# Applying the new column names
colnames(subreadCounts)[(ncol(subreadCounts)-5):ncol(subreadCounts)] <- new_colnames

# Removing the first 6 columns (chr, start, end, strand, length, name) which are irrelevant to our work
subreadCounts <- subreadCounts[,7:ncol(subreadCounts)]

# Converting the table to a matrix
subreadCounts <- as.matrix(subreadCounts)

# Setting up the column data conditions
(condition <- factor(c(rep("exp", 3), rep("temoin", 3))))

# Importing the genes of interest and preparing the table for merging
rownames(subreadCounts) <- sub("gene-","",rownames(subreadCounts))

kegg <- read.table("/resources/kegg.txt", header = FALSE, sep = "",fill=TRUE)

kegg <- kegg[,1]

kegg <- kegg[grepl("SAOUHSC",kegg)]

# Selecting the genes of interest in the count matrix
subreadCounts <- subreadCounts[c(grepl(paste(kegg,collapse="|"), rownames(subreadCounts))),]

# The library for a streamlined RNA-seq data analysis
library(DESeq2)

# "Creating" the column data from the count matrix and the conditions
(subreadData <- data.frame(row.names=colnames(subreadCounts), condition))

# Creating the dataset from the count matrix and the column data
dataSet <- DESeqDataSetFromMatrix(countData = subreadCounts, colData = subreadData, design = ~ condition)

# Analysing differential expression inside the dataset
dataSet <- DESeq(dataSet)

# Formatting the results as a dataframe
resultats <- results(dataSet)
resultatslog <- resultats
resultatslog$baseMean <- log2(resultatslog$baseMean)

# Transforming the count data to reduce variance in small values and "highlight" outliers
rld <- rlogTransformation(dataSet)

#resultats$padj <- p.adjust(resultats$pvalue, method = "BH")

#de_genes <- subset(resultats, padj < 0.05)

# List of genes we want to have labeled on the MA-plot
nameofinterestlist <- list(list("SAOUHSC_01246", "infB"), list("SAOUHSC_01786", "infC"), list("SAOUHSC_01234", "tsf"), list("SAOUHSC_01236", "frr"), list("SAOUHSC_00475", "pth"), list("SAOUHSC_02489", "infA"))

# Plotting log-fold change on a MA-plot
# Open a PNG file
png("MA_plot.png")

plotMA(resultatslog, xlab = "log2 base mean of normalized counts", ylim = c(-6,6), colsig = "red")

# Close the PNG file
dev.off()

png("PCA_plot.png")

plotPCA(rld, intgroup="condition")

dev.off()

library("EnhancedVolcano")
png("Volcano_plot.png")
EnhancedVolcano(resultats,lab = rownames(resultats), x = 'log2FoldChange', y = 'pvalue')
dev.off()
