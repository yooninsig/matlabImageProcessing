function [output] = MyPrewittEdgeFilter(input)
output = input;

mask1 = [-1 0 1; -1 0 1; -1 0 1];
mask2 = [-1 -1 -1; 0 0 0; 1 1 1];

for i = 2 : size(input, 1) - 1
    for j = 2: size(input, 2) - 1
        neighbor_matrix1 = mask1.*input(i - 1: i + 1, j - 1: j + 1);
        avg_value1 = sum(neighbor_matrix1(:));
        
        neighbor_matrix2 = mask2.*input(i - 1: i + 1, j - 1: j + 1);
        avg_value2 = sum(neighbor_matrix2(:));
        
        output(i, j) = max([avg_value1, avg_value2]);
    end
end

end
