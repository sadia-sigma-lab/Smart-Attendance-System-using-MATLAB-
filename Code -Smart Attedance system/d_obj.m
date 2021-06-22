function [object_position,object_dimensions] = d_obj(number,starting_position,ending_position,g,w)



r = 0; % initial value
if starting_position > ending_position % checking validation of positions points given
    r = 1;
    tmp = ending_position; % temperorary variable for ending position of box storing
    ending_position = starting_position; % updating the position 
    starting_position = tmp; % updating starting possition to previous ending position
end
    
object_dimensions = ((ending_position-starting_position)-(number-1)*g)/number;
object_position = starting_position:object_dimensions+g:ending_position; % checking for case g=0
 
object_position = object_position(1:number);  % for position of object as the faces

if r  % for r=1
    object_position = object_position(end:-1:1);
end
if ~w && (any(object_position < 0) || object_dimensions < 0)
	
end
