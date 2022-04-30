function population = init_population3(N, popSize)
    % The vertices number of graph is N
    population = cell(1, popSize);
    for index = 1 : popSize
        population{index} = gen_graph(N);
    end
end


% Generate a random connected graph
function newGraph = gen_graph(N)
    maxLinkNum = N * (N - 1) / 2;
    while true
        s = randi(N, 1, maxLinkNum);
        t = randi(N, 1, maxLinkNum);
        G = simplify(graph(s, t));
        newGraph = full(adjacency(G));
        if check_connected(newGraph) == true
            return;
        end
    end
end
