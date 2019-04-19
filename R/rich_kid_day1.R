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

ovd<-subset(nodal_degree_comb, nodal_degree_comb == "overweight")
obd<-subset(nodal_degree_comb, nodal_degree_comb == "obese")
nod<-subset(nodal_degree_comb, nodal_degree_comb == "normal")
head(nod)

##finding the rich club
#apparent rich club at two points, 75 and 150
##club 1->75
ob_rich<-find_nodes(obd[3:381], 75)
dim(ob_rich)
max(ob_rich$mean_node)
ob_rich
ob_rich<-merge(parcels, ob_rich, by="ROI")
head(ob_rich)
write.table(ob_rich, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_ob_rich.csv", row.names = F, sep=",")

ov_rich<-find_nodes(ovd[3:381], 75)
dim(ov_rich)
max(ov_rich$mean_node)
ov_rich
ov_rich<-merge(parcels, ov_rich, by="ROI")
head(ov_rich)
write.table(ov_rich, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_ov_rich.csv", row.names = F, sep=",")


nor_rich<-find_nodes(nod[3:381], 75)
dim(nor_rich)
max(nor_rich$mean_node)
nor_rich
nor_rich<-merge(parcels, nor_rich, by="ROI")
head(nor_rich)
write.table(nor_rich, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/nod_nor_rich.csv", row.names = F, sep=",")


####finiding which rich nodes line up to be significantly different
nod_btw_ob<-subset(nodal_btw_p, nodal_btw_p$factors == "xobese")
dim(nod_btw_ob)

nod_btw_ov<-subset(nodal_btw_p, nodal_btw_p$factors == "xoverweight")
dim(nod_btw_ov)

sig_rich_ob<-merge(ob_rich, nod_btw_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_ob_day1.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, nod_btw_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_nods_ov_day1.csv", row.names=F, sep=",")
###applying the significant rich nodes to cluster coef and local
loc_eff_ob<-subset(local_eff_p, local_eff_p$factors == "xobese")
dim(loc_eff_ob)
loc_eff_ov<-subset(local_eff_p, local_eff_p$factors == "xoverweight")
dim(nod_btw_ov)

sig_rich_ob<-merge(ob_rich, loc_eff_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_ob_day1.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, loc_eff_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_local_ov_day1.csv", row.names=F, sep=",")


cluster_eff_ob<-subset(clustering_coef_p, clustering_coef_p$factors == "xobese")
dim(cluster_eff_ob)
cluster_eff_ov<-subset(clustering_coef_p, clustering_coef_p$factors == "xoverweight")
dim(cluster_eff_ov)
clustering_coef_p
cluster_eff_ov

sig_rich_ob<-merge(ob_rich, cluster_eff_ob, by=c("ROI"))
dim(sig_rich_ob)
write.table(sig_rich_ob,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_ob_day1.csv", row.names=F, sep=",")
sig_rich_ov<-merge(ov_rich, cluster_eff_ov, by=c("ROI"))
dim(sig_rich_ov)
sig_rich_ov
write.table(sig_rich_ov,"~/Google Drive/MetX/rich_analysis/comb_days/sig_rich_cluster_ov_day1.csv", row.names=F, sep=",")


