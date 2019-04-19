import os
import sys
import glob
import fnmatch

DZ_file1=os.path.join('twin_lists','new1200', 'DZ1.txt')
DZ_file2=os.path.join('twin_lists','new1200', 'DZ2.txt')
DZ_file2=open(DZ_file2,'w+')

file_name=os.path.join('twin_lists','new1200', 'DZ.txt')

with open(file_name, 'r') as search:
	for line in search:
		line = line.split('\t')
		new=line
		mom = new[2]
		
		with open(DZ_file1, 'w+') as search2:
			for line2 in search2:
				new2=line2
				mom2=new2[2]
				if fnmatch.fnmatch(mom, mom2):
					print "match"
				else:
					print "not a match"
