#testing the modularity
#install.packages("devtools")
#devtools::install_github("hohenstein/remef")
library(remef)
library(multcomp)
library(MASS)
library(reshape)
library(ggplot2)
####################################################################################################################################
fit_function<-function(x,z,a,y){
  fit<-lm(x~z+a, data=y)
  sumfit<-summary(fit)
  final<-coef(summary(fit))[, 4]
  final[2:4]
}
####################################################################################################################################
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  return(datac)
}
####################################################################################################################################
meanBar<-function(df, measurevar, groupvar){
  means <- summarySE(df, measurevar=measurevar, groupvars=groupvar)
  means$ymin<-means$mean-means$se
  means$ymax<-means$mean+means$se
  plot1<-ggplot(means, aes_string(groupvar, "mean")) +
    geom_bar(position=position_dodge(), stat="identity") +
    geom_errorbar(aes(ymin=ymin, ymax=ymax),
                  width=.2)
  return(list(measurevar, plot1, means))
}
####################################################################################################################################
data<-read.table( "~/Google Drive/MetX/total_nodal_degree.csv", header=T, sep=",")

# data$regularization[data$BMI_group=="normalweight100"]<-"100"
# data$regularization[data$BMI_group=="obese100"]<-"100"
# data$regularization[data$BMI_group=="overweight100"]<-"100"
# data$regularization[data$BMI_group=="normalweight5"]<-"5"
# data$regularization[data$BMI_group=="obese5"]<-"5"
# data$regularization[data$BMI_group=="overweight5"]<-"5"
# names(data)
# write.table(data, "~/Google Drive/MetX/total_nodal_degree.csv", row.names=F, sep=",")

dim(data)
names(data)
#getting the data into a readable form#
data5<-subset(data, data$regularization=="5")
data5$BMI_group<-levels(droplevels(data5$BMI_group))
data5$BMI_group<-as.factor(data5$BMI_group)
summary(data5$BMI_group)
dim(data5)
#running function to test significance#
data_test<-data5[3:381]
names(data_test)
test<-sapply(data_test, fit_function, y=data5, z=data5$BMI_group, a=data5$Wiring_cost)
#creating a nice looking datatable
termslabs<-c("obese5", "overweight5", "Wiring_cost")
test2<-cbind(termslabs, test)
test2
write.table(test2, "~/Google Drive/MetX/nodal_degree_pvalues5.csv", row.names=F, sep=",")
df<-read.table("~/Google Drive/MetX/nodal_degree_pvalues5.csv", header=T, sep=",")
names(df)
#melting the data so that the adj p reflects every iteration we preformed
mdata <- melt(df, id=c("termslabs"))
#mdata
names(mdata)<-c("factors", "ROIS", "pval")
head(mdata)
#adjusting for every model using FDR
mdata$adpval<-p.adjust(mdata$pval, method="BH")
head(mdata)
#ordering by significance
mdata[order(mdata$pval),]
write.table(mdata, "~/Google Drive/MetX/nodal_degree_adp5.csv", sep=",", row.names=F)

meanBar(data5, "L_7Am_ROI", "BMI_group")

