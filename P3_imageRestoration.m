clear all; close all;
dbstop if error;
%% initialization
I1 = double(imread('Q4_3_1.tiff'));
I2 = double(imread('Q4_3_2.tiff'));
I3 = double(imread('Q4_3_3.tiff')); % obtain images
% figure;title('Q4_3_1');
% imshow(uint8(I1));
% figure;title('Q4_3_2');
% imshow(uint8(I2));
% figure;title('Q4_3_3');
% imshow(uint8(I3));
s = size(I1);               % obtain size

u = 1:s(2);
v = 1:s(1);
[U,V] = meshgrid(u,v);
idx = U+V;                  % obtain index

T = 1;
a = 0.1;
b = 0.1;                      % obtain channel parameters
%% restore Q4_3_3.
H = T./(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*sin(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*exp(-1i*pi*((U-s(2)/2)*a+(V-s(1)/2)*b));
% H = T./(pi*(U*a+V*b)).*sin(pi*(U*a+V*b)).*exp(-1i*pi*(U*a+V*b));
% mesh(abs(H));
Hr = H;
Hr(Hr<0.05) = 1;

I3shift = I3.*(-1).^idx;    % centralize in frequency domain
I3freq = fft2(I3shift);     % map image to frequency domain

% I3freq_plot = abs(I3freq);
% I3freq_plot = I3freq_plot/max(I3freq_plot(:))*255;
% figure;imshow(I3freq_plot);

Y3freq = I3freq./H;         % remove channel from image in frequency domain
Y3shift = ifft2(Y3freq);
Y3 = Y3shift.*(-1).^idx;    % undo centralization

Y3plot = abs(Y3);
Y3plot = Y3plot/max(Y3plot(:))*255;
figure; imshow(uint8(Y3plot));

%% filter salt & pepper noise from Q4_3_1.
% O1_1 = adaptiveMedianFilter(I1,5);
% figure;imshow(uint8(O1_1));
