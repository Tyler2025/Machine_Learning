function [w_grad,b_grad] = gradient(X,w,b,Y)
%Calculate the gradient and return weights and bias
predict = 1./(1+exp(-X*w-b));
predit_error = Y-predict;
w_grad = (-predit_error'*X)';
b_grad = -sum(predit_error);
