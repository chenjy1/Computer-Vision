
clc
clear

name='..\images\3.jpg';%�ı�����Ϊ1��2��3��Ϊѵ��ͼ��
img=imread(name);
subplot(221),imshow(img);title('original image')%��ʾԭͼ

gray=img(:,:,2);%ѡȡRGBͼ���һ��ͨ����Ϊ�Ҷ�ͼ��
binary_image=binary(gray,150);%��ͼ����140Ϊ��ֵ���ж�ֵ��

subplot(222),imshow(binary_image);title('binary image')%��ʾ��ֵ��ͼ��

corrode_image=inflate(binary_image);%�����ͺ�ʴȥ���׶�
corrode_image=corrode(corrode_image);
corrode_image=corrode(corrode_image);%�ȸ�ʴ������ȥ�����
corrode_image=inflate(corrode_image);
inflate_image=inflate(corrode_image);%�м伸�θ�ʴ����ȥ���׶����������Ա߽����ƽ��
inflate_image=inflate(inflate_image);
inflate_image=inflate(inflate_image);
corrode_image=corrode(inflate_image);
corrode_image=corrode(corrode_image);
corrode_image=corrode(corrode_image);
corrode_image=inflate(corrode_image);
corrode_image=corrode(corrode_image);

subplot(223),imshow(corrode_image);title('after open and close')%��ʾ��ʴ���ͺ��ͼƬ
[connect area]=connected(corrode_image);%��ͼ�������ͨ��ָconnect����ָ���ͼ�����area����ÿ����ͨ���������ɵ�����
perimeter=boundary(connect);%��ÿ����ͨ����б߽���٣�perimeter����ÿ����ͨ����ܳ����ɵ�����
ratio=perimeter.^2./area;%����ÿ����ͨ��Ľ��ܶȣ��Դ���Ϊ�����Բ�ͬ��״��ͼ�����ʶ��

