block_length = 1024;
filename = 'evil_laugh.wav';
[nchan fs bytespersecond subchunklen len_in_samples] = wavread(filename);
data = wavread(filename);

%{
    if nchan == 2

        data_r = data(:,2);
        data_l = data(:,1);
        data = (data_r + data_l)./2; % damit Leistung gleich bleibt durch 2 teilen (mean-Bildung)
    
    end

overflow = mod(samples, block_length);
wavwrite(data(1:end-overflow), filename);

wavwrite(file, 'laugh.wav');

filename = 'laugh.wav'
[~, fs_audio] = wavread(filename, [1, 1]); % liest "nur" fs
size = wavread(filename, 'size');
samples = size(1);
samples/1024
%}