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

%% restore Q4_3_3.
s = size(I3);               % obtain size
I3pad = zeros(s(1),s(2));
I3pad(1:s(1), 1:s(2)) = I3;
spad = size(I3pad);
u = 1:spad(1);
v = 1:spad(2);
[U,V] = meshgrid(v,u);
T = 1;
a = 0.1;
b = 0.1;                    % obtain channel parameters

K=0.0025;

H = T./(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*sin(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*exp(-1i*pi*((U-s(2)/2)*a+(V-s(1)/2)*b));
% H = H/max(H(:));
% H = T./(pi*(U*a+V*b)).*sin(pi*(U*a+V*b)).*exp(-1i*pi*(U*a+V*b));
mesh(abs(H));

y3 = WiennerFilter(I3, H, 0.0001);
% y3 = constLSFilter(I3, H, 1);
draw(y3);

%% filter salt & pepper noise from Q4_3_1.
% O1_1 = adaptiveMedianFilter(I1,5);
% figure;imshow(uint8(O1_1));
