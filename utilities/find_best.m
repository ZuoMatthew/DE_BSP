function [ best ] = find_best( child_pars )

m = size(child_pars,1);
score_a = zeros(m,1);
for i = 1 : m
    score_a(i) = child_pars(i).scores;
end
[best.score,best.index] = max(score_a,[],1);
best.recs = child_pars(best.index).recs;
best.samples = child_pars(best.index).samples;

end

