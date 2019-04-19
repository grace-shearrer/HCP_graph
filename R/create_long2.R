library(reshape)
library(ggplot2)
load("~/Google Drive/MetX/app1/Graph.RData")


# data<-read.table("~/Google Drive/MetX/long_data.csv", header=T, sep=",")
# names(data)
# head(data)
# data$Parcel<-as.factor(data$Parcel)
# data_5<-subset(data,data$regularization == "5")
# data_L_Putamen<-subset(data,data$Parcel == "L_Putamen")
# ggplot(data_5, aes(Parcel, Nodal_betweenness, color=BMI_group))+geom_bar("identity")
# ggplot(data_5, aes(x=Parcel, y=Nodal_betweenness, fill=BMI_group)) +
#   geom_bar(stat="identity")

#####################

R<-read.table("~/Google Drive/MetX/day2/totalR.csv", header=T, sep=",")
dim(R)
head(R)
names(R[3:237])
R_long<-melt(R, id=c("BMI_group", "Wiring_cost"), measured=names(R2_null[3:237]))
names(R_long)<-c("BMI_group", "Wiring_cost",  "degree k", "R")
head(R_long)

dim(Ek_day2)
Ek_long<-melt(Ek_day2, id=c("BMI_group", "Wiring_cost"), measured=names(Ek2[3:237]))
names(Ek_long)<-c("BMI_group", "Wiring_cost", "degree k", "Ek")
tail(Ek_long )

dim(Nk_day2)
Nk_long<-melt(Nk_day2, id=c("BMI_group", "Wiring_cost" ), measured=names(Nk2[3:237]))
names(Nk_long)<-c("BMI_group", "Wiring_cost",  "degree k", "Nk")
tail(Nk_long)

rich2_long<-merge(R_long, Ek_long, by=c("BMI_group", "Wiring_cost",  "degree k"))
head(rich2_long)
rich2_long2<-merge(rich2_long, Nk_long, by=c("BMI_group", "Wiring_cost",  "degree k"))
head(rich2_long2)

write.table(rich2_long2, "~/Google Drive/MetX/day2/rich2_comb_long.csv", row.names=F, sep=",")

test<-read.table("~/Google Drive/MetX/final/rich2_comb_long.csv", header=T, sep=",")
View(test)
