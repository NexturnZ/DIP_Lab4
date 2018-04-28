close all;clear all;
dbstop if error;
%% values initialization

I = imread('Q4_2.tif');
I = double(I);
s = size(I);            % obtain size of image

% I_pad = zeros(s(1)*2,s(2)*2);
% I_pad(1:s(1),1:s(2)) = I;
I_pad = I;

u = 1:s(1);
v = 1:s(2);
[U,V] = meshgrid(v,u);
idx = (U+V);
Ishift = I_pad.*((-1).^idx);  % centralize image in frequency domain

% math model for atmosphere turbulence
k = 0.0025;
H = exp(-k*((U-s(1)/2).^2+(V-s(2)/2).^2).^(5/6)); 

Ifreq = fft2(Ishift);   % apply fft on image

%% full inverse filtering

Y1 = Ifreq./H;
y1 = ifft2(Y1);
y1shift = y1.*(-1).^idx;
y1shift = y1shift(1:s(1),1:s(2));
y1_plot = abs(y1shift);
y1_plot = y1_plot/max(y1_plot(:))*255;
imshow(uint8(abs(y1_plot)));

%% radially inverse filtering

Hr = H;
Hr(Hr<0.05)=1;
Y2 = Ifreq./Hr;
y2 = ifft2(Y2);
y2shift = y2.*(-1).^idx;
y2shift = y2shift(1:s(1),1:s(2));
y2_plot = abs(y2shift);
y2_plot = y2_plot/max(y2_plot(:))*255;
figure;
imshow(uint8(abs(y2_plot)));

%% Wiener filtering

K=1e6;
Y3 = 1./H*(abs(H)).^2/((abs(H)).^2+K)*Ifreq;
y3 = ifft2(Y3);

y3_plot = abs(y3);
y3_plot = y3_plot/max(y3_plot(:))*255;
figure;
imshow(uint8(abs(y3_plot)));





