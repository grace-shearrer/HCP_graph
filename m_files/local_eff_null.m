text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh','mean_local_efficiency_null.txt');
disp(text_file)
open_file=fopen(text_file,'a');
%fmt='%s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float
fmt='%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';

file_list0=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/null/binary/*.mat')
file_list=file_list0(22:25)
len=length(file_list);%get the number of files possible


for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	data0=importdata(fileaschar);%import the data from the file name
	A=[]
	B=[]
	for y=linspace(1,100,100)
		tic
		data=randomizer_bin_und(data0,1);
		Eloc=efficiency_bin(data, 1);%do something to the data
		disp(Eloc)
		trans_Eloc=Eloc'
		meanEloc=mean(Eloc)
		A=[A meanEloc]
		B=cat(3, B, trans_Eloc)
		toc	
	end
	mean_null=mean(A)
	mean_B=mean(B,3)
	fprintf(open_file, fmt, filename, mean_null, mean_B);%this is appending the output to the correct file
end

fclose(open_file)
