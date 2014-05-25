clear
clc
close all

profile('on')

elev = '0';
azimuth = '090';  % drei stellen!

pathname = strcat('H', elev, 'e', azimuth, 'a.wav');
filename = 'Mann_short.wav';

[data, fs] = audioread(filename);
[HRTFdata, fs] = wavread(pathname);

convdata_links = conv(data, HRTFdata(:,1));
convdata_rechts = conv(data, HRTFdata(:,2));
convdata = [convdata_links, convdata_rechts];
sound(convdata, fs)

profile('viewer')