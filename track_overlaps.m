function [ O ] = track_overlaps( facedets )

tracks = cat(1, facedets.track);
utrack = unique(tracks);

f = zeros(length(utrack), 2);
for i = 1:length(utrack)
    idx = tracks==utrack(i);
    frames = cat(1, facedets(idx).frame);
    f(i, 1) = min(frames);
    f(i, 2) = max(frames);
end

O = overlap(f, f);

end