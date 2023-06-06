function x = pagerankpower(G,precision)
p = 0.85;
% Eliminate any self-referential links
G = G - diag(diag(G));
% c = out-degree
n = size(G,1);
c = sum(G,1);
% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
% define e, G, z, and initial guess x
e = ones(n,1);
G = p*G*D;
z = ((1-p)*(c~=0) + (c==0))/n;
x = e/n;
y = zeros(n, 1);
% iteration
while norm(x-y) > 10^-(precision)
    y = x;
    x = G*x + e*(z*x);
end
end

