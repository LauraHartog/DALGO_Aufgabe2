function azdir_change(handle, event)
%AZDIR_CHANGE berechnet Azimuthwinkel aus den aktuellen Koordinaten
%
%   AZDIR_CHANGE(HANDLE, EVENT) berechnet aus den aktuell angeklickten
%   Koordinaten welche im struct des Eingabeparameters handle stehen, die
%   Winkel und setzt diese in das Edit-Fenster des Azimuthwinkels aus dem 
%   Skript 'hrtf_gui'.
%
%   Diese Funktion funktioniert nur in Verbindung mit dem Skript hrtf_gui
%
% Copyright 2014 Laura Hartog, Franz Wichert

% handles aus dem hfig-struct werden in Variable 'data' geschrieben
data = guidata(handle);

% die aktuell angeklickten Koordinaten ermitteln
cP = get(data.azi_axes,'Currentpoint');
x = cP(1,1);
y = cP(1,2);

% Lautsprecherbild auf eingestellte Position setzen
set(data.azi_picture_panel, 'Position', [((x+1)/2)-0.04 ((y+1)/2)-0.04 0.08 0.08]);

% if-Abfrage, mit welcher x- und y-Positionen auf Azimuth-Winkel abgebildet werden
if x >= 0 && y >= 0
    
    deg = -atan(y/x) + pi/2;
    
elseif x >= 0 && y < 0
    
    deg = -atan(y/x) +pi/2;
    
elseif x < 0 && y < 0
    
    deg = -atan(y/x) + 3*pi/2;
    
elseif x < 0 && y >= 0
    
    deg = -atan(y/x) + 3*pi/2;
    
end

deg = round(deg*360/(2*pi)); % Radianwinkel in Degreewinkel umwandeln, und
                             % und auf eine Stelle vor dem Komma genau
                             % runden

% Der errechnete Winkel wird in das Edit-Fenster für den Azimuthwinkel
% geschrieben
set(data.azdir_edit, 'string', deg);

end

%--------------------Licence ---------------------------------------------
% Copyright (c) <2011-2013> F. Wichert, L. Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences