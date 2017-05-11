# Load libraries

library('SNFtool')
library('RColorBrewer')
library('reshape2')
library('ggplot2')


setwd("< FILL THIS WITH YOUR DIRECTORY >")

## Load data
load('CBW-GenomicMedicine-Module7-data.RData')

## What's in your environment now? 
ls() ## You should have loaded 

## Looking at dimensions of the data we're integrating: mRNA, methylation, and miRNA
dim(mrna)
dim(methyl)
dim(mirna)

## Looking at the data we're integrating (looking at first 6 rows and first 6 columns)
mrna[1:6,1:6] # Genes labelled numerically -- something you'll have to deal with eventually
methyl[1:6,1:6] # Methylation levels averaged over gene
mirna[1:6,1:6] # miRNA 

## Check that each dataset has the same patients
identical(names(mrna),names(methyl))
identical(names(mrna),names(mirna))

## Put datasets into a list
data_list <- list(mrna,methyl,mirna)
names(data_list) <- c("mRNA","Methyl","miRNA")

##**************************************************##
##                                                  ## 
##          Similarity Network Fusion               ##
##                                                  ##
##**************************************************##

## First, set all the parameters:
K = 20; ##number of neighbors, must be greater than 1. usually (10~30)
alpha = 0.5; ##hyperparameter, usually (0.3~0.8)
T = 20; ###Number of Iterations, usually (10~50)

## Standard normalize each data type
data_norm_list <- lapply(< DATA LIST OBJECT >,standardNormalization)

## Create distance matrices for each data type
data_dist_list <- lapply(X = < NORMALIZED DATA LIST OBJECT >,
                         function(x){dist2(t(x),t(x))})

## Create affinity matrices for each data type
data_aff_list <-  lapply(X = < DATA DISTANCE LIST OBJECT >,
                         function(x){affinityMatrix(x,K,alpha)})


## Get clusters for each data type (we're doing this simply/quickly since it's just a check)
  # Estimate number of clusters

(cluster_nums <- lapply(X = < DATA AFFINITY LIST OBJECT >,
                       function(x){estimateNumberOfClustersGivenGraph(W = x,NUMC = 2:10)[[1]]}))

  # Cluster data
clusters <- sapply(1:3,
                   function(i){spectralClustering(affinity = data_aff_list[[i]],K = cluster_nums[[i]])})
colnames(clusters) <- c("mRNA","Methyl","miRNA")

  # Looking closer at clusters
apply(clusters,2,table)

## Create heatmaps for each data type
displayClustersWithHeatmap(W = data_aff_list[["mRNA"]], group = clusters[,"mRNA"], col = brewer.pal(name = "RdGy",n = 10))
displayClustersWithHeatmap(W = data_aff_list[["Methyl"]], group = clusters[,"Methyl"], col = brewer.pal(name = "RdGy",n = 10))
displayClustersWithHeatmap(W = data_aff_list[["miRNA"]], group = clusters[,"miRNA"], col = brewer.pal(name = "RdGy",n = 10))

##  Running SNF algorithm
W = SNF(< DATA AFFINITY LIST >,K,T)
  # Add column and row names to SNF affinity matrix
colnames(W) <- rownames(W) <- colnames(mirna)

## Choosing number of clusters using eigen-gaps and rotation cost algorithms 
estimateNumberOfClustersGivenGraph(W = < AFFINITY MATRIX OBJECT >,2:10)
## Both eigen-gaps [[1]] and rotation cost [[2]] 
##    indicate that 2 is the best number of clusters

# Perform clustering on the fused network
clustering2 = spectralClustering(< AFFINITY MATRIX OBJECT >,2)

# Look at distribution of group membership
  # With table
table(clustering2)
  # With barplot
barplot(table(clustering2),col = c('darkorchid4','dodgerblue4'))

# Create dataframe for cluster 2
cluster2.df <- data.frame(cbind(colnames(mrna),clustering2))
names(cluster2.df) <- c("id","cluster")

# Heatmap of fused matrix
displayClustersWithHeatmap(W = < AFFINITY MATRIX OBJECT >,group = < 2 CLUSTERING OBJECT >,
                           col = brewer.pal(name = "Spectral",n = 10))

# Can check out how clustering of 3 and 5 
clustering3 = spectralClustering(W,3)
displayClustersWithHeatmap(W = W,group = clustering3,col = brewer.pal(name = "RdGy",n = 10))

