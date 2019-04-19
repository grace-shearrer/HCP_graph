#brainnet viwer
load("~/Google Drive/MetX/app1/Graph.RData")


brainnet<-function(df1,colz){
  library(reshape)
  library(plyr)
  labels<-read.table("~/Google Drive/MetX/parcel.node.txt", header=T, sep="\t")
  myvars<-names(colz)
  data_long<-melt(df1, id=myvars)
  names(data_long)<-c("BMI","Wiring_cost", "ROI", "value")
  data_comb<-merge(data_long, labels, by=c("ROI"))
  means <- summarySE(data_comb, measurevar="value", groupvars=c("BMI", "ROI"))
  # means$ymax<-apply(means,1, add_func)
  # means$ymin<-apply(means,1, sub_func)
  # means$BMI.x <- factor(means$BMI.x, levels = c("normal", "overweight", "obese"))
  vars<-c("BMI", "ROI", "mean")
  keep<-means[vars]
  final<-join(labels, keep)
  return(final)
}
data<-brainnet(local_eff_day2, local_eff_day2[1:2])
head(data)
write.table(data,"~/Google Drive/MetX/local_eff_BN.txt", row.names=F, sep = " ")
