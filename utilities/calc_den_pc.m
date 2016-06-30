function [ den ] = calc_den_pc( recs,samples )

nb_recs = size(recs,1);

vol = zeros(nb_recs,1);
nb_samples = zeros(nb_recs,1);
for i = 1 : nb_recs
    vol(i) = calc_vol(recs(i,:));
    nb_samples(i) = length(samples{i});
end

t_nb = sum(nb_samples);
den = nb_samples ./ t_nb ./vol;
end

