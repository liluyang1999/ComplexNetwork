function fitValues = fitness(population)
    % Calculate the fitness value of each individual in the input population
    % Fitness value: diameter - average path length
    popSize = size(population, 2);
    fitValues = zeros(1, popSize);
    for index = 1 : size(population, 2)
        diameter = cal_diameter(population{index});
        avgPathLen = cal_avg_path_len(population{index});
        fitValue = diameter - avgPathLen;
        fitValues(1, index) = fitValue;
    end
end

