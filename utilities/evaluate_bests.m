function [ id ] = evaluate_bests( all_best )

nb_level = size(all_best,2);
score = zeros(nb_level,1);
for i = 1 : nb_level
    score(i) = all_best(i).score;
end
[~,id] = max(score);
end
