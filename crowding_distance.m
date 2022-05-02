%% Calculate the crowding distances
function crowDists = crowding_distance(population, allFronts)
    % Calculate the crowding distances of all the fronts

    multiFitValues = multi_obj_fitness(population);
    fitNum = size(multiFitValues, 2);
    crowDists = zeros(1, size(population, 2));

    % Calculate each individual's crowding distance in each rank 
    for rankIndex = 1 : size(allFronts, 2)
        frontSize = size(allFronts(rankIndex).front, 2);
        curFrontIndexes = allFronts(rankIndex).front;
        size(allFronts(rankIndex).front, 2);
        
        % Calculate each type of fitness(3 in total) of the current front
        for fitIndex = 1 : fitNum
           curFrontFitValues = multiFitValues{fitIndex}(curFrontIndexes);
           [sortFitValues, sortFitIndexes] = sort(curFrontFitValues, "ascend");

           % Set the boundary points to infinity
           crowDists(curFrontIndexes(sortFitIndexes(1))) = inf;
           crowDists(curFrontIndexes(sortFitIndexes(frontSize))) = inf;

           minFitValue = sortFitValues(1);
           maxFitValue = sortFitValues(frontSize);
           
           % Compute other points' crowding distances
           for indivIndex = 2 : (frontSize - 1)
               crowDistIndex = curFrontIndexes(sortFitIndexes(indivIndex));
               preFitValue = sortFitValues(indivIndex - 1);
               nextFitValue = sortFitValues(indivIndex + 1);
               temp = (nextFitValue - preFitValue) / (maxFitValue - minFitValue);
               crowDists(crowDistIndex) = crowDists(crowDistIndex) + temp;
           end
        end    
    end
end

