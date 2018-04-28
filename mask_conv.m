function OutputImage = mask_conv(InputImage, mask)
mSize = length(mask);
s = size(InputImage);
mask_rot = rot90(mask,2);
I_pad = zeros(s(1)+2*floor(mSize/2),s(2)+2*floor(mSize/2));
I_pad(floor(mSize/2)+1:floor(mSize/2)+s(1),...
    floor(mSize/2)+1:floor(mSize/2)+s(2)) = InputImage;      % pad zeros around I
OutputImage = zeros(s(1), s(2));
for i1 = 1:s(1)
   for i2 = 1:s(2)
       temp = I_pad(i1:i1+2*floor(mSize/2),i2:i2+2*floor(mSize/2)).*mask_rot;
       OutputImage(i1,i2) = sum(temp(:));
   end
end
end