data<-read.table("~/Google Drive/MetX/twin_lists/new1200/twin_BMI.csv", sep=",", header=T)
data1<-read.table("~/Google Drive/MetX/twin_lists/new1200/new_subs.txt", sep=" ", header=F)
names(data)
names(data1)<-c("Subject")
dim(data1)
new_data<-merge(data, data1, by="Subject")
dim(new_data)
unq_data<-new_data[!duplicated(new_data$Mother_ID),]
unq_data[duplicated(unq_data$Mother_ID),]
dim(unq_data)
dup_data<-new_data[duplicated(new_data$Mother_ID),]
dup_data
dup_data[duplicated(dup_data$Mother_ID),]
dup_data[order(dup_data$Mother_ID),] 
View(dup_data)

un_data_MZ<-subset(unq_data, unq_data$ZygositySR == "MZ")
write.table(un_data_MZ, "~/Google Drive/MetX/twin_lists/new1200/un_data_MZ.csv", sep = ",", row.names = F)
un_data_DZ<-subset(unq_data, unq_data$ZygositySR == "DZ")
write.table(un_data_DZ, "~/Google Drive/MetX/twin_lists/new1200/un_data_DZ.csv", sep = ",", row.names = F)
un_data_NT<-subset(unq_data, unq_data$ZygositySR == "NotTwin")
write.table(un_data_NT, "~/Google Drive/MetX/twin_lists/new1200/un_data_NT.csv", sep = ",", row.names = F)

dup_data_NT<-subset(dup_data, dup_data$ZygositySR == "NotTwin")
write.table(dup_data_NT, "~/Google Drive/MetX/twin_lists/new1200/dup_data_NT.csv", sep = ",", row.names = F)
dup_data_DZ<-subset(dup_data, dup_data$ZygositySR == "DZ")
write.table(dup_data_DZ, "~/Google Drive/MetX/twin_lists/new1200/dup_data_DZ.csv", sep = ",", row.names = F)
dup_data_MZ<-subset(dup_data, dup_data$ZygositySR == "MZ")
write.table(dup_data_MZ, "~/Google Drive/MetX/twin_lists/new1200/dup_data_MZ.csv", sep = ",", row.names = F)

