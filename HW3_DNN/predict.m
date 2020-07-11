function out = predict(weights,biases,x)
%this function predict the identify number and return a 10x1 vector
comp = zeros(10,1);
temp_out = (x*weights+biases')';
out = softmax(max(comp,temp_out));
% temp_out = (x*weights+biases')';
% out = softmax(logsig(temp_out));

% temp_out = (x*weights+biases')';
% out = softmax(elu(temp_out,1));

% temp_out = (x*weights+biases')';
% out = softmax(2.*logsig(2.*temp_out)-1);