%% Randomly generate network graphs according to size of population
function population = init_population(N, popSize)
    % The vertices number of graph is N
    population = cell(1, popSize);
    maxLinkNum = N * (N - 1) / 2;
    for index = 1 : popSize
        randNum = randi(maxLinkNum - N);
        linkNum = N + randNum;
        s = zeros(1, linkNum);
        t = zeros(1, linkNum);
        while true
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
