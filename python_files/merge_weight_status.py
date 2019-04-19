import os
import glob

data_dic={}
data_dic_path='/projects/niblab/scripts/HCP'
basepath='/projects/niblab/data/HCP'
NotTwinpath='/projects/niblab/data/HCP/NotTwin/day2'
MZpath='/projects/niblab/data/HCP/MZ/graph_use/day2'
DZpath='/projects/niblab/data/HCP/DZ/graph_use/day2'
#this is reading in the path and then parsing off path
for txtfile in glob.glob('/projects/niblab/scripts/HCP/text_files/*weight.txt'):
#       print txtfile
        n0=txtfile.split('/')[6]
        n1=n0.split('.')[0]
	n2=n1.split('_')[0]
#       print n2
        y=[]
        with open(txtfile) as text_file:
#               print text_file
                text_file_read=text_file.readlines()
                for line in text_file_read:
                        x=line.strip()
                        y.append(x)
        text_file.close()
        data_dic[n2]=y
#       print data_dic 


#print data_dic['No']
#print data_dic['Ob']
#print data_dic['Ov']
#os.chdir(basepath)
f=open('normal_weight2.txt','w')
for x in data_dic['No']:
	print x
	if os.path.exists(os.path.join(NotTwinpath,x))==True:
		file=os.path.join(NotTwinpath,x,'parcellated_day2.ptseries.nii')
		f.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(MZpath,x))==True:
		file=os.path.join(MZpath,x,'parcellated_day2.ptseries.nii')
		f.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(DZpath,x))==True:
		file=os.path.join(DZpath,x,'parcellated_day2.ptseries.nii')
		f.write('%s\n' % (file,))
f.close()

g=open('over_weight2.txt','w')
for x in data_dic['Ov']:
	print x
	if os.path.exists(os.path.join(NotTwinpath,x))==True:
		file=os.path.join(NotTwinpath,x,'parcellated_day2.ptseries.nii')
		g.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(MZpath,x))==True:
		file=os.path.join(MZpath,x,'parcellated_day2.ptseries.nii')
		g.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(DZpath,x))==True:
		file=os.path.join(DZpath,x,'parcellated_day2.ptseries.nii')
		g.write('%s\n' % (file,))
g.close()

h=open('obese_weight2.txt','w')
for x in data_dic['Ob']:
	print x
	if os.path.exists(os.path.join(NotTwinpath,x))==True:
		file=os.path.join(NotTwinpath,x,'parcellated_day2.ptseries.nii')
		h.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(MZpath,x))==True:
		file=os.path.join(MZpath,x,'parcellated_day2.ptseries.nii')
		h.write('%s\n' % (file,))
	elif os.path.exists(os.path.join(DZpath,x))==True:
		file=os.path.join(DZpath,x,'parcellated_day2.ptseries.nii')
		h.write('%s\n' % (file,))
h.close()
