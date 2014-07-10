clear all;close all;clc

profile('on');

airpar.fs = 48e3;
airpar.channel = 1;

%--------------------------------------------------------------------------
% Example 2
%--------------------------------------------------------------------------
% Binaural RIR of Stairway
% Distance: 2m
% With dummy head
% left and right channel
% 15° Azimuth angle
airpar.rir_type = 1;
airpar.room = 11;
airpar.head = 1;
airpar.rir_no = 3;
airpar.azimuth = 0;

airpar.channel = 1;
[h_left,air_info] = load_air(airpar);
airpar.channel = 0;
[h_right,air_info] = load_air(airpar);

[data, fs] = wavread('Mann_short.wav');

conv_data_l = conv(data, h_left);
conv_data_r = conv(data, h_right);

conv_data = [conv_data_l', conv_data_r'];



sound(conv_data, fs)

profile('viewer')