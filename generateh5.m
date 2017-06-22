clear

%%Load and preprocess Hainan data,450x491 for training, 25x491 for testing
% load('Hainan.mat');
% DSM_data=DSM_data';
% DEM_data=DEM_data';
% a=max(DSM_data);
% b=min(DSM_data);
% DSM_data=(DSM_data-b)./(a-b);
% DEM_data=(DEM_data-b)./(a-b);
% train_data(:,1,1,1:225)=DSM_data(:,1:225);
% train_data(:,1,1,226:450)=DSM_data(:,251:475);
% train_label(:,1,1,1:225)=DEM_data(:,1:225);
% train_label(:,1,1,226:450)=DEM_data(:,251:475);
% test_data(:,1,1,:)=DSM_data(:,226:250);
% test_label(:,1,1,:)=DEM_data(:,226:250);

%Load and preprocess Fujian data,650x491 for training, 55x491 for testing
load('FujianMountain.mat');
DSM_data=DSM_data';
DEM_data=DEM_data';
a=max(DSM_data);
b=min(DSM_data);
DSM_data=(DSM_data-b)./(a-b);
DEM_data=(DEM_data-b)./(a-b);
train_data(:,1,1,1:325)=DSM_data(:,1:325);
train_data(:,1,1,326:650)=DSM_data(:,381:705);
train_label(:,1,1,1:325)=DEM_data(:,1:325);
train_label(:,1,1,326:650)=DEM_data(:,381:705);
test_data=DSM_data(:,326:380);
test_label=DEM_data(:,326:380);

%Generate h5 files for training
if exist('train.h5', 'file')
    fprintf('Warning: replacing existing file %s \n', 'train.h5');
    delete('train.h5');
end 
h5create('train.h5','/data',size(train_data),'Datatype','single');
h5create('train.h5','/label',size(train_label),'Datatype','single');

h5write('train.h5','/data',train_data);
h5write('train.h5','/label',train_label);

h5disp('train.h5');

if exist('test.h5', 'file')
    fprintf('Warning: replacing existing file %s \n', 'test.h5');
    delete('test.h5');
end 
h5create('test.h5','/data',size(test_data),'Datatype','single');
h5create('test.h5','/label',size(test_label),'Datatype','single');

h5write('test.h5','/data',test_data);
h5write('test.h5','/label',test_label);

h5disp('test.h5');