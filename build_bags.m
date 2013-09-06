function [ Ka, Y, A_ind, B_ind, others_idx] = build_bags(params, bags, K, Ko, GT, T, tframes )
% the variable with the opposite latent variable is called here T but its
% true value depend on the direction of optimization

N = size(K, 1);

if ~isempty(Ko)
    Kpn = Ko(:, 1:N);
    Knn = Ko(:, N+1:end);
else
    Kpn = Ko(:, 1:N);
    Knn = zeros(0,0);
end

A = tracks_in_bag(bags, tframes);

% removing bags where there are too many tracks
if params.cut_crowds
    idx     = sum(A, 2) < params.cut_threshold;
    A       = A(idx, :);
    bags    = bags(idx);
end

% number of bags
I = size(A,1);

% switching from frame position to track index
bag2 = struct();
for i = 1:I
    if (~params.neg_bag && (isempty(bags(i).person) || bags(i).person > 0)) || params.neg_bag
        bag2(i).tracks = find(A(i, :));
        bag2(i).person = bags(i).person;
        bag2(i).action = bags(i).action;
    end
end

% TAKING CARE OF OTHERS
% getting the number of others tracks
nothers = size(Kpn, 1);

% building the constraints for others
for i = 1:nothers
    bag2(I+i).tracks = size(K, 1) + i;
    
    if strcmp(params.coordinate, 'faces')
        bag2(I+i).person = 1;
        bag2(I+i).action = [];
    else
        bag2(I+i).person = [];
        bag2(I+i).action = 1;
    end
end

% keep index of "others" samples
others_idx = (1:nothers) + size(K, 1);

% adding the label one to all the "OTHERS" tracks
GT = cat(1, GT, ones(nothers, 1));
% adding others to the kernel
Ka = [K, Kpn'; Kpn, Knn];
% adding others to the other latent variable
T = cat(1, T, 1/size(T, 2)*ones(nothers, size(T, 2)));

% remove bags with no tracks
cardNi  = arrayfun(@(x) length(x.tracks), bag2);
idx     = cardNi > 0;
bag2    = bag2(idx);


Y = full(sparse(1:length(GT), GT, 1));

% building the constraint indicator vectors
[ A_ind, B_ind ] = build_bag_indicators(params, bag2, Y, T );

end