
ovd<-subset(nodal_degree_comb, nodal_degree_comb == "overweight")
obd<-subset(nodal_degree_comb, nodal_degree_comb == "obese")
nod<-subset(nodal_degree_comb, nodal_degree_comb == "normal")

ov<-subset(nodal_btw_comb, nodal_btw_comb == "overweight")
ob<-subset(nodal_btw_comb, nodal_btw_comb == "obese")
no<-subset(nodal_btw_comb, nodal_btw_comb == "normal")


find_nodes<-function(x,y){
  a<-sapply(x,mean)
  df <- melt(a, id=c("termslabs"))
  names(df)<-c("mean_degree")
  rich<-subset(df, df$mean_degree > y)
  return(rich)
}


ob_rich<-find_nodes(obd[3:381], 120)
dim(ob_rich)
max(ob_rich)
ob_rich

no_rich<-find_nodes(nod[3:381], 120)
dim(no_rich)
max(no_rich)
no_rich

ov_rich<-find_nodes(ovd[3:381],  120)
dim(ov_rich)
max(ov_rich)
ov_rich
