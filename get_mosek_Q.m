function [ qosubi, qosubj, qoval ] = get_mosek_Q( A, Y, nXi, kapa, opt_flag )
%GET_MOSEK_Q Summary of this function goes here
%   Detailed explanation goes here

A = 1000*A;

[n, P] = size(Y);

% [V, D] = eig(A);
% A = V * max(0, D) * V';

IP = sparse(1:P, 1:P, 1);
As = sparse(A);


Znx = sparse(n*P, nXi);
Znn = sparse(n*P, n*P);

IXi = kapa / 2 * sparse(1:nXi, 1:nXi, 1);

if strcmp(opt_flag, 'MOSEK_QUAD')
    Q = kron(IP, As);
    Q = [Q, Znx; Znx', IXi];
elseif strcmp(opt_flag, 'MOSEK_NORM')
    IY = 1 / 2 * sparse(1:(n*P), 1:(n*P), 1);
%     IY = sparse(n*P, n*P);
    Q = [Znn, Znx, Znn; Znx', IXi, Znx'; Znn, Znx, IY];
end

nQ = size(Q);

Q = Q + 10^(-7) * sparse(nQ, nQ, 1);

[qosubi, qosubj, qoval] = find(Q);

end

