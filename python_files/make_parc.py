import sys
import glob
import os
#/projects/niblab/data/HCP/parcellations
basepath='/projects/niblab/data/HCP/'
f=open('parce_DZ.sh', 'w')
os.chdir(basepath)
for subject in glob.glob('DZ/graph_use/day2/*/'):
	if os.path.exists(os.path.join(basepath,subject,'parcellated.ptseries.nii'))==True:
		print os.path.join(basepath,subject,'parcellated.ptseries.nii')+' exists'
	else:
		input_file=os.path.join(basepath,subject,'demean_day2.dscalar.nii')
		label_file=os.path.join(basepath,'parcellations','Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii')
		output_file=os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')
		new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_command -cifti-parcellate '+str(input_file)+' '+str(label_file)+' COLUMN '+str(output_file)
		os.chdir(os.path.join('/projects','niblab','scripts','HCP'))
		f.write('%s\n' % (new_file,))
f.close()

g=open('parce_MZ.sh', 'w')
os.chdir(basepath)
for subject in glob.glob('MZ/graph_use/day2/*/'):
	if os.path.exists(os.path.join(basepath,subject,'parcellated.ptseries.nii'))==True:
		print os.path.join(basepath,subject,'parcellated.ptseries.nii')+' exists'
	else:
		input_file=os.path.join(basepath,subject,'demean_day2.dscalar.nii')
		label_file=os.path.join(basepath,'parcellations','Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii')
		output_file=os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')
		new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_command -cifti-parcellate '+str(input_file)+' '+str(label_file)+' COLUMN '+str(output_file)
		os.chdir(os.path.join('/projects','niblab','scripts','HCP'))
		g.write('%s\n' % (new_file,))
g.close()

h=open('parce_NotTwin.sh', 'w')
os.chdir(basepath)
for subject in glob.glob('NotTwin/day2/*/'):
	if os.path.exists(os.path.join(basepath,subject,'parcellated.ptseries.nii'))==True:
		print os.path.join(basepath,subject,'parcellated.ptseries.nii')+' exists'
	else:
		input_file=os.path.join(basepath,subject,'demean_day2.dscalar.nii')
		label_file=os.path.join(basepath,'parcellations','Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii')
		output_file=os.path.join(basepath,subject,'parcellated_day2.ptseries.nii')
		new_file= '/home/gshearre/workbench/bin_rh_linux64/wb_command -cifti-parcellate '+str(input_file)+' '+str(label_file)+' COLUMN '+str(output_file)
		os.chdir(os.path.join('/projects','niblab','scripts','HCP'))
		h.write('%s\n' % (new_file,))
h.close()
