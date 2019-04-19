import glob
import os
import csv

ROIS=[]
with open('/projects/niblab/data/HCP/graphs/ptseries/day1/just_labels.txt','r') as labels:
	for line in labels.readlines():
		ROIS.append(line.strip())
print(ROIS)
for x in glob.glob('/projects/niblab/data/HCP/graphs/unthresh/mean_days/*_corr.txt'):
	y=x.split('/')[8].split('_')[0]
	print(y)
	outfile=open(os.path.join('/projects/niblab/data/HCP/graphs/unthresh/mean_days','%s_output.txt'%y),'w')
	writer = csv.writer(outfile, delimiter=",")
	with open(x,'r') as infile:
		for line in infile.readlines():
			l_s=line.strip().split()
			new_line=[]
			try:
				starter='START %s'%l_s[0]
				new_line.append(starter)
			except IndexError:
				print('oops index error')
				break
			for item in range(1,len(l_s)):
				try:
					index=int(l_s[item])
					print(index)
					new_line.append(ROIS[index])
				except ValueError:
					print('not integer~!')
					break
			finish='\n'
                        new_line.append(finish)
			print(new_line)
    			writer.writerow(new_line)
	outfile.close()
