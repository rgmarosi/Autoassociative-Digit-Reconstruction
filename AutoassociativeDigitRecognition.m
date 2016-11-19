% Autoassociative network for digit recognition using Hebbian learning
clear;clc;close all;

%% load training images(5x7 px)
M=7; N=5;
P=zeros(M*N,10);
for n=0:9
    s=num2str(n);
    RGB=imread(s,'png');
    m=n+1;
    P(:,m)=reshape(rgb2gray(RGB),[M*N,1]);%column prototype vector
end
P = P/255*2-1;%normalizes data to be either -1 or 1

%% compute weight matrix using Hebb rule
% W=zeros(M*N,M*N);
% for n=1:10
%     W=W+P(:,n)*P(:,n)';
% end

% simple Hebb rule did not make it recognize images well
% try again using pseudoinverse
T=P;
W=T*pinv(P);

%% test out network with training images
% for n = 10:-1:1
%     a=hardlims(W*P(:,n));
%     outputImg=reshape(a,[M,N]);
%     figure;
%     imshow(outputImg,'InitialMagnification','Fit')
% end

%% test out network with noisy inputs
P_noisy = P + randi([-1,1],M*N,10);

for n = 10:-1:1
    outputImg1=reshape(P_noisy(:,n),[M,N]);
    figure;
    subplot(1,2,1)
    imshow(outputImg1,'InitialMagnification','Fit')
    title('noisy image')
    
    subplot(1,2,2)
    a=hardlims(W*P_noisy(:,n));
    outputImg2=reshape(a,[M,N]);
    imshow(outputImg2,'InitialMagnification','Fit')
    title('reconstructed image')
end

%% test out network with parts of image missing
% P_partial=P;
% P_partial(8:17,:)=1;
% 
% for n = 10:-1:1
%     outputImg1=reshape(P_partial(:,n),[M,N]);
%     figure;
%     subplot(1,2,1)
%     imshow(outputImg1,'InitialMagnification','Fit')
%     title('partial image')
%     
%     subplot(1,2,2)
%     a=hardlims(W*P_partial(:,n));
%     outputImg2=reshape(a,[M,N]);
%     imshow(outputImg2,'InitialMagnification','Fit')
%     title('reconstructed image')
% end