text_file2=fullfile('/projects','niblab','data','HCP','graphs','run02','day1','thresh','assortativity.txt');
disp(text_file)
open_file2=fopen(text_file2,'a');

fmt='%s %s %f\n';

file_list=glob('/projects/niblab/data/HCP/graphs/run02/day1/thresh/*/binary/corr_*.mat')
len=length(file_list);
for x=linspace(1,len,len)
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	group=char(fileascharSplit(10));
	filename=char(fileascharSplit(12));
	data=importdata(fileaschar);
	C = assortativity_bin(data,0)
	fprintf(open_file2, fmt, group, filename, C);
end
fclose(open_file2)
