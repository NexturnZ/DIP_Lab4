% clear all; close all;
I = imread('original_DIP.tif');
imshow(I);
I = double(I);
s = size(I);
u = 1:s(1);
v = 1:s(2);
[U,V] = meshgrid(v,u);
idx = U+V;
% Ishift = I.*(-1).^idx;
Ishift = I;
Ifreq = fft2(Ishift);

T = 1; a = 0.01; b = 0.01;
% H = T./(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*sin(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*exp(-1i*pi*((U-s(2)/2)*a+(V-s(1)/2)*b));
H = T./(pi*(U*a+V*b)).*sin(pi*(U*a+V*b)).*exp(-1i*pi*(U*a+V*b));
y = ifft2(H.*Ifreq);
% y = yshift.*(-1).^idx;
draw(y);
