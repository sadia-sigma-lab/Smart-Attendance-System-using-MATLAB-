	function writing_names(varagin) 
    
		prompt = {img_set_given.Description};
		dlg_title = 'Specify Names'; % getting names at the run time
		d = prompt;
		replace = inputdlg(prompt,dlg_title,1,d); % repacing with the given person number
        
		s_f = pathsFromImageSet(img_set_given);
        
		for k = 1:numel(replace) %loop for all capture images
            
			subf = s_f{k};
			fs = strfind(subf,filesep);
			
			subf = [subf,replace{k}];
			if ~isequal(s_f{k},subf)
				movefile(s_f{k},subf);
			end
		end
		img_set_given = imageSet(targetDirectory,'recursive'); % recursive call for gui 
	end 