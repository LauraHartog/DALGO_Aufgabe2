function azdir_change(handle, event)

data = guidata(handle);

cP = get(data.azi_axes,'Currentpoint');
x = cP(1,1);
y = cP(1,2);

set(data.azi_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);

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

set(data.azdir_edit, 'string', deg);

end