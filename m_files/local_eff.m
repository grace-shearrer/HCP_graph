tic
text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day1','thresh','local_efficiency.txt');
disp(text_file)
open_file=fopen(text_file,'a');
%fmt='%s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float

fmt='%s %s  %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';

file_list=glob('/projects/niblab/data/HCP/graphs/run02/day1/thresh/*/binary/corr*.mat');
%file_list=file_list0(1:2)
len=length(file_list);%get the number of files possible

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	data=importdata(fileaschar);%import the data from the file name
	group=char(fileascharSplit(10));
	disp(fileaschar)
	Eloc=efficiency_bin(data, 1);%note that this is going to give a vector
	trans_Eloc=Eloc'
	meanEloc=mean(Eloc)
	fprintf(open_file, fmt, group, filename, meanEloc, trans_Eloc);%this is appending the output to the correct file
end

fclose(open_file);
toc
