clear all; close all;
I = imread('original_DIP.tif');
imshow(I);
I = double(I);
s = size(I);
u = 1:s(1);
v = 1:s(2);
[U,V] = meshgrid(v,u);
idx = U+V;
Ishift = I.*(-1).^idx;

T = 1; a = 0.1; b = 0.1;

H = T./(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*sin(pi*((U-s(2)/2)*a+(V-s(1)/2)*b)).*exp(-1i*pi*((U-s(2)/2)*a+(V-s(1)/2)*b));
% H = T./(pi*(U*a+V*b)).*sin(pi*(U*a+V*b)).*exp(-1i*pi*(U*a+V*b));
yshift = ifft2(H.*Ishift);
y = yshift.*(-1).^idx;
draw(y);