#rich club analysis
library(reshape)
library(ggplot2)
library(psych)
library(lm.beta)
names(Rich2)
library(plyr)


parcels<-read.table("~/Google Drive/MetX/parcellation.csv", header=T, sep=",")
myvars2<-c("ROI","Aparc","X","Y","Z")
parcels<-parcels[myvars2]
dim(parcels)
head(parcels)

ovd2<-subset(nod_deg_day2, nod_deg_day2 == "overweight")
obd2<-subset(nod_deg_day2, nod_deg_day2 == "obese")
nod2<-subset(nod_deg_day2, nod_deg_day2 == "normal")
head(obd)

##finding the rich club
#apparent rich club at two points, 75 and 150
##club 1->75
ob_rich2<-find_nodes(obd2[3:381], 75)
dim(ob_rich2)
max(ob_rich2$mean_node)
ob_rich2
ob_rich2<-merge(parcels, ob_rich2, by="ROI")
write.table(ob_rich2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_ob_rich_day2.csv", row.names = F, sep=",")

ov_rich2<-find_nodes(ovd2[3:381], 75)
dim(ov_rich2)
max(ov_rich2$mean_node)
ov_rich2
ov_rich2<-merge(parcels, ov_rich2, by="ROI")
write.table(ov_rich2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_ov_rich_day2.csv", row.names = F, sep=",")

nor_rich2<-find_nodes(nod2[3:381], 75)
dim(nor_rich2)
max(nor_rich2$mean_node)
nor_rich2
nor_rich2<-merge(parcels, nor_rich2, by="ROI")
write.table(nor_rich2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_nor_rich_day2.csv", row.names = F, sep=",")





####finiding which rich nodes line up to be significantly different
nod_btw_ob<-subset(nodal_btw_p_day2, nodal_btw_p_day2$factors == "xobese")
dim(nod_btw_ob)
nod_btw_ov<-subset(nodal_btw_p_day2, nodal_btw_p_day2$factors == "xoverweight")
dim(nod_btw_ov)

sig_rich_ob<-merge(ob_rich, nod_btw_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_ob_day2.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, nod_btw_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_ov.csv", row.names=F, sep=",")
###applying the significant rich nodes to cluster coef and local
loc_eff_ob<-subset(local_eff_p_day2, local_eff_p_day2$factors == "xobese")
dim(loc_eff_ob)
loc_eff_ov<-subset(local_eff_p_day2, local_eff_p_day2$factors == "xoverweight")
dim(nod_btw_ov)

sig_rich_ob<-merge(ob_rich, loc_eff_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_ob_day2.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, loc_eff_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_ov_day2.csv", row.names=F, sep=",")


cluster_eff_ob<-subset(clustering_coef_p_day2, clustering_coef_p_day2$factors == "xobese")
dim(cluster_eff_ob)
cluster_eff_ov<-subset(clustering_coef_p_day2, clustering_coef_p_day2$factors == "xoverweight")
dim(cluster_eff_ov)

sig_rich_ob<-merge(ob_rich, cluster_eff_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_ob_day2.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, cluster_eff_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_ov_day2.csv", row.names=F, sep=",")

