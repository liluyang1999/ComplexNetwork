function fitValues = weighted_fitness(population, a1, a2, a3)
    % Calculate the linearly weighted fitness value of each individual
    % a1, a2, a3: choices of the weights
    % Fitness Value: inverse of fw
    % The larger the fitness value, the smaller the fw value
    popSize = size(population, 2);
    fitValues = zeros(1, popSize);
    for index = 1 : size(population, 2)
        avgPathLen = cal_avg_path_len(population{index});
        diameter = cal_diameter(population{index});
        linkNum = cal_link_num(population{index});
        fitValue = 1 / (a1 * avgPathLen + a2 * diameter + a3 * linkNum);
        fitValues(1, index) = fitValue;
    end
end
