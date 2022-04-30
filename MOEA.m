%% Question 5(b): Implement multi-objective evolutionary algorithm
function [bestSolutions, bestMultiFitValues] = MOEA(N, p1, p2)
    % Algorithm: NSGA-II
   
    % Population Size: 80
    % Maximum Generations: 80
    popSize = 80;
    maxGen = 80;
    
    % Generate the initial population of solutions
    population = init_population(N, popSize);
    
    % Start iteration
    for curGen = 1 : maxGen
        % Crowded Tournament Selection
        % Select parents from population according to pareto rank and
        % crowding distances of current population
        parents = crow_tour_selection(population, popSize);
        
        % Perform mutation on the parents to generate offsprings
        offsprings = mutation(parents, p1, p2);
        
        % Elite Preservation
        % Merge old population and offsprings into a combined population
        comPop = [population, offsprings];
        % Non-dominated sorting of combined population
        [allFronts, ~] = non_dominated_sorting(comPop);
        % Calculate the crowding distances of combined population
        crowDists = crowding_distance(comPop, allFronts);
        % Perform elite-preservation to produce the next generation
        population = elite_preservation(comPop, popSize, allFronts, crowDists);
    end

    % Return the 10 best solutions and their corresponding multi-fitness
    bestSolutions = population(1 : 10);
    bestMultiFitValues = multi_obj_fitness(bestSolutions);
end

