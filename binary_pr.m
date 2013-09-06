function [r, p, ap] = binary_pr( s, y )


[s, idx] = sort(s, 'descend');
y = y(idx);

r = zeros(length(s), 1);
p = zeros(length(s), 1);

for i = 1:length(s)
    p(i) = sum(y(1:i)) / i;
    r(i) = sum(y(1:i)) / sum(y);
end

ap = 0;
for i = 2:length(r)
    ap = ap + (p(i)+p(i-1))/2*(r(i)-r(i-1));
end

end

