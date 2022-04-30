%% Crowded Tournament Selection in Multi-Objective Evolutionary Algorithm
function parents = crow_tour_selection(population, parentSize)
    popSize = size(population, 2);
    parents = cell(1, parentSize);

    % Calculate the pareto ranks and crowding distances of population
    [allFronts, popRank] = non_dominated_sorting(population);
    crowDists = crowding_distance(population, allFronts);   

    % Randomly select two individuals and choose the elite as the parent
    % each time until reaching the required parents size
    for index = 1 : parentSize
        while true
            R1 = randi(popSize);
            R2 = randi(popSize);
            if R1 ~= R2
                break;
            end
        end
        R1Rank = popRank(R1);
        R2Rank = popRank(R2);
        % If rank of R1 is higher than R2, choose R1, otherwise choose R2
        if R1Rank < R2Rank
            parents{index} = population{R1};
        elseif R1Rank > R2Rank
            parents{index} = population{R2};
        else
            % If two ranks are equal, choose one with a larger crowding distance
            if crowDists(R1) >= crowDists(R2)
                parents{index} = population{R1};
            else
                parents{index} = population{R2};
            end
        end
    end    

end

