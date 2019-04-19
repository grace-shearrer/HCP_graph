%making a threshholded graph moving it to the threshold area
savepath=fullfile('/projects','niblab','data','HCP','graphs','thresh')
savethresh=fullfile('/projects','niblab','data','HCP','graphs','thresh')

fmt='%s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float
fmt_long='%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';

file_list0=glob('/projects/niblab/data/HCP/graphs/unthresh/sub_check/*_corr.mat')
file_list=file_list0(1:3)
len=length(file_list);
for x=linspace(1,len,len)
        fileaschar=char(file_list(x));
        fileascharSplit=strsplit(fileaschar, '/');
        disp(fileascharSplit);
        filename=char(fileascharSplit(9));
        group=strsplit(filename, '_');
        %data=importdata(fileaschar);
        %data(data < 1e-4)=0;
        finalpath=fullfile(savepath, group(1), 'sub_check',filename);
        finalpath=char(finalpath);
        %save(finalpath, 'data');
        finalpath2=fullfile(savepath, group(1), 'sub_check', 'binary','global_efficiency.txt');
        finalpath_local=fullfile(savepath, group(1), 'sub_check', 'binary','local_efficiency.txt');
        finalpath_mod=fullfile(savepath, group(1), 'sub_check', 'binary','modularity.txt');
	%open_effG=fopen(finalpath2,'a');
	%open_effL=fopen(finalpath_local,'a');
	%open_mod=fopen(finalpath_mod,'a');
	disp(finalpath_local)
	for x=linspace(0.05, 0.25, 25) %applying wiring costs
                fid=(['corr_' num2str(x) '.mat']);
                wirepath=fullfile(savethresh, group(1),'sub_check',fid);
		disp(wirepath);
                %graph=threshold_proportional(data,x);
                %save(wirepath,'graph');
		%bin_data=weight_conversion(graph, 'binarize');
		save2path= fullfile(savepath,group(1),'sub_check','binary',fid);
        	%save(save2path, 'bin_data');
		%disp(save2path);
		%Eglob=efficiency_bin(bin_data, 0);%global efficiency
		%fprintf(open_effG, fmt, fid, Eglob);%this is appending the output to the correct file
		%Eloc=efficiency_bin(bin_data, 1);%local efficiency
		trans_Eloc=Eloc'
        	meanEloc=mean(Eloc)
        	fprintf(open_effL, fmt_long, fid, meanEloc, trans_Eloc);%this is appending the output to the correct file
        	n  = size(bin_data,1);             % number of nodes
        	M  = 1:n;                   % initial community affiliations 
        	Q0 = -1; Q1 = 0;            % initialize modularity values
        	while Q1-Q0>1e-5;           % while modularity increases
                	Q0 = Q1;                % perform community detection
                	[M, Q1] = community_louvain(bin_data, [], M)
        	end
        	fprintf(open_mod, fmt_long, fid, Q1, M);%this is appending the output to the correct file
        end
%fclose(open_effG)
%fclose(open_effL)
%fclose(open_mod)

end



