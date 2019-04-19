#get names

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

write_func<-function(namer, data){
  base<-"~/Google Drive/MetX/data_from_renci/"
  title<-paste(base, "name/", namer, "_names.csv", sep="")
  titles<-read.table(title, sep=",", header=T)
  names(data)<-names(titles)
  read_data<-paste(base, namer, "_comb.csv", sep="")
  write.table(data, read_data, sep=",", row.names=F)
  return(read_data)
}

open_all<-function(){
  base<-"~/Google Drive/MetX/"
}
#global_eff<-rbind(test, test1, test3)
#global_eff
#write_func("global_efficiency", global_eff)

#local_eff<-rbind(test1, test2, test3)
#local_eff
#write_func("local_efficiency", local_eff)

#modularity<-rbind(test1, test2, test3)
#dim(modularity)
#modularity
#write_func("modularity", modularity)

#modularity_potts<-rbind(test1, test2, test3)
#dim(modularity_potts)
#modularity_potts
#write_func("modularity_potts", modularity_potts)

#nodal_degree<-rbind(test1, test2, test3)
#dim(nodal_degree)
#nodal_degree
#write_func("nodal_degree", nodal_degree)

#nodal_btw<-rbind(test1, test2, test3)
#dim(nodal_btw)
#nodal_btw
#write_func("nodal_btw", nodal_btw)

