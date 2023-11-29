setwd("C:/Users/User/Documents/HACKATHON/scripts")

# Importing the count matrix
subreadCounts <- read.table("counts_nous.txt", header = TRUE, sep = '\t', row.names = 1)

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
(condition <- factor(c(rep("temoin", 3), rep("exp", 3))))

# Importing the genes of interest and preparing the table for merging
rownames(subreadCounts) <- sub("gene-","",rownames(subreadCounts))

kegg <- read.table("kegg2.txt", header = FALSE, sep = "",fill=TRUE)

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

# Obtaining the results of the differential expression analysis
resultats <- results(dataSet)
resultats$baseMean <- log2(resultats$baseMean)

# Alternative result tables with different shrinkage methods
resultatsApeShrink <- lfcShrink(dataSet, coef="condition_temoin_vs_exp", type="apeglm")
resultatsApeShrinkLog <- resultatsApeShrink
resultatsApeShrinkLog$baseMean <- log2(resultatsApeShrinkLog$baseMean)

resultatsAshrShrink <- lfcShrink(dataSet, coef="condition_temoin_vs_exp", type="ashr")
resultatsAshrShrinkLog <- resultatsAshrShrink
resultatsAshrShrinkLog$baseMean <- log2(resultatsAshrShrinkLog$baseMean)

# Transforming the count data to reduce variance in small values and "highlight" outliers
rld <- rlogTransformation(dataSet)

# p-value adjustment
resultats$padj <- p.adjust(resultats$pvalue, method = "BH")

# Converting the results to a dataframe for use in ggplot
resultats <- data.frame(resultats)

colnames(resultats)[1] <- "log2BaseMean"

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

# Plotting log-fold change on a MA-plot
# Opening a PNG file to "fill"
png("MA_plot.png")

# Legacy plot from the deseq library with insufficient modularity
#plotMA(resultatsLog, xlab = "log2 base mean of normalized counts", ylim = c(-5.5,5.5), colSig = "red", returnData=TRUE) 

# For additional ggplot functionality
library(ggrepel)


ggplot(resultats, mapping = aes(x=log2BaseMean, y=log2FoldChange)) + # Initial empty plot
  geom_point(aes(color = padj < 0.05), shape = 16, cex = 1.5) + # Adding the points with a condition for colour on p-value significance
  scale_color_manual(values = c("black", "red")) +
  geom_hline(yintercept = 0, linetype = "dashed") + # A line to divide the points between negative and positive lfc
  geom_label_repel(data = resultats[match(nameofinterestlist$X2, resultats$label),], # Labelling the genes of interest
                   aes(label = label), # Ugly but functional (should maybe have called the label column a different way)
                   box.padding = unit(0.5, "lines"),
                   point.padding = unit(0.3, "lines"))
  

# Closing the PNG file
dev.off()

png("PCA_plot.png")

plotPCA(rld, intgroup="condition")

dev.off()

library("EnhancedVolcano")
png("Volcano_plot.png")
EnhancedVolcano(resultats,lab = rownames(resultats), x = 'log2FoldChange', y = 'pvalue')
dev.off()