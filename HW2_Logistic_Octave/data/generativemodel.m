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
Train_y=csvread('Y_train.csv');
Train_x=csvread('X_train.csv');
Train_class1=[];
Train_class2=[];

[M N]=size(Train_y);
P_C1=0;P_C2=0;
for i = 2:M
  if(Train_y(i,2)==1)
      P_C1+=1;
      Train_class1=[Train_class1 ; Train_x(i,:)];
  else
      P_C2+=1;
      Train_class2=[Train_class2 ; Train_x(i,:)];      
  endif
endfor
P_C1=P_C1/M;
P_C2=P_C2/M;
%}

%then calculate the u and sigma ,expectation and covariance
[M1 N1]=size(Train_class1);
[M2 N2]=size(Train_class2);
u1=mean(Train_class1(:,2:N1),1);
u2=mean(Train_class2(:,2:N2),1);
covariance1=[];
covariance2=[];
for i =1:M1
  covariance1_temp=(Train_class1(i,2:N1)-u1)'*(Train_class1(i,2:N1)-u1);
  covariance1=cat(3,covariance1,covariance1_temp);
endfor
for i =1:M2
  covariance2_temp=(Train_class2(i,2:N2)-u2)'*(Train_class2(i,2:N2)-u2);
  covariance2=cat(3,covariance2,covariance2_temp);
endfor
sigma1=mean(covariance1,3);
sigma2=mean(covariance2,3);