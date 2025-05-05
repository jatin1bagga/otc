%% Simplex Method
% max z = 2x1 + 5x2
% x1 + 4x2 <= 24
% 3x1 + x2 <= 21
% x1 + x2 <= 9 

%% Introducing slack variables
% x1 + 4x2 + s1 = 24
% 3x1 + x2 + s2 = 21
% x1 + x2 + s3 = 9

%% Initialize

variables = 2;
C = [2 5];
a = [1 4;3 1;1 1];
b = [24;21;9];
    
identity = eye(size(a,1));
A = [a identity b];
cost = zeros(1,size(A,2));
cost(1:variables) = C;

%% Step-1

bv = variables+1:size(A,2)-1;
ZjCj = cost(bv)*A-cost;
zcj = [ZjCj;A];
% disp(zcj)
simplextable = array2table(zcj);
% disp(simplextable)
simplextable.Properties.VariableNames(1:size(zcj,2)) = {'x1', 'x2', 's1', 's2', 's3', 'Solution'};

%% Step-2

flag = true;
while flag
    if any(ZjCj<0)
        zc = ZjCj(1:end-1);
        [entering_value, pivot_col] = min(zc);
    
        if all(A(:, pivot_col) <= 0)
            error('LPP is unbounded');
        else
            solution = A(:,end);
            column = A(:,pivot_col);
            for i=1:size(A,1)
                if column(i) > 0
                    ratio(i) = solution(i)./column(i);
                else
                    ratio(i) = inf;
                end
            end
            [leaving_value, pivot_row] = min(ratio);
        end

    %% Step 3

    bv(pivot_row) = pivot_col;
    pivot = A(pivot_row, pivot_col);
    A(pivot_row, :) = A(pivot_row, :)./pivot;
    
    for i=1:size(A,1)
        if i ~= pivot_row
            A(i,:) = A(i,:)-A(i, pivot_col).*A(pivot_row,:);
        end
    end
    ZjCj = ZjCj-ZjCj(pivot_col).*A(pivot_row,:);
    zcj = [ZjCj;A];
    table = array2table(zcj);
    table.Properties.VariableNames(1:size(zcj,2)) = {'x1','x2','s1','s2','s3','sol'};
    disp(table);
    else
        flag = false;
        fprintf('Current BFS is optimal\n');
    end
end
