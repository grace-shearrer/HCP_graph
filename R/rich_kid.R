#rich club analysis
library(reshape)
library(ggplot2)
library(psych)
library(lm.beta)
names(Rich2)
library(plyr)


parcels<-read.table("~/Google Drive/MetX/parcellation.csv", header=T, sep=",")
myvars2<-c("ROI","X","Y","Z")
parcels<-parcels[myvars2]
dim(parcels)

ovd<-subset(nodal_degree_comb, nodal_degree_comb == "overweight")
obd<-subset(nodal_degree_comb, nodal_degree_comb == "obese")
nod<-subset(nodal_degree_comb, nodal_degree_comb == "normal")
head(obd)


#apparent rich club at two points, 75 and 150
##club 1->75
ob_rich<-find_nodes(obd[3:381], 75)
dim(ob_rich)
max(ob_rich$mean_node)
ob_rich
ob_rich2<-merge(parcels, ob_rich, by="ROI")
write.table(ob_rich2, "~/Google Drive/MetX/rich_analysis/ob_rich.csv", row.names = F, sep=",")
###################for brain viewer###############
all_ob<-find_nodes(obd[3:381], 0)
dim(all_ob)
dim(parcels)
all_ob2<-merge(parcels, all_ob, by="ROI", all = T)
dim(all_ob2)



