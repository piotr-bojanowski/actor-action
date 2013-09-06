function [resultF, resultA] = joint_optimisation(datapath)

% loading the data
load(datapath);

% getting the number of persons and number of actions
P = max(GTf);
A = max(GTa);

% getting the number of tracks
N = size(Kf,1);

% creating the non-informative prior on actions
T = 1/A * ones(N, A);

Z = cell(4, 1);

%%%%%%%%%%%%%%%%%%%%%%%
%%% face clustering %%%
%%%%%%%%%%%%%%%%%%%%%%%

% optimizing over the faces
isface  = cat(1, bags.isface); % HACK
params  = init_face_params();
resultF = weak_square_loss(params, bags(isface), tframes, Kf, Kof, GTf, T);
Z{1}    = resultF.Z;

% computing different Z matrices
temp = ones(size(Z{1}));
[~, z] = max(Z{1}, [], 2);
Z{2} = bsxfun(@times, temp, 1 ./ sum(temp, 2));
Z{3} = full(sparse(1:N, GTf, 1, N, P));
Z{4} = full(sparse(1:N, z, 1, N, P));

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% action clustering %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

params = init_action_params();

% computing with projected face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
restemp = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{1});
resultA{1} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

% computing with GT face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
restemp = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{3});
resultA{2} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

% computing with random face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
restemp = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{2});
resultA{3} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

% computing with only face+text
params.kapa = 10;
params.alpha = 100;
params.opt_flag = 'feasibility';
params.neg_bag = true;
restemp = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{4});
resultA{4} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

% computing with text + GT faces
params.kapa = 10;
params.alpha = 100;
params.opt_flag = 'feasibility';
params.neg_bag = true;
restemp = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{3});
resultA{5} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

end