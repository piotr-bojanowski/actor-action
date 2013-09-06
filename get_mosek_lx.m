function [ lx ] = get_mosek_lx( n, P, nXi )

lx1 = - inf(n*P, 1);
lx2 = zeros(n*P, 1);
lx3 = zeros(nXi, 1);

lx = cat(1, lx2, lx3, lx1);

end