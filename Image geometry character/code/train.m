
clc
clear

name='..\images\3.jpg';%改变数字为1，2或3，为训练图像
img=imread(name);
subplot(221),imshow(img);title('original image')%显示原图

gray=img(:,:,2);%选取RGB图像的一个通道作为灰度图像
binary_image=binary(gray,150);%对图像以140为阈值进行二值化

subplot(222),imshow(binary_image);title('binary image')%显示二值化图像

corrode_image=inflate(binary_image);%先膨胀后腐蚀去除孔洞
corrode_image=corrode(corrode_image);
corrode_image=corrode(corrode_image);%先腐蚀后膨胀去除噪点
corrode_image=inflate(corrode_image);
inflate_image=inflate(corrode_image);%中间几次腐蚀膨胀去除孔洞和噪声，对边界进行平滑
inflate_image=inflate(inflate_image);
inflate_image=inflate(inflate_image);
corrode_image=corrode(inflate_image);
corrode_image=corrode(corrode_image);
corrode_image=corrode(corrode_image);
corrode_image=inflate(corrode_image);
corrode_image=corrode(corrode_image);

subplot(223),imshow(corrode_image);title('after open and close')%显示腐蚀膨胀后的图片
[connect area]=connected(corrode_image);%对图像进行连通域分割，connect代表分割后的图像矩阵，area代表每个连通域的面积构成的向量
perimeter=boundary(connect);%对每个连通域进行边界跟踪，perimeter代表每个连通域的周长构成的向量
ratio=perimeter.^2./area;%计算每个连通域的紧密度，以此作为特征对不同形状的图像进行识别

