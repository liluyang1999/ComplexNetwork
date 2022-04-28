function avgPathLen = cal_avg_path_len(G)
    % Calculate the average path length of graph
    % G: adjacency matrix of the graph
    % return: average path length 

    if size(G, 1) == 1
        avgPathLen = 0;
    else
        graph_G = graph(G);
        N = size(G, 1);
        shortestPaths = distances(graph_G);
        avgPathLen = sum(sum(shortestPaths)) / (N * (N - 1)); 
    end
    
end
