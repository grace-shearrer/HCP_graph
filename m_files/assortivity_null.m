text_file2=fullfile('/projects','niblab','data','HCP','graphs','thresh','assortativity_null.txt');
open_file2=fopen(text_file2,'a');

fmt='%s %s %f\n';

file_list=glob('/projects/niblab/data/HCP/graphs/thresh/null/binary/corr_*.mat')
%file_list=file_list0(24:25)
len=length(file_list);
for x=linspace(1,len,len)
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	group=char(fileascharSplit(8));
	filename=char(fileascharSplit(10));
	data0=importdata(fileaschar);
	A=[]
	tic
	for y=linspace(1,100,100)
                data=randomizer_bin_und(data0,1);
		C = assortativity_bin(data,0)
		A=[A C]
	end
	meanC=mean(A)
	fprintf(open_file2, fmt, group, filename, meanC);
	toc
end
fclose(open_file2)
