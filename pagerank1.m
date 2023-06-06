function x = pagerank1(G)
p = 0.85;
% Eliminate any self-referential links
G = G - diag(diag(G));
% c = out-degree
n = size(G,1);
c = sum(G,1);
% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
% Solve (I - p*G*D)*x = e
e = ones(n,1);
I = speye(n,n);
x = (I - p*G*D)\e;
% Normalize so that sum(x) == 1.
x = x/sum(x);
end

