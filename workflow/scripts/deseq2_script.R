
# Importing the count matrix
subreadCounts <- read.table("/resources/feature_counts_file/counts.txt", header = TRUE, sep = '\t', row.names = 1)

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
subreadCounts <- subreadCounts[,(ncol(subreadCounts)-5):ncol(subreadCounts)]

# Converting the table to a matrix
subreadCounts <- as.matrix(subreadCounts)

# Setting up the column data conditions
(condition <- factor(c(rep("temoin", 3), rep("exp", 3))))

# Importing the genes of interest and preparing the table for merging
rownames(subreadCounts) <- sub("gene-","",rownames(subreadCounts))

kegg <- read.table("/resources/names_genes/locus_translation.txt", header = FALSE, sep = ":", fill=TRUE)

kegg <- kegg[,3]

# Reserving a count matrix with all the genes
subreadCountsAllGenes <- subreadCounts

# Selecting the genes of interest in the count matrix
subreadCounts <- subreadCounts[c(grepl(paste(kegg,collapse="|"), rownames(subreadCounts))),]

# The library for a streamlined RNA-seq data analysis
library(DESeq2)

# "Creating" the column data from the count matrix and the conditions
(subreadData <- data.frame(row.names=colnames(subreadCounts), condition))

# Creating the dataset from the count matrix and the column data
dataSet <- DESeqDataSetFromMatrix(countData = subreadCounts, colData = subreadData, design = ~ condition)
dataSetAllGenes <- DESeqDataSetFromMatrix(countData = subreadCountsAllGenes, colData = subreadData, design = ~ condition)

# Analysing differential expression inside the dataset
dataSet <- DESeq(dataSet)
dataSetAllGenes <- DESeq(dataSetAllGenes)

# Obtaining the results of the differential expression analysis
resultats <- results(dataSet)
resultats$baseMean <- log2(resultats$baseMean)

resultatsAllGenes <- results(dataSetAllGenes)
resultatsAllGenes$baseMean <- log2(resultatsAllGenes$baseMean)

# Alternative result tables with different shrinkage methods
resultatsApeShrink <- lfcShrink(dataSet, coef="condition_temoin_vs_exp", type="apeglm")
resultatsApeShrink$baseMean <- log2(resultatsApeShrink$baseMean)

resultatsAshrShrink <- lfcShrink(dataSet, coef="condition_temoin_vs_exp", type="ashr")
resultatsAshrShrink$baseMean <- log2(resultatsAshrShrink$baseMean)

# Transforming the count data to reduce variance in small values and "highlight" outliers
rld <- rlogTransformation(dataSet)

# p-value adjustment
resultats$padj <- p.adjust(resultats$pvalue, method = "BH")
resultatsAllGenes$padj <- p.adjust(resultatsAllGenes$pvalue, method = "BH")

resultatsApeShrink$padj <- p.adjust(resultatsApeShrink$pvalue, method = "BH")
resultatsAshrShrink$padj <- p.adjust(resultatsAshrShrink$pvalue, method = "BH")

# Converting the results to a dataframe for use in ggplot
resultats <- data.frame(resultats)
resultatsAllGenes <- data.frame(resultatsAllGenes)

resultatsApeShrink <- data.frame(resultatsApeShrink)
resultatsAshrShrink <- data.frame(resultatsAshrShrink)

colnames(resultats)[1] <- "log2BaseMean"
colnames(resultatsAllGenes)[1] <- "log2BaseMean"

colnames(resultatsApeShrink)[1] <- "log2BaseMean"
colnames(resultatsAshrShrink)[1] <- "log2BaseMean"

# List of genes we want to have labeled on the MA-plot
nameofinterestlist <- list(list("SAOUHSC_01246", "infB"),
                           list("SAOUHSC_01786", "infC"), 
                           list("SAOUHSC_01234", "tsf"), 
                           list("SAOUHSC_01236", "frr"), 
                           list("SAOUHSC_00475", "pth"), 
                           list("SAOUHSC_02489", "infA"))

nameofinterestlist <- matrix(unlist(nameofinterestlist), length(nameofinterestlist), byrow = TRUE)

nameofinterestlist <- data.frame(nameofinterestlist)

