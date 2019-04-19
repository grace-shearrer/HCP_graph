#demographics
full<-read.table("~/Google Drive/MetX/RESTRICTED_gshearrer_1_22_2017_8_14_18.csv", header=T, sep=",")
names(full[1])
normal1<-read.table("~/Google Drive/MetX/demographics/day1/normal_clean.txt", sep=" ", header=F)
head(normal1)

demo_func<-function(day, BMI){
     library(reshape)
     library(psych)
     base<-"~/Google Drive/MetX/demographics/"
     title<-paste(base, day,"/", BMI, "_clean.txt", sep="")
     titles<-read.table(title, sep=" ", header=F)
     names(titles)<-c("Subject")
     x=dim(titles)
     full<-read.table("~/Google Drive/MetX/RESTRICTED_gshearrer_1_22_2017_8_14_18.csv", header=T, sep=",")
     full2<-read.table("~/Google Drive/MetX/unrestricted_gshearrer_6_18_2017_13_59_46.csv", header=T, sep=",")
     myvars=c("Subject","Race", "Ethnicity", "BMI", "Age_in_Yrs")
     myvars2=c("Subject", "Gender")
     data1<-full[myvars]
     data2<-full2[myvars2]
     data<-merge(data1, data2, by="Subject")
     final<-merge(data, titles, by="Subject")
     x<-describe(final$BMI)
     y<-summary(final$Gender)
     z<-describe(final$Age_in_Yrs)
     return(list(x,y,z))
}
demo_func("day1", "normal")

chi_func<-function(day){
  library(reshape)
  library(psych)
  base<-"~/Google Drive/MetX/demographics/"
  title<-paste(base, day,"/", "ov_ob.csv", sep="")
  ovob<-read.table(title, sep=",", header=T)
  #ovob<-read.table("~/Google Drive/MetX/demographics/day1/ov_ob.csv", header=T, sep=",")
  full<-read.table("~/Google Drive/MetX/RESTRICTED_gshearrer_1_22_2017_8_14_18.csv", header=T, sep=",")
  full2<-read.table("~/Google Drive/MetX/unrestricted_gshearrer_6_18_2017_13_59_46.csv", header=T, sep=",")
  myvars=c("Subject","Race", "Ethnicity", "BMI", "Age_in_Yrs")
  myvars2=c("Subject", "Gender")
  data1<-full[myvars]
  data2<-full2[myvars2]
  data<-merge(data1, data2, by="Subject")
  final<-merge(data, ovob, by="Subject")
  mytable <- xtabs(~ov_ob+Gender, data=final)
  y<-ftable(mytable) # print table 
  q<-summary(mytable) # chi-square test of indepedence
  x<-aov(Age_in_Yrs ~ ov_ob, final)
  z<-summary(x)
  library(gmodels)
  a<-CrossTable(final$ov_ob, final$Gender, expected = TRUE)
  return(list(x,z,a))
}
chi_func("day1")
help("CrossTable")
