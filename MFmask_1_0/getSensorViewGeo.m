function [A,B,C,omiga_par,omiga_per] = getSensorViewGeo( x_ul,y_ul,x_ur,y_ur,x_ll,y_ll,x_lr,y_lr )
% imput "x",j
% imput "y",i
% imput cloud height "h"

    x_u=(x_ul+x_ur)/2;
    x_l=(x_ll+x_lr)/2;
    y_u=(y_ul+y_ur)/2;
    y_l=(y_ll+y_lr)/2;

    K_ulr=(y_ul-y_ur)/(x_ul-x_ur); % get k of the upper left and right points
    K_llr=(y_ll-y_lr)/(x_ll-x_lr); % get k of the lower left and right points
    K_aver=(K_ulr+K_llr)/2;
    omiga_par=atan(K_aver); % get the angle of scan lines k (in pi)

    % AX(j)+BY(i)+C=0
    A=y_u-y_l;
    B=x_l-x_u;
    C=y_l*x_u-x_l*y_u;

    omiga_per=atan(B/A); % get the angle which is perpendicular to the track
end

