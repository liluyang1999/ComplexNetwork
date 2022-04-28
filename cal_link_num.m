function linkNum = cal_link_num(G)
    % Calculate the total number of links of the graph
    % G: adjacency matrix of the graph
    % return: total number of links
    
    linkPosVec = find(G == 1);
    linkNum = size(linkPosVec, 1) / 2;

end
