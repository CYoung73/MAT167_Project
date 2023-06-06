% load data
data = importdata('Data/web-NotreDame.txt').data;
load('PageRanks\NotreDame_True_PRs.mat');

% dimension of G
n = max(max(data)) + 1;

% define G
i = data(:, 2) + 1;
j = data(:, 1) + 1;
G = sparse(i,j,1,n,n);

% remove self-referential links
G = G - diag(diag(G));

% pagerank1
%x1 = pagerank1(G);

% test run-time of pagerank1
%f = @() pagerank1(G);
%pr1_time = timeit(f); 

% pagerank2 cannot be used. Creation of A requires too much space.
% Requested 325729x325729 (790.5GB) array exceeds maximum array size preference (31.9GB).
% x2 = pagerank2(G);

% pagerank3, i.e. power method
%x3 = pagerankpower(G, 6);

% test run-time of power method
%f = @() pagerankpower(G, 6);
%pr_power_6_time = timeit(f); 

% measure relative error and run-time vs digits of precision
iters = 25;
errors = zeros(iters);
run_times = zeros(iters);
for k=1:iters
    approx = pagerankpower(G, k);
    errors(k) = errors(k) + (norm(approx - x1) / norm(x1));
    f = @() pagerankpower(G, k);
    run_times(k) = run_times(k) + timeit(f);
end

% plot relative error vs digits of precision
%subplot(2, 1, 1);
%plot(1:iters, errors);
%subplot(2, 1, 2);
%plot(10:iters, errors(10:iters))