function [ bags ] = merge_bags( face_bags, action_bags, cast )
%MERGE_BAGS Summary of this function goes here
%   Detailed explanation goes here

bags    = struct();
k       = 1;

for i = 1:length(face_bags)
    f = face_bags(i).f;
    for j = 1:length(face_bags(i).cast)
        bags(k).f = f;
        bags(k).person = face_bags(i).cast(j);
        bags(k).action = [];
        bags(k).isface = true;
        k = k+1;
    end
end

actions = {action_bags.action};
[~, ~, ib] = unique(actions);
% converter = [2,3,4];
converter = [2,3,3,3,3];
actid = converter(ib);

persons = {action_bags.person};
[~, persid] = ismember(lower(persons), lower(cast));

for i = 1:length(action_bags)
    if persid(i)~=0
        % getting the frames
        f = [action_bags(i).f1, action_bags(i).f2];
        
        % building positive constraint
        bags(k).f = f;
        bags(k).person = persid(i);
        bags(k).action = actid(i);
        bags(k).isface = false;
        k = k+1;
        
        % building negative constraint
        bags(k).f = f;
        bags(k).person = -persid(i);
        bags(k).action = actid(i);
        bags(k).isface = false;
        k = k+1;
        
    else
        % getting the frames
        f = [action_bags(i).f1, action_bags(i).f2];
        
        % no negative bag here, also person is empty
        bags(k).f = f;
        bags(k).person = [];
        bags(k).action = actid(i);
        bags(k).isface = false;
        k = k+1;
    end
end

end

