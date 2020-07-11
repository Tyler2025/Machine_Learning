%{
***************************************************************************
In view of the fact that the classification effect of the previously constructed DNN network is not ideal.
This function will build a DNN network of user-defined hidden layers and the number of neurons in each layer,
and use the back propagation algorithm to calculate the gradient and update the parameter information.

2020-07-02 Tyler Leigh @1930417368 NUC Chengdu Sichuan
***************************************************************************
%}

%���ȣ���Ҫ����MNIST���ݼ�,ע����Ҫ����ǩת��Ϊ������
Train_x = loadMNISTImages('train-images.idx3-ubyte');
Train_y = loadMNISTLabels('train-labels.idx1-ubyte')';
Train_y = full(ind2vec(Train_y+1,10));%��תΪϡ�������תΪ���ȣ���ɶ�����ת��
% 
% % [M1,N1] = size(Train_x);
% % [M2,N2] = size(Train_y);
Train_x = round(Train_x);%��һ��

Test_x = loadMNISTImages('t10k-images.idx3-ubyte');
Test_y = loadMNISTLabels('t10k-labels.idx1-ubyte')';
Test_y = full(ind2vec(Test_y+1,10));%��תΪϡ�������תΪ���ȣ���ɶ�����ת��
Test_x = round(Test_x);%��һ��
%{
%Ȼ�����ݼ���Ϊѵ�����뷢չ��������֤��
Split_ratio=input('Split Radio(train remain):');
split_loc = floor(M1*Split_ratio);
train_x = Train_x(1:split_loc,:);
train_y = Train_y(1:split_loc,:);
dev_x = Train_x(split_loc:M1,:);
dev_y = Train_y(split_loc:M1,:);
[M3,N3]=size(train_x);
[M4,N4]=size(dev_x);


%�������ز�����ÿ����Ԫ����
%��ʼ��Ȩ����ƫ����Ԫ������
Hidden_layers = input('Input Hidden Layers:');
Neuron_numbers = input('Input Each Layers''s Neuron Numbers:');
Weights = cell(Hidden_layers+1,1);
Biases  = cell(Hidden_layers,1);
for i = 1:Hidden_layers+1
    if i == 1
        a = Neuron_numbers(i);
        Weights{1} = repmat(0.01,784,a);
        Biases{1}  = repmat(0.01,a,1);
    else
        b = Neuron_numbers(i-1);
        if i == Hidden_layers+1
            Weights{i} = repmat(0.01,b,10);
            break
        end
        a = Neuron_numbers(i);
        Weights{i} = repmat(0.01,b,a);
        Biases{i} = repmat(0.01,a,1);
    end
end


%�м����
cro_entropy = 0;
cro_entropy_dev = 0;

%�������������ѧϰ�ʣ����ߴ�
Iteration = input('Input Iteration Steps: ');
L_rate = input('Input Learning_rate: ');
Batch_size=input('Batch size:');
steps =0;
temp_length = floor(M3/Batch_size-1);


%��ʼѵ��

for j = 1:Iteration
    %shuffles the two matrix
    rowrank = randperm(size(train_x, 1));
    train_x = train_x(rowrank,:);
    train_y = train_y(rowrank,:); 
    
    tic
    for i = 1:temp_length
        X = train_x(i*Batch_size:(i+1)*Batch_size,:);%��ȡС��ѵ�������ǩ
        Y = train_y(i*Batch_size:(i+1)*Batch_size,:);
        steps = steps +1;

        %��ʼ����ƫ΢��
        [gra_w,gra_b] = BP_Gradient(X,Y,Weights,Biases,Hidden_layers,Neuron_numbers);
        
        %���²���
        for k = 1:Hidden_layers+1
            Weights{k} = Weights{k} - L_rate.*gra_w{k}/sqrt(steps);
            if k == Hidden_layers+1
                break
            end
            Biases{k}  = Biases{k}  - L_rate.*gra_b{k}/sqrt(steps);    
        end
    end
    toc
    
     for i = 1:M3 
        prediction = predict(Weights,Biases,train_x(i,:),Hidden_layers);
        entropy = cross_entropy(train_y(i,:),prediction');
        cro_entropy = cro_entropy + entropy/10;       
     end        
     disp(['Cross_entropy:',num2str(cro_entropy)]);
     
     for i = 1:M4 
        prediction_dev = predict(Weights,Biases,dev_x(i,:),Hidden_layers);
        entropy = cross_entropy(dev_y(i,:),prediction_dev');
        cro_entropy_dev = cro_entropy_dev + entropy/10;       
     end        
     disp(['Cross_entropy_dev:',num2str(cro_entropy_dev)]);
     
     cro_entropy = 0;
     cro_entropy_dev = 0;
     steps = 0;
end
%}