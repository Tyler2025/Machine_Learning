function R = elu_d(I,a)
%the diffirent function of elu
R(I<=0)=a.*exp(I(I<=0));
R(I>0) = 1;