function main(number) % using recursive calls concepts


try
	v_object = webcam;  % Validating webcam connection
catch
	
	disp('Webcam is not connected properly with MATLAB Please Check Again');
	return
end



f_Directory = fullfile(fileparts(which(mfilename)),'Database'); % for creating or validating the directory to store regisetered face
captured_images = true;
p_Number = 1;
dir_e = exist(f_Directory,'dir') == 7;
if dir_e % checking if directory exist 
	prompt = sprintf('Would you like to:\n\nSTART OVER (Clears Existing Data!!)\nAdd Face(s) to recognition set\nor Use recognition set as is?');
	option = questdlg(prompt,'Face Recognition Options','START OVER','Add Face(s)','Use as is','START OVER');
	u_Option = find(ismember({'START OVER','Add Face(s)','Use as is'},option)); % showing dialogue box
else
	mkdir(f_Directory);
	u_Option = 1;
    delete('output.csv') % if previous reocrd of atendance needs to be removed
end

if u_Option == 1 % for string over option
    delete('output.csv') % if previous reocrd of atendance needs to be removed
	rmdir(f_Directory,'s'); 
	mkdir(f_Directory)
    
	mkdir(fullfile(f_Directory,filesep,['Person' num2str(1)]))
	p_Number = 1;
elseif u_Option == 2
     %delete('output.csv')
	tmperorary = dir(targetDirectory);
	
	tmperorary = cellfun(var,{tmperorary.name},'UniformOutput',false);
	
	mkdir(fullfile(targetDirectory,filesep,['Person' num2str(p_Number)]))
elseif u_Option == 3
    
    prompt1 = sprintf('Would you like to:\n\nRemove Existing Attendance database? \nYES \nor NO?');
	option1 = questdlg(prompt1,' Options','YES','NO','YES');
	refreshOption1 = find(ismember({'YES', 'NO'},option1))
    
    if refreshOption1==2
    
	
	captured_images = false; % this means no validation required
    else
        delete('output.csv') % for use as is option
        
	captured_images = false; % this means no validation required
    end

elseif isempty(u_Option)
	delete(v_object)
	return
end


fig = figure('name','RECORD FACE UNTIL BEEP; Press <ESCAPE> to Stop','position',[0.2 0.1 0.6 0.7],'closerequestfcn',[],'currentcharacter','0','keypressfcn',@checkForEscape);





if nargin < 1
	number = 8; % to check 8 different versions
end

if nargin < 2
	pauseval = 0.5; % frame capturing after 0.5 seconds
end

b_box = 25;

c_number = 0; % initial  number of captured
is_D = false;
capture_other = true;

original_img = snapshot(v_object);
Size = size(original_img); % getting size of image
img_axes = axes('parent',fig,'units','normalized','position',[0.05 0.45 0.9 0.45]);
img_h = imshow(original_img);
disp('Press Escape button to quit')
if ismember(u_Option,[1,2]) && capture_other && ~is_d
	while capture_other && double(get(fig,'currentCharacter')) ~= 27
		
	[dis_f, pass] = detecting_and_validating; % for detection and validation of captured faces
		if pass
		c_number = c_number + 1;
		end
		set(img_h,'CData',dis_f);
		if c_number >= number
			pause(0.25);
			
		end
	end 
end


img_set_given = imageSet(targetDirectory,'recursive'); 
if numel(img_set_given) < 2   % checking this condition for matching the features
	error(' Need atleast two faces to be registered');
end

if captured_images
	detecing_and_validating(img_set_given);
end
F = check(img_set_given); % for recognition


figure(fig)
while double(get(fig,'currentCharacter')) ~= 27 && ~is_d % checking escape charcter condition 
	best_p = '?';
	original_img = snapshot(v_object);
	gray_f = rgb2gray(original_img);
    
b_box = face_d.step(gray_f);
    
	for jj = 1:size(b_box,1)
		if all(b_box(jj,3:4) >= klt.minBBSize)
			t_Face = imcrop(gray_f,b_box(jj,:)); % cropping the face and applying image nehancement techniques	if preprocessOpts.matchHistograms
				t_Face = imhistmatch(t_Face,preprocessOpts.targetForHistogramAndResize);
			end
	if preprocessOpts.adjustHistograms % histogram equalization
		t_Face = histeq(t_Face);
		end
			t_Face = imresize(t_Face,size(preprocessOpts.targetForHistogramAndResize)); % scaling the image
			%tic;
best_p = mycheck(t_Face,F,numel(img_set_given));
			if best_p == 0
				best_p = '?';
			else
				best_p = img_set_given(best_p).Description;
			end
			
original_img = 	insertObjectAnnotation(original_img, 'rectangle', b_box(jj,:), strcat(best_p, ' is marked present'),'FontSize',48);
       att='present'
            fid = fopen('Output.csv','a');
            C={'Name','Attendance'};  % for storing attendance in csv
            
            fprintf( fid,'%s,%s\n',best_p,att);
            fclose(fid)
            
		end
	end
	imshow(original_img,'parent',img_axes);
    drawnow;
	title([best_p '?'])
end 


delete(v_object)

delete(fig)

end