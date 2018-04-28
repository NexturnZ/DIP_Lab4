% Smax is the maximum radius of neighborhood
function outputImage = adaptiveMedianFilter(InputImage, Smax)
s_image = size(InputImage);
s0 = 1; % initial radius of neighborhood
I_pad = zeros(2*Smax+s_image(1),2*Smax+s_image(2));
I_pad(Smax(1)+1:Smax+s_image(1),Smax+1:Smax+s_image(2)) = InputImage;
outputImage = zeros(s_image(1),s_image(2));

s = s0; % size of neighborhood
for i1 = 1:s_image(1)
   for i2 = 1:+s_image(2)
       temp = I_pad(i1+Smax-s:i1+Smax+s,i2+Smax-s:i2+Smax+s);
       zmax = max(temp(:));
       zmed = median(temp(:));
       zmin = min(temp(:));
       while (zmax<=zmed || zmin>=zmed) && s<=round(Smax/2)
            s = s+1;
            temp = I_pad(i1+Smax-s:i1+Smax+s,i2+Smax-s:i2+Smax+s);
            zmax = max(temp(:));
            zmed = median(temp(:));
            zmin = min(temp(:));
       end
       if s>Smax
          outputImage(i1,i2) = zmed;
       else
          if InputImage(i1,i2)>zmin && InputImage(i1,i2)<zmax
             outputImage(i1,i2) = InputImage(i1,i2); 
          else
              outputImage(i1,i2) = zmed;
          end
       end
   end
end
end