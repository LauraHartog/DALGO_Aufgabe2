function dir_change_fcn(handle, event)

data = guidata(handle);
[x, y, button] = ginput(1);

global deg

if x >= 0 && y >= 0
    
    deg = -atan(y/x) + pi/2;
    
elseif x >= 0 && y < 0
    
    deg = -atan(y/x) +pi/2;
    
elseif x < 0 && y < 0
    
    deg = -atan(y/x) + 3*pi/2;
    
elseif x < 0 && y >= 0
    
    deg = -atan(y/x) + 3*pi/2;
    
end

deg = deg*360/(2*pi); % Radianwinkel in Degreewinkel umwandeln

end