data1<-read.table("~/Google Drive/MetX/run02/day2/clustering_coef.txt", sep="\t", header=F)
dim(data1)
head(data1)
data2<-read.table("~/Google Drive/MetX/run02/day1/clustering_coef.csv", sep=",", header=T)
dim(data2)

cleaner<-function(name){
  base<-"~/Google Drive/MetX/run02"
  ndata2<-paste(base, "/day2/", name, ".txt", sep="")
  ndata1<-paste(base, "/day1/", name, ".csv", sep="")
  data1<-read.table(ndata1, sep=",", header=T)
  data2<-read.table(ndata2, sep=" ", header=F)
  heads<-names(data1)
  names(data2)<-c(heads)
  data2<-subset(data2, data2$BMI_group != "null")
  #data2$Wiring_cost[data2$BMI_group %in% data1$BMI_group] <- data1$Wiring_cost
  data2$Wiring_cost <- data1$Wiring_cost
  save_data2<-paste(base, "/day2/", name, ".csv", sep="")
  write.table(data2, save_data2, sep=",", row.names=F)
  return(data2)
}

null_cleaner<-function(name){
  base<-"~/Google Drive/MetX/run02"
  ndata2<-paste(base, "/day2/", name, ".txt", sep="")
  ndata1<-paste(base, "/day1/", name, ".csv", sep="")
  data1<-read.table(ndata1, sep=",", header=T)
  data2<-read.table(ndata2, sep=" ", header=F)
  heads<-names(data1)
  names(data2)<-c(heads)
  #data2<-subset(data2, data2$BMI_group != "null")
  #data2$Wiring_cost[data2$BMI_group %in% data1$BMI_group] <- data1$Wiring_cost
  data2$Wiring_cost <- data1$Wiring_cost
  save_data2<-paste(base, "/day2/", name, ".csv", sep="")
  write.table(data2, save_data2, sep=",", row.names=F)
  return(data2)
}

null_cleaner("mean_local_efficiency_null")
View(test)
