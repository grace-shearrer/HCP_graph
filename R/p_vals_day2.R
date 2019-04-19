library(reshape)
library(lm.beta)
#load("~/Google Drive/MetX/app1/Graph.RData")

names(local_eff_day2) 
dim(local_eff_day2)
local<-local_eff_day2[3:382]
local_eff_p_day2<-big_fit(local_eff_day2$BMI_group, local, local_eff_day2)
dim(local_eff_p_day2)
local_eff_p_day2[order(local_eff_p_day2$pval),]
names(local_eff_p_day2)<-c("factors", "ROI", "pval", "BHpval", "beta", "CIlow", "CIhigh")
head(local_eff_p_day2)
local_eff_p_day2<-join(local_eff_p_day2, parcels)
local_eff_p_day2
write.table(local_eff_p_day2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/local_eff_sig_day2.csv", sep=",", row.names=F)


dim(nod_btw_day2)
nodal_btw0_day2<-nod_btw_day2[2:381]
nodal_btw_p_day2<-big_fit(nod_btw_day2$BMI_group, nodal_btw0_day2, nod_btw_day2)
nodal_btw_p_day2[order(nodal_btw_p_day2$pval),]
dim(nodal_btw_p_day2)
names(nodal_btw_p_day2)<-c("factors", "ROI", "pval", "BHpval", "beta","CIlow", "CIhigh")
nodal_btw_p_day2
nodal_btw_p_day2<-join(nodal_btw_p_day2, parcels)
nodal_btw_p_day2
write.table(nodal_btw_p_day2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/nodal_btw_sig_day2.csv", sep=",", row.names=F)



#out<-fit_function(global_eff_day2$BMI_group, global_eff_day2$normEffglob, global_eff_day2)
#out


names(assortativity_day2)
assortativity0=assortativity_day2[4]
head(assortativity0)
assortativity_p_day2<-big_fit(assortativity_day2$BMI_group, assortativity0, assortativity_day2)
assortativity_p_day2#super different
write.table(assortativity_p_day2, "~/Google Drive/MetX/rich_analysis/comb_days/assortativity_p_day2.csv", sep=",", row.names=F)

names(clustering_coef_day2)
clustering_coef0<-clustering_coef_day2[2:381]
clustering_coef_p_day2<-big_fit(clustering_coef_day2$BMI_group, clustering_coef0, clustering_coef_day2)
clustering_coef_p_day2#super different
names(clustering_coef_p_day2)<-c("factors", "ROI", "pval", "BHpval", "beta","CIlow", "CIhigh")
clustering_coef_p_day2<-join(clustering_coef_p_day2, parcels)
clustering_coef_p_day2
write.table(clustering_coef_p_day2, "~/Google Drive/MetX/rich_analysis/comb_days/for_paper/cluster_coef_p_day2.csv", sep=",", row.names=F)




