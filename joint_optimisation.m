function [resultF, resultA, restemp, trackid] = joint_optimisation(Kf, GTf, Ka, Koa, GTa, fdpath, bags, toeval)
% function that iterates bewtween face and action optimization. As there
% was no change after the first iteration (see article), this code does 
% not contain a loop.

% getting the number of persons and number of actions
P = max(GTf);
A = max(GTa);

[ Kf, Kof, Ka, Koa, GTf, GTa, tframes, trackid ] = load_data(Kf, Ka, Koa, GTf, GTa, fdpath);

toeval = toeval(trackid);

% getting the number of tracks
N = size(Kf,1);

% creating the non-informative prior on actions
T = 1/A * ones(N, A);


Z = cell(3, 1);


% optimizing over the faces
isface          = cat(1, bags.isface); % HACK
params          = init_face_params();
[resultF, Z{1}] = weak_square_loss(params, bags(isface), tframes, Kf, Kof, GTf, T);


params = init_action_params();

% computing different Z matrices
temp = ones(size(Z));
Z{2} = bsxfun(@times, temp, 1 ./ sum(temp, 2));
Z{3} = full(sparse(1:N, GTf, 1, N, P));


% computing with projected face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
[restemp, ~] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z{1});
resultA{1} = evaluate(restemp.Z(toeval, :), restemp.Y(toeval, :));

% computing with GT face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
[restemp, ~] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Zgt);
resultA{3} = evaluate_action(toeval, restemp);

% computing with random face matrix
params.neg_bag = false;
params.opt_flag = 'MOSEK_NORM';
[restemp, ~] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Zrand);
resultA{4} = evaluate_action(toeval, restemp);

% computing with only face+text
params.kapa = 10;
params.alpha = 100;
params.opt_flag = 'feasibility';
params.neg_bag = true;
[restemp, ~] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Zproj);
resultA{5} = evaluate_action(toeval, restemp);

% computing with text + GT faces
params.kapa = 10;
params.alpha = 100;
params.opt_flag = 'feasibility';
params.neg_bag = true;
[restemp, ~] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Zgt);
resultA{6} = evaluate_action(toeval, restemp);

end
