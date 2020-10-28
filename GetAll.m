clear all
close all
%//Open file
fid = fopen('train-images', 'r');

%//Read in magic number
A = fread(fid, 1, 'uint32');
magicNumber = swapbytes(uint32(A));

%//Read in total number of images
A = fread(fid, 1, 'uint32');
totalImages = swapbytes(uint32(A));

%//Read in number of rows
A = fread(fid, 1, 'uint32');
numRows = swapbytes(uint32(A));

%//Read in number of columns
A = fread(fid, 1, 'uint32');
numCols = swapbytes(uint32(A));

%//For each image, store into an individual cell
trainImageCellArray = cell(1, totalImages);
for k = 1 : totalImages
    %//Read in numRows*numCols pixels at a time
    A = fread(fid, numRows*numCols, 'uint8');
    %//Reshape so that it becomes a matrix
    %//We are actually reading this in column major format
    %//so we need to transpose this at the end
    trainImageCellArray{k} = reshape(uint8(A), numCols, numRows)';
end

%//Close the file
fclose(fid);
clear A
clear numCols
clear numRows
clear totalImages
clear magicNumber
clear fid
clear k

%//Open file
fid = fopen('test-images', 'r');

%//Read in magic number
A = fread(fid, 1, 'uint32');
magicNumber = swapbytes(uint32(A));

%//Read in total number of images
A = fread(fid, 1, 'uint32');
totalImages = swapbytes(uint32(A));

%//Read in number of rows
A = fread(fid, 1, 'uint32');
numRows = swapbytes(uint32(A));

%//Read in number of columns
A = fread(fid, 1, 'uint32');
numCols = swapbytes(uint32(A));

%//For each image, store into an individual cell
testImageCellArray = cell(1, totalImages);
for k = 1 : totalImages
    %//Read in numRows*numCols pixels at a time
    A = fread(fid, numRows*numCols, 'uint8');
    %//Reshape so that it becomes a matrix
    %//We are actually reading this in column major format
    %//so we need to transpose this at the end
    testImageCellArray{k} = reshape(uint8(A), numCols, numRows)';
end

%//Close the file
fclose(fid);
clear A
clear numCols
clear numRows
clear totalImages
clear magicNumber
clear fid
clear k

fid = fopen('train-labels', 'r');
    trainId=[];

    A = fread(fid, 1, 'uint32');
    magicNum = swapbytes(uint32(A));
    
    
    A = fread(fid, 1, 'uint32');
    totalId = swapbytes(uint32(A));
    

for t=1:totalId
       A = fread(fid, 1, 'uint8');
        trainId = [trainId swapbytes(uint8(A))];
end


fclose(fid);
clear fid
clear A
clear totalId
clear magicNum
clear t

fid = fopen('test-labels', 'r');
    testId=[];

    A = fread(fid, 1, 'uint32');
    magicNum = swapbytes(uint32(A));
    
    
    A = fread(fid, 1, 'uint32');
    totalId = swapbytes(uint32(A));
    

for t=1:totalId
       A = fread(fid, 1, 'uint8');
        testId = [testId swapbytes(uint8(A))];
end


fclose(fid);
clear fid
clear A
clear totalId
clear magicNum
clear t
clear ans

%trainTestArray=trainImageCellArray(1,59951:end);
%trainImageCellArray=trainImageCellArray(1,1:59950);
%trainTestId=trainId(1,59951:end);
%trainId=trainId(1,1:59950);
 


testImageCellArray=testImageCellArray';
trainImageCellArray=trainImageCellArray';
testId=testId';
trainId=trainId';
trainImageArray=cell2mat(trainImageCellArray);
testImageArray=cell2mat(testImageCellArray);


[boy,~]=size(testImageArray);
TestFeatures=[];
i=0;
for i=1:28:boy
    A=testImageArray(i:i+27,:);
    A=A(:);
    B=dct(single(A));
    TestFeatures=[TestFeatures B];
    DISP(i);
end
TestFeatures=TestFeatures';


[boy,~]=size(trainImageArray);
TrainFeatures=[];
i=0;
for i=1:28:boy
    A=trainImageArray(i:i+27,:);
    A=A(:);
    B=dct(single(A));
    TrainFeatures=[TrainFeatures B];
    DISP(i);
end
TrainFeatures=TrainFeatures';


TestTarget=[];
[boy,en]=size(testId);
for i=1:boy
    switch testId(i,en)
        case 0
            TestTarget=[TestTarget; 1 0 0 0 0 0 0 0 0 0];
        case 1
            TestTarget=[TestTarget; 0 1 0 0 0 0 0 0 0 0];
        case 2
            TestTarget=[TestTarget; 0 0 1 0 0 0 0 0 0 0];
        case 3
            TestTarget=[TestTarget; 0 0 0 1 0 0 0 0 0 0];
        case 4
            TestTarget=[TestTarget; 0 0 0 0 1 0 0 0 0 0];
        case 5
            TestTarget=[TestTarget; 0 0 0 0 0 1 0 0 0 0];
        case 6
            TestTarget=[TestTarget; 0 0 0 0 0 0 1 0 0 0];
        case 7
            TestTarget=[TestTarget; 0 0 0 0 0 0 0 1 0 0];
        case 8
            TestTarget=[TestTarget; 0 0 0 0 0 0 0 0 1 0];
        case 9
            TestTarget=[TestTarget; 0 0 0 0 0 0 0 0 0 1];
    end
end

TrainTarget=[];
[boy,en]=size(trainId);
for i=1:boy
    switch trainId(i,en)
        case 0
            TrainTarget=[TrainTarget; 1 0 0 0 0 0 0 0 0 0];
        case 1
            TrainTarget=[TrainTarget; 0 1 0 0 0 0 0 0 0 0];
        case 2
            TrainTarget=[TrainTarget; 0 0 1 0 0 0 0 0 0 0];
        case 3
            TrainTarget=[TrainTarget; 0 0 0 1 0 0 0 0 0 0];
        case 4
            TrainTarget=[TrainTarget; 0 0 0 0 1 0 0 0 0 0];
        case 5
            TrainTarget=[TrainTarget; 0 0 0 0 0 1 0 0 0 0];
        case 6
            TrainTarget=[TrainTarget; 0 0 0 0 0 0 1 0 0 0];
        case 7
            TrainTarget=[TrainTarget; 0 0 0 0 0 0 0 1 0 0];
        case 8
            TrainTarget=[TrainTarget; 0 0 0 0 0 0 0 0 1 0];
        case 9
            TrainTarget=[TrainTarget; 0 0 0 0 0 0 0 0 0 1];
    end
end

Target=[TrainTarget;TestTarget];
Features=[TrainFeatures;TestFeatures];


F=[];
for i=1:70000
F=[F;Features(i,1:7) Features(i,29:35) Features(i,57:63) Features(i,85:91) Features(i,113:119) Features(i,141:147) Features(i,169:175)];
end


Features=F';
Target=Target';