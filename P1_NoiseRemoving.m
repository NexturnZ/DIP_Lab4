clear all; close all;
dbstop if error;
%% Noise removement of figure 1.
I1 = imread('Q4_1_1.tiff');
O1_1 = adaptiveMedianFilter(I1,5);
O1_2 = contraharmonicFilter(I1,1.5);
figure;
subplot(1,3,1);
imshow(uint8(I1));title('Q4_1_1 original');
subplot(1,3,2);
imshow(uint8(O1_1));title('Q4_1_1 adaptive median filter');
subplot(1,3,3);
imshow(uint8(O1_2));title('Q4_1_1 contraharmonic filter');

%% Noise removement of figure 2.
I2 = imread('Q4_1_2.tiff');
O2_1 = adaptiveMedianFilter(I2,5);
O2_2 = contraharmonicFilter(I2,-1.5);
figure;
subplot(1,3,1);
imshow(uint8(I2));title('Q4_1_2 original');
subplot(1,3,2);
imshow(uint8(O2_1));title('Q4_1_2 adaptive median filter');
subplot(1,3,3);
imshow(uint8(O2_2));title('Q4_1_2 contraharmonic filter');

%% Noise removement of figure 3.
I3 = imread('Q4_1_3.tiff');
O3_1 = adaptiveMedianFilter(I3,5);
O3_2 = contraharmonicFilter(I3,-1.5);
O3_3 = contraharmonicFilter(I3,1.5);
figure;
subplot(2,2,1);
imshow(uint8(I3));title('Q4_1_3 original');
subplot(2,2,2);
imshow(uint8(O3_1));title('Q4_1_3 adaptive median filter');
subplot(2,2,3);
imshow(uint8(O3_2));title('Q4_1_3 contraharmonic filter Q=-1.5');
subplot(2,2,4);
imshow(uint8(O3_3));title('Q4_1_3 contraharmonic filter Q=-1.5');

%% Noise removement of figure 4.
I4 = imread('Q4_1_4.tiff');
O4_1 = adaptiveMedianFilter(I4,5);    % filter salt & pepper noise
flat_part = O4_1(138:169,247:281);    % select a flat part to observe noise
var_n = var(flat_part(:));
O4_2 = adaptiveMeanFilter(O4_1,var_n,3);
figure;
subplot(1,3,1);
imshow(uint8(I4));title('Q4_1_4 origin');
subplot(1,3,2);
imshow(uint8(O4_1));title('Q4_1_3 only adaptive median filter');  % show filtered image
subplot(1,3,3); imshow(uint8(O4_2));title('Q4_1_3 both filter');
figure;
imhist(uint8(flat_part));
title('histogram of chosen flat region');    % show histogram of selected part

% mask = ones(3)/9;
% O6 = mask_conv(O4,mask);
% figure; imshow(uint8(O6));