filename = 'evil_laugh.wav';
file = wavread(filename);
file = file(1:(end-0.75*1024));
%{
wavwrite(file, 'laugh.wav');

filename = 'laugh.wav'
[~, fs_audio] = wavread(filename, [1, 1]); % liest "nur" fs
size = wavread(filename, 'size');
samples = size(1);
samples/1024
%}