function paper_plots(resultF, resultA)

figure, clf;
plot(resultF.r, resultF.p, 'LineWidth', 2, 'Color', 'red');
axis equal;
axis([0 1 0 1]);
grid;
xlabel('proportion of labelled tracks');
ylabel('per-sample accuracy');

L{1} = sprintf('OURS with others AP=%3.2f', resultF.ap);
legend(L, 'Location', 'southWest');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure,clf;
hold on;
plot(resultA{2}.class_r{1}, resultA{2}.class_p{1}, 'red', 'LineWidth', 2);
plot(resultA{1}.class_r{1}, resultA{1}.class_p{1}, 'blue', 'LineWidth', 2);
plot(resultA{3}.class_r{1}, resultA{3}.class_p{1}, 'green', 'LineWidth', 2);

grid;
axis equal;
axis([0 1 0 1]);
ylabel('precision');
xlabel('recall');
L{1} = sprintf('True Names+Actions AP=%3.2f', resultA{2}.class_ap(1));
L{2} = sprintf('Names+Actions AP=%3.2f', resultA{1}.class_ap(1));
L{3} = sprintf('No Names AP=%3.2f', resultA{3}.class_ap(1));
legend(L, 'Location', 'SouthEast');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure,clf;
hold on;
plot(resultA{2}.class_r{3}, resultA{2}.class_p{3}, 'red', 'LineWidth', 2);
plot(resultA{1}.class_r{3}, resultA{1}.class_p{3}, 'blue', 'LineWidth', 2);

Z1 = resultA{5}.Z>0.9;
Y1 = resultA{5}.Y==1;
z3 = Z1(:, 3);
y3 = Y1(:, 3);
prec1 = sum(y3 == 1 & z3 == 1) / sum(z3 == 1);
rec1 = sum(y3 == 1 & z3 == 1) / sum(y3 == 1);
scatter(rec1, prec1, 200, 'r*', 'LineWidth', 3);

Z1 = resultA{4}.Z>0.9;
Y1 = resultA{4}.Y==1;
z3 = Z1(:, 3);
y3 = Y1(:, 3);
prec1 = sum(y3 == 1 & z3 == 1) / sum(z3 == 1);
rec1 = sum(y3 == 1 & z3 == 1) / sum(y3 == 1);
scatter(rec1, prec1, 200, 'b*', 'LineWidth', 3);

plot(resultA{3}.class_r{3}, resultA{3}.class_p{3}, 'green', 'LineWidth', 2);

hold off;

grid;
axis equal;
axis([0 1 0 1]);
ylabel('precision');
xlabel('recall');

L{1} = sprintf('True Names+Actions AP=%3.2f', resultA{2}.class_ap(3));
L{2} = sprintf('Names+Actions AP=%3.2f', resultA{1}.class_ap(3));
L{3} = sprintf('True Names+Text');
L{4} = sprintf('Names+Text');
L{5} = sprintf('No Names AP=%3.2f', resultA{3}.class_ap(3));

legend(L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure,clf;
hold on;
plot(resultA{2}.class_r{2}, resultA{2}.class_p{2}, 'red', 'LineWidth', 2);
plot(resultA{1}.class_r{2}, resultA{1}.class_p{2}, 'blue', 'LineWidth', 2);

Z1 = resultA{5}.Z>0.9;
Y1 = resultA{5}.Y==1;
z3 = Z1(:, 2);
y3 = Y1(:, 2);
prec1 = sum(y3 == 1 & z3 == 1) / sum(z3 == 1);
rec1 = sum(y3 == 1 & z3 == 1) / sum(y3 == 1);
prec2 = sum(y3 == 1) / length(z3);
ap4 = (prec1*rec1) + ((1-rec1)*prec2);
scatter(rec1, prec1, 200, 'r*', 'LineWidth', 3);
% plot([0 rec1 rec1 1], [prec1 prec1 prec2 prec2], 'red', 'LineWidth', 2, 'LineStyle', '--');

Z1 = resultA{4}.Z>0.9;
Y1 = resultA{4}.Y==1;
z3 = Z1(:, 2);
y3 = Y1(:, 2);
prec1 = sum(y3 == 1 & z3 == 1) / sum(z3 == 1);
rec1 = sum(y3 == 1 & z3 == 1) / sum(y3 == 1);
scatter(rec1, prec1, 200, 'b*', 'LineWidth', 3);
% plot([0 rec1 rec1 1], [prec1 prec1 prec2 prec2], 'blue', 'LineWidth', 2, 'LineStyle', '--');

plot(resultA{3}.class_r{2}, resultA{3}.class_p{2}, 'green', 'LineWidth', 2);
plot(resultA{1}.class_r{2}, resultA{1}.class_p{2}, 'blue', 'LineWidth', 2);

hold off;

grid;
axis equal;
axis([0 1 0 1]);
ylabel('precision');
xlabel('recall');

L{1} = sprintf('True Names+Actions AP=%3.2f', resultA{2}.class_ap(2));
L{2} = sprintf('Names+Actions AP=%3.2f', resultA{1}.class_ap(2));
L{3} = sprintf('True Names+Text');
L{4} = sprintf('Names+Text');
L{5} = sprintf('No Names AP=%3.2f', resultA{3}.class_ap(2));
legend(L);

end