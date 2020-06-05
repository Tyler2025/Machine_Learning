%{
  This project aims to predict the PM2.5 value on the tenth day based on 18
  features of nine days ahead.
  To do the typical linear regression application by Gradient Descent Algorithm
  in Octave.
  Tyler leigh 1930417368@qq.com 155-3698-5802 2020-4-11 In ZhongJiang Sichuan   
%}

clc;
clear all;
Raw_Data=csvread('train.csv');

%Transfer the mat to 18*5760
Data_train=[];
for months = 1:12
  for days = 1:20
    for hours = 1:24
      for features = 1:18
        Data_train(features,480*(months-1)+24*(days-1)+hours)=Raw_Data(features+1,hours+3); 
      endfor
    endfor 
  endfor
endfor

%Normalization
Data_train_mean=mean(Data_train,1);
Data_train_std=std(Data_train);
for i=1:5760
  if(mod(i,10)!=0)
    if(Data_train_std(i)!=0)
      for j=1:18
        Data_train(j,i)=(Data_train(j,i)-Data_train_mean(i))/Data_train_std(i);
      endfor  
    endif
  endif
endfor

%Divide the mat to input[18*9,576] and output[1,576]
Data_train_output=[];
Data_train_input=ones(18*9+1,576);
a=0;
for i = 1:5760
  b=mod(i,10);
  if(b==0)
    a=a+1;
    Data_train_output=[Data_train_output Data_train(10,i)];
  else
    Data_train_input(18*b-17:18*b,a+1)=Data_train(:,b+10*a); 
  endif
endfor


%Algorithm implementation section
W=ones(1,18*9+1);
eps = 0.0000000001;
Ada=zeros(1,163);
L_rate=input('Learining Rate:');
Iteration=input('Iteration Steps:');
for i = 1:Iteration
  error=W* Data_train_input-Data_train_output;
  Loss=sqrt(sum(error.^2,2)/576);
  for j = 1:163
    Gra(j)=error*Data_train_input'(:,j)/Loss/576;
  endfor
  Ada=Ada+Gra.^2;
  W=W-L_rate*Gra/sqrt(sum(Ada.^2,2)+eps);
  if mod(i,100)==0
      disp(['Iteration:', num2str(i), ' Loss:', num2str(Loss)]);  
  endif
endfor

%}
%Read Test files&&Normalization&&transfer the file into the same format as input did
Raw_Data_test=csvread('test.csv');
Data_test_input=ones(163,240);
j=0;
for i = 1:2400
  a=mod(i,10);
  if(a==0)
    j=j+1;
  else
    Data_test_input(18*a-17:18*a,j+1)=Raw_Data_test(18*j+1:18*j+18,a+2);
    Data_test_mean=mean(Data_test_input(18*a-17:18*a,j+1),1);
    Data_test_std=std(Data_test_input(18*a-17:18*a,j+1));    
    for k= 1:18
      Data_test_input(18*a-18+k,j+1)=(Data_test_input(18*a-18+k,j+1)-Data_test_mean)/Data_test_std;
    endfor
  endif
endfor


%Projected future PM2.5 values
PM_Value=W*Data_test_input;
csvwrite('Predicted_PM2.5.csv',PM_Value);