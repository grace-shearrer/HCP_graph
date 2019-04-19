text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day1','thresh','modularity.txt');
disp(text_file)
open_file=fopen(text_file,'a');
%fmt='%s %f\n';%this is formatting the text file, saying the first column is a string, the second is a float
%the s is the string for the file name, the first f is the Q1 value, the 379 fs are M matrix generated 
fmt='%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';

file_list=glob('/projects/niblab/data/HCP/graphs/run02/day1/thresh/*/binary/corr_*.mat')
len=length(file_list);%get the number of files possible

for x=linspace(1,len,len)%loop through the number of files possible
	fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
	fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
	filename=char(fileascharSplit(12));%this is the name of the file
	group=char(fileascharSplit(10));
	W=importdata(fileaschar);%import the data from the file name
%       % Iterative community finetuning.
%       % W is the input connection matrix.
	n  = size(W,1);             % number of nodes
	M  = 1:n;                   % initial community affiliations 
	Q0 = -1; Q1 = 0;            % initialize modularity values
	while Q1-Q0>1e-5;           % while modularity increases
		Q0 = Q1;                % perform community detection
		[M, Q1] = community_louvain(W, [], M)
	end
	fprintf(open_file, fmt, filename, Q1, M);%this is appending the output to the correct file
end
fclose(open_file)
