function [gra_w,gra_b] = Gradient(X,Y,Weights,Biases)
%this function return the gradient of weights and bias
%X n x 784
%Y n x 10
[M,~] = size(X);%读取X矩阵大小
graw_temp = zeros(784,10,M);
grab_temp = zeros(10,1,M);
% comp = zeros(1,10);
% L_Z = zeros(1,10);
for i = 1:M
    X_ope = X(i,:)';%784 X 1
    Y_ope = Y(i,:)';%10 x 1
    Z = X_ope'*Weights+Biases';%1 x 10
    %%%选择激活函数
    Z = logsig(Z);%sigmoid
    %Z = elu(Z,1);%elu_有bug
    %Z = max(comp,Z);%ReLu 1 x 10
    %Z = log(1+exp(Z));%1x10
    %Z = 2.*logsig(2.*Z)-1;%tanh
    %Z = max(0.01*Z,Z);%Leaky ReLu
    A = softmax(Z');%1 x 10
    PDV = A' - Y_ope';%1 x 10
    %%%激活函数微分点乘偏微分
%    PDX = logsig(Z).*PDV;
    PDX = Z.*(1-Z).*PDV;
%    PDX = elu_d(Z,1).*PDV;
%    PDX = (1-Z.*Z).*PDV;%tanh
%     L_Z(Z<0) = 0.01;
%     L_Z(Z>0) = Z(Z>0);
%     PDX = L_Z.*PDV;
    graw_temp(:,:,i) = X_ope *PDX;%784x10
    grab_temp(:,:,i) = PDX';
end
gra_w = sum(graw_temp,3);
gra_b = sum(grab_temp,3);

% for i = 1:M
%     X_ope = X(i,:)';%784 X 1
%     Y_ope = Y(i,:)';%10 x 1
%     Z = X_ope'*Weights+Biases';%1 x 10
%     A = logsig(Z);%1 x 10
%     S =sum(exp(A));%1 x 1
%     logsig_d = A.*(1-A);%1 x 10
%     PDM = repmat(1./exp(A),10,1);%10 x 10
%     PDM(logical(eye(10))) = A;
%     PDV = PDM * -Y_ope + (A.*exp(A)/S)';%10 x 1
%     graw_temp(:,:,i) = X_ope *(logsig_d.*PDV');%784x10
%     grab_temp(:,:,i) = PDV;
% end
% gra_w = sum(graw_temp,3)./M;
% gra_b = sum(grab_temp,3)./M;
% Temp_a = zeros(10,10);
% Temp = (X* Weights); %nx10
% [M,~]=size(Temp);
% B = repmat(Biases',M,1);%nx10
% Z = Temp + B;%nx10
% A = logsig(Z);%nx10
% S =sum(exp(A),2);%nx1
% 
% logsig_d = A.*(1-A);%nx10

