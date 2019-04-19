library(reshape)
library(ggplot2)
load("~/Google Drive/MetX/app1/Graph.RData")


#data<-read.table("~/Google Drive/MetX/long_data.csv", header=T, sep=",")
#names(data)
#head(data)
#data$Parcel<-as.factor(data$Parcel)
#data_5<-subset(data,data$regularization == "5")
#data_L_Putamen<-subset(data,data$Parcel == "L_Putamen")
#ggplot(data_5, aes(Parcel, Nodal_betweenness, color=BMI_group))+geom_bar("identity")
#ggplot(data_5, aes(x=Parcel, y=Nodal_betweenness, fill=BMI_group)) +
#  geom_bar(stat="identity")

#####################
#Rn<-read.table("~/Google Drive/MetX/day2/R_null.csv", header=T, sep=",")
dim(RR2day1)
head(RR2day1)
names(Rn[3:237])
RR2day1_long<-melt(RR2day1, id=c("BMI_group", "Wiring_cost"), measured=names(RR2day1[3:235]))
names(RR2day1_long)<-c("BMI_group", "Wiring_cost",  "degree k", "R")
head(RR2day1_long)

dim(RR2day2)

RR2day2_long<-melt(RR2day2, id=c("BMI_group", "Wiring_cost"), measured=names(RR2day2[3:230]))
names(RR2day2_long)<-c("BMI_group", "Wiring_cost",  "degree k", "R")
head(RR2day2_long)
write.table(RR2day2_long, "~/Google Drive/MetX/run02/day2/R_long.csv", sep=",", row.names = F)
RR2day2_long<-read.table("~/Google Drive/MetX/run02/day2/R_long.csv", sep=",", header = T)
RR2day2_long$degree.k<-RR2day2_long$degree.k+1

write.table(RR2day1_long, "~/Google Drive/MetX/run02/day1/R_long.csv", sep=",", row.names = F)
RR2day1_long<-read.table("~/Google Drive/MetX/run02/day1/R_long.csv", sep=",", header = T)
RR2day1_long$degree.k<-RR2day1_long$degree.k+1

dim(R_nullR2day1)
R_nullR2day1_long<-melt(R_nullR2day1, id=c("BMI_group", "Wiring_cost"), measured=names(R_nullR2day1[3:224]))
names(R_nullR2day1_long)<-c("BMI_group", "Wiring_cost",  "degree k", "R")
head(R_nullR2day1_long)
write.table(R_nullR2day1_long, "~/Google Drive/MetX/run02/day1/Rn_long.csv", sep=",", row.names = F)
R_nullR2day1_long<-read.table("~/Google Drive/MetX/run02/day1/Rn_long.csv", sep=",", header = T)
R_nullR2day1_long$degree.k<-R_nullR2day1_long$degree.k+1

RR2day1_long$R_norm<-RR2day1_long$R/R_nullR2day1_long$R
head(RR2day1_long)
