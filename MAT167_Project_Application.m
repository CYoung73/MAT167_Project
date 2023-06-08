% load data
data = importdata('Data/web-NotreDame.txt').data;
load('Results\NotreDame_True_PRs.mat');

%%%%%%%%%%%%%%%%%%%
%%% computation %%%
%%%%%%%%%%%%%%%%%%%

% dimension of G
n = max(max(data)) + 1;

% define G
i = data(:, 2) + 1;
j = data(:, 1) + 1;
G = sparse(i,j,1,n,n);

% pagerank1
x1 = pagerank1(G);

% test run-time of pagerank1
f = @() pagerank1(G);
pr1_time = timeit(f); 

% pagerank2 cannot be used. Creation of A requires too much space.
% Requested 325729x325729 (790.5GB) array exceeds maximum array size preference (31.9GB).
% x2 = pagerank2(G);

% pagerank3, i.e. power method
x3 = pagerankpower(G, 6);

% test run-time of power method
f = @() pagerankpower(G, 6);
pr_power_6_time = timeit(f); 

% measure relative error and run-time vs digits of precision
iters = 25;
errors = zeros(iters, 1);
run_times = zeros(iters, 1);
for k=1:iters
    approx = pagerankpower(G, k);
    errors(k) = errors(k) + (norm(approx - x1) / norm(x1));
    f = @() pagerankpower(G, k);
    run_times(k) = run_times(k) + timeit(f);
end

%%%%%%%%%%%%%
%%% plots %%%
%%%%%%%%%%%%%

% plot of sparsity of G
spy(G)

% plot of pageranks
plot(x1);
title('PageRanks of Pages from University of Notre Dame Website')
xlabel('Node ID')
ylabel('PageRank')

% plot of sorted pageranks
plot(sort(x1));
title('Sorted PageRanks of Pages from University of Notre Dame Website')
ylabel('PageRank')

% plot of digraph
included_x = find(x1 > 10^-5);
D = digraph(G');
H = subgraph(D, included_x);
plot(H, 'NodeLabel', {}, 'NodeCData', x1(included_x), 'Layout', 'Force')
title('Pages from University of Notre Dame Website with PageRank > 0.00001')
col = colorbar;
col.Label.String = 'PageRank';
col.Label.Rotation = 270;
col;

% percentage probability of top 5% pageranks
sum(maxk(x1, round(0.05*n)))

% plot relative error vs digits of precision
subplot(2, 1, 1);
plot(1:iters, errors);
title('Relative Error Between True Page Ranks and Approximate Page Ranks')
xlabel('Digits of Precision')
ylabel('Relative Error')
subplot(2, 1, 2);
plot(5:iters, errors(5:iters));
xlabel('Digits of Precision')
ylabel('Relative Error')

% plot run-time vs digits of precision
plot(1:iters, run_times)
title('Run Time of Power Method vs Digits of Precision')
xlabel('Digits of Precision')
ylabel('Run Time (s)')





