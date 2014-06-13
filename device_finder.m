%%%%%%%%%%%%%%%%% In- und Output-Devices erkennen %%%%%%%%%%%%%%%%%%%%%%%%%
function device_finder(handle, event)

    data = guidata(handle);


dev_struct = msound('deviceInfo');
dev_num = length(dev_struct);

dev_name_vec = cell(1, dev_num);
dev_id_vec = [];

for dev = 1:dev_num
    
    
    dev_name_vec(dev) = {dev_struct(dev).name};
    dev_id_vec = [dev_id_vec, dev_struct(dev).id];
    
end

set(data.dev_popup, 'string', dev_name_vec);

msound('close');

end

%{
in_devs = [];
out_devs = [];
in_out_dev = [];

for dev = 1:dev_num
    
    if dev_struct(dev).outputs == 0
        
        in_devs = [in_devs, dev];
        
    elseif dev_struct(dev).inputs == 0
        
        out_devs = [out_devs, dev];
        
    else
        
        in_out_dev = [in_out_dev, dev];
        
    end

end
%}
