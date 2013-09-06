function [ Kf, Kof, Ka, Koa, GTf, GTa, tframes, trackid ] = load_data(Kf, Ka, Koa, GTf, GTa, fdpath)

% loading the face kernels
% temp    = load(Kf);
% Kf      = temp.K;
% Kof     = temp.Kothers;

temp = load('/sequoia/data1/bojanows/ICCV2013/old_working_face_kernels.mat');
Kf = temp.K;
Kof = temp.Kothers;


temp    = load(Ka, 'eKa');
Ka      = temp.eKa;
temp    = load(Koa, 'eKoa', 'L');
Koa     = temp.eKoa;
labels  = temp.L;

% loading the annotations
temp        = load(fdpath);
facedets    = temp.facedets;
tframes     = track_frames(facedets);

% removing non-reliable tracks
idx = sum(Kf, 1) > 1 + eps;
Kf = Kf(idx, idx);
Ka = Ka(idx, idx);

drop = find(~idx);
Kof(:, drop) = [];
Koa(:, drop) = [];
tframes = tframes(idx, :);
trackid = find(idx);

N = size(Ka, 1);
No = size(Koa, 1);

sitdown = false(No,1);
run = false(No,1);
% removing SitDown samples from others
for i = 1:length(labels)
    if ~isempty(labels{i})
        sitdown(i) = ismember('<ActionSitDown>', labels{i});
        run(i) = ismember('<ActionRun>', labels{i});
    end
end

% picking random others
perm = randperm(No);
lotery = perm(1:round(0.5*No));
drop = find(ismember(1:No, lotery) | sitdown' | run');
Koa(drop, :) = [];
Koa(:, N+drop) = [];

GTf = GTf(idx);
GTa = GTa(idx);

end

