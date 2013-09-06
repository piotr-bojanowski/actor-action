function [ K ] = make_PSD( K )

K = (K+K')/2;
[V,D] = eig(K);
K = V * abs(D) * V';
K = (K+K')/2;

end

