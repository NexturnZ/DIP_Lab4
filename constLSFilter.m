
function OutputImage = constLSFilter(InputImage, H, gama)

s = size(InputImage);
u = 1:s(1);
v = 1:s(2);
[U,V] = meshgrid(v,u);
idx = (U+V);

Ishift = InputImage.*((-1).^idx);  % centralize image in frequency domain
Ifreq = fft2(Ishift);


mask = [0,-1,0;-1,4,-1;0,-1,0];
maskpad= zeros(s(1),s(2));
maskpad(1:3,1:3) = mask;
maskShift = maskpad.*(-1).^idx;
Mfreq = fft2(maskShift);

Y = conj(H).*Ifreq./(abs(H).^2+gama*abs(Mfreq).^2);
yshift = ifft2(Y);
OutputImage = yshift.*(-1).^idx;
end