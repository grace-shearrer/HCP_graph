savepath = fullfile('/projects','niblab','data','HCP','graphs','thresh','day2')

text_file=fullfile('/projects','niblab','data','HCP','graphs','thresh','day2','path_length.txt');
text_file2=fullfile('/projects','niblab','data','HCP','graphs','thresh','day2','thresh','path_length_ecc.txt');
disp(text_file)
open_file=fopen(text_file,'a');
%open_file2=fopen(text_file2,'a');

fmt='%s %s %f %f %f %f\n';
fmt_long='%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n'; 

file_list=glob('/projects/niblab/data/HCP/graphs/thresh/day2/*/binary/corr_*.mat')
%file_list=file_list0(1:3)
len=length(file_list);
for x=linspace(1,len,len)
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	disp(fileascharSplit)
	group=char(fileascharSplit(9));
	filename=char(fileascharSplit(11));
	disp(filename)
	data=importdata(fileaschar);
	dist_data=distance_bin(data);
	%save2path= fullfile(savepath,group,filename);
	%save(save2path, 'dist_data');
	[lambda,efficiency,ecc,radius,diameter] = charpath(dist_data,0,0)
	fprintf(open_file, fmt, group, filename, lambda, efficiency, radius, diameter);
	%fprintf(open_file2, fmt_long, group, filename, ecc);
end
fclose(open_file)
%fclose(open_file2)
