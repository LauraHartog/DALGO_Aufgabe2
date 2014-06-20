function eldir_change(handle, event)

data = guidata(handle);

cP = get(data.elev_axes,'Currentpoint');
x = cP(1,1);
y = cP(1,2);

y_position = linspace(0,1,360);
y_position = y_position(round(y)+181) 
set(data.elev_picture_panel, 'Position', [0.45 y_position-0.05 0.1 0.1]);

% if x >= 0 && y >= 0
%     
%     deg = -atan(y/x) + pi/2;
%     
% elseif x >= 0 && y < 0
%     
%     deg = -atan(y/x) +pi/2;
%     
% elseif x < 0 && y < 0
%     
%     deg = -atan(y/x) + 3*pi/2;
%     
% elseif x < 0 && y >= 0
%     
%     deg = -atan(y/x) + 3*pi/2;
%     
% end

%deg = deg*360/(2*pi); % Radianwinkel in Degreewinkel umwandeln

set(data.eldir_edit, 'string', y);

end