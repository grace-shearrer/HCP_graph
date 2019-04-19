library(psych)
library(ggplot2)
all_data<-read.table("~/Google Drive/MetX/restricted.csv", sep=",", header=T)
names(all_data )
myvars <- c("Subject", "Age_in_Yrs", "Race", "Ethnicity", "Height", "Weight",  "BMI", "BPSystolic", "BPDiastolic","HbA1C", "Hypothyroidism", "Hyperthyroidism", "OtherEndocrn_Prob", "SSAGA_BMICatHeaviest")
newdata <- all_data[myvars]
head(newdata)
data<-na.omit(newdata)
complete.cases(data)
write.table(data, "~/Google Drive/MetX/MetX.csv", sep=",", row.names=F)
#n=328
data$OtherEndocrn_Prob<-as.factor(data$OtherEndocrn_Prob)
data$Hyperthyroidism<-as.factor(data$Hyperthyroidism)
summary(data$Hyperthyroidism)
data$Hypothyroidism<-as.factor(data$Hypothyroidism)
summary(data$Hypothyroidism)
#######BMI#######
describe(data$BMI)
ggplot(data, aes(BMI)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
#mod positive skew
data$logBMI<-log10(data$BMI)
ggplot(data, aes(logBMI)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
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
#####HbA1C#####
describe(data$HbA1C)
ggplot(data, aes(HbA1C)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
#mayo clinic/ADA criteria
data$diabetes[data$HbA1C<4.0]<-"Low_status"
data$diabetes[data$HbA1C>=4.0 & data$HbA1C<5.7]<-"normal"
data$diabetes[data$HbA1C>=5.7 & data$HbA1C<6.5]<-"prediabetes"
data$diabetes[data$HbA1C>=6.5]<-"diabetes"

data$diabetes<-as.factor(data$diabetes)
summary(data$diabetes)
#need to remove low, no diabetics
##############Systolic blood pressure##############
describe(data$BPSystolic)
ggplot(data, aes(BPSystolic)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
data$sqrtSBP<-sqrt(data$BPSystolic)
ggplot(data, aes(sqrtSBP)) +  geom_histogram(aes(y=..density..), colour="black", fill="white") 
#AHA criteria
data$hypertension[data$BPSystolic<120]<-"normal"
data$hypertension[data$BPSystolic>=120 & data$BPSystolic<140]<-"prehypertension"
data$hypertension[data$BPSystolic>=140 & data$BPSystolic<160]<-"hypertension1"
data$hypertension[data$BPSystolic>=160 ]<-"hypertension2"
data$hypertension<-as.factor(data$hypertension)
summary(data$hypertension)

#removing low blood sugar, low weight, other endocrine problems
data<-subset(data, data$diabetes != "Low_status")
summary(data$diabetes)
data<-subset(data, data$ov_ob != "Underweight")
summary(data$ov_ob)
data<-subset(data, data$OtherEndocrn_Prob != 1)
summary(data$OtherEndocrn_Prob)
data<-subset(data, data$Hypothyroidism != 1)
summary(data$Hypothyroidism)
data<-subset(data, data$Hyperthyroidism != 1)
summary(data$Hyperthyroidism)

ggplot(data, aes(logBMI, HbA1C))+geom_point(aes(colour=hypertension))
