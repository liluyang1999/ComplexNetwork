%% Randomly generate network graphs according to the size of population
function population = init_population(N, popSize)
    % The vertices number of graph is N
    population = cell(1, popSize);
    maxLinkNum = N * (N - 1) / 2;
    for index = 1 : popSize
        % Randomly decide the initial link number (maximum: N*(N-1)/2)
        % N links to ensure connectivity + Random number of remaining links 
        randNum = randi(maxLinkNum - N);
        linkNum = N + randNum;
        s = zeros(1, linkNum);
        t = zeros(1, linkNum);
        while true
            % For each vertice, randomly generate a link to another vertice 
            % to ensure the connectivity of graph
            s(1, 1:N) = randperm(N);
            for tIndex = 1 : N
                while true
                    randVer = randi(N);
                    if randVer ~= s(1, tIndex)
                        t(1, tIndex) = randVer;
                        break;
                    end
                end
            end
            
            % Randomly generate the remaining links, then make it a simple
            % graph and check its connectivity
            s(1, N+1:linkNum) = randi(N, 1, randNum);
            t(1, N+1:linkNum) = randi(N, 1, randNum);
            graph_G = graph(s, t);
            graph_G = simplify(graph_G);
            G = full(adjacency(graph_G));
            if check_connected(G) == true
                population{1, index} = G;
                break;
            end
        end
    end
end
