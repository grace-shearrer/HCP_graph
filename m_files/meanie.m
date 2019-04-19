
file_list=glob('/projects/niblab/data/HCP/graphs/unthresh/day*/overweight_graph_corr.mat')
len=length(file_list);
overweight=[]
overweight=zeros(379,379,2);
for x=linspace(1,len,len)
        disp(file_list(x))
        fileaschar=char(file_list(x));
        data=importdata(fileaschar);
	overweight(:,:,x)=data;
	disp(size(overweight));
end
out = mean(overweight,3);
saver=fullfile('/projects','niblab','data','HCP','graphs','unthresh','mean_days','mean_overweight.mat');
saver=char(saver);
save(saver,'out');
