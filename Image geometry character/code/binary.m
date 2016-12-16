function [ binary_image ] = binary( gray_image,threshold )%二值化函数，对图像的每个像素点进行二值化
row=size(gray_image,1);
col=size(gray_image,2);
binary_image=zeros(row,col);
for i=1:row
    for j=1:col
        if(gray_image(i,j)>threshold)
            binary_image(i,j)=0;
        else
            binary_image(i,j)=1;
        end
    end
end
end

