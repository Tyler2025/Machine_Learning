%{
  Binary Classification Demo 
  This script aims to implement the Genarative Probabilistic Model and Logistic 
  Regression Model Algothrims based on the Octave or Matlab Environment.
  The main procedures include Input data feature extracture and parameter calculation
  then do the classification.
  Tyler leigh 1930417368@qq.com 155-3698-5802 2020-4-18 In ZhongJiang Sichuan   
%}


%Firstly Got the prior probabilities of the two classes
%Meanwhile,Divide the train data into two classes
tic
Train_y=csvread('Y_train.csv',1,1);
Train_x=csvread('X_train.csv',1,1);
disp('Read Csv Done');
disp('Calculating Prior Pro...');
[M,N]=size(Train_x);
Train_class1=zeros(M,N);
Train_class2=zeros(M,N);


%%Normalization
Train_x = zscore(Train_x);
P_C1=0;P_C2=0;i=0;
for i = 1:M
  if(Train_y(i)==1)
      P_C1=P_C1+1;
      Train_class1(P_C1,:)= Train_x(i,:);
  else
      P_C2=P_C2+1;
      Train_class2(P_C2,:)= Train_x(i,:);     
  end
end
Train_class1(all(Train_class1==0,2),:)=[];
Train_class2(all(Train_class2==0,2),:)=[];

P_C1=P_C1/M;
P_C2=P_C2/M;
 
 %then calculate the u and sigma ,expectation and covariance
 %Based on Maximum Likelihood in Gaussian distribution
[M1,N1]=size(Train_class1);
[M2,N2]=size(Train_class2);
u1=mean(Train_class1,1);
u2=mean(Train_class2,1);

covariance1 = cov(Train_class1);
covariance2 = cov(Train_class2);

sigma = P_C1*covariance1 + P_C2*covariance2;


%Based on SVD calculate the inverse of sigma
[U,S,V] = svd(sigma);
T=S;
T(S~=0) = 1./S(S~=0);
psigma = V*T'*U';
%Based on Bayesian formula, classification
Test_X = csvread('X_test.csv',1,1);
Test_X = zscore(Test_X);
[M3,N3] = size(Test_X);
prediction = zeros(M3+1,2);
prediction(2:M3+1,1) = 1:M3;

%Calculate Weights and Biases with u1,u2 and sigma
Weights = (u1-u2)*psigma;
Biases = -0.5*u1*psigma*u1'+0.5*u2*psigma*u2'+log(P_C1/P_C2);

%Compute accuracy on training set
accuracy_output = predict(Train_x,Weights',Biases);
acc = 1 - mean(abs(accuracy_output - Train_y));
disp(['Accuracy = ',num2str(acc)]);


%predict the income
prediction_output = predict(Test_X,Weights',Biases);
columns = {'id','value'};
id = 0:M3-1;
data = table(id',prediction_output,'VariableNames',columns);
writetable(data,'Classifier_output.csv');
toc
