function [ binary_image ] = binary( gray_image,threshold )%��ֵ����������ͼ���ÿ�����ص���ж�ֵ��
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

