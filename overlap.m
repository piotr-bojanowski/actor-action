function [ res ] = overlap( bb1,bb2 )
%OVERLAP Computes the overlap matrix of the two set of bounding boxes. The
%resulting matrix is of the following form 
% 
%                         bb2
%                      ______________
%                     |              |
%                     |              |
%                bb1  |              |
%                     |              |
%                     |              |
%                     |______________|


m1 = size(bb1,1);
m2 = size(bb2,1);

res = zeros(m1,m2);

for i = 1:m1
    j1 = find(bb2(:,2)>=bb1(i,1) & bb2(:,1)<=bb1(i,2));
    
    if ~isempty(j1)
        for j = j1'
            res(i,j) = box_overlap(bb1(i,:),bb2(j,:));
        end
    end
end

% res = sparse(res);

end

