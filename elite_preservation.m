%% Elite Preservation 
function newPopulation = elite_preservation(comPop, popSize, allFronts, crowDists)
    % comPop: combined population including parents and offsprings
    % allFronts: all the pareto fronts of combined population
    % crowwDists: the crowding distances of each individual of comPop
    frontSize = size(allFronts, 2);
    newPopulation = cell(1, popSize);
    count = 0;

    for rank = 1 : frontSize
        curFrontIndexes = allFronts(rank).front;
        temp = count + size(curFrontIndexes, 2);
        [~, sortIndexes] = sort(crowDists(curFrontIndexes), "descend"); 
        if temp <= popSize
            % If the remaining size of new population is large enough, 
            % incorporate all the individuals of the current front into it
            newPopulation(count+1 : temp) = comPop(curFrontIndexes(sortIndexes));
            count = count + size(curFrontIndexes, 2);
        elseif (popSize - count) > 0
            % If the remaining size of new population can't incorporate all 
            % the individuals of current front, it will be filled according
            % to the crowding distances and then return
            remSize = popSize - count;
            newPopulation(count+1:popSize) = comPop(curFrontIndexes(sortIndexes(1:remSize)));
            return;
        else 
            % If the new population has been filled up, directly return
            return;
        end
    end
end


