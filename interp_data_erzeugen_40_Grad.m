clear all;
close all;
clc;

elev = '-40';

deg_array1 = [0, 6, 13, 19, 26, 32, 39, 45, 51, 58, 64, 71, 77, 84, 90, 96,...
            103, 109, 116, 122, 129, 135, 141, 148, 154, 161, 167, 174, 180];
deg_array2 = 360.-deg_array1(end-1:-1:1);
idx = 1;

angles_elev40 = [];
hrtf_l_elev40 = [];
hrtf_r_elev40 = [];

for angl_idx = 1:1:length(deg_array1)

angl = deg_array1(angl_idx);
    
   
azimuth = num2str(angl);

if length(azimuth) == 1
    
    azimuth = ['00', azimuth];

elseif length(azimuth) == 2

    azimuth = ['0', azimuth];
    
elseif length(azimuth) == 3
    
    azimuth = num2str(angl);
    
end

pathname = ['H', elev, 'e', azimuth, 'a.wav'];

hrtf = wavread(pathname);

hrtf_l_elev40 = vertcat(hrtf_l_elev40, hrtf(:,1)');
hrtf_r_elev40 = vertcat(hrtf_r_elev40, hrtf(:,2)');

idx = idx + 1;

end


angl_vec = deg_array1(end-1:-1:1)
idx = 1;

for angl_idx = 1:length(angl_vec)

angl = angl_vec(angl_idx)
    
azimuth = num2str(angl);

if length(azimuth) == 1
    
    azimuth = ['00', azimuth];

elseif length(azimuth) == 2

    azimuth = ['0', azimuth];
    
elseif length(azimuth) == 3
    
    azimuth = num2str(angl);
    
end

pathname = ['H', elev, 'e', azimuth, 'a.wav'];

hrtf = wavread(pathname);

hrtf_l_elev40 = vertcat(hrtf_l_elev40, hrtf(:,2)');
hrtf_r_elev40 = vertcat(hrtf_r_elev40, hrtf(:,1)');

idx = idx + 1;

end


%%% nur bei 50 Grad notwendig!!!
%{
angles_elev0 = [angles_elev0, 360];

pathname = ['H', elev, 'e', '000', 'a.wav'];
hrtf = wavread(pathname);
hrtf_l_elev0 = vertcat(hrtf_l_elev0, hrtf(:,2)');
hrtf_r_elev0 = vertcat(hrtf_r_elev0, hrtf(:,1)');

%}
%%% nur bei 50 Grad notwendig!!!

angles_elev40 = [deg_array1, deg_array2];

hrtf_l_elev_min40 = hrtf_l_elev40;
hrtf_r_elev_min40 = hrtf_r_elev40;
angles_elev_min40 = angles_elev40;

save hrtf_l_elev_min40.mat hrtf_l_elev_min40
save hrtf_r_elev_min40.mat hrtf_r_elev_min40
save angles_elev_min40.mat angles_elev_min40


%hrtf_2d_r = zeros(73, 128, 5);        
%hrtf_2d_r(:,:,:) = [hrtf_r_elev_min20;...
%               hrtf_r_elev_min10;...
%                hrtf_r_elev0;
%                hrtf_r_elev10;
%                hrtf_r_elev20];

%ZI = interp2(X,Y,Z,XI,YI)


%{
hrtf_l_elev_min20 = hrtf_l_elev0;
hrtf_r_elev_min20 = hrtf_r_elev0;
angles_elev_min20 = angles_elev0;

save hrtf_l_elev_min20.mat hrtf_l_elev_min20
save hrtf_r_elev_min20.mat hrtf_r_elev_min20
save angles_elev_min20.mat angles_elev_min20


[x, y] = meshgrid(service, years')



ZI = interp2(X,Y,Z,XI,YI)



data_hrtf_li = hrtf(:,1);
data_hrtf_re = hrtf(:,2);

li_hrtf_0 = [0 15 1 7 9 2];
li_hrtf_5 = [10 20 3 3 4 1];
li_hrtf_10 = [12 12 6 8 6 0];

winkel_vec = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70,...
    75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145,...
    150, 155, 160, 165, 170, 175, 180];

interpoliert = interp1(winkel_vec(1:3), [li_hrtf_0; li_hrtf_5; li_hrtf_10], 4)
%}

