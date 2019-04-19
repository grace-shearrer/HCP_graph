import glob
import shutil
import fnmatch
import os

mzdir='/projects/niblab/data/HCP/MZ'

for subject in glob.glob(os.path.join(mzdir,'graph_use','*')):
	subject=subject.split('/')
	subject=subject[7]
	print subject
	for check in glob.glob(os.path.join(mzdir,'*')):
		print "checking MZ graphuse"
		x=check.split('/')
		x=x[6]
		print x
		if fnmatch.fnmatch(subject,x)== True:
			shutil.move(check,os.path.join(mzdir,'remove'))
			print x+" already exists in DZ graph use use moving"