# Subset of the count matrix with only the genes we want labeled, plus  the label
genesToLabel <- subreadCounts[c(grepl(paste(nameofinterestlist$X1,collapse="|"), rownames(subreadCounts))),]
genesToLabel <- data.frame(genesToLabel)
genesToLabel$label <- nameofinterestlist$X2[match(rownames(genesToLabel), nameofinterestlist$X1)]

# Adding a "label" column to the results table so that the information for the graph is contained within a single dataframe
resultats$label <- genesToLabel$label[match(rownames(resultats), rownames(genesToLabel))]
resultatsApeShrink$label <- genesToLabel$label[match(rownames(resultatsApeShrink), rownames(genesToLabel))]
resultatsAshrShrink$label <- genesToLabel$label[match(rownames(resultatsAshrShrink), rownames(genesToLabel))]

# Plotting log-fold change on a MA-plot
# Opening a PNG file to "fill"
png("MA_plot.png")

# For additional ggplot functionality
library(ggrepel)

# MA-plot
ggplot(resultats, mapping = aes(x=log2BaseMean, y=log2FoldChange)) + # Initial empty plot
  geom_point(aes(color = padj < 0.05), shape = 16, cex = 1.5) + # Adding the points with a condition for colour on p-value significance
  scale_color_manual(values = c("black", "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") + # A line to divide the points between negative and positive lfc
  geom_label_repel(data = resultats[match(nameofinterestlist$X2, resultats$label),], # Labelling the genes of interest
                   aes(label = label), # Ugly but functional (should maybe have called the label column a different way)
                   box.padding = unit(0.5, "lines"),
                   point.padding = unit(0.3, "lines")) +
  expand_limits(y = c(-5.5, 5.5)) # For a nice, symmetrical graph


# Closing the PNG file
dev.off()

png("MA_allgenes_plot.png")

ggplot(resultatsAllGenes, mapping = aes(x=log2BaseMean, y=log2FoldChange)) + # Initial empty plot
  geom_point(aes(color = padj < 0.05), shape = 16, cex = 1.5) + # Adding the points with a condition for colour on p-value significance
  scale_color_manual(values = c("black", "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") + # A line to divide the points between negative and positive lfc
  expand_limits(y = c(-5.5, 5.5))

dev.off()

png("MA_apeshrink_plot.png")

ggplot(resultatsApeShrink, mapping = aes(x=log2BaseMean, y=log2FoldChange)) + # Initial empty plot
  geom_point(aes(color = padj < 0.05), shape = 16, cex = 1.5) + # Adding the points with a condition for colour on p-value significance
  scale_color_manual(values = c("black", "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") + # A line to divide the points between negative and positive lfc
  geom_label_repel(data = resultatsApeShrink[match(nameofinterestlist$X2, resultatsApeShrink$label),], # Labelling the genes of interest
                   aes(label = label), # Ugly but functional (should maybe have called the label column a different way)
                   box.padding = unit(0.5, "lines"),
                   point.padding = unit(0.3, "lines")) +
  expand_limits(y = c(-5.5, 5.5))

dev.off()

png("MA_ashrshrink_plot.png")

ggplot(resultatsAshrShrink, mapping = aes(x=log2BaseMean, y=log2FoldChange)) + # Initial empty plot
  geom_point(aes(color = padj < 0.05), shape = 16, cex = 1.5) + # Adding the points with a condition for colour on p-value significance
  scale_color_manual(values = c("black", "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") + # A line to divide the points between negative and positive lfc
  geom_label_repel(data = resultatsAshrShrink[match(nameofinterestlist$X2, resultatsAshrShrink$label),], # Labelling the genes of interest
                   aes(label = label), # Ugly but functional (should maybe have called the label column a different way)
                   box.padding = unit(0.5, "lines"),
                   point.padding = unit(0.3, "lines")) +
  expand_limits(y = c(-5.5, 5.5))

dev.off()

png("PCA_plot.png")

plotPCA(rld, intgroup="condition")

dev.off()

library("EnhancedVolcano")
png("Volcano_plot.png")
EnhancedVolcano(resultats,lab = rownames(resultats), x = 'log2FoldChange', y = 'pvalue')
dev.off()

