function [cross_entropy] = cross_entropy(p,q)
%This function calculates the cross entropy between two distributions
%Where the input is two vectors and the scalar is returned
q(q==1) = q(q==1) -0.0001;
q(q==0) = q(q==0) +0.0001;
cross_entropy = -p'*log(q)-(1-p)'*log(1-q);