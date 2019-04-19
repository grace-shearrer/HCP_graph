library(psych)
library(ggplot2)
library(reshape)
library(tidyr)
all_data<-read.table("~/Google Drive/MetX/RESTRICTED_gshearrer_1_22_2017_8_14_18.csv", sep=",", header=T)
describe(all_data$Age_in_Yrs)
names(all_data )
myvars <- c("Subject","Age_in_Yrs", "Race", "Ethnicity", "Height", "Weight",  "BMI", "Twin_Stat", "Zygosity", "Mother_ID")
newdata <- all_data[myvars]
head(newdata)
data<-newdata
#data<-na.omit(newdata)
#complete.cases(data)
write.table(data, "~/Google Drive/MetX/MetX_twins.csv",sep=",", row.names=F)
describe(data$Age_in_Yrs)
####TWINS#####
summary(data$Twin_Stat)
#n=881
#######BMI#######
describe(data$BMI)
ggplot(data, aes(BMI)) +  geom_histogram(aes(y=..density..), colour="black",fill="white") 
#mod positive skew
data$logBMI<-log10(data$BMI)
ggplot(data, aes(logBMI)) +  geom_histogram(aes(y=..density..), colour="black",fill="white") 
#log is normal
#######Overweight or Obese####
data$ov_ob[data$BMI<18.5]<-"Underweight"
data$ov_ob[data$BMI>=18.5 & data$BMI<25]<-"Normalweight"
data$ov_ob[data$BMI>=25 & data$BMI<30]<-"Overweight"
data$ov_ob[data$BMI>=30]<-"Obese"
data$ov_ob<-as.factor(data$ov_ob)
summary(data$ov_ob)
#will want to remove the underweight#
######AGE#####
describe(data$Age_in_Yrs)
ggplot(data, aes(Age_in_Yrs)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
#pretty normal
#all adults
###removing the underweight###
data<-subset(data, data$ov_ob != "Underweight")
summary(data$ov_ob)
#####subset no twins#####
notwin<-subset(data, data$Twin_Stat=="NotTwin")
describe(notwin$Age_in_Yrs)
summary(notwin$ov_ob)
NotTwinData<-notwin$Subject 
head(NotTwinData)
write.table(NotTwinData, "~/Desktop/NotTwin.txt", row.names = F)
#####subset MZ#####
MZtwin<-subset(data, data$Zygosity=="MZ")
write.table(MZtwin, "~/Desktop/MZtwin.csv", row.names=F, sep=",")
describe(MZtwin$Age_in_Yrs)
summary(MZtwin$ov_ob)
MZData<-MZtwin$Subject 
head(MZData)
write.table(MZData, "~/Desktop/MZ.txt", row.names = F)
#####subset DZ#####
DZtwin<-subset(data, data$Zygosity=="NotMZ")
describe(DZtwin$Age_in_Yrs)
write.table(DZtwin, "~/Desktop/DZtwin.csv", row.names=F, sep=",")

summary(DZtwin$ov_ob)
DZData<-DZtwin$Subject 
head(DZData)
write.table(DZData, "~/Desktop/DZ.txt", row.names = F)
