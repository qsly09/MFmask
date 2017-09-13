function [x_new,y_new] = getRealCloudPosition(x,y,h,A,B,C,omiga_par,omiga_per,sensor_heigh_bias)
    % imput "x",j col 
    % imput "y",i row
    % imput cloud height "h"
    H=705000-sensor_heigh_bias; % average Landsat 7 height (m) is 705000, but the height of cloud's surface should be excluded.
    dist=(A*x+B*y+C)/((A^2+B^2)^(0.5));% from the cetral perpendicular (unit: pixel)
    dist_par=dist/cos(omiga_per-omiga_par);
    dist_move=dist_par.*double(h)/double(H); % cloud move distance (m);
    delt_x=dist_move*cos(omiga_par);
    delt_y=dist_move*sin(omiga_par);

    x_new=x+delt_x; % new x, j
    y_new=y+delt_y; % new y, i   
end

