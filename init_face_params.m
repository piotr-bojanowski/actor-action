function params = init_face_params()

alpha   = 3;                                    % parameter for the geq in constraint
kapa    = 50;                                   % penalization for the slack
lambda  = 0.0001;                               % regularization constant

params = struct('coordinate', 'faces', ...
                'alpha', alpha, ...
                'kapa', kapa, ...
                'lambda', lambda, ...
                'neg_bag', false, ...
                'cut_crowds', true, ...         % flag to decide whether or not to remove crowded scenes
                'cut_threshold', 30, ...        % max size of crowds in bags
                'opt_flag', 'MOSEK_NORM', ...   % kind of optimization performed
                'mosek_license', '/sequoia/data1/bojanows/local/mosek/6/licenses');


end