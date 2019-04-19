tic
file_list=glob('/projects/niblab/data/HCP/graphs/run02/day2/ptseries/*.ptseries.nii')
len=length(file_list)
for x=linspace(1,len,len)
	fileaschar=char(file_list(x))
	fileascharSplit=strsplit(fileaschar, '/')
	filename0=strsplit(char(fileascharSplit(10)),'.')
	filename=filename0(1)
	working_cifti = ft_read_cifti(fileaschar,'readdata',true);
	matrix = working_cifti.ptseries;
	trans_matrix = transpose(matrix);
	netmats_corr = nets_netmats(trans_matrix,0,'corr');
	saver=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','unthresh',filename,'graph_corr.mat');
	saver=char(saver);
	save(saver,'netmats_corr')
end
toc
