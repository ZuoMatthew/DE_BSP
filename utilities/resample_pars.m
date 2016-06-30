function [ new_child_pars ] = resample_pars( child_pars )

m = size(child_pars,1);
weight = zeros(m,1);
for i = 1 : m
    weight(i) = child_pars(i).weights;
end 

resampleMethod = 1;
switch resampleMethod  
    % Algorithm 1: Modified multinomial resampling
    case 1
        gamma = 0.5;
        a = weight .^ gamma;
        a_n = a ./ sum(a(:));
        a_c = cumsum(a_n);
        
        for i = 1 : m
            sampl = rand(1,1);
            j=1;
            while (a_c(j)<sampl),
                j=j+1;
            end;
            index(i)=j;
            i=i+1;
        end
        new_weight = weight .^ (1 - gamma);
        new_weight = new_weight / sum(new_weight(:));
    % Algorithm 2: Multinomial resampling
    case 2
        c = cumsum(weight);
        for i = 1 : m
            sampl = rand(1,1);
            j=1;
            while (c(j)<sampl),
                j=j+1;
            end;
            index(i)=j;
            i=i+1;
        end
        new_weight = ones(m,1) ./ m;
    % Algorithm 3: Residual resampling
    case 3
        Ns = floor(m .* weight);  % repetition count
        R = sum(Ns);              % remainder or residual count
        n_rdn = m - R;
        weight_m = (m .* weight - floor(m .* weight)) / n_rdn;     % the modified weight
        i = 1;     % deterministic part
        for j = 1 : m
            for k = 1 : Ns(j)
                index(i) = j;
                i = i + 1;
            end
        end
        
        c = cumsum(weight_m);     % stochastic part
        while i <= m
            sampl = rand(1,1);  % (0,1]
            j = 1;
            while (c(j) < sampl),
                j = j + 1;
            end;
            index(i) = j;
            i = i + 1;
        end
        
        new_weight = ones(m,1) ./ m;
    % Algorithm 4: Stratified resampling
    case 4
        c = cumsum(weight);
        for i = 1 : m
            T(i) = rand(1,1)/m + (i-1)/m;
        end
        T(m+1) = 1;
        
        i = 1; j = 1;        
        while i <= m
            if T(i) < c(j)
                index(i) = j;
                i = i + 1;
            else
                j = j + 1;
            end
        end
        
        new_weight = ones(m,1) ./ m;
    % Algorithm 5: Systematic resampling
    case 5
        c = cumsum(weight);
        T = linspace(0,1-1/m,m) + rand(1)/m;
        T(m+1) = 1;
        
        i = 1;j = 1;
        while i <= m
            if T(i) < c(j)
                index(i) = j;
                i = i + 1;
            else
                j = j + 1;
            end
        end
        
        new_weight = ones(m,1) ./ m;
end

%% Output
new_child_pars = child_pars;
for i = 1 : m
    new_child_pars(i) = child_pars(index(i));
    new_child_pars(i).weights = new_weight(i);
end
        
end

