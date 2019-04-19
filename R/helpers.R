library(remef)
library(multcomp)
library(MASS)
library(ggplot2)
library(reshape)
cbPalette <- c("#000000", "#33CC33", "#0066CC", "#FF3333", "#9900CC", "#FFFF00")
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

fit_function<-function(x,y,data){
  fit<-lm(y~x, data=data, na.rm=T)
  sumfit<-summary(fit)
  final<-coef(summary(fit))[, 4]
  final[2:4]
}

fit_function2<-function(x,y,data){
  library(lm.beta)
  fit<-lm(y~x, data=data, na.rm=T)
  beta<-lm.beta(fit)
  y<-coef(summary(beta))[,2]
  y[2:3]
}

CI_low_function<-function(x,y,data){
  fit<-lm(y~x, data=data, na.rm=T)
  a<-confint.default(fit)[,1] #2.5%
  a[2:3]
}

CI_high_function<-function(x,y,data){
  fit<-lm(y~x, data=data, na.rm=T)
  b<-confint.default(fit)[,2] #97.5%
  b[2:3]
}

big_fit<-function(x, colz, data){
  myvars<-names(colz)
  newdata <- data[myvars]
  test<-head(newdata)#all the ROIs as columns
  a0<-sapply(newdata, fit_function, data=data, x=x) #applying fit_function across the ROIs
  df <- melt(a0, id=c("termslabs"))
  names(df)<-c("factors", "ROIS", "pval")
  df$BHpval<-p.adjust(df$pval, method="BH")
  df[order(df$pval),]
  df_p<-subset(df, df$BHpval <= 0.05)#all the p values
  
  a1<-sapply(newdata, fit_function2, data=data, x=x)#applying fit function 2 to get betas
  test2<-head(a1)
  df2 <- melt(a1)
  names(df2)<-c("factors", "ROIS", "beta")
  test3<-head(df2)
  
  a2<-sapply(newdata, CI_low_function, data=data, x=x)#applying CI function 3 to get CI low
  test4<-head(a2)
  df3 <- melt(a2)
  names(df3)<-c("factors", "ROIS", "CIlow")
   
  a3<-sapply(newdata, CI_high_function, data=data, x=x)#applying CI function 3 to get CI high
  test5<-head(a3)
  df4 <- melt(a3)
  names(df4)<-c("factors", "ROIS", "CIhigh")
  
  df_f0<-merge(df3, df4, by=c("factors", "ROIS"))#merging the CI low and high
  df_f1<-merge(df_p, df2, by=c("factors", "ROIS"))#merging the pvals and the betas
  df_f<-merge(df_f1, df_f0, by=c("factors", "ROIS"))#merging the pvals and the betas
  return(df_f)
}

# big_fit<-function(x, colz, data){
#   myvars<-names(colz)
#   newdata <- data[myvars]
#   a0<-sapply(newdata, fit_function, data=data, x=x)
#   df <- melt(a0, id=c("termslabs"))
#   names(df)<-c("factors", "ROIS", "pval")
#   df$BHpval<-p.adjust(df$pval, method="BH")
#   df[order(df$pval),]
#   df_p<-subset(df, df$BHpval <= 0.05)
# 
#   a1<-sapply(newdata, fit_function2, data=data, x=x)
#   df2 <- melt(a1)
#   names(df2)<-c("factors", "ROIS", "beta")
#   df_f<-merge(df_p, df2, by=c("factors", "ROIS"))
#   return(df_f)
# }


meanBar<-function(df, measurevar, groupvar){
  means <- summarySE(df, measurevar=measurevar, groupvars=groupvar)
  means$ymin<-means$mean-means$se
  means$ymax<-means$mean+means$se
  plot1<-ggplot(means, aes_string(groupvar, "mean", fill=groupvar)) +
    geom_bar(position=position_dodge(), stat="identity") +
    geom_errorbar(aes(ymin=ymin, ymax=ymax),
                  width=.2)+ scale_colour_manual(values=cbPalette)
  return(list(measurevar, plot1, means))
}

add_func<-function(df){
  mean<-as.numeric(df[4])
  se<-as.numeric(df[6])
  x<-mean+se
  return(x)
}

sub_func<-function(df){
  mean<-as.numeric(df[4])
  se<-as.numeric(df[6])
  x<-mean-se
  return(x)
}

