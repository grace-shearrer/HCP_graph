file_list0=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/null/binary/corr_*.mat')
file_list=file_list0(22:25)
len=length(file_list);%get the number of files possible

dir_name='/projects/niblab/data/HCP/graphs/run02/day2/thresh/'
R_file=fullfile(dir_name,'R_null.txt');
Nk_file=fullfile(dir_name,'Nk_null.txt');
Ek_file=fullfile(dir_name,'Ek_null.txt');

open_R=fopen(R_file,'a');
open_Ek=fopen(Ek_file,'a');
open_Nk=fopen(Nk_file,'a');

for x=linspace(1,len,len)%loop through the number of files possible
	tic
        fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
        fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
        filename=char(fileascharSplit(12));%this is the name of the file
        data0=importdata(fileaschar);%import the data from the file name
        R0=[]
	Nk0=[]
	Ek0=[]
        for y=linspace(1,100,100)
                data=randomizer_bin_und(data0,1);
		[R, Nk, EK]=rich_club_bu(data);
		R0=[R0;R]
		Nk0=[Nk0; Nk]
		Ek0=[Ek0; EK]
        end
        mean_R=mean(R0, 1)
        mean_Nk=mean(Nk0, 1)
        mean_Ek=mean(Ek0, 1)

	lenR=length(mean_R)
	lenEk=length(mean_Ek)
	lenNk=length(mean_Nk)

	fmtR0=char(repmat('%f ', 1 , lenR))
	fmtR1=strcat(fmtR0, '\n')
	fmtR=['%s ', fmtR1]
	fmtNk0=char(repmat('%f ', 1 , lenNk))
	fmtNk1=strcat(fmtNk0, '\n')
	fmtNk=['%s ', fmtNk1]

	fmtEk0=char(repmat('%f ', 1 , lenEk))
	fmtEk1=strcat(fmtEk0, '\n')
	fmtEk=['%s ', fmtEk1]

        fprintf(open_R, fmtR, filename, mean_R);%this is appending the output to the correct file
        fprintf(open_Nk, fmtNk, filename, mean_Nk);%this is appending the output to the correct file
        fprintf(open_Ek, fmtEk, filename, mean_Ek);%this is appending the output to the correct file
	toc
end

fclose(open_R)
fclose(open_Nk)
fclose(open_Ek)
