function output = mycheck(image_to_be_tested,features,number)


fcnHandle = @(x) detectFASTFeatures(x,'MinQuality',0.025,'MinContrast',0.025);  % defining function handle for detection


box_cordinates = fcnHandle(image_to_be_tested); % getting cordinates of box
[Features_b, box_cordinates] = extractFeatures(image_to_be_tested, box_cordinates,'Method','SURF','BlockSize',3,'SURFSize',64);
matched_m = zeros(size(Features_b,1),number); % for matching features
for k = 1:number
	[~,matched_m(:,k)] = matchFeatures(Features_b,features{k},'MaxRatio',1,'MatchThreshold',100,'Metric','SAD');
end


	[~,output] = min(mean(matched_m));
