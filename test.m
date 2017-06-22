clear
clc
close
load('FujianMountain.mat');
data=DSM_data(326:380,:)';
label=DEM_data(326:380,:)';
a=max(data);
b=min(data);
%data=(data-b)./(a-b);
train_data(:,1,1,:)=(data-b)./(a-b);
model='deploy_prelu.prototxt';
weights='fujian/prelu_iter_100000.caffemodel';
caffe.set_mode_gpu();
net = caffe.Net(model, weights, 'test');
output = net.forward({train_data});
result=output{1,1}.*(a-b)+b;
error=abs(result-label);
maximum=max(max(error))
minimum=min(min(error))
average=mean(mean(error))
variance=sum(sum((error-average).*(error-average)))/(55*491)

plot(result(:,50));
hold on
plot(label(:,50));
hold on
plot(data(:,50));
