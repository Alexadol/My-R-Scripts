#Script for FeatureCounts


library(Rsubread)
library(ggplot2)
library(DESeq2)

setwd('/home/alexadol/Ecoli/SORTED_BAM/')

res <- featureCounts(files = c('K1_U_S65_L007_R1_001.sorted.bam','Nb1_U_S68_L007_R1_001.sorted.bam','Rif1_U_S66_L007_R1_001.sorted.bam',
  'Tet1_U_S67_L007_R1_001.sorted.bam','K2_U_S69_L007_R1_001.sorted.bam','Nb2_U_S72_L007_R1_001.sorted.bam',
  'Rif2_U_S70_L007_R1_001.sorted.bam','Tet2_U_S71_L007_R1_001.sorted.bam','K3_U_S73_L007_R1_001.sorted.bam',
  'Nb3_U_S76_L007_R1_001.sorted.bam','Rif3_U_S74_L007_R1_001.sorted.bam','Tet3_U_S75_L007_R1_001.sorted.bam'),
  annot.ext = '/home/alexadol/Ecoli/E_coli_K12_MG1655.gff',isGTFAnnotationFile=T,GTF.attrType = 'ID',GTF.featureType = "CDS")

res_df <- as.data.frame(res$counts)

colnames(res_df) <- c('K1','Nb1','Rif1','Tet1','K2','Nb2','Rif2','Tet2','K3','Nb3','Rif3','Tet3') #Better the same name for each group
colnames(res_df) <- c(rep(c('Control','Novobiocine','Rifampicine','Tetracicline'),3))
coldata = data.frame(strain = colnames(res_df))
rawdata = rownames(res_df)

colnames(coldata)<-'species'

res_norm <- as.matrix(res_df)
res_norm <- rlog(res_norm)
RE <- SummarizedExperiment(res_norm,rowData=rawdata,colData = coldata)
tran <- DESeqTransform(RE)
plotPCA(tran,intgroup = 'species')
