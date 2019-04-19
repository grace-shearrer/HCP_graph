library(ggplot2)
library(psych)
library(scales) 
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
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
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}
###################################################################################
#defining colours for graphs
cbPalette <- c("#000000", "#33CC33", "#0066CC", "#FF3333", "#9900CC", "#FFFF00")
###################################################################################
#global_eff<-read.table("~/Google Drive/MetX/data_from_renci/global_efficiency_final.csv", header=T, sep=",")
#global_null<-read.table("~/Google Drive/MetX/data_from_renci/null/null_global_efficiency_final.csv", header=T, sep=",")
#data<-merge(global_null, global_eff, by=c("BMI_group", "Wiring_cost"))

#data$mean_LocEff<-(data$Global_eff)/(data$null_global_eff)
#head(data)
#data$BMI_group<-as.factor(data$BMI_group)


# data$regularization[data$BMI_group=="normalweight100"]<-"100"
# data$regularization[data$BMI_group=="obese100"]<-"100"
# data$regularization[data$BMI_group=="overweight100"]<-"100"
# data$regularization[data$BMI_group=="normalweight5"]<-"5"
# data$regularization[data$BMI_group=="obese5"]<-"5"
# data$regularization[data$BMI_group=="overweight5"]<-"5"
# 
# null<-read.table("~/Google Drive/MetX/data_from_renci/mean_local_null.csv", header=T, sep=",")
# datam<-merge(null, data, by=c("BMI_group", "Wiring_cost"))
# data$norm_Effloc<-((data$mean_LocEff)/(data$mean_local_null))
# 
# write.table(data, "~/Google Drive/MetX/locEff_graph_measures.csv", row.names=F, sep=",")

data<-read.table("~/Google Drive/MetX/locEff_graph_measures.csv", header=T, sep=",")
head(data)
dim(data)


plot1<-ggplot(data, aes(Wiring_cost, mean_LocEff, color=BMI_group)) + geom_point() + scale_colour_manual(values=cbPalette)+scale_fill_discrete(breaks=c("normalweight5", "overweight5", "obese5", "normalweight100", "overweight100", "obese100"))
plot1 

###################################################################################
#100
###################################################################################

data100<-subset(data, data$regularization=="100")
ggplot(data100, aes(
  Wiring_cost, mean_LocEff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) 

mean_normGeff100 <- summarySE(data100, measurevar="mean_LocEff", groupvars=c("BMI_group"))
mean_normGeff100

ggplot(mean_normGeff100, aes(BMI_group, mean_LocEff)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=mean_LocEff-se, ymax=mean_LocEff+se),
                width=.2)

###################################################################################
#5
###################################################################################
data5<-subset(data, data$regularization=="5")
ggplot(data5, aes(
  Wiring_cost, mean_LocEff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) 


mean_normGeff5 <- summarySE(data5, measurevar="mean_LocEff", groupvars=c("BMI_group"))
mean_normGeff5

ggplot(mean_normGeff5, aes(BMI_group, mean_LocEff)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=mean_LocEff-se, ymax=mean_LocEff+se),
                width=.2)


