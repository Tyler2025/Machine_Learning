function [gra_w,gra_b] = BP_Gradient(X,Y,Weights,Biases,Hidden_layer,Neuron_numbers)
%正向传播并返回交叉熵损失函数对W与B的偏微分,还有问题具体为梯度计算后每一列结构一样
Z = cell(Hidden_layer+1,1);
A = cell(Hidden_layer+1,1);
ZW_Partial = cell(Hidden_layer+1,1);
LZ_Partial = cell(Hidden_layer+1,1);
Activation_d = cell(Hidden_layer,1);%激活函数微分
gra_w_single = cell(Hidden_layer+1,1);
gra_w = cell(Hidden_layer+1,1);%输出的w偏微分
gra_b = cell(Hidden_layer+1,1);%输出的b偏微分
%初始化梯度矩阵
for i = 1:Hidden_layer+1
    if i==1
        gra_w{i}=zeros(784,Neuron_numbers(1));
        gra_b{i}=zeros(Neuron_numbers(1),1);
    else if i==Hidden_layer+1
            gra_w{i}=zeros(Neuron_numbers(i-1),10);
            gra_b{i}=zeros(10,1);
            break
        end
        gra_w{i}=zeros(Neuron_numbers(i-1),Neuron_numbers(i));
        gra_b{i}=zeros(Neuron_numbers(i),1);
    end
end
M = size(X,1);
% gra_w_sum = cell(M,1);
% gra_b_sum = cell(M,1);
%先计算各层的Z
for i = 1:M
    X_ope = X(i,:)';%784 X 1
    Y_ope = Y(i,:)';%10 x 1    
    
    %开始正向传播，并获得Z对W的偏微分
    for j = 1:Hidden_layer+1
        if j==1
            Z{1} = (X_ope'*Weights{1})'+Biases{1};%第一层输出,H1x1
            A{1} = logsig(Z{1});%第一层激活函数输出，H1x1
            Activation_d{1}=A{1}.*(1-A{1});%激活函数导数，这里是sigmoid,H1x1
            ZW_Partial{1} = repmat(X_ope,1,Neuron_numbers(1));%第一次偏微分等于输入值,784xH1
        else
            if j==Hidden_layer+1
                Z{j} = (A{j-1}'*Weights{j})'+Biases{j};%最后一层输出,H3x1
                A{j} = softmax(Z{j});%最后一层激活函数，得到输出结果
                ZW_Partial{j} = repmat(A{j-1},1,10);%最后一层等于前一层输出
            break
            end
            %Z{j} = X_ope'*Weights{j-1}+Biases{j-1}';%中间层输出,1xH1
            Z{j} = (A{j-1}'*Weights{j})' +Biases{j};%中间层输出,H2x1
            A{j} = logsig(Z{j});%中间层激活函数输出，H2x1
            Activation_d{j}=A{j}.*(1-A{j});
            ZW_Partial{j} = repmat(A{j-1},1,Neuron_numbers(j));
        end
    end
    
    %开始反向传播，获得L对Z的偏微分
    for j = Hidden_layer+1:-1:1
        if j==Hidden_layer+1
            LZ_Partial{j} = A{j} - Y_ope;%交叉熵对Z偏微分
        else
            LZ_Partial{j} = Activation_d{j}.*(Weights{j+1}*LZ_Partial{j+1});
        end
    end
    
    %计算梯度
    for j = 1:Hidden_layer+1
        if j==1
            gra_w_single{j} =  ZW_Partial{j}.*repmat(LZ_Partial{j}',784,1);%%
            gra_w{j} = gra_w{j} + gra_w_single{j};
            gra_b{j} = gra_b{j} + LZ_Partial{j};
        else
            gra_w_single{j} =  ZW_Partial{j}.*repmat(LZ_Partial{j}',Neuron_numbers(j-1),1);
            gra_w{j} = gra_w{j} + gra_w_single{j};
            gra_b{j} = gra_b{j} + LZ_Partial{j};
        end
    end
    
    %将所得梯度放入元胞数组中
%     gra_w = gra_w+gra_w_single;
%     gra_b = gra_b+LZ_Partial;
    %gra_w_sum{i} = gra_w_single;
    
    %gra_b_sum{i} = LZ_Partial;
end

% for i =1:Hidden_layer+1
%     for j =1:M
%         gra_w{i} = gra_w{i}+gra_w_sum{j}{i};
%         if i == Hidden_layer+1
%             break
%         else
%             gra_b{i}= gra_b{i}+gra_b_sum{j}{i};
%         end
%     end
% end