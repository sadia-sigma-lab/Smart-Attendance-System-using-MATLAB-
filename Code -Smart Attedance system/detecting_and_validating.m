	function [dis_f, pass, image_p] = detecting_and_validating(varargin)
		
		original_img = snapshot(v_object);
		
		dis_f = original_img; % initilize it with orignial captured image
		pass = false;
		image_p = []
		gray_f = rgb2gray(original_img);
		
 klt.oneNose = false;
klt.oneMouth = false;
klt.oneEyes = false;

if klt.oneNose
	klt.noseDetector = vision.CascadeObjectDetector('ClassificationModel','Nose','MergeThreshold',10);
end
if klt.oneEyes
	klt.EyesDetector = vision.CascadeObjectDetector('ClassificationModel','Eyes','MergeThreshold',10);
end
if klt.oneMouth
	klt.mouthDetector = vision.CascadeObjectDetector('ClassificationModel','Mouth','MergeThreshold',10);
end
% H,W of bounding box must be at least this size for a proper detection
klt.minBBSize = 30; 

% Create face detector
face_d = vision.CascadeObjectDetector('MergeThreshold',10);
        
        
        
		if preprocessOpts.matchHistograms
			gray_f = imhistmatch(gray_f,preprocessOpts.targetForHistogramAndResize);  % checking if histogram is matche or not
		end
		if preprocessOpts.adjustHistograms
			gray_f = histeq(gray_f); % histogram equalization
		end
		
		
		b_box = face_d.step(gray_f);
		
		if isempty(b_box)  % validate dimensions of box
			return
		end
		if size(b_box,1) > 1
			disp(' To ensure only one face is detected for registering!');
			return
		end
		
		if klt.oneMouth
			mouthBox = klt.mouthDetector.step(gray_f);
			if size(mouthBox,1) ~= 1
				return
			end
		end
		if klt.oneNose
			noseBox = klt.noseDetector.step(gray_f);
			if size(noseBox,1) ~= 1
				return
			end
		end
		
		pass = true;
		
		dis_f = insertShape(original_img, 'Rectangle', b_box,'linewidth',4,'color','cyan');
		
		b_box = b_box + [-b_box -b_box 2*b_box 2*b_box]; % writing name to directory as label
		
		face_img = imcrop(gray_f,b_box); % for storing only cropped face
		min_size = min(size(face_img));
		t_Size = preprocessOpts.targetSize/min_size;
		face_img = imresize(face_img,t_Size);
		
		
		image_p = fullfile(targetDirectory,['Person' num2str(p_Number)],filesep,['faceImg' num2str(c_number) '.png']); % saving in image directory for database	imwrite(faceImg,image_p);
		pause(pauseval)
    end