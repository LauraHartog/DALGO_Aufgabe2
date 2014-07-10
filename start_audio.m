function start_audio(handle, event)
  %START_AUDIO gibt audio-Datei blockweise wieder
  %   START_AUDIO(HANDLE, EVENT) lädt zu Beginn des Aufrufs alle
  %   hrtf-Dateien und die zugehörigen Winkel in ein struct. Mithilfe
  %   der hrtfs aus diesem struct wird die Audio-Datei in der blockweisen
  %   Wiedergabe, mittels overlap-add-Methode gefaltet.
  %
  %   Diese Funktion funktioniert nur in Verbindung mit dem Skript hrtf_gui
  %   und wird ausgeführt nachdem Button 'start audio' gedrückt wurde.
  
  % Copyright 2014 Laura Hartog, Franz Wichert

% for-schleife, welche alle hrtf-Daten, sowie zugehörige Winkel (von -40°
% bis +90° in Zehnerschritten) lädt
idx = 0;
for angle_idx = -40:10:90
    idx = idx + 1;
    angle_str = num2str(angle_idx);
    
    % Pfade der hrtf-Dateien und Winkel-Dateien werden in Variablen
    % geschrieben
    angle_path = ['angles_elev', angle_str, '.mat'];
    hrtf_l_path = ['hrtf_l_elev', angle_str, '.mat'];
    hrtf_r_path = ['hrtf_r_elev', angle_str, '.mat'];
    
    % Winkel und hrtf-Dateien werden geladen
    angles = load(angle_path);
    hrtf_l = load(hrtf_l_path);
    hrtf_r = load(hrtf_r_path);
    
    % geladene Winkel und hrtf-Dateien werden in ein struct geschrieben
    hrtf_struct(idx) = struct('angles', angles.(cell2mat(fieldnames(angles))),...
                              'hrtf_l', hrtf_l.(cell2mat(fieldnames(hrtf_l))),...
                              'hrtf_r', hrtf_r.(cell2mat(fieldnames(hrtf_r))));

end

%%%%%%%%%%%%%%%%%%%% audio-file-Daten aufbereiten %%%%%%%%%%%%%%%%%%%%%%%%%

% handles aus dem hfig-struct werden in Variable 'data' geschrieben
data = guidata(handle);

% output-Device-ID wird mithilfe der Funktion 'Device-Finder' aus dem
% popup-menu geholt
out_dev = get(data.dev_popup, 'value');

% Die, aus 'sound_popup' des Skripts 'hrtf_gui' ausgewählte Sounddatei
% wird als string in die Variable 'filename' geschrieben
sound_val = get(data.sound_popup, 'value');
sound_str = get(data.sound_popup, 'string');
filename = char(sound_str(sound_val));


% Samplefrequenz der ausgewählten audiodatei wird ermittelt
[~, fs_audio] = wavread(filename, [1, 1]);
size = wavread(filename, 'size');
% Anzahl der samples, wird in Variable 'samples' geschrieben
samples = size(1);
% Anzahl der Kanäle wird in die Variable 'file_chans' geschrieben
file_chans = size(2);

% Eingabeparameter für 'msound'-Funktion werden deklariert
block_size = 1024;
out_chans = 2;
block_size_out = block_size;

msound('openwrite', out_dev, fs_audio, block_size_out, out_chans);

% conv_puffer wird erstellt, der zur Overlap-add-Methode genutzt wird
conv_puffer = zeros(127,2); % 127 = hrtf - 1

% Blockweises einlesen der audiodatei
for idx=1:block_size:samples
    
    % Mittels buttondownfcn werden die aktuellen winkel durch Funktionen
    % azdir_change und eldir_change ermittelt
    set(data.azi_panel, 'buttondownfcn', @azdir_change);
    set(data.elev_panel, 'buttondownfcn', @eldir_change);
    
    % drawnow sorgt dafür, dass alle Änderungen sofort übernommen werden
    drawnow;
    
    % Aktuelle Winkelwerte werden aus den jeweiligen Edit-Fenstern geholt
    az_deg = str2num(get(data.azdir_edit, 'string'));
    el_deg = str2num(get(data.eldir_edit, 'string'));
    
    % Mithilfe der Funktion 'interpolate' werden aus den Azimuth-, und
    % Elevationswinkeln und dem hrtf_struct das rechte und linke gefaltete
    % Signal interpoliert
    [interp_l, interp_r] = interpolate(az_deg, el_deg, hrtf_struct);
    
    % In Variable 'data_audio' wird der aktuelle Block des audiosignals
    % geschrieben
    data_audio = wavread(filename, [idx, idx+block_size-1]);
    
    % if-Schleife fässt stereo-signale zu mono-Signal zusammen
    if file_chans == 2

        data_r = data_audio(:,2);
        data_l = data_audio(:,1);
        % damit Leistung gleich bleibt durch 2 teilen (mean-Bildung)
        data_audio = (data_r + data_l)./2;
    
    end
    
    % Faltung
    conv_data_l = conv(data_audio, interp_l);
    conv_data_r = conv(data_audio, interp_r);
    
    % Blockweise Faltung mittels Overlap-add-Methode
    conv_data = [conv_data_l(1:block_size), conv_data_r(1:block_size)];
    % die 127 samples der letzten Faltung werden zu den ersten 127 
    % samples der aktuellen Faltung addiert
    conv_data(1:127,:) = conv_data(1:127,:) + conv_puffer;
    conv_puffer = [conv_data_l(block_size + 1:end), conv_data_r(block_size + 1:end)];

    % Wiedergabe mit msound
    msound('putsamples', conv_data);
    


end

% msound schließen
msound('close');

end


%--------------------Licence ---------------------------------------------
% Copyright (c) <2011-2013> F. Wichert, L. Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences