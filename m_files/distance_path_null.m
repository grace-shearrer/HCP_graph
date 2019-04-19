savepath = fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh')

text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh','path_length_null.txt');
%text_file2=fullfile('/projects','niblab','data','HCP','graphs','thresh','path_length_ecc_null.txt');
disp(text_file)
open_file=fopen(text_file,'a');
%open_file2=fopen(text_file2,'a');

fmt='%s %s %f %f %f %f\n';
%fmt_long='%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n'; 

file_list=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/null/binary/corr_*.mat')
%file_list=file_list0(13:25)
len=length(file_list);
for x=linspace(1,len,len)
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	group=char(fileascharSplit(8));
	filename=char(fileascharSplit(10));
	data0=importdata(fileaschar);
	A=[]
	B=[]
	C=[]
	D=[]
	E=[]
	tic
	for y=linspace(1,100,100)
                data=randomizer_bin_und(data0,1);
		dist_data=distance_bin(data);
		[lambda,efficiency,ecc,radius,diameter] = charpath(dist_data,0,0)
		A=[A lambda]
		B=[B efficiency]
		C=[C radius]
		D=[D diameter]
		E=cat(3, E, ecc) 	
	end
	mean_lambda=mean(A)
	mean_eff=mean(B)
	mean_radius=mean(C)
	mean_dia=mean(D)
	mean_ecc=mean(E,3)
	toc
	fprintf(open_file, fmt, group, filename, mean_lambda, mean_eff, mean_radius, mean_dia);
%	fprintf(open_file2, fmt_long, group, filename, mean_ecc);
end
fclose(open_file)
%fclose(open_file2)
