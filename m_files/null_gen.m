savepath = fullfile('/projects','niblab','data','HCP','graphs','thresh')
file_list=glob('/projects/niblab/data/HCP/graphs/thresh/null/corr_*.mat')
len=length(file_list);
for x=linspace(1,len,len)
	tic
	disp(file_list(x))
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');
	group=char(fileascharSplit(8));
	filename=char(fileascharSplit(9));
	data=importdata(fileaschar);
	[W_rand R_rand]=null_model_und_sign(data, 5,1);
	save2path= fullfile(savepath,group,'null',filename);
	save2Rpath= fullfile(savepath,group,'old',filename);
	save(save2path, 'W_rand');
	save(save2Rpath, 'R_rand');
	toc
end
