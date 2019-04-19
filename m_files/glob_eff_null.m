text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh','global_efficiency_null.txt');
disp(text_file)
open_file=fopen(text_file,'a');
fmt='%s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float

file_list0=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/null/binary/*.mat')
file_list=file_list0(22:25)
len=length(file_list);%get the number of files possible

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	data0=importdata(fileaschar);%import the data from the file name
	A=[]
	for y=linspace(1,100,100)
		tic
		data=randomizer_bin_und(data0,1);
		Eglob=efficiency_bin(data, 0);%do something to the data
		disp(Eglob)
		A=[A Eglob]	
		toc
	end
	mean_null=mean(A)
	fprintf(open_file, fmt, filename, mean_null);%this is appending the output to the correct file
end

fclose(open_file)
