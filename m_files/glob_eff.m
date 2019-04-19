text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day1','thresh','global_efficiency.txt');
disp(text_file)
open_file=fopen(text_file,'a');
fmt='%s %s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float

file_list=glob('/projects/niblab/data/HCP/graphs/run02/day1/thresh/*/binary/corr_*.mat')
len=length(file_list);%get the number of files possible

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	group=char(fileascharSplit(10));
	data=importdata(fileaschar);%import the data from the file name
%	data=randomizer_bin_und(data0,1);
	Eglob=efficiency_bin(data, 0);%do something to the data
	disp(Eglob)
	fprintf(open_file, fmt, group, filename, Eglob);%this is appending the output to the correct file
end

fclose(open_file)
