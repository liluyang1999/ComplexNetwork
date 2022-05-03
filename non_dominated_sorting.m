%% Non-Dominated Sorting
function [allFronts, popRank] = non_dominated_sorting(population)
    % Return: all the individuals' (n, S) and their corresponding rank
    
    popSize = size(population, 2);    
    multiFitValues = multi_obj_fitness(population);
    fitNum = size(multiFitValues, 2);
    
    P = []; % Each individual's (n, S)
    popRank = zeros(1, popSize); % Each individual's corresponding rank of front
    rank = 1; % Pareto Rank Count
    allFronts = []; % All the non-dominated fronts and their individuals
    allFronts(rank).front = [];

    for i = 1 : popSize
        % Calculate each individual's number of being dominated (N) and set
        % of domination (S)
        % P: record each individual's (n, S) and rank(R)
        P(i).n = 0;
        P(i).S = [];

        for j = 1 : popSize
            lessFitNum = 0;
            equalFitNum = 0;
            betterFitNum = 0;
            for fitIndex = 1 : fitNum
                iValue = multiFitValues{fitIndex}(i);
                jValue = multiFitValues{fitIndex}(j);
                if iValue > jValue
                    betterFitNum = betterFitNum + 1;
                elseif iValue == jValue
                    equalFitNum = equalFitNum + 1;
                else 
                    lessFitNum = lessFitNum + 1;
                end
            end
            % Check the domination
            if betterFitNum == 0 && lessFitNum > 0
                % If i is dominated by j, n = n + 1
                P(i).n = P(i).n + 1;
            elseif lessFitNum == 0 && betterFitNum > 0
                % If i dominates j, add j into S
                P(i).S = [P(i).S, j];
            end
        end
                      
        if P(i).n == 0
            % If i is non-dominated, record i in the current non-dominated front
            allFronts(rank).front = [allFronts(rank).front, i];
            popRank(i) = rank;
        end
    end

    while rank <= size(allFronts, 2)
        temp = [];
        % Iterate over all the individuals of the current non-dominated front
        for i = 1 : size(allFronts(rank).front, 2)
            pIndex = allFronts(rank).front(i);
            if ~isempty(P(pIndex).S)
               for j = 1 : size(P(pIndex).S, 2)
                    P(P(pIndex).S(j)).n = P(P(pIndex).S(j)).n - 1;
                    if (P(P(pIndex).S(j)).n == 0)
                        temp = [temp, P(pIndex).S(j)];
                        popRank(P(pIndex).S(j)) = rank + 1;
                    end
               end
            end
        end

        rank = rank + 1;
        if ~isempty(temp)
            allFronts(rank).front = temp;
        end
   end
end

