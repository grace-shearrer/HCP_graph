library(R.matlab)
library(psych)
data <-readMat("~/Google Drive/HCP_graph/matrices_raw/normal_graph_corr.mat")
normal<-data$mean.matrix
normalz<-fisherz(normal)
dim(normalz)

ov_data <-readMat("~/Google Drive/HCP_graph/matrices_raw/over_graph_corr.mat")
over<-ov_data$mean.matrix
overz<-fisherz(over)
dim(overz)

ob_data <-readMat("~/Google Drive/HCP_graph/matrices_raw/obese_graph_corr.mat")
obese<-ob_data$mean.matrix
obesez<-fisherz(obese)
dim(obesez)

write.table(normalz, "~/Google Drive/HCP_graph/matrices_raw/normal_graph_corr_Z.txt", sep=" ", row.names = F, col.names = F)
write.table(overz, "~/Google Drive/HCP_graph/matrices_raw/over_graph_corr_Z.txt", sep=" ", row.names = F, col.names = F)
write.table(obesez, "~/Google Drive/HCP_graph/matrices_raw/obese_graph_corr_Z.txt", sep=" ", row.names = F, col.names = F)