clustering5 = spectralClustering(W,5)
displayClustersWithHeatmap(W = W,group = clustering5,col = brewer.pal(name = "RdGy",n = 10))


##**************************************************##
##                                                  ## 
##    ASSESSING CLINICAL ATTRIBUTES OF CLUSTERS     ##
##                                                  ##
##**************************************************##

## 
##    LOOKING AT DISTRIBUTION OF Basal, LumA, and LumB subtypes 
##

head(brca.subtype.data)

brca.subtype.data$basal <- "Not Basal"
brca.subtype.data$basal[substr(x = brca.subtype.data$V2,start = 1,
                               stop = 9) == "ER-/HER2-"] <- "Basal"

brca.subtype.data$luma <- "Not LumA"
brca.subtype.data$luma[substr(x = brca.subtype.data$V2,start = 11,
                              stop = nchar(brca.subtype.data$V2)) == "Low Prolif"] <- "LumA"

brca.subtype.data$lumb <- "Not LumB"
brca.subtype.data$lumb[substr(x = brca.subtype.data$V2,start = 11,
                              stop = nchar(brca.subtype.data$V2)) == "High Prolif"] <- "LumB"

head(cluster2.df)

cluster2.df$id2 <- substr(x = cluster2.df$id,start = 9,stop = 12)

brca.subtype.cluster2.merge <- merge(brca.subtype.data,
                                     cluster2.df,
                                     by.x = 'V1',
                                     by.y = 'id2')

head(brca.subtype.cluster2.merge)

table(brca.subtype.cluster2.merge$basal,
      brca.subtype.cluster2.merge$cluster)
table(brca.subtype.cluster2.merge$luma,brca.subtype.cluster2.merge$cluster)
table(brca.subtype.cluster2.merge$lumb,brca.subtype.cluster2.merge$cluster)

chisq.test(table(brca.subtype.cluster2.merge$basal,
                 brca.subtype.cluster2.merge$cluster))
chisq.test(table(brca.subtype.cluster2.merge$luma,brca.subtype.cluster2.merge$cluster))
chisq.test(table(brca.subtype.cluster2.merge$lumb,brca.subtype.cluster2.merge$cluster))

## Simple barplot
barplot(table(brca.subtype.cluster2.merge$basal,
              brca.subtype.cluster2.merge$cluster))

## Colorful barplots side-by-side
par(mfrow = c(1,3)) # this plots 1 row and 3 columns of graphs (3 graphs side by side)
barplot(table(brca.subtype.cluster2.merge$basal,brca.subtype.cluster2.merge$cluster), main = "Basal", xlab = 'cluster',
        col = c('tomato',rgb(red=255, green=99, blue=71, alpha=90, names = NULL, maxColorValue = 255)))
barplot(table(brca.subtype.cluster2.merge$luma,brca.subtype.cluster2.merge$cluster), main = "LumA", xlab = 'cluster',
        col = c('darkturquoise',rgb(red=0, green=206, blue=209, alpha=60, names = NULL, maxColorValue = 255)))
barplot(table(brca.subtype.cluster2.merge$lumb,brca.subtype.cluster2.merge$cluster), main = "LumB", xlab = 'cluster',
        col = c('seagreen4',rgb(red=46, green=139, blue=87, alpha=90, names = NULL, maxColorValue = 255)))
## cluster 2 appears to be primarily basal with some lumB

par(mfrow = c(1,1)) ## change back to single frame graph

## 
##      BONUS: CREATE PIE CHART OF SUBTYPES IN CLUSTER 2
## 

# First, create data frame of cluster 2 only
cluster2only.df <- brca.subtype.cluster2.merge[brca.subtype.cluster2.merge$cluster == 2,] 
# Have a look at it
head(cluster2only.df)
# Create new variable indicating the subtype
cluster2only.df$Subtype <- 'No subtype'
cluster2only.df$Subtype[cluster2only.df$basal == "Basal"] <- "Basal" # Use the three subtype variables to name subtypes in a single variable
cluster2only.df$Subtype[cluster2only.df$luma == "LumA"] <- "LumA"
cluster2only.df$Subtype[cluster2only.df$lumb == "LumB"] <- "LumB"

# Frquencies of each subtype in cluster 2
table(cluster2only.df$Subtype)

