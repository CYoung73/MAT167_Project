% (a)
i = [2 3 3 4 1 6 5];
j = [1 1 2 2 4 5 6];
n = 6;

G = sparse(i, j, 1, n, n);
disp('G')
disp(full(G))

% (b)
p = 0.85;

c = sum(G, 1);
k = find(c~=0);
D = sparse(k, k, 1./c(k),n,n);
e = ones(n,1);
I = speye(n,n);
x = (I-p*G*D)\e;
x = x/sum(x);
disp('PageRank')
disp(x)