file_list=glob('/projects/niblab/data/HCP/graphs/unthresh/*');
len=length(file_list);
for x=linspace(1,len,len)
fileaschar=char(file_list(x));%take x which is currently a cell and make it a character, this is the filenamepath
fileascharSplit=strsplit(fileaschar, '/');%this is splitting the filenamepath so you can grab the actual name
filename0=char(fileascharSplit(8));
filename=strsplit(filename0, '.');
file=filename(1)
data=importdata(fileaschar);
fig(x) = figure;

colormap('prism');
imagesc(data);
colorbar;

%--PLOTLY--%

% Strip MATLAB style by default!
response = fig2plotly(fig(x), file, file);
plotly_url = response.url;
end
