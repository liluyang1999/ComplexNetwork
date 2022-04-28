%% Question 4: Implement evolutionary algorithm on maximizing f2(G)-f1(G)
function [bestGraph, bestFitValue] = EA(N, p1, p2)
    % N: number of vertices
    % Population Size: 80, Maximum Generations: 80
    % Return: the best solution and its maximal f2(G)-f1(G)
    popSize = 80;
    MaxGen = 80;

    % Generate initial population of solutions
    population = init_population(N, popSize);
    popFitValues = fitness(population);
    temp = cell(1, popSize * 2);

    for curGen = 1 : MaxGen
        % Select parants using Binary Tournament Selection
        parents = selection(population, popSize);
        
        % Variation: apply mutation to the selected parents
        newIndivs = mutation(parents, p1, p2);
        
        % Evaluate the fitness of new individuals
        newFitValues = fitness(newIndivs);
        [sortValues, sortIndexes] = sort([popFitValues, newFitValues], 'descend');
        popFitValues = sortValues(1, 1:popSize);
        sortIndexes = sortIndexes(1, 1:popSize);

        % Reproduction (replace the worse individuals)
        temp(1, 1:popSize) = population(1, :);
        temp(1, popSize+1:popSize*2) = newIndivs(1, :);
        [population{1, :}] = deal(temp{1, sortIndexes});
    end

    % Return the best graph and its fitness value (maximal f2(G)-f1(G))
    bestGraph = population{1};
    bestFitValue = fitness({bestGraph});
end

