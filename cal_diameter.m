function diameter = cal_diameter(G)
    % Calculate the diameter (maximal path length) of graph
    % G: adjacency matrix of the graph
    % return: diameter

    graph_G = graph(G);
    shortestPaths = distances(graph_G);
    diameter = max(max(shortestPaths));

end
