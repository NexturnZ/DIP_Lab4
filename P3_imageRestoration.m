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
H = T./(pi*(U*a+V*b)).*sin(pi*(U*a+V*b)).*exp(-1i*pi*(U*a+V*b));

I3shift = I3.*(-1).^idx;    % centralize in frequency domain
I3freq = fft2(I3shift);     % map image to frequency domain
O3freq = I3freq.*H;         % remove channel from image in frequency domain
O3 = ifft2(O3freq);
% O3 = O3shift.*(-1).^idx;    % undo centralization

% O3plot = O3-min(O3(:));
O3plot = abs(O3);
O3plot = O3plot/max(O3plot(:))*255;
figure; imshow(uint8(O3plot));

%% filter salt & pepper noise from Q4_3_1.
O1_1 = adaptiveMedianFilter(I1,5);
figure;imshow(uint8(O1_1));
