function f = check(img_Set_given)
number = numel(img_Set_given);

per_person_fce = max(5,min([img_Set_given.Count]));
test = select(img_Set_given,1:per_person_fce);
all = [test.imageLocation];
adjustHistograms = false; 
out = @(x) detectFASTFeatures(x,'MinQuality',0.025,'MinContrast',0.025);

ind = reshape(1:numel(alli),[],number);
s_Points = cell(number,1);
f = cell(number,1);
target_s = 100;

t_Size = [target_s,target_s];


	s_Points{k} = out(trainingImage);
	[f{k}, s_Points{k}] = extractFeatures(trainingImage, s_Points{k},'Method','SURF');
end