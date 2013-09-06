movie = 'casablanca';

rootdir     = '/sequoia/data1/bojanows/ICCV2013/';
moviedir    = fullfile(rootdir, 'AutoNaChar', movie);

trackdir    = fullfile(moviedir, 'tracks');
fdpath      = fullfile(trackdir, 'facedets_lite.mat');

Kf          = fullfile(moviedir, 'face_kernels.mat');
GTfpath     = fullfile(moviedir, 'track_GT.mat');
temp        = load(GTfpath);
GTf         = temp.track_GT;
cast        = temp.cast;

videodir    = fullfile(rootdir, 'video-features', movie);
Ka          = fullfile(videodir, sprintf('K_%s.mat', movie));
Koa         = fullfile(videodir, sprintf('Ko_%s.mat', movie));
GTapath     = fullfile(videodir, 'GTa_corr.mat');

temp        = load(GTapath);
GTa         = temp.track_GT;
actions     = temp.cast;
converter   = [1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,3];
toeval      = GTa~=0;
GTa         = converter(GTa+1)';

castpath    = fullfile(moviedir, 'scene_cast.mat');
temp        = load(castpath);
init_scene  = temp.scene_cast;

jbagpath    = fullfile(rootdir, 'clips42.mat');
temp        = load(jbagpath);
joint_bags  = temp.clips42;


bags = merge_bags(init_scene, joint_bags, cast);


[resultF, resultA, restemp, trackid] = joint_optimisation(Kf, GTf, Ka, Koa, GTa, fdpath, bags, toeval);

