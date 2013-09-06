function [ lx ] = get_mosek_lx( n, P, nXi, opt_flag )
%GET_MOSEK_LX Summary of this function goes here
%   Detailed explanation goes here

lx1 = - inf(n*P, 1);
lx2 = zeros(n*P, 1);
lx3 = zeros(nXi, 1);

if strcmp(opt_flag, 'MOSEK_NORM')
    lx = cat(1, lx2, lx3, lx1);
else
    lx = cat(1, lx2, lx3);
end

end

