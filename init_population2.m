%% Randomly generate network graphs according to the size of population
function population = init_population2(N, popSize)
    % The vertices number of graph is N
    population = cell(1, popSize);
    for index = 1 : popSize
        population{index} = gen_graph(N);
    end
end


% Generate a random connected graph
function graph = gen_graph(N)
    while true
        graph = zeros(N, N);
        for i = 1 : N
            for j = i : N
                if i == j 
                    graph(i, j) = 0;
                else
                    randNum = randi(2) - 1;
                    graph(i, j) = randNum;
                    graph(j, i) = randNum;
                end
            end
        end
        if check_connected(graph) == true
            return;
        end
    end
end

