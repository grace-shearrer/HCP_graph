library(plyr)

day1_nod<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_day1.csv", sep=",", header=T)
dim(day1_nod)
day1_loc<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_day1.csv", sep=",", header=T)
dim(day1_loc)
day1_cluster<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_day1.csv", sep=",", header=T)
dim(day1_cluster)
head(day1_cluster)

day2_nod<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_day2.csv", sep=",", header=T)
dim(day2_nod)
day2_loc<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_day2.csv", sep=",", header=T)
dim(day2_loc)
day2_cluster<-read.table("~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_day2.csv", sep=",", header=T)
dim(day2_cluster)

nod<-merge(day1_nod, day2_nod, by=c("ROI", "BMI"))
dim(nod)
cluster<-merge(day1_cluster, day2_cluster, by=c("ROI", "BMI"))
dim(cluster)
head(cluster)
local<-merge(day1_loc, day2_loc, by=c("ROI", "Aparc", "BMI"))
dim(local)

write.table(nod, "~/Google Drive/MetX/rich_analysis/comb_daysnod_btw_day1-2.csv", sep=",", row.names=F)
write.table(cluster, "~/Google Drive/MetX/rich_analysis/comb_dayscluster_day1-2.csv", sep=",", row.names=F)
write.table(local, "~/Google Drive/MetX/rich_analysis/comb_dayslocal_day1-2.csv", sep=",", row.names=F)




comb_function<-function(measure){
  base<-"~/Google Drive/MetX/rich_analysis/comb_days/for_paper/"
  ndata1<-paste(base, measure, ".csv", sep="")
  ndata2<-paste(base, measure,"_day2", ".csv", sep="")
  data1<-read.table(ndata1, sep=",", header=T)
  data2<-read.table(ndata2, sep=",", header=T)
  data3<-merge(data1, data2, by=c("factors","ROI", "Aparc","X","Y","Z"))
  betas<-cbind(data3[9],data3[14])
  CIlow<-cbind(data3[10],data3[15])
  CIhigh<-cbind(data3[11],data3[16])
  data3$ave_beta<-apply(betas,1,mean)
  data3$ave_CIlow<-apply(CIlow,1,mean)
  data3$ave_CIhigh<-apply(CIhigh,1,mean)
  save_data2<-paste(base, measure,"_comb", ".csv", sep="")
  write.table(data3, save_data2, sep=",", row.names=F)
  return(data3)
  
}
clust_sig<-comb_function("cluster_coef_p")
local_sig<-comb_function("local_eff_sig")
nodal_sig<-comb_function("nodal_btw_sig")
names(clust_sig)
names(local_sig)
names(nodal_sig)
data1<-merge(clust_sig, local_sig, by=c("factors", "ROI", "Aparc"))
head(data1)
data2<-merge(data1, nodal_sig, by=c("factors", "ROI", "Aparc"))
head(data2)
View(data2)
write.table(data2, "~/Google Drive/MetX/rich_analysis/comb_days/all_sig.csv", sep=",", row.names=F)
names(data2)
data2<-data2[1:9]
names(data2)
names(data2)<-c("BMI", "ROI","Aparc","pval","BHpval","beta","X","Y","Z"  )
View(clustering_coef_p)
plot3<-bigbar(clustering_coef, clustering_coef[1:2], data2)
plot3
png('~/Google Drive/MetX/rich_analysis/SSIB_images/tr_nodal.png',width=33,height=15,res=300, units="in",bg = "transparent")
print(plot3)
dev.off()
