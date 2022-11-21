function g = hist_eq(imname)

f_in = double(imread(imname)); %load image
f = f_in(:,:,1); %in case of color, just work with one component

[mr,mc] = size(f);
m = mr*mc; %total number of pixels
g = zeros(mr,mc);

%start with integer intensities range from 0 to 255
f = floor(f);
L = 256; %number of intensity levels

%define histogram
p = zeros(L,1);
for i = 1:mr
   for j = 1:mc
      p(f(i,j)+1) = p(f(i,j)+1) + 1/m;
   end
end

%histogram equalization
for i = 1:mr
   for j = 1:mc
      g(i,j) = (L-1)*sum(p(1:f(i,j)+1));
   end
end
g = floor(g); %round down to nearest integer

%compute histogram of g
q = zeros(L,1);
for i = 1:mr
   for j = 1:mc
      q(g(i,j)+1) = q(g(i,j)+1) + 1/m;
   end
end

%plot stuff

%full grayscale map for L intensities
cmap = zeros(L,3);
cmap(:,1) = [0:(1/(L-1)):1]';
cmap(:,2) = [0:(1/(L-1)):1]';
cmap(:,3) = [0:(1/(L-1)):1]';
figure(8)

%axis parameters
XMIN = 0; XMAX = L; YMIN = 0; YMAX = max(p);

%plot images and histograms
subplot(2,2,1); image(f); colormap(cmap); title('original image'); axis off;
subplot(2,2,2); bar(0:L-1,p); title('original histogram'); axis([XMIN XMAX YMIN YMAX]);
subplot(2,2,3); image(g); colormap(cmap); title('transformed image'); axis off;
subplot(2,2,4); bar(0:L-1,q); title('transformed histogram'); axis([XMIN XMAX YMIN YMAX]);

      
      
      
      
