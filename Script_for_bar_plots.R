#load libraries
library(ggplot2)
library(reshape2)
#Open table with TPM
r <- read.csv('/home/alexadol/Загрузки/genopea_counts_on_Genome_TPM.csv')
#extract GPRP genes
r_gpr <- r[r$X %in% c('Psat2g145320','Psat4g107720','Psat4g216400'),]
#extract columns with nodules
r_gpr_nodes <- r_gpr[,c(18:20)]
#Add columns with genome
r_gpr_nodes$gene <- rownames(r_gpr_nodes)
#Melt dataframe for ggplot
r_gpr_nodes_melted <- melt(r_gpr_nodes)
#Change gene names
r_gpr_nodes_melted$gene <- gsub ('14883','Psat2g145320',r_gpr_nodes_melted$gene)
r_gpr_nodes_melted$gene <- gsub ('23215','Psat4g107720',r_gpr_nodes_melted$gene)
r_gpr_nodes_melted$gene <- gsub ('25683','Psat4g216400',r_gpr_nodes_melted$gene)
#Change Condition names
r_gpr_nodes_melted$variable <- gsub('Nodule_G_LN','C',r_gpr_nodes_melted$variable)
r_gpr_nodes_melted$variable <- gsub('Nodule_A_LN','A',r_gpr_nodes_melted$variable)
r_gpr_nodes_melted$variable <- gsub('Nodule_B_LN','B',r_gpr_nodes_melted$variable)
#Change column names
colnames(r_gpr_nodes_melted)<-c('gene','Стадия развития','value')
#Create plot
p <- ggplot(data = r_gpr_nodes_melted,aes(x = r_gpr_nodes_melted$`Стадия развития`,y = value,fill=`Стадия развития`)) +  geom_bar(stat='identity')+
facet_wrap(~gene) + ylab(label ='Количество транскриптов на миллион')+xlab(label='')+scale_fill_manual(values=c('#f6e8c3','#80cdc1','#bf812d'))+
theme_classic()+theme(text = element_text(size=15))
p
#saveplot
ggsave('/home/alexadol/Alexa/GPRP/GPRP_Expression_Pisum.png',width = 12,height = 10)
