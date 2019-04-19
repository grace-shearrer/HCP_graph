savepath = fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh')
file_list=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/over/corr_*.mat')
len=length(file_list);
for x=linspace(1,len,len)
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	group=char(fileascharSplit(10));
	filename=char(fileascharSplit(11));
	data=importdata(fileaschar);
	bin_data=weight_conversion(data, 'binarize');
	save2path= fullfile(savepath,group,'binary',filename);
	save(save2path, 'bin_data');
end
