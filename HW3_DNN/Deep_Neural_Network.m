%{
***************************************************************************
this project aims to identify the handwriting numbers includes 0-9 based on
the MNIST data set.So the methods to access this goal is Deep Neural Net
work which owns the 256*10 fully connected network.in output layer,with softmax
function to output the result,and backpropagation algorithim is a good way
to compute the gradient.Besides we also utilize diffirent activation
function to test each one's performance.

2020-06-20 Tyler Leigh @1930417368 NUC Chengdu Sichuan
***************************************************************************
%}

%首先，需要读入MNIST数据集,注意需要将标签转化为独热码
Train_x = loadMNISTImages('train-images.idx3-ubyte')';
Train_y = loadMNISTLabels('train-labels.idx1-ubyte')';
Train_y = full(ind2vec(Train_y+1,10))';%先转为稀疏矩阵，再转为满秩，完成独热码转换

[M1,N1] = size(Train_x);
[M2,N2] = size(Train_y);
Train_x = zscore(Train_x);

%Then split data into train_set and dev_set
Split_ratio=input('Split Radio(train remain):');
split_loc = floor(M1*Split_ratio);
train_x = Train_x(1:split_loc,:);
train_y = Train_y(1:split_loc,:);
dev_x = Train_x(split_loc:M1,:);
dev_y = Train_y(split_loc:M1,:);
[M3,N3]=size(train_x);
[M4,N4]=size(dev_x);

%输入层为784*1 中间层10个神经元784*10 输出层 softmax函数 损失函数交叉熵
%权重与偏移量
% Weights = zeros(784,10);
Weights = ones(784,10);
Biases  = repmat(0.01,10,1);

%中间变量
cro_entropy = 0;
cro_entropy_dev = 0;

Iteration = input('Input Iteration Steps: ');
L_rate = input('Input Learning_rate: ');
Batch_size=input('Batch size:');
steps =0;
temp_length = floor(M3/Batch_size-1);

gra_w = ones(784,10);
gra_b = zeros(10,1);

%开始训练
for j = 1:Iteration
    %shuffles the two matrix
    rowrank = randperm(size(train_x, 1));
    train_x = train_x(rowrank,:);
    train_y = train_y(rowrank,:); 
    
    for i = 1:temp_length
        X = train_x(i*Batch_size:(i+1)*Batch_size,:);
        Y = train_y(i*Batch_size:(i+1)*Batch_size,:);
        steps = steps +1;
      
        [gra_w,gra_b] = Gradient(X,Y,Weights,Biases);

        Weights = Weights - L_rate/sqrt(steps)*gra_w;
        Biases  = Biases  - L_rate/sqrt(steps)*gra_b;    
%         Weights = Weights - L_rate.*gra_w;
%         Biases  = Biases  - L_rate.*gra_b;  
    end
  
     for i = 1:M3 
        prediction = predict(Weights,Biases,train_x(i,:));
        entropy = cross_entropy(train_y(i,:),prediction');
        cro_entropy = cro_entropy + entropy/10;       
     end        
     disp(['Cross_entropy:',num2str(cro_entropy)]);
     
     for i = 1:M4 
        prediction_dev = predict(Weights,Biases,dev_x(i,:));
        entropy = cross_entropy(dev_y(i,:),prediction_dev');
        cro_entropy_dev = cro_entropy_dev + entropy/10;       
     end        
     disp(['Cross_entropy_dev:',num2str(cro_entropy_dev)]);
     cro_entropy = 0;
     cro_entropy_dev = 0;
     steps = 0;
end
%}