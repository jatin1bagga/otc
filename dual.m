%% Dual simplex
% max z = -2x1 - x3
% -x1 - x2 + x3 <= -5
% -x1 + 2x2 - 4x3 <= -8
% x1, x2, x3 >= 0

%% Standard form
% -x1 - x2 + x3 + s1 = -5
% -x1 + 2x2 - 4x3 + s2 = -8

%% Initialization

a = [-1 -1 1 1 0; -1 2 -4 0 1];
b = [-5; -8];
A = [a b];
bv = [4 5];
cost = [-2 0 -1 0 0 0];

ZjCj = cost(bv)*A - cost;
zjcj = [ZjCj; A];
simplextable = array2table(zjcj);
simplextable.Properties.VariableNames(1:size(zjcj,2)) = {'x1', 'x2', 'x3', 's1', 's2', 'Solution'};
disp(simplextable);

%% Step 1

flag = true;
while flag
    sol = A(:, end);
    if any(sol < 0)
        [leaving_val, pivot_row] = min(sol);
        for i=1:size(A,2)-1
            if A(pivot_row, i) < 0
                ratio(i) = abs(ZjCj(i)./A(pivot_row, i));
            else
                ratio(i) = inf;
            end
        end
        [entering_row, pivot_col] = min(ratio);
        bv(pivot_row) = pivot_col;
        pivot_key = A(pivot_row, pivot_col);
        A(pivot_row, :) = A(pivot_row, :)./pivot_key;
    
        %% Step 2
    
        for i=1:size(A,1)
            if i ~= pivot_row
                A(i,:) = A(i,:)-A(pivot_row, :).*A(i,pivot_col);
            end
        end
    
        ZjCj = cost(bv)*A - cost;
        zcj = [ZjCj; A];
        table = array2table(zcj);
        table.Properties.VariableNames(1:size(zcj,2)) = {'x1','x2','x3','s1','s2','sol'};
        disp(table);
    
    else
        flag = false;
        objective_val = ZjCj(end);
        fprintf("New Objective value is: ");
        disp(objective_val);
    end
end
