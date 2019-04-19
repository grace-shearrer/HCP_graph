data<-read.table("~/Google Drive/MetX/twin_lists/new1200/twin_BMI.csv", sep=",", header=T)
head(data)
data$ov_ob[data$BMI<18.5]<-"Underweight"
data$ov_ob[data$BMI>=18.5 & data$BMI<25]<-"Normalweight"
data$ov_ob[data$BMI>=25 & data$BMI<30]<-"Overweight"
data$ov_ob[data$BMI>=30]<-"Obese"
data$ov_ob<-as.factor(data$ov_ob)

normal<-subset(data, data$ov_ob == "Normalweight")
over<-subset(data, data$ov_ob == "Overweight")
obese<-subset(data, data$ov_ob == "Obese")
write.table(normal$Subject, "~/Google Drive/MetX/twin_lists/new1200/normal.txt", sep=" ", row.names=F)
write.table(over$Subject, "~/Google Drive/MetX/twin_lists/new1200/over.txt", sep=" ", row.names=F)
write.table(obese$Subject, "~/Google Drive/MetX/twin_lists/new1200/obese.txt", sep=" ", row.names=F)
