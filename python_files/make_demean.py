import sys
import glob
import os
scriptpath='/projects/niblab/scripts/HCP'
basepath='/projects/niblab/data/HCP'
h=open('demean_NT.sh', 'w')
os.chdir(basepath)
#989987/MNINonLinear/Results/rfMRI_REST1_RL:
for subject in glob.glob('NotTwin/run02/day2/*'):
	if os.path.exists(os.path.join(basepath, subject,'demean_run02.dscalar.nii'))==True:
		print os.path.join(basepath, subject,'demean_run02.dscalar.nii')+' exists'
	else:
		input1=os.path.join(basepath,subject,'rfMRI_REST2_RL','rfMRI_REST2_RL_Atlas_MSMAll_hp2000_clean.dtseries.nii')
		input2=os.path.join(basepath,subject,'rfMRI_REST2_LR','rfMRI_REST2_LR_Atlas_MSMAll_hp2000_clean.dtseries.nii')
		output=os.path.join(basepath,subject,'demean_run02.dscalar.nii')
		new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_shortcuts -cifti-demean -normalize '+str(output)+' '+str(input1)+' '+str(input2)
		os.chdir(scriptpath)
		h.write('%s\n' % (new_file,))
h.close()
