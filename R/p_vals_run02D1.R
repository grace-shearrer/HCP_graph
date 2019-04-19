library(plyr)
library(reshape)
library(lm.beta)
load("~/Google Drive/MetX/app1/Graph.RData")
parcels<-read.table("~/Google Drive/MetX/parcellation.csv", header=T, sep=",")
myvars2<-c("ROI","Aparc","X","Y","Z")
parcels<-parcels[myvars2]
dim(parcels)
head(parcels)

names(local_efficiencyR2day2) 
dim(local_efficiencyR2day2)
local<-local_efficiencyR2day2[2:382]
local_eff_p<-big_fit(local_efficiencyR2day2$BMI_group, local, local_efficiencyR2day2)
dim(local_eff_p)
local_eff_p[order(local_eff_p$pval),]
names(local_eff_p)<-c("factors", "ROI", "pval", "BHpval", "beta")
local_eff_p<-join(local_eff_p, parcels)
local_eff_p
write.table(local_eff_p, "~/Google Drive/MetX/run02/day2/local_eff_sig.csv", sep=",", row.names=F)

names(nodal_btwR2day2) 
dim(nodal_btwR2day2)
nodal_degree0<-nodal_btwR2day2[3:381]
nodal_degree_p<-big_fit(nodal_btwR2day2$BMI_group, nodal_degree0, nodal_btwR2day2)
dim(nodal_degree_p)
nodal_degree_p
write.table(nodal_degree_p, "~/Google Drive/MetX/run02/day2/nodal_deg_sig.csv", sep=",", row.names=F)

names(nodal_btwR2day2)
dim(nodal_btwR2day1)
nodal_btw0<-nodal_btwR2day2[3:380]
nodal_btw_p<-big_fit(nodal_btwR2day2$BMI_group, nodal_btw0, nodal_btwR2day2)
nodal_btw_p[order(nodal_btw_p$pval),]
dim(nodal_btw_p)
names(nodal_btw_p)<-c("factors", "ROI", "pval", "BHpval", "beta")
nodal_btw_p<-join(nodal_btw_p, parcels)
nodal_btw_p
write.table(nodal_btw_p, "~/Google Drive/MetX/run02/day2/nodal_btw_sig.csv", sep=",", row.names=F)

names(modularityR2day2)
modularity0=modularity_comb[2:382]
modularity_p<-big_fit(modularityR2day2$BMI_group, modularity0, modularityR2day2)
dim(modularity_p)
modularity_p#none

glob<-global_efficiencyR2day2[4]
out<-big_fit(global_efficiencyR2day2$BMI_group, glob, global_efficiencyR2day2)
out

modularity0<-modularityR2day2[3]
out<-big_fit(modularityR2day2$BMI_group, modularity0, modularityR2day2)
out

names(assortativityR2day2)
assortativity0=assortativityR2day2[3]
assortativity_p<-big_fit(assortativityR2day2$BMI_group, assortativity0, assortativityR2day2)
assortativity_p#super different
write.table(assortativity_p, "~/Google Drive/MetX/run02/day2/assortativity_p.csv", sep=",", row.names=F)

names(clustering_coefR2day2)
clustering_coef0=clustering_coef[2:381]
clustering_coef_p<-big_fit(clustering_coefR2day2$BMI_group, clustering_coef0, clustering_coefR2day2)
clustering_coef_p#super different
names(clustering_coef_p)<-c("factors", "ROI", "pval", "BHpval", "beta")
clustering_coef_p<-join(clustering_coef_p, parcels)
clustering_coef_p
write.table(clustering_coef_p, "~/Google Drive/MetX/run02/day2/cluster_coef_p.csv", sep=",", row.names=F)

names(path_lengthR2day2)
path_length0=path_lengthR2day2[3:6]
path_length_p<-big_fit(path_lengthR2day2$BMI_group, path_length0, path_lengthR2day2)
path_length_p#none



