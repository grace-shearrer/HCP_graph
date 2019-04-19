%o2bese_cell={'L_FFC_ROI','L_PCV_ROI','L_RI_ROI','L_V1_ROI','R_V1_ROI','L_V7_ROI','R_V4_ROI','R_a9-46v_ROI','R_OP2-3_ROI'};
overweight_cell={'L_OP1_ROI','L_PCV_ROI','L_VVC_ROI','R_PCV_ROI','L_V7_ROI','R_24dd_ROI','R_MT_ROI'};
labels = importdata('/projects/niblab/data/HCP/graphs/ptseries/day1/just_labels.txt');

overweight_mean=importdata('/projects/niblab/data/HCP/graphs/unthresh/mean_days/mean_overweight.mat');

C={};
D={};
len=numel(overweight_cell);
for x=linspace(1,len,len)
	y=overweight_cell{x};
	Index = find(strcmp(labels,y));
	%disp(Index)
	cols=find(overweight_mean(Index,:)>0.4);
	C{x}=cols;
	vals=overweight_mean(Index,cols);
	D{x}=vals
end

fileID = fopen('/projects/niblab/data/HCP/graphs/unthresh/mean_days/overweight_corr.txt','a');
[nrows,ncols] = size(C);
trans=transpose(overweight_cell);
for cols=1:ncols 
	len=length(C{cols});
	fmt0=char(repmat(' %i ', 1 , len));
	fmt00=char(repmat(' %s ', 1 , len));
	fmt=strcat('%s ',fmt0, '\n');
	fmt2=strcat('%s ',fmt00, '\n');
	fmt=char(fmt);
	fmt2=char(fmt2);
	disp(C{:,cols});
	disp(overweight_cell{:,cols});
	y=C{:,cols}
	fprintf(fileID,fmt,overweight_cell{:,cols},C{:,cols})
	fprintf(fileID,fmt,overweight_cell{:,cols},D{:,cols})
end

fclose(fileID);
