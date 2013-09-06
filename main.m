
% path to the mosek toolbox folder
mosek_path = '/nas/home2/b/bojanows/Documents/MATLAB/mosek/6/toolbox/r2009b';

% path to the mosek licence folder
mosek_license = '/sequoia/data1/bojanows/local/mosek/6/licenses';

% path to the cvx_setup.m file
cvx_path = '~/Documents/MATLAB/cvx/cvx_setup.m'; 

addpath(mosek_path);
setenv('MOSEKLM_LICENSE_FILE', mosek_license);
run(cvx_path);

datapath = './data.mat';

[resultF, resultA] = joint_optimisation(datapath);
