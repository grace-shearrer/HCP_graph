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
###################################################################################
#defining colours for graphs
cbPalette <- c("#000000", "#33CC33", "#0066CC", "#FF3333", "#9900CC", "#FFFF00")
###################################################################################
#global_eff<-read.table("~/Google Drive/MetX/data_from_renci/global_efficiency_final.csv", header=T, sep=",")
#global_null<-read.table("~/Google Drive/MetX/data_from_renci/null/null_global_efficiency_final.csv", header=T, sep=",")
#data<-merge(global_null, global_eff, by=c("BMI_group", "Wiring_cost"))

#data$norm_glob_eff<-(data$Global_eff)/(data$null_global_eff)
#head(data)
#data$BMI_group<-as.factor(data$BMI_group)


#data$regularization[data$BMI_group=="normalweight100"]<-"100"
#data$regularization[data$BMI_group=="obese100"]<-"100"
#data$regularization[data$BMI_group=="overweight100"]<-"100"
#data$regularization[data$BMI_group=="normalweight5"]<-"5"
#data$regularization[data$BMI_group=="obese5"]<-"5"
#data$regularization[data$BMI_group=="overweight5"]<-"5"

#write.table(data, "~/Google Drive/MetX/graph_measures.csv", row.names=F, sep=",")
data<-read.table("~/Google Drive/MetX/global_eff.csv", header=T, sep=",")
plot1<-ggplot(data, aes(Wiring_cost, norm_glob_eff, color=BMI_group)) + geom_point() + scale_colour_manual(values=cbPalette)+scale_fill_discrete(breaks=c("normalweight5", "overweight5", "obese5", "normalweight100", "overweight100", "obese100"))
plot1 
#graphs look like log functions, transforming the wiring cost to be log based
#looking at regularization subsets#


###################################################################################
#100
###################################################################################

data100<-subset(data, data$regularization=="100")
ggplot(data100, aes(
  Wiring_cost, norm_glob_eff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) 

ggplot(data100, aes(
  Wiring_cost, Global_eff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) #+geom_point(position=position_jitter(width=0.06))

mean_normGeff100 <- summarySE(data100, measurevar="norm_glob_eff", groupvars=c("BMI_group"))
mean_normGeff100
typeof(mean_normGeff100)

ggplot(mean_normGeff100, aes(BMI_group, norm_glob_eff)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=norm_glob_eff-se, ymax=norm_glob_eff+se),
                width=.2)

fit100 <- lm (norm_glob_eff ~ BMI_group, data=data100)
summary(fit100)
sqrt(0.2215)
TukeyHSD(fit100)
###################################################################################
#5
###################################################################################
data5<-subset(data, data$regularization=="5")
ggplot(data5, aes(
  Wiring_cost, norm_glob_eff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) 

ggplot(data5, aes(
  Wiring_cost, Global_eff, color=BMI_group)) + geom_point() + scale_colour_manual(
    values=cbPalette) #+geom_point(position=position_jitter(width=0.01))

mean_normGeff5 <- summarySE(data5, measurevar="norm_glob_eff", groupvars=c("BMI_group"))
mean_normGeff5

ggplot(mean_normGeff5, aes(BMI_group, norm_glob_eff)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=norm_glob_eff-se, ymax=norm_glob_eff+se),
                width=.2)

mean_Geff5 <- summarySE(data5, measurevar="Global_eff", groupvars=c("BMI_group"))
mean_Geff5

ggplot(mean_Geff5, aes(BMI_group, Global_eff)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Global_eff-se, ymax=Global_eff+se),
                width=.2)


fit5 <- lm(norm_glob_eff ~ BMI_group, data=data5)
sumfit5<-summary(fit5)
pearson_correlation<-sqrt(0.0001115)
#BMI accounts for less than 1% of variation, this model sucks