%dir_list=glob('/projects/niblab/data/HCP/graphs/thresh/day2/*/binary');
%len=length(dir_list);
%for z=linspace(1,len,len)
%	dir_name=char(dir_list(z));
%	rich=char('rich.mat');
%	data2import=strcat(dir_name,rich);
%	disp(data2import)
raw_data=importdata('/projects/niblab/data/HCP/graphs/run02/day2/thresh/rich.mat');
for x=linspace(2,4,3)
	filename=char(raw_data.header{x});
	txt=char('.txt');
	final_name=strcat(filename,txt);
	text_file=fullfile('/projects','niblab','data','HCP','graphs','run02','day2','thresh',final_name);
%	text_file=fullfile(dir_name,final_name);
	disp(text_file)
	open_file2=fopen(text_file, 'a');
	disp(text_file)
	for y=linspace(1,100,100)
		name=raw_data.A{y,1};   
		z=x+1 
		var=raw_data.A{y,z};
		wc=raw_data.A{y,x};
		len=length(var)
		fmt0=char(repmat('%f ', 1 , len));
       		fmt=strcat('%s %s',{' '},fmt0, '\n');
       		fmt=char(fmt)
		disp(name)
		disp(var)
		disp(fmt)
		fprintf(open_file2, fmt, name, wc, var); 
	end
	fclose(open_file2)
end
%end
