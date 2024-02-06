clc
clear all
close all
%Part1
I{1}=imread('Image1.jpg');
I{2}=imread('Image2.jpg');
I{3}=imread('Image3.jpg');
I{4}=imread('Image4.jpg');
I{5}=imread('Image5.jpg');
I{6}=imread('Image6.jpg');
I{7}=imread('Image7.jpg');
I{8}=imread('Image8.jpg');
I{9}=imread('Image9.jpg');
I{10}=imread('Image10.jpg');
Step=50;
for i1=1:length(I)
    k1=I{i1};
    k1=im2bw(k1);
    I2{i1}=imresize(k1,[Step Step]);
    subplot(4,3,i1)
    imshow(I2{i1})
    title(['\fontsize{10}Image',num2str(i1)])
end
saveas(gcf,'Figure1.jpg')
%%
%Part2
%Neural network
%Input
k1=I2{1};
Feature=k1;
k1=I2{2};
Feature(length(Feature)+1:length(Feature)+Step,:)=k1;
k1=I2{3};
Feature(length(Feature)+1:length(Feature)+Step,:)=k1;
k1=I2{6};
Feature(length(Feature)+1:length(Feature)+Step,:)=k1;
k1=I2{7};
Feature(length(Feature)+1:length(Feature)+Step,:)=k1;
k1=I2{8};
Feature(length(Feature)+1:length(Feature)+Step,:)=k1;
for i1=1:Step*6
    for i2=1:Step
        if Feature(i1,i2)==1
            Input(i1,i2)=1;
        else
            Input(i1,i2)=0;
        end
    end
end
%Output
Output(1:3*Step,1)=1;
Output(3*Step+1:6*Step)=0;
%Train network
net=newff(Input',Output');
net=train(net,Input',Output');
%Test network
%Picture1
k1=I2{4};
for i1=1:Step
    for i2=1:Step
        if k1(i1,i2)==1
           I_test(i1,i2)=1;
        else
           I_test(i1,i2)=0;
        end
    end
end
O_test=sim(net,I_test');
O(1)=mean(O_test);
%Picture2
k1=I2{5};
for i1=1:Step
    for i2=1:Step
        if k1(i1,i2)==1
           I_test(i1,i2)=1;
        else
           I_test(i1,i2)=0;
        end
    end
end
O_test=sim(net,I_test');
O(2)=mean(O_test);
%Picture3
k1=I2{9};
for i1=1:Step
    for i2=1:Step
        if k1(i1,i2)==1
           I_test(i1,i2)=1;
        else
           I_test(i1,i2)=0;
        end
    end
end
O_test=sim(net,I_test');
O(3)=mean(O_test);
%Picture4
k1=I2{10};
for i1=1:Step
    for i2=1:Step
        if k1(i1,i2)==1
           I_test(i1,i2)=1;
        else
           I_test(i1,i2)=0;
        end
    end
end
O_test=sim(net,I_test');
O(4)=mean(O_test);
%%
%Show Output
k1=I{4};
I3{1}=imresize(k1,[384,512]);
k1=I{5};
I3{2}=imresize(k1,[384,512]);
I3{3}=I{9};
I3{4}=I{10};
%
for i1=1:length(O)
    figure
    if O(i1)>.5
       imshow(I3{i1})
       title('\fontsize{20}With Sheet')
    else
       imshow(I3{i1})
       title('\fontsize{20}Without Sheet')
    end
end