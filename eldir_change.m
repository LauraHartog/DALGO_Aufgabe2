function eldir_change(handle, event)

data = guidata(handle);

[x, y] = ginput(1);

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

set(data.eldir_edit, 'string', deg);

end