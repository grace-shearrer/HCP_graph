import os
import shutil
import glob
import fnmatch
basedir='/projects/niblab/data/HCP/'
pattern='rfMRI_REST2_*'
for subject_path in glob.glob(os.path.join(basedir,'NotTwin','run02','*')):
	subject0=subject_path.split('/')
	subject=subject0[7]
	print(subject)
	if len(glob.glob(os.path.join(subject_path,'MNINonLinear','Results','rfMRI_REST2_*')))==2:
		print 'checking if '+subject+' is in day 2'
		if os.path.exists(os.path.join(basedir,'NotTwin','graph_use','day2',subject)):
			print subject+' already exists in day 2'
		else:
			shutil.move( os.path.join(subject_path,'MNINonLinear','Results','rfMRI_REST2_LR'),os.path.join(basedir,'NotTwin','run02','day2',subject,'rfMRI_REST2_LR'))
			shutil.move( os.path.join(subject_path,'MNINonLinear','Results','rfMRI_REST2_RL'),os.path.join(basedir,'NotTwin','run02','day2',subject,'rfMRI_REST2_RL'))
