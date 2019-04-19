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
#/projects/niblab/data/HCP/zipfile
#need to name the text file MZ, DZ, NotTwin
#/projects/niblab/scripts/HCP/text_files/run02/day1/twin_status
#############creating data dictionary#####################
for txtfile in glob.glob('/projects/niblab/scripts/HCP/text_files/run02/day1/twin_status/*.txt'):
#	print txtfile
	n1=txtfile.split('/')[9]
	n2=n1.split('.')[0]
#	print n2
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
#for x in data_dic['MZ']:
#	print x
#	movepath= os.path.join(basepath,'MZ',x)
#	if os.path.exists(movepath):
#		print str(x)+" is already in MZ"
#	else:
#		dirpath=os.path.join(basepath,'zipfile',x)
#		shutil.move(dirpath,movepath)
	
#print "starting DZ"
#for x in data_dic['DZ']:
#	print x
#	movepath= os.path.join(basepath,'DZ',x)
#	if os.path.exists(movepath):
#		print str(x)+" is already in DZ"
#	else:
#		dirpath=os.path.join(basepath,'zipfile',x)
#		shutil.move(dirpath,movepath)

print "starting NotTwin"
for x in data_dic['NotTwin']:
	print x
	movepath= os.path.join(basepath,'NotTwin','run02',x)
	if os.path.exists(movepath):
		print str(x)+" is already in NotTwin"
	else:
		#dirpath=os.path.join(basepath,'zipfile',x)
		dirpath=os.path.join(basepath,'NotTwin',x)
		shutil.move(dirpath,movepath)
