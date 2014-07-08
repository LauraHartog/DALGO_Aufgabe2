function start_audio(handle, event)

load hrtf_l_elev0.mat
load hrtf_r_elev0.mat
load angles_elev0.mat

%%%%%%%%%%%%%%%%%%%% audio-file-Daten aufbereiten %%%%%%%%%%%%%%%%%%%%%%%%%
data = guidata(handle);

out_dev = get(data.dev_popup, 'value');

filename = 'Mann_short.wav';

[~, fs_audio] = wavread(filename, [1, 1]); % liest "nur" fs
size = wavread(filename, 'size');
samples = size(1);
file_chans = size(2);

block_size = 1024;
out_chans = 2;

block_size_out = block_size;

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Test

elev = '0';
azimuth = '090';  % drei stellen!
pathname = strcat('H', elev, 'e', azimuth, 'a.wav');
    
[data_hrtf, fs_hrtf] = wavread(pathname);


data_audio = wavread(filename);
conv_data_l = conv(data_audio, data_hrtf(:,1), 'same');
conv_data_r = conv(data_audio, data_hrtf(:,2), 'same');
conv_data_m = [conv_data_l, conv_data_r];

sound(conv_data_m, fs_hrtf);

%%%%%%%%%%%%%%%%%%%%%%%%% Test
%}

msound('openwrite', out_dev, fs_audio, block_size_out, out_chans);
complete_data = [];
conv_puffer = zeros(127,2);

for idx=1:block_size:samples
    
    drawnow;
    deg = str2num(get(data.azdir_edit, 'string'));

    
    interp_l = interp1(angles_elev0, hrtf_l_elev0, deg);
    interp_r = interp1(angles_elev0, hrtf_r_elev0, deg);
    
    data_audio = wavread(filename, [idx, idx+block_size-1]);
    
    if file_chans == 2

        data_r = data_audio(:,2);
        data_l = data_audio(:,1);
        data_audio = data_r + data_l;
    
    end
    
    
    conv_data_l = conv(data_audio, interp_l);
    conv_data_r = conv(data_audio, interp_r);
    conv_data = [conv_data_l(1:block_size), conv_data_r(1:block_size)];
    conv_data(1:127,:) = conv_data(1:127,:) + conv_puffer;
    
    conv_puffer = [conv_data_l(block_size + 1:end), conv_data_r(block_size + 1:end)];

    %{
    %%%% Daten einlesen nach Eva & Lenas Methode
    
    load 'hrir_final_KEMAR_large.mat'
    h_l = squeeze(hrir_l(1,1,:));
    h_r = squeeze(hrir_r(1,1,:));
    
    conv_data_l = filter(h_l,1,data_audio);
    conv_data_r = filter(h_r,1,data_audio);
    conv_data = [conv_data_l, conv_data_r];
    
    %conv_data = [data_audio*0.8, data_audio*0.4];
    
    %}
    msound('putsamples', conv_data);
    
    %complete_data = vertcat(complete_data, conv_data);
    
end

msound('close')

end
