import sys
import glob
import os
import sys
import fnmatch
#need to say what twin status is either MZ, DZ, or NotTwin
#/projects/niblab/data/HCP/parcellations
#989987/MNINonLinear/Results
def parcer(basepath):
	TWIN=sys.argv[1]
	print TWIN
	if fnmatch.fnmatch(TWIN,'NotTwin')==False:
		f=open('parce2_'+TWIN+'.sh', 'w')
		os.chdir(basepath)
		print "starting "+TWIN
		for subject in glob.glob(os.path.join(TWIN,'run02','day2','*')):
			print subject
			if os.path.exists(os.path.join(basepath,subject,'parcellated_day2.ptseries.nii'))==True:
				print os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')+' exists'
			else:
				print "file doesn't exist making"
				input_file=os.path.join(basepath,subject,'demean_run02.dscalar.nii')
				label_file=os.path.join(basepath,'parcellations','Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii')
				output_file=os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')
				new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_command -cifti-parcellate '+str(input_file)+' '+str(label_file)+' COLUMN '+str(output_file)
				os.chdir(os.path.join('/projects','niblab','scripts','HCP'))
				f.write('%s\n' % (new_file,))
		f.close()

	else:
		h=open('parce_NotTwin.sh', 'w')
		os.chdir(basepath)
		for subject in glob.glob('NotTwin/run02/day2/*/'):
			if os.path.exists(os.path.join(basepath,subject,'parcellated_day2.ptseries.nii'))==True:
				print os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')+' exists'
			else:
				input_file=os.path.join(basepath,subject,'demean_run02.dscalar.nii')
				label_file=os.path.join(basepath,'parcellations','Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii')
				output_file=os.path.join(basepath,subject,'parcellated_day1.ptseries.nii')
				new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_command -cifti-parcellate '+str(input_file)+' '+str(label_file)+' COLUMN '+str(output_file)
				os.chdir(os.path.join('/projects','niblab','scripts','HCP'))
				h.write('%s\n' % (new_file,))
		h.close()

def main():
	basepath='/projects/niblab/data/HCP/'
	parcer(basepath)
main()
