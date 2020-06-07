my_output = csvread('Classifier_output.csv',1,1);
mrli_output = csvread('output_generative.csv',1,1);
acc = 1 - mean(abs(my_output - mrli_output));
disp(['Error:',num2str(acc)]);