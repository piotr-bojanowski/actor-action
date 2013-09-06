function [ A ] = build_A( K, lambda )
%BUILD_A Summary of this function goes here
%   Detailed explanation goes here


[n,d] = size(K);
In = eye(n);
% Id = eye(d);
Pn = In - ones(n)/n;

% A = Pn * (In - X * inv(X' * Pn * X + n * lambda * Id) * X') * Pn / n;

M = Pn * K * Pn + n * lambda * In;

% [V, D] = eig(M);

% A = diag(diag(D).^(-.5)) * V' * Pn;
A = lambda * Pn * inv(M) * Pn;

A = (A + A') / 2;

A = 1000 * A + 10.^(-10) * eye(size(A));

end

