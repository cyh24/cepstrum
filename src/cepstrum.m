I = imread('D:\\10.jpg');         
% 读入图像
I = rgb2gray(I);
    

subplot(2,3,1),imshow(I); 
title('原始图像');           
  
subplot(2,3,2),imhist(I);axis([0 255 0 255]);     %显示图像灰度直方图

FI = abs((fft2(I)));  
NFI = 255*mat2gray(FI);  

%归一化 
SFI = fftshift(NFI);  
subplot(2,3,3),imshow(SFI); 
title('FFT');  

cep = ifftshift(ifft2(log(FI)));
subplot(2,3,4), imshow(cep);
title('cepturm');


E = 0;
E0 = 0.001;
[row col]=size(cep);
for T = 0:0.001:1
    E = 0;
    for i = 1:row
        for j=1:col
            if cep(i,j)>=T
                c = 1;
            else
                c = 0;
            end
            E = E + sqrt( (i-(row/2)).^2 + (j-(col/2)).^2 )*c/(row*col);
        end
    end
    
    if E < E0
        break;
    end
end
T
E
score = (1-T)*100%