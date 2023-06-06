% (d)
i = [2 6 3 4 4 5 6 1 1];
j = [1 1 2 2 3 3 3 4 6];

n = 6;
G = sparse(i,j,1,n,n);

% pagerank1
disp('pagerank1')
x1 = pagerank1(G);
disp(x1)

% pagerank2
disp('pagerank2')
x2 = pagerank2(G);
disp(x2)

% pagerank3
disp('pagerank3')
x3 = pagerank3(G);
disp(x3)