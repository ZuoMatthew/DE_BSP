%% Density Estimation via Bayesian Sequential Partitioning (DE_BSP)

% Author: LIU WANG-SHENG. Nanyang Technological University
% Email: awang.signup#gmail.com
%
% This program is developed for multivariate density estimation with
% moderately large dimension
%
% - Reference: 
%  Lu L, Jiang H, Wong W H. Multivariate density estimation by bayesian sequential partitioning[J]. 
%  Journal of the American Statistical Association, 2013, 108(504): 1402-1410.
% - Log: 
%  - 2016.06.30


clc;
clear;
recs = [-1 1 -1 1];
samples = {randn(1000,2)};

% Mean subtraction and normalization
[recs,samples] = orig_to_01(recs, samples);

m = 500;
beta = 0.5;
t_max = 200;
parent_pars.recs = recs;
parent_pars.samples = samples;
parent_pars.weights = 1 / m;
parent_pars.log_q = calc_log_q(recs,samples);
parent_pars.h = [];
parent_pars.scores = calc_score_logpi(recs,samples,parent_pars.log_q);
parent_pars = repmat(parent_pars,m,1);

best = find_best(parent_pars);
all_best(1) = best;
i = 1;
while i < t_max     % Levels i
    i = i + 1;
    % Generate child_partitions
    child_pars = gen_child_BSP(parent_pars);  
    % Calculate weights
    child_pars = calc_weights(child_pars,parent_pars);
    % Resample
    ESS_before = calc_ESS(child_pars);
    if ESS_before < beta * m
        child_pars = resample_pars(child_pars);
        fprintf('Resampling in level %i... ESS: %0.3f -> %0.3f\n',i , ESS_before, calc_ESS(child_pars));
    end
    % Calculate the partition score
    for k = 1 : m
        child_pars(k).scores = calc_score_logpi(child_pars(k).recs,child_pars(k).samples,child_pars(k).log_q);
    end
    % Find the best partition
    best = find_best(child_pars);
    all_best(i) = best;
    % Evaluate stopping criteria
    i_best_level = evaluate_bests(all_best);
    if i - i_best_level > 10;break;end;
    
    % Update parent_pars by child_pars
    parent_pars = child_pars;
end

% Calculate the frequency in each rectangle
myrecs = all_best(i_best_level).recs;
mysamples = all_best(i_best_level).samples;
[myrecs,mysamples] = norm_to_orig(partition.recs,myrecs,mysamples);
myden = calc_den_pc(myrecs,mysamples);     % Piecewise constant density

density_results.recs = myrecs;
density_results.samples = mysamples;
density_results.den = myden;
