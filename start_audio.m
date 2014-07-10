function start_audio(handle, event)

% for-schleife, welche alle hrtf-Daten, sowie zugehörige Winkel lädt


idx = 0;
for angle_idx = -40:10:90
    idx = idx + 1;
    angle_str = num2str(angle_idx);
    
    angle_path = ['angles_elev', angle_str, '.mat'];
    hrtf_l_path = ['hrtf_l_elev', angle_str, '.mat'];
    hrtf_r_path = ['hrtf_r_elev', angle_str, '.mat'];
    
    angles = load(angle_path);
    hrtf_l = load(hrtf_l_path);
    hrtf_r = load(hrtf_r_path);
    
    hrtf_struct(idx) = struct('angles', angles.(cell2mat(fieldnames(angles))),...
                              'hrtf_l', hrtf_l.(cell2mat(fieldnames(hrtf_l))),...
                              'hrtf_r', hrtf_r.(cell2mat(fieldnames(hrtf_r))));

end

%%%%%%%%%%%%%%%%%%%% audio-file-Daten aufbereiten %%%%%%%%%%%%%%%%%%%%%%%%%
data = guidata(handle);

out_dev = get(data.dev_popup, 'value');

sound_val = get(data.sound_popup, 'value');
sound_str = get(data.sound_popup, 'string');
filename = char(sound_str(sound_val));



[~, fs_audio] = wavread(filename, [1, 1]); % liest "nur" fs
size = wavread(filename, 'size');
samples = size(1);
file_chans = size(2);

block_size = 1024;
out_chans = 2;

block_size_out = block_size;

msound('openwrite', out_dev, fs_audio, block_size_out, out_chans);
complete_data = [];

conv_puffer = zeros(127,2); % 127 = hrtf - 1


for idx=1:block_size:samples
    
    set(data.azi_panel, 'buttondownfcn', @azdir_change);
    set(data.elev_panel, 'buttondownfcn', @eldir_change);

    drawnow;
    
    az_deg = str2num(get(data.azdir_edit, 'string'));
    el_deg = str2num(get(data.eldir_edit, 'string'));
    
    
    %interp_l = interp1(angles_elev0, hrtf_l_elev0, az_deg);
    %interp_r = interp1(angles_elev0, hrtf_r_elev0, az_deg);
    
    [interp_l, interp_r] = interpolate(az_deg, el_deg, hrtf_struct);
    
    data_audio = wavread(filename, [idx, idx+block_size-1]);
    
    if file_chans == 2

        data_r = data_audio(:,2);
        data_l = data_audio(:,1);
        data_audio = (data_r + data_l)./2; % damit Leistung gleich bleibt durch 2 teilen (mean-Bildung)
    
    end
    
    
    conv_data_l = conv(data_audio, interp_l);
    conv_data_r = conv(data_audio, interp_r);
    conv_data = [conv_data_l(1:block_size), conv_data_r(1:block_size)];
    conv_data(1:127,:) = conv_data(1:127,:) + conv_puffer;
    
    conv_puffer = [conv_data_l(block_size + 1:end), conv_data_r(block_size + 1:end)];

    
    msound('putsamples', conv_data);
    


end

msound('close')

end
