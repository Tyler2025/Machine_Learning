my_output = csvread('Classifier_output.csv',1,1);
my_output_log = csvread('Classifier_output_log.csv',1,1);
mrli_output = csvread('output_generative.csv',1,1);

acc = 1 - mean(abs(my_output - mrli_output));
disp(['Error:',num2str(acc)]);

acc1 = 1 - mean(abs(my_output_log - mrli_output));
disp(['Error:',num2str(acc1)]);