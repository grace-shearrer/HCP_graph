import glob
import shutil
import fnmatch
import os

zipdir='/projects/niblab/data/HCP/zipfile'
mzdir='/projects/niblab/data/HCP/MZ'
dzdir='/projects/niblab/data/HCP/DZ'
ntdir='/projects/niblab/data/HCP/NotTwin'

os.chdir(zipdir)
for zipfile in glob.glob('*_3T_rfMRI_REST_fix.zip'):
	z=zipfile.split('_')
	z=z[0]
	for x in glob.glob(os.path.join(dzdir,'graph_use','*')):
		x=x.split('/')
		x=x[7]
		if fnmatch.fnmatch(z,x)== True:
			shutil.move(os.path.join(zipdir,zipfile),os.path.join(zipdir,'dontuse','DZ'))
			print z+" already exists in DZ graph use use moving"
	for y in glob.glob(os.path.join(dzdir,'*')):
		y=y.split('/')
		y=y[6]
		if fnmatch.fnmatch(z,y)== True:
			shutil.move(os.path.join(zipdir,zipfile),os.path.join(zipdir,'dontuse','DZ'))
			print z+" already exists in DZ  moving"
	for a in glob.glob(os.path.join(mzdir,'graph_use','*')):
		a=a.split('/')
		a=a[7]
		if fnmatch.fnmatch(z,a)== True:
			shutil.move(os.path.join(zipdir,zipfile),os.path.join(zipdir,'dontuse','MZ'))
			print z+" already exists in MZ graph use moving"
	for b in glob.glob(os.path.join(mzdir,'*')):
		b=b.split('/')
		b=b[6]
		if fnmatch.fnmatch(z,b)== True:
			shutil.move(os.path.join(zipdir,zipfile),os.path.join(zipdir,'dontuse','MZ'))
			print z+" already exists in MZ moving"
	for c in glob.glob(os.path.join(ntdir,'*')):
		c=c.split('/')
		c=c[6]
		if fnmatch.fnmatch(z,c)== True:
			shutil.move(os.path.join(zipdir,zipfile),os.path.join(zipdir,'dontuse','NT'))
			print z+" already exists in NT moving"
