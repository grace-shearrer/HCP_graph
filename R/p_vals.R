library(plyr)
library(reshape)
library(lm.beta)
load("~/Google Drive/MetX/app1/Graph.RData")
parcels<-read.table("~/Google Drive/MetX/parcellation.csv", header=T, sep=",")
myvars2<-c("ROI","Aparc","X","Y","Z")
parcels<-parcels[myvars2]
dim(parcels)
head(parcels)

names(local_efficiency_comb) 
local<-local_efficiency_comb[4:382]
local_eff_p<-big_fit(local_efficiency_comb$BMI_group, local, local_efficiency_comb)
dim(local_eff_p)
local_eff_p[order(local_eff_p$pval),]
names(local_eff_p)<-c("factors", "ROI", "pval", "BHpval", "beta","CIlow","CIhigh")
local_eff_p<-join(local_eff_p, parcels)
local_eff_p
write.table(local_eff_p, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/local_eff_sig_day1.csv", sep=",", row.names=F)

names(nodal_degree_comb) 
nodal_degree0=nodal_degree_comb[3:381]
nodal_degree_p<-big_fit(nodal_degree_comb$BMI_group, nodal_degree0, nodal_degree_comb)
dim(nodal_degree_p)
nodal_degree_p#none

nodal_btw0<-nodal_btw_comb[3:381]
nodal_btw_p<-big_fit(nodal_btw_comb$BMI_group, nodal_btw0, nodal_btw_comb)
nodal_btw_p[order(nodal_btw_p$pval),]
dim(nodal_btw_p)
names(nodal_btw_p)<-c("factors", "ROI", "pval", "BHpval", "beta", "CIlow", "CIhigh")
nodal_btw_p<-join(nodal_btw_p, parcels)
nodal_btw_p
write.table(nodal_btw_p, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/nodal_btw_sig1.csv", sep=",", row.names=F)

modularity0=modularity_comb[4:382]
modularity_p<-big_fit(modularity_comb$BMI_group, modularity0, modularity_comb)
dim(modularity_p)
modularity_p#none

out<-fit_function(global_efficiency_comb$BMI_group, global_efficiency_comb$normEffglob, global_efficiency_comb)
out

out<-fit_function(modularity_comb$BMI_group, modularity$Q1, modularity_comb)
out

names(assortativity)
assortativity0=assortativity[3]
assortativity_p<-big_fit(assortativity$BMI_group, assortativity0, assortativity)
assortativity_p#super different
write.table(assortativity_p, "~/Google Drive/MetX/rich_analysis/comb_days/assortativity_p.csv", sep=",", row.names=F)

names(clustering_coef)
clustering_coef0=clustering_coef[3:381]
clustering_coef_p<-big_fit(clustering_coef$BMI_group, clustering_coef0, clustering_coef)
clustering_coef_p#super different
names(clustering_coef_p)<-c("factors", "ROI", "pval", "BHpval", "beta", "CIlow", "CIhigh")
clustering_coef_p<-join(clustering_coef_p, parcels)
clustering_coef_p
write.table(clustering_coef_p, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/cluster_coef_p.csv", sep=",", row.names=F)

names(path_length)
path_length0=path_length[3:6]
path_length_p<-big_fit(path_length$BMI_group, path_length0, path_length)
path_length_p#none



