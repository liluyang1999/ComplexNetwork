%% Question 5(a): Use a linearly weighted fitness and minimize fw
function [bestGraph, bestFw] = EA_weighted_fitness(N, p1, p2, a1, a2, a3)
    % N: number of vertices
    % a1, a2, a3: weights of f1, f2 and f3
    % Population Size: 80, Maximum Generations: 80
    % Return: the best solution and its minimal fw
    popSize = 80;
    MaxGen = 80;

    % Generate initial population of solutions
    population = init_population(N, popSize);
    popFitValues = weighted_fitness(population, a1, a2, a3);
    temp = cell(1, popSize * 2);

    for curGen = 1 : MaxGen
        % Select parants using Binary Tournament Selection
        parents = selection(population, popSize);
        
        % Variation: apply mutation to the selected parents
        offsprings = mutation(parents, p1, p2);
        
        % Evaluate the linearly weighted fitness of new individuals
        newFitValues = weighted_fitness(offsprings, a1, a2, a3);
        [sortValues, sortIndexes] = sort([popFitValues, newFitValues], 'descend');
        popFitValues = sortValues(1, 1:popSize);
        sortIndexes = sortIndexes(1, 1:popSize);

        % Reproduction (replace the worse individuals)
        temp(1, 1:popSize) = population(1, :);
        temp(1, popSize+1:popSize*2) = offsprings(1, :);
        [population{1, :}] = deal(temp{1, sortIndexes});
    end

    % Return the best solution and its corresponding minimal fw value  
    bestGraph = population{1};
    bestFw = 1 / weighted_fitness({bestGraph}, a1, a2, a3);
end

