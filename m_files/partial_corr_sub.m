tic
file_list=glob('/projects/niblab/data/HCP/DZ/graph_use/*/parcellated.ptseries.nii');
%file_list=file_list0(1:2);
len=length(file_list);%get the number of files possible

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	subNum=char(fileascharSplit(8));%this is the name of the file
	final_path=fullfile('/projects','niblab','data','HCP','DZ','graph_use',subNum,'graph_100.mat');
	finalraw_path=fullfile('/projects','niblab','data','HCP','DZ','graph_use',subNum,'rawgraph_100.mat');
	if exist(final_path,'file')==2
		warning=[final_path,' EXISTS'];
		disp(warning)
	else	
		working_cifti = ft_read_cifti(fileaschar,'readdata',true);
		matrix = working_cifti.ptseries;
		trans_matrix = transpose(matrix);
		netmats_100 = nets_netmats(trans_matrix,0,'icov',100);
		save(finalraw_path,'netmats_100')
		netmats_100(netmats_100 < 1e-4)=0;
		save(final_path,'netmats_100')
	end
end
toc
%exit
