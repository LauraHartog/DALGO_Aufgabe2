function [interp_l, interp_r] = interpolate(az_deg, el_deg, hrtf_struct)
%INTERPOLATE() interpoliert in Azimuthebene aus definierter Elevationsebene
%   INTERPOLATE(AZ_DEG, EL_DEG, HRTF_STRUCT) interpoliert die hrtf des 
%   Winkels az_deg in Azimuthebene aus definierter Elevationsebene des
%   Winkels el_deg. Die zur Interpolation benutzten hrtfs sind im
%   Eingabeparameter hrtf_struct gespeichert.
  
% Copyright 2014 Laura Hartog, Franz Wichert

% Funktion erstellen, welche winkel (deg) auf Index des hrtf_structs
% abbildet
deg2idx = @(deg)((deg + 50)/10);


% Azimuthwinkelvektor eines Elevationswinkels in Variable schreiben
angles = hrtf_struct(deg2idx(el_deg)).angles;


% hrtf des Elevationswinkels in Variable schreiben,
% sowohl für links als auch für rechts
hrtf_l = hrtf_struct(deg2idx(el_deg)).hrtf_l;
hrtf_r = hrtf_struct(deg2idx(el_deg)).hrtf_r;

% Interpolation über Azimuth-Ebene
interp_l = interp1(angles, hrtf_l, az_deg);
interp_r = interp1(angles, hrtf_r, az_deg);


end

%--------------------Licence ---------------------------------------------
% Copyright (c) <2011-2013> F. Wichert, L. Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences