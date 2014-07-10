
x = [0.2];


elev_vec = [0, 5];


azim_vec = [0, 5, 10];

elev_0 = [x;...
        2*x;...
        3*x];

elev_5 = [(x).^2;...
        (2*x).^2;...
        (3*x).^2];


matrix_2d = zeros(2, 3, 1);

matrix_2d(1,:,:) = elev_0;
matrix_2d(2,:,:) = elev_5;

elev = 4;
azim = 8;

[azim_angles, elev_angles] = meshgrid(azim_vec, elev_vec');

interp_2d = interp2(azim_angles, elev_angles, matrix_2d, azim, elev)

surf(azim_angles, elev_angles, matrix_2d)
