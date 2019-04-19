tic
text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day1','thresh','rich.mat');


header=cell(1,4);
header{1}='subject';
header{2}='R';
header{3}='Nk';
header{4}='Ek';


file_list=glob('/projects/niblab/data/HCP/graphs/run02/day1/thresh/*/binary/corr_*.mat');
%file_list=file_list0(1)
len=length(file_list);%get the number of files possible


A=cell(1,5);

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	group=char(fileascharSplit(10));
	data=importdata(fileaschar);%import the data from the file name
	[R, Nk, EK]=rich_club_bu(data);
	A{x,1}=group;
	A{x,2}=filename;
	A{x,3}=R;
	A{x,4}=Nk;
	A{x,5}=EK;
	[nrows, ncols]=size(A);
end

disp(A)

save(text_file,'header', 'A')
toc
