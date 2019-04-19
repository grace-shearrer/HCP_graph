tic
working_cifti = ft_read_cifti('/projects/niblab/data/HCP/graphs/ptseries/day2/obese_day2.ptseries.nii','readdata',true);
matrix = working_cifti.ptseries;
trans_matrix = transpose(matrix);
netmats_corr = nets_netmats(trans_matrix,0,'corr');
save('/projects/niblab/data/HCP/graphs/unthresh/day2/obese_graph_corr.mat','netmats_corr')
toc
