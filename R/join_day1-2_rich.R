comb_function_rich<-function(measure){
  base<-"~/Google Drive/MetX/rich_analysis/comb_days/for_paper/rich_only/"
  ndata1<-paste(base, measure, ".csv", sep="")
  ndata2<-paste(base, measure,"_day2", ".csv", sep="")
  data1<-read.table(ndata1, sep=",", header=T)
  data2<-read.table(ndata2, sep=",", header=T)
  data3<-merge(data1, data2, by=c("ROI", "Aparc","X","Y","Z"))
  data3$ave_mean_node<-apply(data3[6:7],1,mean)
  save_data2<-paste(base, measure,"_comb", ".csv", sep="")
  write.table(data3, save_data2, sep=",", row.names=F)
  return(data3)
  
}
normies<-comb_function_rich("nod_nor_rich")
obies<-comb_function_rich("nod_ob_rich")
ovies<-comb_function_rich("nod_ov_rich")

#not shared between clubs
normies[1]
obies[1]
ovies[1]
x <- rbind(normies[1],obies[1])
normVob<-x[! duplicated(x, fromLast=TRUE) & seq(nrow(x)) <= nrow(normies[1]), ]
normVob

y <- rbind(normies[1],ovies[1])
normVov<-y[! duplicated(y, fromLast=TRUE) & seq(nrow(y)) <= nrow(normies[1]), ]
normVov

z <- rbind(obies[1],ovies[1])
obVov<-z[! duplicated(z, fromLast=TRUE) & seq(nrow(z)) <= nrow(obies[1]), ]
obVov
