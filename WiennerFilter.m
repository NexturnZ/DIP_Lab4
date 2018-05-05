function OutputImage = WiennerFilter(InputImage, H, K)
s = size(InputImage);
u = 1:s(1);
v = 1:s(2);
[U,V] = meshgrid(v,u);
idx = (U+V);
Ishift = InputImage.*((-1).^idx);  % centralize image in frequency domain
% Ishift = InputImage;

Ifreq = fft2(Ishift);   % apply fft on image

Y = 1./H.*(abs(H)).^2./((abs(H)).^2+K).*Ifreq;
OutShift = ifft2(Y);
OutputImage = OutShift.*(-1).^idx;
end