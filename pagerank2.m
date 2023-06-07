function x = pagerank2(G)
% set hyperlink transition probability
p = 0.85;
% Eliminate any self-referential links
G = G - diag(diag(G));
% c = out-degree
n = size(G,1);
c = sum(G,1);
% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
% define e, I, delta, and A
e = ones(n,1);
I = speye(n,n);
delta = (1-p)/n;
A = p*G*D + delta;
% solve (I-A)*x=e
x = (I-A)\e;
% Normalize so that sum(x) == 1.
x = x/sum(x);
end

