function [ A, blc, buc ] = get_mosek_A( IA, IB, B, alpha)

n   = length(IA{1});
P   = length(IB{1});
nXi = length(IA);
A1 = zeros(n, n*P);
for i = 1:n
    idx = (0:(P-1))*n + i;
    A1(i, idx) = 1;
end

nel = zeros(length(IB), 1);
A2 = zeros(length(IB), n*P);
for i = 1:length(IB)
    bid = find(IB{i});
    aid = find(IA{i});
    idx = (bid-1)*n + aid;
    A2(i, idx) = IA{i}(aid);
    nel(i) = length(aid);
end

A = cat(1, A1, A2);

% adding the slack to the constraints
Z = zeros(n, nXi);
AXi = eye(nXi);
A = [A, [Z; AXi]];

A = sparse(A);

blc = [ones(n, 1); alpha * ones(length(IB), 1)];
buc = [ones(n, 1); inf(length(IB), 1)];


Bs = sparse(B);
Is = sparse(eye(P));
AY1 = kron(Is, Bs);
AY2 = sparse(n*P, nXi);
AY3 = - sparse(1:(n*P), 1:(n*P), 1);
AY = cat(2, AY1, AY2, AY3);

AZ = sparse(size(A,1), n*P);
A = cat(2, A, AZ);
A = cat(1, A, AY);

blc = cat(1, blc, zeros(n*P,1));
buc = cat(1, buc, zeros(n*P,1));


end

