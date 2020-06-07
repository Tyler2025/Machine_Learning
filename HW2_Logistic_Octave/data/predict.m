function [p] = predict(x,w,b)
%Based on the generation probability model, the expectation of the Gaussian
%distribution is passed in, and after the covariance matrix, the posterior 
%probability is returned
prediction = x*w+b;
prediction_value =1./(1+exp(-prediction));
p = round(prediction_value);