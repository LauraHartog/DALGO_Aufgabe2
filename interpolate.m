function [interp_l, interp_r] = interpolate(az_deg, el_deg, hrtf_struct)


% Funktion erstellen, welche winkel (deg) auf Index des hrtf_structs
% abbildet
deg2idx = @(deg)((deg + 50)/10);


% Azimuthwinkelvektor eines Elevationswinkels in Variable schreiben
angles = hrtf_struct(deg2idx(el_deg)).angles;


% hrtf der unteren und oberen Elevationswinkel in Variable schreiben,
% sowohl für links als auch für rechts
hrtf_l = hrtf_struct(deg2idx(el_deg)).hrtf_l;
hrtf_r = hrtf_struct(deg2idx(el_deg)).hrtf_r;

% Interpolation über Azimuth-Ebene
interp_l = interp1(angles, hrtf_l, az_deg);
interp_r = interp1(angles, hrtf_r, az_deg);


end