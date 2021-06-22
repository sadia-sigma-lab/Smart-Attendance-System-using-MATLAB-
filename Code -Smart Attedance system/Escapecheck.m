function is_d=Escapecheck(varargin)
		if double(get(gcf,'currentcharacter'))== 27
			is_d=True;
		end
	end 