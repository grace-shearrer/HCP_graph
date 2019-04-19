openall<-function(day){
  #base<-"~/Google Drive/MetX/final/"
  base<-"~/Google Drive/MetX/run02/"
  base<-paste(base,day,"/",sep="")
  files<-list.files(base)
  paths<-paste(base, files, sep="")
  data<-sapply(paths, read.table, header=T, sep=",")
  files2<-gsub(".csv", "", files)
  files2<-paste(files2, "R2",day,sep="")
  names(data)<-c(files2)
  return(data)
}

