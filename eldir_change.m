
function eldir_change(handle, event)

data = guidata(handle);

cP = get(data.elev_axes,'Currentpoint');
x = cP(1,1)
y = cP(1,2)

set(data.elev_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);

if x >= 0 && y >= 0
    
    deg = -atan(y/x) -pi;
    
elseif x >= 0 && y < 0
    
    deg = -atan(y/x) -pi;
    
elseif x < 0 && y < 0
    
    deg = -atan(y/x);
    
elseif x < 0 && y >= 0
    
    deg = -atan(y/x);
    
end

deg = round(deg*360/(2*pi)/10)*10; % Radianwinkel in Degreewinkel umwandeln,
                                   % und auf Zehnerschritte runden

set(data.eldir_edit, 'string', deg);

end
%{
data = guidata(handle);

cP = get(data.elev_axes,'Currentpoint');
x = cP(1,1);
y = cP(1,2);

y_position = linspace(0,1,360);
y_position = y_position(round(y)+181);
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
y = round(y/10)*10;
set(data.eldir_edit, 'string', y);

end
%}