function R = elu(I,a)
%ELU transfer function
R(I<=0)=a.*(exp(I(I<=0))-1);
R(I>0) = I(I>0);
% if I >0
%     R = I;
% else
%     R = exp(I) -1;
% end