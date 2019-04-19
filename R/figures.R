library(ggplot2)
head(Rich2)
Rich2$BMI_group <- factor(Rich2$BMI_group, levels = c("normal", "overweight", "obese"))
plot2 <- ggplot(Rich2, aes_string(Rich2$degree.k,Rich2$R_norm, color=Rich2$BMI_group))+
  geom_point(size=5)+scale_x_continuous(name="Nodal Degree (k)")+geom_hline(yintercept=1, linetype = "dashed", colour="#FF0000", size=2)+
  scale_y_continuous(name="Normalized Rich Club Coefficient")+
  scale_color_discrete(name="BMI category")+
  theme_bw()+ 
  theme(
    panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(
      colour = "black"))+theme(axis.title.x = element_blank(),
                               axis.text.x  = element_text(size=26))+theme(axis.title.y = element_blank(),
                                                                           axis.text.y  = element_text(size=26))+theme(
                                                                             legend.text = element_text(size = 26))+theme(legend.title = element_text(size=32, face="bold"))
plot2
pdf("~/Google Drive/MetX/rich_analysis/images/plot1.pdf", width=12, height=12)
print(plot2)
dev.off()

plot2 <-meanBar(dataset, input$y, input$colour)
if (input$subset !='None')
  dataset<-subset(dataset, dataset$regularization==input$subset)
q <- meanBar(dataset, input$y, input$colour)
q