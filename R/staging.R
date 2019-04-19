library(R.matlab)
#data<-openall("day2")
#list2env(data,envir=.GlobalEnv)
#data2<-openall("day2")
#list2env(data2,envir=.GlobalEnv)
load("~/Google Drive/MetX/app1/Graph.RData")
# Mod<-read.table("~/Google Drive/MetX/modularity.csv", header=T, sep=",") 
# Mod_potts<-read.table("~/Google Drive/MetX/modularity_potts.csv", header=T, sep=",")  
# Nod_btw<-read.table("~/Google Drive/MetX/total_nodal_btw.csv", header=T, sep=",")
# Nod_degree<-read.table("~/Google Drive/MetX/total_nodal_degree.csv", header=T, sep=",")
# Ek<-read.table("~/Google Drive/MetX/Ek.csv", header=T, sep=",")
# Nk<-read.table("~/Google Drive/MetX/Nk.csv", header=T, sep=",")
# R<-read.table("~/Google Drive/MetX/R.csv", header=T, sep=",")
# Eff_loc<-read.table("~/Google Drive/MetX/locEff_graph_measures.csv", header=T, sep=",")
 
# data0<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/normalweight_graph_5.mat")
# normal_5<-round(data0$netmats.5, 5)
# normal_5[normal_5<0] <- 0

# data1<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/normalweight_graph_100.mat")
# normal_100<-round(data1$netmats.100, 5)
# normal_100[normal_100<0] <- 0

# data2<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/overweight_graph_5.mat")
# data2$netmats.5
# over_5<-round(data2$netmats.5, 5)
# over_5[over_5<0] <- 0

# data3<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/overweight_graph_100.mat")
# over_100<-round(data3$netmats.100, 5)
# over_100[over_100<0] <- 0

# data4<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/obese_graph_5.mat")
# obese_5<-round(data4$netmats.5, 5)
# obese_5[obese_5<0] <- 0
 
# data5<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/obese_graph_100.mat")
# obese_100<-round(data5$netmats.100, 5)
# obese_100[obese_100<0] <- 0

# corr1<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/obese_graph_corr.mat")
# obese_corr<-round(corr1$netmats.corr, 5)
 
# corr2<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/normal_graph_corr.mat")
# normal_corr<-round(corr2$netmats.corr, 5)
 
# corr3<-readMat("~/Google Drive/MetX/data_from_renci/mat_files/overweight_graph_corr.mat")
# over_corr<-round(corr3$netmats.corr, 5)

# corr1_day2<-readMat("~/Google Drive/MetX/day2/obese_graph_corr.mat")
# corr1_day2
# obese_corr_day2<-round(corr1_day2$netmats.corr, 5)
 
# corr2_day2<-readMat("~/Google Drive/MetX/day2/normal_graph_corr.mat")
# normal_corr_day2<-round(corr2_day2$netmats.corr, 5)
 
# corr3_day2<-readMat("~/Google Drive/MetX/day2/over_graph_corr.mat")
# over_corr_day2<-round(corr3_day2$netmats.corr, 5)



# name_txt<-read.table("~/Google Drive/MetX/just_labels.txt", header=F, sep=" ")
# nms <- name_txt
# global_efficiency_comb$normEffglob<-(global_efficiency_comb$Global_eff)/(global_efficiency_null$eff_glob_null)
# global_efficiency_comb$nullEffglob<-global_efficiency_null$eff_glob_null
 
# local_efficiency_comb$normEffloc<-(local_efficiency_comb$mean_LocEff)/(mean_local_efficiency_null$mean_LocEff_null)
# local_efficiency_comb$nullEffloc<-mean_local_efficiency_null$mean_LocEff_null
#R2<-read.table("~/Google Drive/MetX/final/R2.csv", header=T, sep=",")
#head(R2)

#Nk2<-read.table("~/Google Drive/MetX/final/Nk2.csv", header=T, sep=",")
#Ek2<-read.table("~/Google Drive/MetX/final/Ek2.csv", header=T, sep=",")
#Rich<-read.table("~/Google Drive/MetX/final/rich_comb_long.csv", header=T, sep=",")
#Rich2<-read.table("~/Google Drive/MetX/final/rich2_comb_long.csv", header=T, sep=",")
#nms<-read.table("~/Google Drive/MetX/final/ROIS.csv", header=T, sep=",")
#nms<-names(nms)
#nms
#assortativity_nullR1day2<-read.table("~/Google Drive/MetX/day2/assortativity_null.csv", sep=",", header=T)
#nms2<-read.table("~/Google Drive/MetX/final/ROISwb.csv", header=T, sep=",")
#nms2<-names(nms2)
#nms2
# assortativity_day2<-read.table("~/Google Drive/MetX/day2/total_assortativity.csv", header=T, sep=",")
# clustering_coef_day2<-read.table("~/Google Drive/MetX/day2/clustering_coef.csv", header=T, sep=",")
# global_eff_day2<-read.table("~/Google Drive/MetX/day2/total_global_efficiency.csv", header=T, sep=",")
# local_eff_day2<-read.table("~/Google Drive/MetX/day2/total_local_efficiency.csv", header=T, sep=",")
# nod_btw_day2<-read.table("~/Google Drive/MetX/day2/total_nodal_btw.csv", header=T, sep=",")
# nod_deg_day2<-read.table("~/Google Drive/MetX/day2/total_nodal_degree.csv", header=T, sep=",")
# R_day2<-read.table("~/Google Drive/MetX/day2/totalR.csv", header=T, sep=",")
# Ek_day2<-read.table("~/Google Drive/MetX/day2/totalEk.csv", header=T, sep=",")
# Nk_day2<-read.table("~/Google Drive/MetX/day2/totalNk.csv", header=T, sep=",")
# head(Rn_long)
# #head(Rich2)
#Rich_day2<-read.table("~/Google Drive/MetX/day2/rich2_comb_long.csv", sep=",",header=T)
#local_efficiencyR2day1$normEffloc<-local_efficiencyR2day1$mean_local_null/mean_local_efficiency_nullR2day1$mean_LocEff_null
#global_efficiencyR2day1$normEffglob<-global_efficiencyR2day1$Global_eff/global_efficiency_nullR2day1$eff_glob_null
#head(global_efficiencyR2day1)
#assortativityR2day1$Norm_assortivity<-assortativityR2day1$Assortivity/assortativity_nullR2day1$Assortivity_null
assortativity_day2$Norm_assortivity<-assortativity_day2$Assortivity/assortativity_nullR1day2$Assortivity
head(assortativity_day2)
#head(assortativityR2day1)
save.image("~/Google Drive/MetX/app1/Graph.RData")
