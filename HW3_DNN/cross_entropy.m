function [entropy] = cross_entropy(p,q)
%returns cross entropy beween two distribution p and q
q(q == 0) = 0.00001;
entropy = sum(-p.*log(q));