# Relative frequencies
table(cluster2only.df$Subtype)/sum(table(cluster2only.df$Subtype))

# Put frequencies in a pie chart
pie(table(cluster2only.df$Subtype),labels = names(table(cluster2only.df$Subtype)),col = brewer.pal("Dark2",n = 4))

## 
##    BONUS: LOOKING AT DISTRIBUTION OF OTHER CLINICAL VARIABLES  
##

# Merge our other clinical set with the cluster data frame
clinical.clust.df <- merge(clinical.data,cluster2.df,by.x = 'sample_id',by.y = 'id')
head(clinical.clust.df)

# Look at counts for different histological types
table(clinical.clust.df$histological_type,clinical.clust.df$cluster)

# Test if age of diagnosis confers with cluster membership
t.test(age_at_initial_pathologic_diagnosis ~ cluster,clinical.clust.df)
# Plot age of onset for each cluster
ggplot(clinical.clust.df,aes(age_at_initial_pathologic_diagnosis,fill = cluster)) + xlab('Age at Initial Pathological Diagnosis') + 
  geom_density(alpha = 0.6) + scale_fill_manual( values = c('darkorchid4','dodgerblue4')) + theme_bw()

t.test(tumor_nuclei_percent ~ cluster,clinical.clust.df)
ggplot(clinical.clust.df,aes(tumor_nuclei_percent,fill = cluster)) + xlab('Tumor Nuclei Percentage') + 
  geom_density(alpha = 0.6) + scale_fill_manual( values = c('darkorchid4','dodgerblue4')) + theme_bw()


##                                                   
##    BONUS: DETERMINING FEATURES THAT DRIVE CLUSTERS (this can take a bit of time)
##                                                  

  # miRNA
kw.mirna <- data.frame(matrix(nrow = nrow(mirna),ncol = 2))
names(kw.mirna) <- c('miRNA','kw_pval')

for(k in 1:nrow(mirna)){
  kw.mirna[k,'miRNA'] <- rownames(mirna)[k]
  kw.mirna[k,'kw_pval'] <- kruskal.test(unlist(mirna[k,]) ~ clustering2)$p.value
}

  # Methylation
kw.methyl <- data.frame(matrix(nrow = nrow(methyl),ncol = 2))
names(kw.methyl) <- c('probe','kw_pval')

for(k in 1:nrow(methyl)){
  kw.methyl[k,'probe'] <- rownames(methyl)[k]
  kw.methyl[k,'kw_pval'] <- kruskal.test(unlist(methyl[k,]) ~ clustering2)$p.value
}

  # mRNA
kw.mrna <- data.frame(matrix(nrow = nrow(mrna),ncol = 2))
names(kw.mrna) <- c('gene','kw_pval')

for(k in 1:nrow(mrna)){
  kw.mrna[k,'gene'] <- rownames(mrna)[k]
  kw.mrna[k,'kw_pval'] <- kruskal.test(unlist(mrna[k,]) ~ clustering2)$p.value
}

# Put kruskal wallis data frames into a list 
kw.list <- list(kw.mrna,kw.methyl,kw.mirna)
names(kw.list) <- c('mRNA','Methyl','miRNA')

# Sort kw.list
head(kw.methyl)
kw.list.sorted <- lapply(kw.list,function(x)x[order(x = x[,'kw_pval']),])

## Look at top associated genes and miRNA for each of the data sets
lapply(kw.list.sorted,head) ## Note: numeric values for mRNA gene names -- important to label rows and columns in your data! 

## 
##  BONUS: Create cytoscape file
## 
W_cyto <- W

# Set lower triangle and diagonal to missing since matrix is symmetric
W_cyto[lower.tri(W_cyto, diag = F)] <- NA

W_cyto[1:6,1:6] ## look at first six rows and columns, lower triangle and diagonal are now 'NA'

# Make matrix into a dataframe
W_cyto_mlt <- melt(W_cyto)

# Check it out -- lots of missing values
head(W_cyto_mlt)

# Let's overwrite the object with the missing values removed
W_cyto_mlt <- W_cyto_mlt[!(is.na(W_cyto_mlt$value)),]

# That's better! 
head(W_cyto_mlt)

# Write a text file with the affinities for each of your patients relative to each other
write.table(W_cyto_mlt,file = "SNF-affinity-matrix-cytoscape-infile.txt",quote=FALSE,row.names=FALSE,col.names=TRUE)
