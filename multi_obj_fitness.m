function [multiFitValues] = multi_obj_fitness(population)
    % The aim is to minimize each of the three costs
    % Three types of fitness value correspond to three costs
    % multiFitValues include all the three types of finess

    multiFitValues = cell(1, 3);
    popSize = size(population, 2);
    
    % Fitness 1: inverse of average path length (transportation costs)
    for index = 1 : popSize
        avgPathLen = cal_avg_path_len(population{index});
        multiFitValues{1}(index) =  1 / avgPathLen;
    end

    % Fitness 2: inverse of diameter (network maintenance costs)
    for index = 1 : popSize
        diameter = cal_diameter(population{index});
        multiFitValues{2}(index) = 1 / diameter;
    end

    % Fitness 3: inverse of total link number (complaint + refund costs)
    for index = 1 : popSize
        linkNum = cal_link_num(population{index});
        multiFitValues{3}(index) = 1 / linkNum;
    end
end

