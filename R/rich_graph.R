load("~/Google Drive/MetX/app1/Graph.RData")



local_eff_day2
local
plot3<-bigbar(local_eff_day2, local_eff_day2[1:2], local)
plot3

pdf("~/Google Drive/MetX/rich_analysis/images/nodal.pdf", width=33, height=15)
png('~/Google Drive/MetX/rich_analysis/images/tr_local.png',width=33,height=15,res=300, units="in",bg = "transparent")
print(plot3)
dev.off()

head(assortativity_day2)
test<-summarySE(assortativity_day2, measurevar = "Norm_assortivity", groupvars="BMI_group")
test
test$BMI_group <- factor(test$BMI_group, levels = c("normal", "overweight", "obese"))
test
plot3<-ggplot(test, aes_string("BMI_group", "mean", fill="BMI_group")) +
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=test$mean-test$se, ymax=test$mean+test$se),width=.5, position=position_dodge(.9))+ 
  scale_colour_manual(values=cbPalette)+theme_bw()+ 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  theme(axis.title.x = element_text(face="bold", size=32),axis.text.x  = element_text(size=26))+
  theme(axis.title.y = element_text(face="bold", size=32),axis.text.y  = element_text(size=26))+
  theme(legend.text = element_text(size = 26))+
  theme(legend.title = element_text(size=32, face="bold"))+
  scale_fill_discrete(name  ="BMI group")
plot3

