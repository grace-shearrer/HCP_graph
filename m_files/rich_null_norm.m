dir_list=glob('/projects/niblab/data/HCP/graphs/thresh/*/binary/');
tic
dir_name=char(dir_list(1));
mat_file=char('*.mat');
file_path=strcat(dir_name,mat_file);
file_list0=glob(file_path)
file_list=file_list0(43:50)
len=length(file_list);%get the number of files possible

R_file=fullfile(dir_name,'R_null.txt');
Nk_file=fullfile(dir_name,'Nk_null.txt');
Ek_file=fullfile(dir_name,'Ek_null.txt');
open_R=fopen(R_file,'a');
open_Ek=fopen(Ek_file,'a');
open_Nk=fopen(Nk_file,'a');
fmt='%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';
for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
        fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
        filename=char(fileascharSplit(10));%this is the name of the file
        data0=importdata(fileaschar);%import the data from the file name
        R0=[]
	Nk0=[]
	Ek0=[]
        for y=linspace(1,100,100)
                data=randomizer_bin_und(data0,1);
		[R, Nk, EK]=rich_club_bu(data, 25);
		R0=[R0;R]
		Nk0=[Nk0; Nk]
		Ek0=[Ek0; EK]
        end
        mean_R=mean(R0, 1)
        mean_Nk=mean(Nk0, 1)
        mean_Ek=mean(Ek0, 1)
        fprintf(open_R, fmt, filename, mean_R);%this is appending the output to the correct file
        fprintf(open_Nk, fmt, filename, mean_Nk);%this is appending the output to the correct file
        fprintf(open_Ek, fmt, filename, mean_Ek);%this is appending the output to the correct file
end

fclose(open_R)
fclose(open_Nk)
fclose(open_Ek)
toc
