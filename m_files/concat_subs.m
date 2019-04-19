%need to read in a file list that will then merge
%concat_subs
tic
file_list0 = textread('/projects/niblab/scripts/HCP/text_files/run01/sub_test/obese_weight_sub.txt','%s');

inital0 = file_list0(1);
inital2import = char(inital0);
inital = importdata(inital2import);
%norm 294
%over 238, one subjected removed, failure to converge
%ob 150 
file_list = file_list0(2:150);
len=length(file_list);

for x=linspace(1,len,len)
	data0=file_list(x);
	data2import=char(data0);
	disp(data2import)
        matrix=importdata(data2import);
	inital = cat(3,inital,matrix);
end
size(inital)
mean_matrix = mean(inital,3);
std_matrix = std(inital,[],3);
mean_path=fullfile('/projects','niblab','data','HCP','graphs', 'unthresh', 'obese_graph_corr.mat');
std_path=fullfile('/projects','niblab','data','HCP','graphs', 'unthresh',  'obese_over_graph_corr.mat');
save(mean_path,'mean_matrix');
save(std_path,'std_matrix');
toc
