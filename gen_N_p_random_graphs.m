function randomGraphs = gen_N_p_random_graphs(popSize, N, p)
    % Generate the population of (N, p) random graphs for the calculation on f1,
    % f2, f3 and fw
    randomGraphs = cell(1, popSize);
    for index = 1 : popSize
        randomGraphs{index} = gen_random_graph(N, p);
    end
end


% Generate a graph of N vertices where each pair of vertices is connected by
% probability p
function randomGraph = gen_random_graph(N, p)
    randomGraph = zeros(N, N);
    for rowIndex = 1 : N
        for colIndex = rowIndex : N
            if rowIndex == colIndex
                randomGraph(rowIndex, colIndex) = 0;
            else
                randProb = rand();
                if randProb < p
                    randomGraph(rowIndex, colIndex) = 1;
                    randomGraph(colIndex, rowIndex) = 1;
                else
                    randomGraph(rowIndex, colIndex) = 0;
                    randomGraph(colIndex, rowIndex) = 0;
                end
            end
        end
    end
end

