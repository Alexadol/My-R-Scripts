library(ggplot2)

genes <- read.table('/home/alexadol/Загрузки/Aeromonas/Number_of_genes.txt')
p<-ggplot(data=genes, aes(x=reorder(V1,as.numeric(V2)), y=V2)) +
  geom_bar(stat="identity")

# Horizontal bar plot
p + coord_flip()


ggplot(data=genes, aes(x=reorder(V1,as.numeric(V2)), y=V2)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=V2), vjust=0, color="white", size=3.5)+
  theme_light()+coord_flip()

ggplot(data=genes, aes(x=reorder(V1,as.numeric(V2)), y=V2)) +geom_col(aes(fill = as.numeric(V2))) + 
  scale_fill_gradient2(low = "aliceblue", 
                       high = "lightskyblue4", mid = 'lightskyblue3',
                       midpoint = median(as.numeric(genes$V2))) + coord_flip()+theme_classic()+geom_text(aes(label=V2), hjust=1.2, color="white", size=3.5)+
  guides(fill=guide_legend(title="Number of genes"))+xlab(label = 'Assembly accession numbers')+ylab(label = '')+theme(text = element_text(size=11))

  
