function out = predict(Weights,Biases,x,Hidden_layers)
%this function predict the identify number and return a 10x1 vector
%comp = zeros(10,1);
Z = cell(Hidden_layers+1,1);
A = cell(Hidden_layers,1);
for i =1:Hidden_layers+1
   if i == 1
        Z{i} = (x*Weights{i}+Biases{i}')';
        A{i} = logsig(Z{i});
   else if i == Hidden_layers+1
           Z{i} = (A{i-1}'*Weights{i}+Biases{i}')';
%            A{i} = logsig(Z{i});
           break
       end
        Z{i} = (A{i-1}'*Weights{i}+Biases{i}')';
        A{i} = logsig(Z{i});
   end
end
out = softmax(Z{i});
% temp_out = (x*weights+biases')';
% out = softmax(logsig(temp_out));

% temp_out = (x*weights+biases')';
% out = softmax(elu(temp_out,1));

% temp_out = (x*weights+biases')';
% out = softmax(2.*logsig(2.*temp_out)-1);