function OutputImage = contraharmonicFilter(InputImage,Q)
iSize = size(InputImage);   % obtian image size
wRadius = 1;                % window size 3
I_pad = zeros(iSize(1)+2*wRadius,iSize(2)+2*wRadius);
I_pad(2:end-1,2:end-1) = InputImage;
OutputImage = zeros(iSize(1),iSize(2));

for i1 = 1:iSize(1)
   for i2 = 1:iSize(2) 
       temp = I_pad(i1:i1+2*wRadius,i2+2*wRadius);
       OutputImage(i1,i2) = sum(temp(:).^(Q+1))/sum(temp(:).^Q);
   end
end
end


