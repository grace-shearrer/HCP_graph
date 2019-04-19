#this function will take a global measure and will parse it into a file suitable for R
import os
import sys
from subprocess import check_output

def get_names(basedir):
	text_file=sys.argv[2]
	print text_file
	group=sys.argv[1]
	print group
	outp=text_file.strip('.txt')
	print outp
	os.chdir(os.path.join(basedir,group,'binary'))
	weight_list=[]
	percent_list=[]
	value_list=[]
	with open(outp+'_parsed.txt','w') as outfile, open(text_file,'r') as infile:
		for lines in infile.readlines():
			x=lines.split('_')
			weight=x[0]
			weight_list.append(weight)
			y=x[1].split(' ')
			value=y[1].strip('\n')
			value_list.append(value)
			intm=y[0].split('r')
			percent=intm[1].split('.m')
			percent_list.append(percent[0])
		rows=zip(weight_list, percent_list, value_list)
		print rows
		outfile.write('\n'.join('%s %s %s' %x for x in rows))
	outfile.close()
	infile.close()

def main ():
	check_args=1
	if len(sys.argv)<3:
		print ('please put which folder ie overweight, obese, normal, and which text file ie. global_efficiency_null.txt,local_efficiency.txt, modularity_potts.txt, nodal_degree.txt, global_efficiency.txt,mean_local_efficiency.txt, modularity.txt, nodal_btw.txt')
		sys.exit()
	basedir='/projects/niblab/data/HCP/graphs/thresh/'

	get_names(basedir)
main()	
