function [gra ,gra_b]= gradient_decent_w(x,z,y,a,media)
%this function return weights 784*10 gradient
sigmoid_d = (1./(1+exp(-z))).*(1-1./(1+exp(-z)));
md = x'*sigmoid_d';

%现在计算交叉熵对s函数输出的偏导数
s_gra = -y'.*(a+a.*exp(a)/media);
gra = md*sum(s_gra);
gra_b = sigmoid_d*sum(s_gra);

