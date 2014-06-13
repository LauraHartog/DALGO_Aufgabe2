clear all;
close all;
clc;

elev = '-20';
    
idx = 1;
angles_elev0 = [];
hrtf_l_elev0 = [];
hrtf_r_elev0 = [];

for angl = 0:5:180
    
angles_elev0 = [angles_elev0, angl];
   
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

hrtf_l_elev0 = vertcat(hrtf_l_elev0, hrtf(:,1)');
hrtf_r_elev0 = vertcat(hrtf_r_elev0, hrtf(:,2)');

idx = idx + 1;

end


angl = 175;
idx = 1;

for angl = 175:-5:0

    angles_elev0 = [angles_elev0, (angl + (idx)*10)];
   
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

hrtf_l_elev0 = vertcat(hrtf_l_elev0, hrtf(:,2)');
hrtf_r_elev0 = vertcat(hrtf_r_elev0, hrtf(:,1)');

idx = idx + 1;

end

load angles_elev_min20
load angles_elev_min10
load angles_elev0
load angles_elev10
load angles_elev20
elev_angles = [-20, -10, 0, 10, 20];

load hrtf_l_elev_min20
load hrtf_l_elev_min10
load hrtf_l_elev0
load hrtf_l_elev10
load hrtf_l_elev20

load hrtf_r_elev_min20
load hrtf_r_elev_min10
load hrtf_r_elev0
load hrtf_r_elev10
load hrtf_r_elev20

hrtf_2d_l = zeros(5, 73, 128);
hrtf_2d_l(1,:,:) = hrtf_l_elev_min20;
hrtf_2d_l(2,:,:) = hrtf_l_elev_min10;
hrtf_2d_l(3,:,:) = hrtf_l_elev0;
hrtf_2d_l(4,:,:) = hrtf_l_elev10;
hrtf_2d_l(5,:,:) = hrtf_l_elev20;

azim_winkel = 91.1;
elev_winkel = 19.22;

[x, y] = meshgrid(angles_elev0, elev_angles');

hrtf_2d_l_interp = interp2(x, y, hrtf_2d_l, azim_winkel, elev_winkel);

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

