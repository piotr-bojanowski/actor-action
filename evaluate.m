function [results] = evaluate(Z, Y)



P = size(Y,2);

[~, ygt]    = max(Y, [], 2);

[s, z] = max(Z, [], 2);

[s, idx]    = sort(s, 'descend');
z           = z(idx, :);
ygt         = ygt(idx, :);

acc = sum(z==ygt)/length(z);

p = zeros(length(s), 1);
r = zeros(length(s), 1);

eval = ones(length(ygt), 1);
% eval = ygt~=max(ygt);

for j = 1:length(s)
    p(j) = sum(z(1:j) == ygt(1:j) & eval(1:j)) / j;
    r(j) = sum(eval(1:j)) / sum(eval);
end

class_p = cell(P, 1);
class_r = cell(P, 1);
class_ap = zeros(P, 1);

for i = 1:P
    [class_r{i}, class_p{i}, class_ap(i)] = binary_pr(Z(:,i), Y(:,i));
end

ap = 0;
for i = 2:length(r)
    ap = ap + (p(i)+p(i-1)) * (r(i)-r(i-1)) / 2;
end


results = struct();
results.ap = ap;
results.p = p;
results.r = r;
results.class_r = class_r;
results.class_p = class_p;
results.class_ap = class_ap;
results.Z = Z;
results.Y = Y;
results.acc = acc;


end

