function connected = check_connected(G)
    % Check whether the graph is connected
    % G: adjacency matrix of graph
    % return: 1/true(G is connected), 0/false(G is not connected)
   
    graph_G = graph(G);
    
    shortestPaths = distances(graph_G);

    if all(shortestPaths ~= inf) == true 
        connected = true;
    else
        connected = false;
    end

end

