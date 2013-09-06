function [ A_ind, B_ind ] = build_bag_indicators( params, bag, Y, T )

[N, P]  = size(Y);

eA      = zeros(N, 1);
eB      = zeros(P, 1);
I       = length(bag);

A_ind = cell(I, 1);
B_ind = cell(I, 1);

for i = 1:I
    A_ind{i} = eA;
    B_ind{i} = eB;
    
    if isempty(bag(i).person) || isempty(bag(i).action)
        if strcmp(params.coordinate, 'faces')
            if bag(i).person == 1
                A_ind{i}(bag(i).tracks) = 1;
            else
%                 A_ind{i}(bag(i).tracks) = 1 ./ size(T,2);
                A_ind{i}(bag(i).tracks) = 1;
            end
            B_ind{i}(bag(i).person) = 1;
        else
            if bag(i).action == 1
                A_ind{i}(bag(i).tracks) = 1;
            else
%                 A_ind{i}(bag(i).tracks) = 1 ./ size(T,2);
                A_ind{i}(bag(i).tracks) = 1;
            end
            B_ind{i}(bag(i).action) = 1;
        end
    else
        temp = eA;
        temp(bag(i).tracks) = 1;
        if strcmp(params.coordinate, 'faces')
            if bag(i).person > 0
                A_ind{i} = temp .* T(:, bag(i).action);
                B_ind{i}(bag(i).person) = 1;
            else
                fprintf('Skipping negative constraint\n');
            end
        else
            if bag(i).person < 0
                A_ind{i} = temp .* (1 - T(:, -bag(i).person));
                B_ind{i}(1) = 1;
            else
                A_ind{i} = temp .* T(:, bag(i).person);
                B_ind{i}(bag(i).action) = 1;
            end
        end
    end
end

sA = cellfun(@sum, A_ind);
sB = cellfun(@sum, B_ind);
nonempty = sA>0 & sB>0;
A_ind = A_ind(nonempty);
B_ind = B_ind(nonempty);

end