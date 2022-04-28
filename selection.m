%% Binary Tournament Selection
function parents = selection(population, parentSize)
    popSize = size(population, 2);
    fitValues = fitness(population);
    parents = cell(1, parentSize);

    % Randomly select two individuals and choose one with higher fitness as
    % the parent each time until reaching the required parents size
    for i = 1 : parentSize
        while true
            R1 = randi(popSize);
            R2 = randi(popSize);
            if R1 ~= R2
                break;
            end
        end
        % If fitness of R1 is higher than R2, choose R1, otherwise choose R2
        if fitValues(1, R1) >= fitValues(1, R2)
            parents{1, i} = population{1, R1};
        else
            parents{1, i} = population{1, R2};
        end
    end
    
end

