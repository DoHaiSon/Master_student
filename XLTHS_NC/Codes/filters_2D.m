lena = imread('lena.png');
lena_gray = double(rgb2gray(lena));
subplot(1,3,1)
imshow(uint8(lena_gray));

% gauss_filter = imgaussfilt(lena_gray, 2);   %% Built in function with 2 is std
% subplot(1,3,1);
% imshow(lena_gray);
% subplot(1,3,2);
% imshow(gauss_filter);
% subplot(1,3,3)
% imshow(gauss_filter - lena_gray);

%Window size
sz = 1;
[x,y]=meshgrid(-sz:sz,-sz:sz);

sigma = 1.5;
Gauss_kernel = 1/(2*pi*sigma^2) * exp( -(x.^2 + y.^2) / 2*sigma^2 );
gauss_fft = fft2(Gauss_kernel);
subplot(2,3,2);
imagesc(abs(fftshift(gauss_fft)));

M = size(x,1)-1;
N = size(y,1)-1;

%Initialize
Output=zeros(size(lena_gray));
%Pad the vector with zeros
lena_gray = padarray(lena_gray,[sz sz]);

%Convolution
for i = 1:size(lena_gray,1)-M
    for j = 1:size(lena_gray,2)-N
        Temp = lena_gray(i:i+M, j:j+M) .* Gauss_kernel;
        Output(i,j)=sum(Temp(:));
    end
end
%Image without Noise after Gaussian blur
Output = uint8(Output);
subplot(1,3,3);
imshow(Output);

f1 = fft2(uint8(lena_gray));
f2 = f1 * gauss_fft;
