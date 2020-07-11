function [gra_w,gra_b] = BP_Gradient(X,Y,Weights,Biases,Hidden_layer,Neuron_numbers)
%���򴫲������ؽ�������ʧ������W��B��ƫ΢��,�����������Ϊ�ݶȼ����ÿһ�нṹһ��
Z = cell(Hidden_layer+1,1);
A = cell(Hidden_layer+2,1);
ZW_Partial = cell(Hidden_layer+1,1);
LZ_Partial = cell(Hidden_layer+1,1);
Activation_d = cell(Hidden_layer+1,1);%�����΢��
gra_w_single = cell(Hidden_layer+1,1);
gra_w = cell(Hidden_layer+1,1);
gra_b = cell(Hidden_layer,1);
for i = 1:Hidden_layer+1
    if i==1
        gra_w{i}=zeros(784,Neuron_numbers(1));
        gra_b{i}=zeros(Neuron_numbers(1),1);
    else if i==Hidden_layer+1
            gra_w{i}=zeros(Neuron_numbers(i-1),10);
            break
        end
        gra_w{i}=zeros(Neuron_numbers(i-1),Neuron_numbers(i));
        gra_b{i}=zeros(Neuron_numbers(i),1);
    end
end
M = size(X,1);
gra_w_sum = cell(M,1);
gra_b_sum = cell(M,1);
%�ȼ�������Z
for i = 1:M
    X_ope = X(i,:)';%784 X 1
    Y_ope = Y(i,:)';%10 x 1    
    
    %��ʼ���򴫲��������Z��W��ƫ΢��
    for j = 1:Hidden_layer+1
        if j==1
            Z{1} = X_ope'*Weights{1}+Biases{1}';%��һ�����,1xH1
            A{1} = logsig(Z{1});%��һ�㼤��������1xH1
            Activation_d{1}=A{1}.*(1-A{1});%�����������������sigmoid
            ZW_Partial{1} = X_ope';%��һ��ƫ΢�ֵ�������ֵ
        else
            if j==Hidden_layer+1
                Z{j} = A{j-1}*Weights{j};%���һ�����,1xH1
                A{j} = logsig(Z{j});%���һ�㼤��������1xH1 
                Activation_d{j}=A{j}.*(1-A{j});
                A{j+1} = softmax(A{j}');%�õ�������
                ZW_Partial{j} = A{j-1};%���һ�����ǰһ�����
            break
            end
            %Z{j} = X_ope'*Weights{j-1}+Biases{j-1}';%�м�����,1xH1
            Z{j} = A{j-1}*Weights{j} +Biases{j}';
            A{j} = logsig(Z{j});%�м�㼤��������1xH1  
            Activation_d{j}=A{j}.*(1-A{j});
            ZW_Partial{j} = A{j-1};
        end
    end
    
    %��ʼ���򴫲������L��Z��ƫ΢��
    for j = Hidden_layer+1:-1:1
        if j==Hidden_layer+1
            LZ_Partial{j} = Activation_d{j}'.*(A{j+1} - Y_ope);%�����ض�Zƫ΢��
        else
            LZ_Partial{j} = Activation_d{j}'.*(Weights{j+1}*LZ_Partial{j+1});
        end
    end
    
    %�����ݶ�
    for j = 1:Hidden_layer+1
        gra_w_single{j} =  ZW_Partial{j}'*LZ_Partial{j}';%%
    end
    gra_w_sum{i} = gra_w_single;
    gra_b_sum{i} = LZ_Partial(1:Hidden_layer);
end

for i =1:Hidden_layer+1
    for j =1:M
        gra_w{i} = gra_w{i}+gra_w_sum{j}{i};
        if i == Hidden_layer+1
            break
        else
            gra_b{i}= gra_b{i}+gra_b_sum{j}{i};
        end
    end
end