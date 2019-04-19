%making a threshholded graph moving it to the threshold area

savepath=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh')
file_list=glob('/projects/niblab/data/HCP/graphs/run02/day2/unthresh/*/graph_corr.mat')
%file_list=file_list(1:3)
len=length(file_list);
for x=linspace(1,len,len)
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	disp(fileascharSplit);
	filename=char(fileascharSplit(10));
	group=strsplit(filename, '_');
	data=importdata(fileaschar);
	data(data < 1e-4)=0;
	finalpath=fullfile(savepath, group(1), filename);
	finalpath=char(finalpath)
	save(finalpath, 'data');
end
