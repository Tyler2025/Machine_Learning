%{
  Binary Classification Demo 
  This script aims to implement the  Logistic Regression Model Algothrims 
  based on the Octave or Matlab Environment.
  The main procedures include Input data feature extracture and parameter calculation
  then do the classification.
  Tyler leigh 1930417368@qq.com 155-3698-5802 2020-6-7 In ChengDu Sichuan   
%}
%
%First,we gonna read the csv file and normalize the data
tic
Train_y=csvread('Y_train.csv',1,1);
Train_x=csvread('X_train.csv',1,1);
Train_x = zscore(Train_x);
[M1,N1]=size(Train_x);
disp('Read CSV File done');

%Then split data into train_set and dev_set
Split_ratio=input('Split Radio(train remain):');
split_loc = floor(M1*Split_ratio);
train_x = Train_x(1:split_loc,:);
train_y = Train_y(1:split_loc,:);
dev_x = Train_x(split_loc:M1,:);
dev_y = Train_y(split_loc:M1,:);
[M2,N2]=size(train_x);
[M3,N3]=size(dev_x);
disp('Split Data Done');
toc
%Gradient Descent to find W and b
tic
Weights = ones(N1,1);
Bias = 1;
steps = 1;
L_rate=input('Learining Rate:');
Iteration=input('Iteration Steps:');
Batch_size=input('Batch size:');
Train_loss_s = zeros(1,Iteration);
Dev_loss_s = zeros(1,Iteration);
for i = 1:Iteration
    %shuffles the two matrix
    rowrank = randperm(size(train_x, 1));
    train_x = train_x(rowrank,:);
    train_y = train_y(rowrank,:);   
    %Mini_batch Training
    for j = 1:floor(M2/Batch_size-1)
        X = train_x(j*Batch_size:(j+1)*Batch_size,:);
        Y = train_y(j*Batch_size:(j+1)*Batch_size,:);
        
        [W_grad,B_grad]=gradient(X,Weights,Bias,Y);
        
        %update Weights and Bias
        Weights = Weights-L_rate/sqrt(steps)*W_grad;
        Bias    = Bias  - L_rate/sqrt(steps)*B_grad;
        
        steps = steps +1;
    end
    predict_train = work(train_x,Weights,Bias);
    predict_dev = work(dev_x,Weights,Bias);
    Train_loss = cross_entropy(train_y,predict_train)/M2;
    Dev_loss = cross_entropy(dev_y,predict_dev)/M3;
    Train_loss_s(i) = Train_loss;
    Dev_loss_s(i)= Dev_loss;
    %display the loss transformation
    disp(['Iter:',num2str(i),' Training loss:',num2str(Train_loss)]);
    disp(['Iter:',num2str(i),' Dev loss:     ',num2str(Dev_loss)]);    
end
disp('Model Training Done');
toc
%}

%plot the error curve
figure
plot(1:Iteration,Train_loss_s,'g');
hold on
plot(1:Iteration,Dev_loss_s,'b');
title(['Cross Entropy Loss','Learining Rate:',num2str(L_rate),'Iteration:',num2str(Iteration)]);
xlabel('Iteration');
ylabel('Cross Entropy');
legend('Trainset','Devset');

%Compute accuracy on training set
accuracy_output = predict(dev_x,Weights,Bias);
acc = 1 - mean(abs(accuracy_output - dev_y));
disp(['Accuracy = ',num2str(acc)]);

%output predict
Test_X = csvread('X_test.csv',1,1);
Test_X = zscore(Test_X);
[M4,N4] = size(Test_X);
prediction_output = predict(Test_X,Weights,Bias);
columns = {'id','value'};
id = 0:M4-1;
data = table(id',prediction_output,'VariableNames',columns);
writetable(data,'Classifier_output_log.csv');
