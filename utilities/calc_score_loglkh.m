function [ scores ] = calc_score_loglkh( pars )

n = size(pars,1);     % Number of partitions
scores = zeros(n,1);

for i = 1 : n
    temp_recs = pars(i).recs;
    temp_samples = pars(i).samples;
    nb_recs = size(temp_recs,1);
    nb_samples = zeros(nb_recs,1);
    vol = zeros(nb_recs,1);
    for j = 1 : nb_recs
        nb_samples(j) = size(temp_samples{j},1);
        vol(j) = calc_vol(temp_recs(j,:));
    end
    t_nb_samples = sum(nb_samples,1);
    beta = nb_samples ./ vol ./ t_nb_samples;
    scores(i) = sum(nb_samples.*log(beta),1);
end

end

