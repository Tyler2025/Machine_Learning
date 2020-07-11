Train_x = loadMNISTImages('train-images.idx3-ubyte');
[m,n] = size(Train_x);
images = zeros(28,28,n);

for i = 1:n
    for j = 1:m
        b = mod(j,28);
        if b == 0;
            b = 28;
        end
        images(b,ceil(j/28),i) = round(Train_x(j,i));
    end
end
