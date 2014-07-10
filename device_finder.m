function device_finder(handle, event)
%DEVICE_FINDER findet In- und Output-Devices
%   DEVICE_FINDER(HANDLE, EVENT) findet alle internen und extern
%   angeschlossenen Devices, und zeigt diese im popup-Fenster 'h_device_popup'
%   aus dem zugehörigen Skript hrtf_gui.m an. Die values, welche
%   im popup-menu stehen, entsprechen der jeweiligen device-id
%
%   Diese Funktion funktioniert nur in Verbindung mit dem Skript hrtf_gui
%   und wird ausgeführt nachdem Button 'find device' gedrückt wurde.

% Copyright 2014 Laura Hartog, Franz Wichert


data = guidata(handle); % handles aus dem hfig-struct werden in Variable
                        % 'data' geschrieben

% Alle vorhandenen Devices werden in dev_struct geschrieben
dev_struct = msound('deviceInfo');
dev_num = length(dev_struct);

% in dev_name_vec werden später die Namen der Devices geschrieben
dev_name_vec = cell(1, dev_num);

for dev = 1:dev_num
    
    dev_name_vec(dev) = {dev_struct(dev).name};
    
end
% in das popup-Fenster werden die Namen aller Devices in Reihenfolge der
% zugehörigen Device-ID gespeichert
set(data.dev_popup, 'string', dev_name_vec);

msound('close');

end

%--------------------Licence ---------------------------------------------
% Copyright (c) <2011-2013> F. Wichert, L. Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences