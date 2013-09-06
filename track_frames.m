function [ f ] = track_frames( facedets )
%TRACK_FRAMES Summary of this function goes here
%   Detailed explanation goes here

tracks = cat(1, facedets.track);
utrack = unique(tracks);

f = zeros(length(utrack), 2);

for i = 1:length(utrack)
    idx = tracks == utrack(i);
    f(i,1) = min([facedets(idx).frame]);
    f(i,2) = max([facedets(idx).frame]);
end

end

