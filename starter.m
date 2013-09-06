if ~isdeployed()
    addpath('mosek');
    addpath('~/Documents/MATLAB/APT.1.3');
    addpath('/nas/home2/b/bojanows/Documents/MATLAB/mosek/6/toolbox/r2009b');
    run('~/Documents/MATLAB/cvx/cvx_setup.m');
end

global APT_PARAMS;
if isempty(APT_PARAMS)
    APT_params();
end 
APT_PARAMS.exec_name = 'square_loss';