View(parcels)
describe(all_ob2$mean_node)
all_ob2$color[all_ob2$mean_node >= 75]<-5
all_ob2$color[all_ob2$mean_node < 75]<-4
head(all_ob2)
myvars<-c("X", "Y", "Z", "color", "mean_node", "ROI")
all_ob2<-all_ob2[myvars]
head(all_ob2)
dim(all_ob2)
all_ob2[1:379,]
#write.table(all_ob2[1:379,], "~/Google Drive/MetX/rich_analysis/images/ob_list.txt", row.names = F, sep=" ")
all_ob2[1:379,]$X<-round(all_ob2[1:379,]$X, digits = 0)
all_ob2[1:379,]$Y<-round(all_ob2[1:379,]$Y, digits = 0)
all_ob2[1:379,]$Z<-round(all_ob2[1:379,]$Z, digits = 0)
names(all_ob2)
all_ob2[1:379,]$mean_node<-round(all_ob2[1:379,]$mean_node, digits = 2)
head(all_ob2)
write.table(all_ob2[1:379,], "~/Google Drive/MetX/rich_analysis/images/obese",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
write.table(obese_corr, "~/Google Drive/MetX/rich_analysis/images/ob_corr",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
###################for brain viewer###############

ov_rich<-find_nodes(ovd[3:381], 75)
dim(ov_rich)
max(ov_rich)
ov_rich
ov_rich2<-merge(parcels, ov_rich, by="ROI")
write.table(ov_rich2, "~/Google Drive/MetX/rich_analysis/ov_rich.csv", row.names = F, sep=",")
###################for brain viewer###############

all_ov<-find_nodes(ovd[3:381], 0)
dim(all_ov)
dim(parcels)
all_ov2<-join(parcels,all_ov)
dim(all_ov2)

describe(all_ov2$mean_node)
all_ov2$color[all_ov2$mean_node >= 75]<-3
all_ov2$color[all_ov2$mean_node < 75]<-1
all_ov2$color[all_ov2$ROI == "L_PHT_ROI"]<-6
all_ov2$color[all_ov2$ROI == "L_V6A_ROI"]<-6
all_ov2$color[all_ov2$ROI == "R_MT_ROI"]<-6
all_ov2$color[all_ov2$ROI == "L_V7_ROI"]<-6
all_ov2$color[all_ov2$ROI == "R_24dd_ROI"]<-6
head(all_ov2)
myvars<-c("X", "Y", "Z", "color", "mean_node", "ROI")
all_ov2<-all_ov2[myvars]
head(all_ov2)
dim(all_ov2)
all_ov2[1:379,]
#write.table(all_ob2[1:379,], "~/Google Drive/MetX/rich_analysis/images/ob_list.txt", row.names = F, sep=" ")
all_ov2[1:379,]$X<-round(all_ov2[1:379,]$X, digits = 0)
all_ov2[1:379,]$Y<-round(all_ov2[1:379,]$Y, digits = 0)
all_ov2[1:379,]$Z<-round(all_ov2[1:379,]$Z, digits = 0)
names(all_ov2)
all_ov2[1:379,]$mean_node<-round(all_ov2[1:379,]$mean_node, digits = 2)
head(all_ov2)
write.table(all_ov2[1:379,], "~/Google Drive/MetX/rich_analysis/images/over",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
write.table(over_corr, "~/Google Drive/MetX/rich_analysis/images/ov_corr",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
###################for brain viewer###############
no_rich<-find_nodes(nod[3:381], 75)
dim(no_rich)
max(no_rich)
no_rich
no_rich2<-merge(parcels, no_rich, by="ROI")
write.table(no_rich2, "~/Google Drive/MetX/rich_analysis/no_rich.csv", row.names = F, sep=",")
###################for brain viewer###############
all_ov<-find_nodes(ovd[3:381], 0)
dim(all_ov)
dim(parcels)
all_ov2<-join(parcels,all_ov)
dim(all_ov2)

describe(all_ov2$mean_node)
all_ov2$color[all_ov2$mean_node >= 75]<-3
all_ov2$color[all_ov2$mean_node < 75]<-1
all_ov2$color[all_ov2$ROI == "L_PHT_ROI"]<-6
all_ov2$color[all_ov2$ROI == "L_V6A_ROI"]<-6
all_ov2$color[all_ov2$ROI == "R_MT_ROI"]<-6
all_ov2$color[all_ov2$ROI == "L_V7_ROI"]<-6
all_ov2$color[all_ov2$ROI == "R_24dd_ROI"]<-6
head(all_ov2)
myvars<-c("X", "Y", "Z", "color", "mean_node", "ROI")
all_ov2<-all_ov2[myvars]
head(all_ov2)
dim(all_ov2)
all_ov2[1:379,]
#write.table(all_ob2[1:379,], "~/Google Drive/MetX/rich_analysis/images/ob_list.txt", row.names = F, sep=" ")
all_ov2[1:379,]$X<-round(all_ov2[1:379,]$X, digits = 0)
all_ov2[1:379,]$Y<-round(all_ov2[1:379,]$Y, digits = 0)
all_ov2[1:379,]$Z<-round(all_ov2[1:379,]$Z, digits = 0)
names(all_ov2)
all_ov2[1:379,]$mean_node<-round(all_ov2[1:379,]$mean_node, digits = 2)
head(all_ov2)
write.table(all_ov2[1:379,], "~/Google Drive/MetX/rich_analysis/images/over",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
write.table(over_corr, "~/Google Drive/MetX/rich_analysis/images/ov_corr",col.names=FALSE,row.names=FALSE,quote=FALSE, sep=",")
###################for brain viewer###############
##club 2->150
ob_rich3<-find_nodes(obd[3:381], 150)
dim(ob_rich3)
max(ob_rich3$mean_node)
ob_rich3
ob_rich4<-merge(parcels, ob_rich3, by="ROI")
ob_rich4

ov_rich3<-find_nodes(ovd[3:381], 150)
dim(ov_rich3)
max(ov_rich3)
ov_rich3
ov_rich4<-merge(parcels, ov_rich3, by="ROI")
ov_rich4

no_rich3<-find_nodes(nod[3:381], 150)
dim(no_rich3)
max(no_rich3)
no_rich3
no_rich4<-merge(parcels, no_rich3, by="ROI")
no_rich4
##########################################################################################
#local efficiency
##########################################################################################
test<-ob_rich$ROI

head(local_efficiency_comb)
local<-local_efficiency_comb[3:382]
local_m<-melt(local_efficiency_comb, id=c("BMI_group", "Wiring_cost"))
names(local_m)<-c("BMI_group", "Wiring_cost", "ROI", "local_eff")
head(local_m)
rich_local<-merge(ob_rich, local_m, by=("ROI"))
rich_local$ROI<-as.factor(rich_local$ROI)
summary(rich_local$ROI)
summary(rich_local$ROI)

ggplot(data=rich_local, aes(x=ROI, y=local_eff, fill=BMI_group)) +
  geom_bar(stat="identity")
head(rich_local)
myvars<-c("ROI", "BMI_group", "Wiring_cost", "local_eff")
rich_local2<-rich_local[myvars]
head(rich_local2)
wide_richloc<-reshape(rich_local2, idvar = c("BMI_group", "Wiring_cost"), timevar = "ROI", direction = "wide")
head(wide_richloc)
dim(wide_richloc)

wide_richloc[3:134]
local_rich_p<-big_fit(wide_richloc$BMI_group, wide_richloc[3:134], wide_richloc)
dim(local_rich_p)
local_rich_p[order(local_rich_p$pval),]
write.table(local_rich_p, "~/Google Drive/MetX/rich_analysis/local_rich_pvalbetas.csv", row.names = F, sep=",")
##########################################################################################
#nodal betweenness
##########################################################################################
test<-ob_rich$ROI

head(nodal_btw_comb)
btw<-nodal_btw_comb[3:382]
btw_m<-melt(nodal_btw_comb, id=c("BMI_group", "Wiring_cost"))
names(btw_m)<-c("BMI_group", "Wiring_cost", "ROI", "btw")
head(btw_m)
rich_btw<-merge(ob_rich, btw_m, by=("ROI"))
rich_btw$ROI<-as.factor(rich_btw$ROI)
summary(rich_btw$ROI)
head(rich_btw)

ggplot(data=rich_btw, aes(x=ROI, y=btw, fill=BMI_group)) +
  geom_bar(stat="identity")

head(rich_btw)
myvars<-c("ROI", "BMI_group", "Wiring_cost", "btw")
rich_btw2<-rich_btw[myvars]
head(rich_btw2)
wide_richbtw<-reshape(rich_btw2, idvar = c("BMI_group", "Wiring_cost"), timevar = "ROI", direction = "wide")
head(wide_richbtw)
dim(wide_richbtw)

wide_richbtw[3:134]
btw_rich_p<-big_fit(wide_richbtw$BMI_group, wide_richbtw[3:134], wide_richbtw)
dim(btw_rich_p)
btw_rich_p[order(btw_rich_p$pval),]
write.table(btw_rich_p, "~/Google Drive/MetX/rich_analysis/btw_rich_pvalbetas.csv", row.names = F, sep=",")

##########################################################################################
#modularity
##########################################################################################
test<-ob_rich$ROI

head(modularity_comb)
mod<-modularity_comb[3:382]
mod<-melt(modularity_comb, id=c("BMI_group", "Wiring_cost"))
names(mod)<-c("BMI_group", "Wiring_cost", "ROI", "mod")
head(mod)
rich_mod<-merge(ob_rich, mod, by=("ROI"))
rich_mod$ROI<-as.factor(rich_mod$ROI)
summary(rich_mod$ROI)
head(rich_mod)

ggplot(data=rich_mod, aes(x=ROI, y=mod, fill=BMI_group)) +
  geom_bar(stat="identity")

myvars<-c("ROI", "BMI_group", "Wiring_cost", "mod")
rich_mod2<-rich_mod[myvars]
head(rich_mod2)
wide_richmod<-reshape(rich_mod2, idvar = c("BMI_group", "Wiring_cost"), timevar = "ROI", direction = "wide")
head(wide_richmod)
dim(wide_richmod)

wide_richmod[3:134]
mod_rich_p<-big_fit(wide_richmod$BMI_group, wide_richmod[3:134], wide_richmod)
dim(mod_rich_p)
mod_rich_p[order(mod_rich_p$pval),]

##########################################################################################
#clustering coeff
##########################################################################################
test<-ob_rich$ROI

CC<-clustering_coef[3:382]
CC<-melt(clustering_coef, id=c("BMI_group", "Wiring_cost"))
names(CC)<-c("BMI_group", "Wiring_cost", "ROI", "clustering_coef")
head(CC)
rich_CC<-merge(ob_rich, CC, by=("ROI"))
rich_CC$ROI<-as.factor(rich_CC$ROI)
summary(rich_CC$ROI)
head(rich_CC)
names(rich_CC)
ggplot(data=rich_CC, aes(x=ROI, y=clustering_coef, fill=BMI_group)) +
  geom_bar(stat="identity")

myvars<-c("ROI", "BMI_group", "Wiring_cost", "clustering_coef")
rich_CC2<-rich_CC[myvars]
head(rich_CC2)
wide_richCC<-reshape(rich_CC2, idvar = c("BMI_group", "Wiring_cost"), timevar = "ROI", direction = "wide")
head(wide_richCC)
dim(wide_richCC)

wide_richCC[3:134]
CC_rich_p<-big_fit(wide_richCC$BMI_group, wide_richCC[3:134], wide_richCC)
dim(CC_rich_p)
CC_rich_p[order(CC_rich_p$pval),]
#write.table(CC_rich_p, "~/Google Drive/MetX/rich_analysis/cluster_rich_pvalbetas.csv", row.names = F, sep=",")

##########################################################################################
#eccentricity
##########################################################################################
test<-ob_rich$ROI
names(path_length_ecc)
ecc<-path_length_ecc[3:381]
ecc<-melt(path_length_ecc, id=c("BMI_group", "Wiring_cost"))
names(ecc)<-c("BMI_group", "Wiring_cost", "ROI", "ecc")
head(ecc)
rich_ecc<-merge(ob_rich, ecc, by=("ROI"))
rich_ecc$ROI<-as.factor(rich_ecc$ROI)
summary(rich_ecc$ROI)
head(rich_ecc)
names(rich_ecc)
ggplot(data=rich_ecc, aes(x=ROI, y=ecc, fill=BMI_group)) +
  geom_bar(stat="identity")

myvars<-c("ROI", "BMI_group", "Wiring_cost", "ecc")
rich_ecc2<-rich_ecc[myvars]
head(rich_ecc2)
wide_richecc<-reshape(rich_ecc2, idvar = c("BMI_group", "Wiring_cost"), timevar = "ROI", direction = "wide")
head(wide_richecc)
dim(wide_richecc)

wide_richecc[3:134]
ecc_rich_p<-big_fit(wide_richecc$BMI_group, wide_richecc[3:134], wide_richecc)
dim(ecc_rich_p)
ecc_rich_p[order(ecc_rich_p$pval),]
names(parcels)
##########################################################################################
##########################################################################################
localp<-read.table("~/Google Drive/MetX/rich_analysis/local_rich_pvalbetas.csv", header=T, sep=",")
localpOb<-subset(localp, localp$factors == "xobese")
localpOb
localpOv<-subset(localp, localp$factors == "xoverweight")
localpOv
clusterp<-read.table("~/Google Drive/MetX/rich_analysis/cluster_rich_pvalbetas.csv", header=T, sep=",")
names(clusterp)
clusterpOb<-subset(clusterp, localp$factors == "xobese")
clusterpOb
localpOv<-subset(localp, localp$factors == "xoverweight")
localpOv
btwp<-read.table( "~/Google Drive/MetX/rich_analysis/btw_rich_pvalbetas.csv", header = T, sep=",")
names(btwp)
localp<-merge(localp, parcels, by="ROI")
btwp<-merge(btwp, parcels, by="ROI")
clusterp<-merge(clusterp, parcels, by="ROI")
names(clusterp)
dim(localp)
dim(clusterp)
overlap_areas<-merge(localp, clusterp, by=c("ROI", "factors"))
overlap_areas<-merge(overlap_areas, btwp, by=c("ROI", "factors"))
overlap_areas

#write.table(localp, "~/Google Drive/MetX/rich_analysis/local_rich_pvalbetas.csv", row.names = F, sep=",")
#write.table(clusterp, "~/Google Drive/MetX/rich_analysis/cluster_rich_pvalbetas.csv", row.names = F, sep=",")
#write.table(btwp, "~/Google Drive/MetX/rich_analysis/btw_rich_pvalbetas.csv", row.names = F, sep=",")

head(Rich2)
rich_ob<-subset(Rich2, Rich2$BMI_group == "obese")
rich_ov<-subset(Rich2, Rich2$BMI_group == "overweight")
rich_no<-subset(Rich2, Rich2$BMI_group == "normal")

ggplot(rich_no, aes(degree.k, R_norm))+geom_point(size=3)
ggplot(rich_ob, aes(degree.k, R_norm))+geom_point(size=3)
ggplot(rich_ov, aes(degree.k, R_norm))+geom_point(size=3)

