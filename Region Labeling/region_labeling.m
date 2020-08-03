%% Region_labeling - 함수 제작하기
function[output] = region_labeling(input)
    %preliminary labeling
    [rows, cols] = size(input);
    labels = zeros(size(input));
    nextlabel = 2;
    linked = [];
    
 for i = 2 : rows
    for j = 2 : cols - 1
        if input(i, j) ~= 0
            neighborsearch = [input(i - 1, j - 1), input(i - 1, j), input(i - 1, j + 1), input(i, j - 1)];
            [~, n, neighbors] = find(neighborsearch == 1);
            if isempty(neighbors)
                linked{nextlabel-1} = nextlabel;
                labels(i, j) = nextlabel;
                nextlabel = nextlabel + 1;
            else
                neighborsearch_label = [labels(i - 1, j - 1), labels(i - 1, j), labels(i - 1, j + 1), labels(i, j - 1)];
                L = neighborsearch_label(n);
                labels(i, j) = min(L);
                for k = 1 : length(L)
                    label = L(k);
                    linked{label-1} = unique([linked{label - 1} L]);
                end
            end
        end
    end
 end

% resolve label collisions
% generate label equipvalence relationships
for i = 1 : length(linked)
    for j = 1 : length(linked)
       if intersect(linked{i}, linked{j}) ~= 0
          linked{i} = union(linked{i}, linked{j});
          linked{j} = linked{i};
       end
    end
end

% remove redundance labels in linked cell
linked = unique(cellfun(@num2str, linked, 'UniformOutput', false));
linked = cellfun(@str2num, linked, 'UniformOutput', false);

% relabel image
for i = 1 : length(linked)
    for j = 1 : length(linked{i})
        for x = 1: rows
            for y  = 1 : cols
                if ismember(labels(x, y), linked{i}(j))
                    labels(x, y) = min(linked{i});
                end
            end
        end
    end
end
output = labels;
 
end