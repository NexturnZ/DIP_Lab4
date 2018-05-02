close all;clear all;
dbstop if error;
%% values initialization

I = imread('Q4_2.tif');
I = double(I);
s = size(I);            % obtain size of image

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
draw(y1shift);
%% radially inverse filtering

Hr = H;
Hr(Hr<0.01)=1;
Y2 = Ifreq./Hr;
y2 = ifft2(Y2);
y2shift = y2.*(-1).^idx;
% y2shift = y2shift(1:s(1),1:s(2));
draw(y2shift);

%% Wiener filtering

% y3 = WiennerFilter(I, H, 0.00065);
y3 = constLSFilter(I, H, 0.0001);
draw(y3);

