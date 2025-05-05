cost= [2 7 4;3 3 1;5 5 4;1 6 2];
A =[5 8 7 14];
B =[ 7 9 18];


if sum(A) == sum(B)
    fprintf('Balanced')
else
    fprintf('Unbalanced')
    if sum(A)<sum(B)
        cost(end+1,:) = zeros(1,size(B,2))
        A(end+1) = sum(B)-sum(A)
    elseif sum(A)>sum(B)
        cost(:,end+1) =zeros(1,size(A,2))
        B(end+1)=sum(A)-sum(B)
    end
end


ICost = cost;
X = zeros(size(cost))
[m n] = size(cost)      
BFS = m + n - 1


for i = 1 : size(cost, 1)
    for j = 1 : size(cost, 2)
        hh = min(cost(:))
        [row_index col_index] = find(hh == cost)

        x11 = min(A(row_index), B(col_index))
        [val index] = max(x11)
        ii = row_index(index)
        jj = col_index(index)

        y11 = min(A(ii), B(jj))
        X(ii, jj) = y11
        A(ii) = A(ii) - y11
        B(jj) = B(jj) - y11
        
        cost(ii, jj) = inf;
    end
end


initial_basic_sol = array2table(X)
total_BFS = length(nonzeros(X))


if total_BFS == BFS
    fprintf('Non - degenerate')
else
    fprintf('Degenerate')
end


final = sum(sum(ICost.*X))