bigbar<-function(df1,colz,df2){
  library(reshape)
  library(ggplot2)
  library(plyr)
  labels<-read.table("~/Google Drive/MetX/human_labels.csv", header=T, sep=",")
  myvars<-names(colz)
  data_long<-melt(df1, id=myvars)
  names(data_long)<-c("BMI","Wiring_cost", "ROI", "value")
  data_comb0<-merge(data_long, df2, by=c("ROI"))
  data_comb<-join(data_comb0, labels)
  means <- summarySE(data_comb, measurevar="value", groupvars=c("BMI.x", "Label"))
  means$ymax<-apply(means,1, add_func)
  means$ymin<-apply(means,1, sub_func)
  means$BMI.x <- factor(means$BMI.x, levels = c("normal", "overweight", "obese"))
  plot2<-ggplot(means, aes_string("Label", "mean", fill="BMI.x")) +
    geom_bar(position=position_dodge(), stat="identity") +
    geom_errorbar(aes(ymin=means$ymin, ymax=means$ymax),width=.5, position=position_dodge(.9))+ 
    scale_colour_manual(values=cbPalette)+theme_bw()+ 
    theme(panel.background = element_rect(fill = "transparent"), panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
    theme(axis.title.x = element_blank(),axis.text.x  = element_text(size=35, angle=15, hjust = 1))+
    theme(axis.title.y = element_blank(),axis.text.y  = element_text(size=35))+
    theme(legend.text = element_text(size = 26))+
    theme(legend.title = element_text(size=35, face="bold"))+
    theme(plot.margin = unit(c(1,6,1,6),"cm"), plot.background = element_rect(fill = "transparent"), legend.background = element_rect(fill = "transparent"), legend.box.background = element_rect(fill = "transparent"))+
    scale_fill_discrete(name  ="BMI group")
  return(plot2)
}

hist_func<-function(data, variable){
  plot1<-ggplot(data, aes(variable))+geom_histogram()
  return(plot1)
}

# 
combine_function<-function(status, filename){
  base<-"~/Google Drive/MetX/data_from_renci/"
  read_data<-paste(base, status, "/full_corr/", filename, ".txt", sep="")
  test_data<-read.table(read_data, sep=" ", header=F)
  data<-test_data[2:dim(test_data)[2]]
  list_data<-paste(base, status, "_list.txt", sep="")
  bmi<-read.table(list_data, sep="\t", header=F)
  data1<-cbind(bmi, data)
  outfile<-paste(base, status, "_", filename, "_test.csv", sep="")
  print(outfile)
  write.table(data1, outfile, sep=",", row.names=F)
  return(data1)
}
combine_function("normal", "R2")

comb_function<-function(measure){
  base<-"~/Google Drive/MetX/rich_analysis/comb_days/for_paper/"
  ndata1<-paste(base, measure, ".csv", sep="")
  ndata2<-paste(base, measure,"_day2", ".csv", sep="")
  data1<-read.table(ndata1, sep=",", header=T)
  data2<-read.table(ndata2, sep=",", header=T)
  data3<-merge(data1, data2, by=c("factors","ROI", "Aparc","X","Y","Z"))
  betas<-cbind(data3[9],data3[14])
  CIlow<-cbind(data3[10],data3[15])
  CIhigh<-cbind(data3[11],data3[16])
  data3$ave_beta<-apply(betas,1,mean)
  data3$ave_CIlow<-apply(CIlow,1,mean)
  data3$ave_CIhigh<-apply(CIhigh,1,mean)
  save_data2<-paste(base, measure,"_comb", ".csv", sep="")
  write.table(data3, save_data2, sep=",", row.names=F)
  return(data3)
}

write_func<-function(namer, data){
  base<-"~/Google Drive/MetX/data_from_renci/"
  title<-paste(base, "name/", namer, "_names.csv", sep="")
  titles<-read.table(title, sep=",", header=T)
  names(data)<-names(titles)
  read_data<-paste(base, namer, "_comb.csv", sep="")
  write.table(data, read_data, sep=",", row.names=F)
  return(read_data)
}

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

OVOB<-function(BMI, data){
  data$ov_ob[BMI<18.5]<-"Underweight"
  data$ov_ob[BMI>=18.5 & BMI<25]<-"Normalweight"
  data$ov_ob[BMI>=25 & BMI<30]<-"Overweight"
  data$ov_ob[BMI>=30]<-"Obese"
  return(data$ov_ob)
}

BMI_cal<-function(height, weight){
  weight_kg<-(weight/2.20462)
  height_m<-(height*2.54)/100
  BMI=weight_kg/(height_m)^2
  return(BMI)
}


jittery <- function(onsets, T, nsamp) {
  lambda = 1.5
  shift=2
  m.theory = lambda - T/(exp(1/lambda*T)-1)
  
  R = runif(nsamp)*(1-exp(-T/lambda))
  rand.trunc.exp = -log(1-R)*lambda + shift
  
  #theoretical mean
  theo_mean=m.theory + shift
  #min ITI
  low = min(rand.trunc.exp)
  #max ITI
  high = max(rand.trunc.exp)
  iti.uni = runif(nsamp, low, high)
  
  vr <- c(0) ### an empty vector 
  for (i in 2:length(onsets)) {
    jitter<-sample(iti.uni, 1)
    vr[i] <- onsets[i]+jitter
  }
  vr
  vr<-round(vr, 0)
  return(list(vr, theo_mean))
}

mult_func<-function(df){
  x<-df[33]*df[31]
  return(x)
}