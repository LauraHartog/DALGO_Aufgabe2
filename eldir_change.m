function eldir_change(handle, event)
%ELDIR_CHANGE berechnet Elevationswinkel aus den aktuellen Koordinaten
%
%   ELDIR_CHANGE(HANDLE, EVENT) berechnet aus den aktuell angeklickten
%   Koordinaten welche im struct des Eingabeparameters handle stehen, die
%   Winkel und setzt diese in das Edit-Fenster des Elevationswinkels aus dem 
%   Skript 'hrtf_gui'.
%
%   Diese Funktion funktioniert nur in Verbindung mit dem Skript hrtf_gui
%
% Copyright 2014 Laura Hartog, Franz Wichert

% handles aus dem hfig-struct werden in Variable 'data' geschrieben
data = guidata(handle);

% die aktuell angeklickten Koordinaten ermitteln
cP = get(data.elev_axes, 'Currentpoint');
x = cP(1,1);
y = cP(1,2);

% if-Abfrage, mit welcher x- und y-Positionen auf Elevations-Winkel abgebildet werden
if x >= 0 && y >= 0
    
    deg = -atan(y/x) + pi;
    
elseif x >= 0 && y < 0
    
    deg = -atan(y/x) -pi;
    
elseif x < 0 && y < 0
    
    deg = -atan(y/x);
    
elseif x < 0 && y >= 0
    
    deg = -atan(y/x);
    
end


deg = round(deg*360/(2*pi)/10)*10; % Radianwinkel in Degreewinkel umwandeln,
                                   % und auf Zehnerschritte runden

% if-Schleife, um Lautsprecherbild auf die eingestellte Position zu setzen;
% if- und elseif-Bedingung lassen keine Elevationswinkel > 90° und < -40°
% zu, da diese im hrtf-Datensatz nicht enthalten sind.

if deg > 90
    
    deg = 90;
    y = 0.5;
    x = 0;
    % Lautsprecherbild auf eingestellte Position setzen
    set(data.elev_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);
                                   
elseif deg < -40
    
    deg = -40;
    y = -0.3;
    x = tan((deg+90)*2*pi/360)*y;
    % Lautsprecherbild auf eingestellte Position setzen
    set(data.elev_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);
    
else
    
    % Lautsprecherbild auf eingestellte Position setzen
    set(data.elev_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);

end

% Der errechnete Winkel wird in das Edit-Fenster für den Elevationswinkel
% geschrieben
set(data.eldir_edit, 'string', deg);

end


%--------------------Licence ---------------------------------------------
% Copyright (c) <2011-2013> F. Wichert, L. Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences