load("~/Google Drive/MetX/app1/Graph.RData")
null_CC<-read.table("~/Google Drive/MetX/final/clustering_coef_null.csv", sep=",", header=T)
null_path<-read.table("~/Google Drive/MetX/final/path_length_null.csv", sep=",", header=T)

names(null_CC)
null_CC$mean_null<-apply(null_CC[3:381], 1, mean)
null_CC$mean_null

clustering_coef$mean_null<-apply(clustering_coef[3:381], 1, mean)
clustering_coef$mean_null
clustering_coef$mean_norm<-(clustering_coef$mean_null)/(null_CC$mean_null)
clustering_coef$mean_norm

names(path_length)
path_length$lambda_norm<-(path_length$lambda)/(null_path$lambda)
path_length$lambda_norm

clustering_coef$small_world<-(clustering_coef$mean_norm)/(path_length$lambda_norm)
clustering_coef$small_world
save.image("~/Google Drive/MetX/app1/Graph.RData")
