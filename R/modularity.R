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
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  #datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  #datac$ymin<-datac$mean - datac$se
  #datac$ymax<-datac$mean - datac$se
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
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
data<-read.table( "~/Google Drive/MetX/modularity_potts.csv", header=T, sep=",")

plot1<-ggplot(data, aes(
  Wiring_cost, Q1, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette)+scale_fill_discrete(breaks=c(
      "normalweight5", "overweight5", "obese5", "normalweight100", "overweight100", "obese100"))+geom_smooth()
plot1

plot2<-ggplot(data5, aes(
  Wiring_cost, Q1, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette)+geom_smooth()
plot2

# data$regularization[data$BMI_group=="normalweight100"]<-"100"
# data$regularization[data$BMI_group=="obese100"]<-"100"
# data$regularization[data$BMI_group=="overweight100"]<-"100"
# data$regularization[data$BMI_group=="normalweight5"]<-"5"
# data$regularization[data$BMI_group=="obese5"]<-"5"
# data$regularization[data$BMI_group=="overweight5"]<-"5"
# names(data)
# write.table(data, "~/Google Drive/MetX/modularity_potts.csv", row.names=F, sep=",")

#getting the data into a readable form#
data5<-subset(data, data$regularization=="5")
data5$BMI_group<-levels(droplevels(data5$BMI_group))
data5$BMI_group<-as.factor(data5$BMI_group)
summary(data5$BMI_group)
dim(data5)
#running function to test significance#
data_test<-data5[4:382]
names(data_test)
test<-sapply(data_test, fit_function, data=data5, x=data5$BMI_group)
#creating a nice looking datatable
termslabs<-c("obese5", "overweight5")#, "obese5:Wiring_cost", "overweight5:Wiring_cost")
test2<-cbind(termslabs, test)
test2
write.table(test2, "~/Google Drive/MetX/modularity_potts_pvalues5.csv", row.names=F, sep=",")
df<-read.table("~/Google Drive/MetX/modularity_potts_pvalues5.csv", header=T, sep=",")
names(df)
#melting the data so that the adj p reflects every iteration we preformed
mdata <- melt(df, id=c("termslabs"))
#mdata
names(mdata)<-c("factors", "ROIS", "pval")
head(mdata)
#adjusting for every model using FDR
mdata$BHpval<-p.adjust(mdata$pval, method="BH")
head(mdata)
#ordering by significance
mdata[order(mdata$pval),]
write.table(mdata, "~/Google Drive/MetX/modularity_potts_adp5.csv", sep=",", row.names=F)
#mdata[mdata$pval <= 0.05, ]
data2<-subset(mdata, mdata$pval <= 0.05)
data2
meanBar(data5, "R_VMV3_ROI", "BMI_group")

