function [ results, T ] = weak_square_loss(params, bags, tframes, Ka, Koa, GTa, Z)

setenv('MOSEKLM_LICENSE_FILE', params.mosek_license);

% making kernels PSD
if ~isempty(Koa)
    [Ka, Koa] = make_PSD_wo(Ka, Koa);
else
    Ka = make_PSD(Ka);
    Koa = zeros(0, size(Ka, 1));
end

% building the bags - kernel, constraints
[Ka, Y, A_ind, B_ind, others_idx] = build_bags(params, bags, Ka, Koa, GTa, Z, tframes);

% solving the minimization problem
T = weak_square_loss(params, Ka, Y, A_ind, B_ind);

% removing others and evaluating
if ~isempty(others_idx)
    idx = setdiff(1:size(Y,1), others_idx);
    results = evaluate(T(idx, :), Y(idx, :));
    T = T(idx,:);
else
    results = evaluate(T, Y);
end

end