function [gra ,gra_b]= gradient_decent_w(x,z,y,a,media)
%this function return weights 784*10 gradient
sigmoid_d = (1./(1+exp(-z))).*(1-1./(1+exp(-z)));
md = x'*sigmoid_d';

%���ڼ��㽻���ض�s���������ƫ����
s_gra = -y'.*(a+a.*exp(a)/media);
gra = md*sum(s_gra);
gra_b = sigmoid_d*sum(s_gra);

