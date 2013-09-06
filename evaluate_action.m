function [ res ] = evaluate_action( toeval, resultA, trackid )
%EVALUATE_ACTION Summary of this function goes here
%   Detailed explanation goes here

% per = {bags.person};
% act = {bags.action};

% indic42 = ~cellfun(@isempty, act);
% posit   = cellfun(@(x) x>0, per);

% O = tracks_in_bag(bags(posit & indic42), tframes);
% idx = sum(O, 1)>0;

idx = toeval;


res = evaluate(resultA.Z(idx, :), resultA.Y(idx, :));

% computing the per class order
A = size(resultA.Y, 2);
order = cell(A, 1);
for i = 1:A
    [~, temp] = sort(resultA.Z(:, i), 'descend');
    order{i} = trackid(temp);
end

Zidx = resultA.Z(idx, :);
Yidx = resultA.Y(idx, :);
[~, zidx] = max(Zidx, [], 2);
[~, yidx] = max(Yidx, [], 2);
for i = 1:A
    idx = find(yidx==i);
    class_acc(i) = sum(zidx(idx)==yidx(idx))/length(idx);
end

res.mean_class_acc = mean(class_acc);
res.class_acc = class_acc;
res.class_order = order;


end