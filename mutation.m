%% Network Mutation Operators
function newIndivs = mutation(parents, p1, p2)
    % Perform mutation operation on the network and return the mutated result
    parentSize = size(parents, 2);
    newIndivs = cell(1, parentSize);
    mutProb = [p1, p2 + p1, 1];
    for index = 1 : parentSize
        % Generate a random number to decide to use which mutation operator
        prob = rand();
        choice = find(prob <= mutProb);
        switch choice(1)
            case 1
                % Add a link at a randomly chosen position
                newIndivs{1, index} = add_link(parents{1, index});
            case 2
                % Remove a randomly chosen link
                newIndivs{1, index} = remove_link(parents{1, index});
            case 3
                % Random rewiring
                newIndivs{1, index} = rewiring(parents{1, index});
        end
    end
end


% Mutation Operator 1: Add a link at a randomly chosen position
function [G, rand1, rand2] = add_link(G)
    graphSize = size(G, 2);
    % Check if the graph is fully connected
    if check_fully_connected(G) == true
        return;
    else
        while true
            rand1 = randi(graphSize);
            rand2 = randi(graphSize);
            % Check if the link is absent before
            if rand1 ~= rand2 && G(rand1, rand2) == 0
                break;
            end
        end
        G(rand1, rand2) = 1;
        G(rand2, rand1) = 1;
    end
end


% Mutation Operator 2: Remove a randomly chosen link
function [G, rand1, rand2] = remove_link(G)
    GCopy = G;
    verticeNum = size(G, 1);
    linkNum = cal_link_num(G);
    records = cell(1, linkNum);
    recIndex = 0;
    while recIndex < linkNum
        rand1 = randi(verticeNum);
        rand2 = randi(verticeNum);
        if (rand1 ~= rand2) && G(rand1, rand2) == 1 
            GCopy(rand1, rand2) = 0;
            GCopy(rand2, rand1) = 0;
            % Ensure the graph is still connected after removing the link
            if check_connected(GCopy) == true
                G(rand1, rand2) = 0;
                G(rand2, rand1) = 0;
                return;
            else
                GCopy = G;
                [records, recIndex] = record_link(records, recIndex, rand1, rand2);
            end 
        end
    end
end


% Mutation Operator 3: Random rewiring
function G = rewiring(G)
    % Combination of adding link and removing link
    % Remove a link between two random points and then randomly add another
    % link based on these two points
    [G, rand1, rand2] = remove_link(G);
    verticeNum = size(G, 1);
    for index = 1 : verticeNum
        if (index ~= rand1) && (index ~= rand2)
            if G(rand1, index) == 0
                G(rand1, index) = 1;
                G(index, rand1) = 1;
                return;
            elseif G(rand2, index) == 0
                    G(rand2, index) = 1;
                    G(index, rand2) = 1;
                    return;
            end
        end
    end
end


% Check if the graph is fully connected or not
function fullyConnected = check_fully_connected(G)
    % return: 1/true(fully connected), 0/false(not fully connected)
    fullyConnected = true;
    for rowIndex = 1 : size(G, 1)
        for colIndex = rowIndex + 1 : size(G, 2)
            if G(rowIndex, colIndex) == 0
                % Value 0 means no link between these two vertices, so it 
                % is not fully connected
                fullyConnected = false;
                return;
            end
        end
    end
end


% Used in mutation operator 2, record which link has been checked that it
% can't be removed due to connectivity 
function [records, recIndex] = record_link(records, recIndex, rand1, rand2)
    isExisted = false;
    for index = 1 : recIndex
        if all([rand1, rand2] == records{1, index}) == true
            isExisted = true;
            break;
        end
    end

    if isExisted == false
        recIndex = recIndex + 1;
        records{1, recIndex} = [rand1, rand2];
    end
end
