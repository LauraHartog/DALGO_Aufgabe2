function [interp_l, interp_r] = interpolate_old(az_deg, el_deg, hrtf_struct)


% Funktion erstellen, welche winkel (deg) auf Index des hrtf_structs
% abbildet
deg2idx = @(deg)((deg + 50)/10);

% untere (floor) und obere (ceil) Elevationswinkel ermitteln, zwischen denen der
% eigentliche Elevationswinkel 'el_deg' liegt
floor_el = floor(el_deg/10)*10;
ceil_el = ceil(el_deg/10)*10;

% Gewichtung zu linearer Interpolation zwischen Elevationswinkeln ermitteln
floor_weight = 1 - (el_deg - floor_el)/10;
ceil_weight = 1 - (ceil_el - el_deg)/10;

% untere und obere Elevationswinkel in Variable schreiben
floor_el_angles = hrtf_struct(deg2idx(floor_el)).angles;
ceil_el_angles = hrtf_struct(deg2idx(ceil_el)).angles;

% hrtf der unteren und oberen Elevationswinkel in Variable schreiben,
% sowohl für links als auch für rechts
floor_el_hrtf_l = hrtf_struct(deg2idx(floor_el)).hrtf_l;
ceil_el_hrtf_l = hrtf_struct(deg2idx(ceil_el)).hrtf_l;

floor_el_hrtf_r = hrtf_struct(deg2idx(floor_el)).hrtf_r;
ceil_el_hrtf_r = hrtf_struct(deg2idx(ceil_el)).hrtf_r;

% Interpolation über Azimuth-Ebene
interp_l_floor = interp1(floor_el_angles, floor_el_hrtf_l, az_deg);
interp_l_ceil = interp1(ceil_el_angles, ceil_el_hrtf_l, az_deg);

interp_r_floor = interp1(floor_el_angles, floor_el_hrtf_r, az_deg);
interp_r_ceil = interp1(ceil_el_angles, ceil_el_hrtf_r, az_deg);

% manuelle lineare Interpolation über Elevations-Ebene

interp_l = floor_weight*interp_l_floor + ceil_weight*interp_l_ceil;

interp_r = floor_weight*interp_r_floor + ceil_weight*interp_r_ceil;








%{

plot(interp_r)
hold on
plot(interp_l)
hold off

if strcmp(num2str(ceil_el), num2str(floor_el)) == 1
    ceil_el =  ceil_el + 10;
end


floor_el_str = num2str(floor_el);

ceil_el_str = num2str(ceil_el);

angles_floor = ['angles_elev', floor_el_str, '.mat'];
angles_ceil = ['angles_elev', ceil_el_str, '.mat'];

angles_floor = load(angles_floor);
angles_ceil = load(angles_ceil);

field_angles_floor = cell2mat(fieldnames(angles_floor));
field_angles_ceil = cell2mat(fieldnames(angles_ceil));

angles_floor = angles_floor.(field_angles_floor);
angles_ceil = angles_ceil.(field_angles_ceil);

hrtf_l_floor = ['hrtf_l_elev', floor_el_str, '.mat'];
hrtf_l_ceil = ['hrtf_l_elev', ceil_el_str, '.mat'];
hrtf_r_floor = ['hrtf_r_elev', floor_el_str, '.mat'];
hrtf_r_ceil = ['hrtf_r_elev', ceil_el_str, '.mat'];

hrtf_l_floor = load(hrtf_l_floor);
hrtf_l_ceil = load(hrtf_l_ceil);
hrtf_r_floor = load(hrtf_r_floor);
hrtf_r_ceil = load(hrtf_r_ceil);

field_l_floor = cell2mat(fieldnames(hrtf_l_floor));
field_l_ceil = cell2mat(fieldnames(hrtf_l_ceil));
field_r_floor = cell2mat(fieldnames(hrtf_r_floor));
field_r_ceil = cell2mat(fieldnames(hrtf_r_ceil));

hrtf_l_floor = hrtf_l_floor.(field_l_floor);
hrtf_l_ceil = hrtf_l_ceil.(field_l_ceil);
hrtf_r_floor = hrtf_r_floor.(field_r_floor);
hrtf_r_ceil = hrtf_r_ceil.(field_r_ceil);

az_deg = 13;

%}
end