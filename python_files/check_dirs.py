import os
import glob
import fnmatch
import shutil

basedir='/projects/niblab/data/HCP'
checkdir='MNINonLinear/Results'
excludedir='/projects/niblab/data/HCP/exclude/one_run'
os.chdir(basedir)

#for dir in glob.glob('*Z/graph_use/*/'):
#	print dir
#	subdir=os.path.join(basedir,dir)
#	print subdir
#	os.chdir(os.path.join(basedir, dir,checkdir))
#	if len(glob.glob('rfMRI_REST1_*'))==2:
#		print(dir+' is complete')
#	else:
#		print(dir+' is missing an resting state run exclude')
#		shutil.move(subdir,excludedir)

for dir in glob.glob('NotTwin/*/'):
#	print dir
	subdir=os.path.join(basedir,dir)
	print subdir
	os.chdir(os.path.join(basedir, dir,checkdir))
	if len(glob.glob('rfMRI_REST1_*'))==2:
		print(dir+' is complete')
	else:
		print(dir+' is missing an resting state run exclude')
		shutil.move(subdir,excludedir) 
