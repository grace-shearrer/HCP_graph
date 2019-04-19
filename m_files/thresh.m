%this is creating the weighted maps
savepath=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh')
files=glob('/projects/niblab/data/HCP/graphs/run02/day2/thresh/over/*.mat')
len=length(files);
for y=linspace(1, len, len)
	data2import=char(files(y));
	data=importdata(data2import);
	fileascharSplit=strsplit(data2import, '/');
	group=char(fileascharSplit(10));
	disp(data2import)
	for x=linspace(0.05, 0.25, 25)
		fid=(['corr_' num2str(x) '.mat']);
		finalpath=fullfile(savepath, group, fid)
		graph=threshold_proportional(data,x);
		save(finalpath,'graph');
	end
end
