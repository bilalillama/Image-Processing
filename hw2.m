%BILAL AHMED (6004)
%load image and display
img = imread('IDPicture.bmp');
figure
subplot(1,2,1)
imshow(img), title('Image');
subplot(1,2,2)
imhist(img), title('Image Histogram');

red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);
intensity = 0.299*red + 0.587*green + 0.114*blue;
figure
subplot(1,2,1)
imshow(intensity), title('Intensity image');
subplot(1,2,2)
imhist(intensity), title('Intensity histogram');

equalization = histeq(img);
figure
subplot(1,2,1)
imshow(equalization), title('Equalized image');
subplot(1,2,2)
imhist(equalization, 64), title('Equalized histogram');

contrast = imadjust(intensity);
figure
subplot(1,2,1)
imshow(contrast), title('contrast');
subplot(1,2,2)
imhist(contrast), title('Contrast histogram');

hor_1x2 = [-1 1];
vert_1x2 = [1; -1];
Gx_1x2 = abs(conv2(intensity, hor_1x2, 'same')/255);
Gy_1x2 = abs(conv2(intensity, vert_1x2, 'same')/255);
G_1x2 = Gx_1x2 + Gy_1x2;
figure
subplot(2,2,1)
imshow(Gx_1x2), title('Horizontal Gradient 1x2');
subplot(2,2,2)
imshow(Gy_1x2), title('Vertical Gradient 1x2');
subplot(2,2,3)
imshow(G_1x2), title('Combined Gradient 1x2');

sobel_hor = [-1 0 1; -2 0 2; -1 0 1];
sobel_vert = [1 2 1; 0 0 0; -1 -2 -1];
sobel_Gx = abs(conv2(intensity, sobel_hor, 'same')/255);
sobel_Gy = abs(conv2(intensity, sobel_vert, 'same')/255);
sobel_G = sobel_Gx + sobel_Gy;
figure
subplot(2,2,1)
imshow(sobel_Gx), title('Horizontal Gradient Sobel');
subplot(2,2,2)
imshow(sobel_Gy), title('Vertical Gradient Sobel');
subplot(2,2,3)
imshow(sobel_G), title('Combined Gradient Sobel');

figure
subplot(2,2,1)
imhist(G_1x2), title('1x2');
subplot(2,2,2)
imhist(sobel_G), title('sobel');

maxVal_sobel = 0.9;
maxVal_1x2 = 0.1;
zero = 0;

G_1x2(G_1x2 <= maxVal_1x2) = zero;
sobel_G(sobel_G <= maxVal_sobel) = zero;

figure
subplot(2,2,1)
imshow(G_1x2), title('1x2');
subplot(2,2,2)
imshow(sobel_G), title('sobel');

red_sobel_hor = abs(conv2(red, sobel_hor, 'same')/255);
red_sobel_vert = abs(conv2(red, sobel_vert, 'same')/255);
red_sobel = red_sobel_hor + red_sobel_vert;
green_sobel_hor = abs(conv2(green, sobel_hor, 'same')/255);
green_sobel_vert = abs(conv2(green, sobel_vert, 'same')/255);
green_sobel = green_sobel_hor + green_sobel_vert;
blue_sobel_hor = abs(conv2(blue, sobel_hor, 'same')/255);
blue_sobel_vert = abs(conv2(blue, sobel_vert, 'same')/255);
blue_sobel = blue_sobel_hor + blue_sobel_vert;
color_sobel(:,:,1) = red_sobel;
color_sobel(:,:,2) = green_sobel;
color_sobel(:,:,3) = blue_sobel;
figure
subplot(2,2,1)
imshow(red_sobel), title('red');
subplot(2,2,2)
imshow(green_sobel), title('green');
subplot(2,2,3)
imshow(blue_sobel), title('blue');
subplot(2,2,4)
imshow(color_sobel), title('color sobel');