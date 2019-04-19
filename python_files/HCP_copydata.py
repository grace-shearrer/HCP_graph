import numpy
import os
import glob
import shutil

data_dic={}
#data_dic['MZ']={}
#data_dic['DZ']={}
#data_dic['NotTwin']={}
data_dic_path='/projects/niblab/scripts/HCP'
basepath='/projects/niblab/data/HCP'
#need to name the text file MZ, DZ, NotTwin
#############creating data dictionary#####################
for txtfile in glob.glob('/projects/niblab/scripts/HCP/*use.txt'):
#	print txtfile
	n0=txtfile.split('/')[5]
	n1=n0.split('.')[0]
	n2=n1.split('_')[0]
	print n2
	y=[]
	with open(txtfile) as text_file:
#		print text_file
		text_file_read=text_file.readlines()
		for line in text_file_read:
			x=line.strip()
			y.append(x)	
	text_file.close()
	data_dic[n2]=y
#	print data_dic	

print data_dic
os.chdir(basepath)
for x in data_dic['MZ']:
	print x
	movepath= os.path.join(basepath,'MZ','graph_use',x)
	if os.path.exists(movepath):
		print str(x)+" is already in MZ graph theory"
	else:
		dirpath=os.path.join(basepath,'MZ',x)
		shutil.copytree(dirpath,movepath)
	
print "starting DZ"
for x in data_dic['DZ']:
	print x
	movepath= os.path.join(basepath,'DZ','graph_use',x)
	if os.path.exists(movepath):
		print str(x)+" is already in DZ graph theory"
	else:
		dirpath=os.path.join(basepath,'DZ',x)
		shutil.copytree(dirpath,movepath)
