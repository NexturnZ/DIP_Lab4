function OutputImage = adaptiveMeanFilter(InputImage,var_n,maskRadius)
s_image = size(InputImage);
I_pad = zeros(s_image(1)+2*maskRadius,s_image(2)+2*maskRadius);
I_pad(maskRadius+1:maskRadius+s_image(1),maskRadius+1:maskRadius+s_image(2)) = InputImage;
OutputImage = zeros(s_image(1),s_image(2));

for i1 = 1:s_image(1)
   for i2 = 1:s_image(2)
       temp = I_pad(i1:i1+2*maskRadius,i2:i2+2*maskRadius);
       localMean = mean(temp(:));
       var_l = var(temp(:));
       if var_l>= var_n
          OutputImage(i1,i2) = InputImage(i1,i2)-var_n/var_l*(InputImage(i1,i2)-localMean);
       else
          OutputImage(i1,i2) = localMean;
       end
       
   end
end
end