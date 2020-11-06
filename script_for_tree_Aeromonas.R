ä#tree representation with ggtree package

#load packages
library(extrafont)
library(ggtree)
library(ggplot2)

#Open table with genotype matrix
Genes <- read.table('for_tree_3_genes.tsv',sep = '\t',header = T)
Genes_t <- as.data.frame(t(Genes))
#Set gene names
colnames(Genes_t) <- c('NSE','MACP','CA')

#read tree 
n <- read.tree("C:/Users/Alexandra Dolgikh/Downloads/new_fasta_txt_treefile (1).treefile")
#Show node labels
ggtree(n)+geom_text(aes(label=node), hjust=-.3)
#Reroot tree
n1 <- phytools::reroot(n,node.number = 34)

#at this step choose nodes with support more than 0.7 
label <- n1$node.label 
changed_label<- as.numeric(sub("/", "", label))
morethan <- changed_label > 0.7 & !is.na(changed_label)
newlabel <- ifelse( morethan,label,'')
n1$node.label <- newlabel
newnewlabel <- ifelse(newlabel == "", "", intToUtf8(9679))
#9679 is a circle in UTF-8 and nodes with support > 0.7 will be labeled by circles
n1$node.label <- newnewlabel

#colors,highlights and labels
p2 <- ggtree(n1) +  
  geom_hilight(node=63, fill="blue", alpha=0.35,extend=0.1)+
  geom_hilight(node=34, fill="darkslategray3", alpha=0.35,extend=0.1)+
  geom_hilight(node=59, fill="skyblue", alpha=0.25,extend=0.1)+
  geom_nodelab(hjust=0.7,vjust=.3, size=6,color='darkslateblue',alpha = 0.7)

p2

#geom_highlight should be done before tiplab because it overlap labels
p3 <- p2 +geom_tiplab(linesize=0.5,size=4.2,offset = 0.005,family='Trebuchet MS')

#add heatmap to the tree
p4 <- gheatmap(p3, Genes_t,offset = 0.07) 
#some modification
p4 + scale_fill_brewer(palette="Set2") + theme_tree2() + 
  scale_y_continuous(expand=c(0, 0.6)) +
  theme(legend.text=element_text(size=14), 
        legend.key.height=unit(.5, "cm"),
        legend.key.width=unit(.4, "cm"), 
        legend.position=c(.44, y=.625),
        legend.title=element_text(size=15),
        axis.text.x=element_text(size=10), 
        axis.title.x = element_text(size=12))+guides(fill=guide_legend(title="Ortholog"))

ggsave('C:/Users/Alexandra Dolgikh/Documents/Aeromonas_tree_with_gheatmap.tiff',width = 12,height = 8)

