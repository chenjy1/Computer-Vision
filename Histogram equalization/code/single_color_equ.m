%对各个通道各自直方图均衡化

%read the image
image=imread('..\images\4.jpg');

%substract R,G,B channel
R0=image(:,:,1);
G0=image(:,:,2);
B0=image(:,:,3);

%turn the uint8 into double 
R1=im2double(R0);
G1=im2double(G0);
B1=im2double(B0);

%caculate the ratio of each channel
r=R1./(R1+G1+B1);
g=G1./(R1+G1+B1);
b=B1./(R1+G1+B1);

%convert the rgb into gray
gray=0.299*R1+0.587*G1+0.114*B1;
gray1=im2uint8(gray);

R2=zeros(1,256);
G2=zeros(1,256);
B2=zeros(1,256);
gray2=zeros(1,256);

%caculate the histgram of each channel
for i=1:size(image,1)
    for j=1:size(image,2)
        R2(R0(i,j)+1)=R2(R0(i,j)+1)+1;
        G2(G0(i,j)+1)=G2(G0(i,j)+1)+1;
        B2(B0(i,j)+1)=B2(B0(i,j)+1)+1;
        gray2(gray1(i,j)+1)=gray2(gray1(i,j)+1)+1;
    end
end
figure(1)
hold on
plot(R2,'r')
plot(G2,'g')
plot(B2,'b')
plot(gray2,'k')
legend('R','G','B','gray');
hold off

%caculate the cumulative distribution of each channel
for i=1:256
    if i==1
        R3(i)=R2(i);
        G3(i)=G2(i);
        B3(i)=B2(i);
        gray3(i)=gray2(i)
    else
        R3(i)=R3(i-1)+R2(i);
        G3(i)=G3(i-1)+G2(i);
        B3(i)=B3(i-1)+B2(i);
        gray3(i)=gray3(i-1)+gray2(i);
    end
end
figure(2)
hold on
image_size=size(R0,1)*size(R0,2);
R3=R3./image_size;
G3=G3./image_size;
B3=B3./image_size;
gray3=gray3./image_size;
plot(R3,'r')
plot(G3,'g')
plot(B3,'b')
plot(gray3,'k')
legend('R','G','B','gray');
hold off

R4=uint8(255.*R3+0.5);
G4=uint8(255.*G3+0.5);
B4=uint8(255.*B3+0.5);
gray4=uint8(255.*gray3+0.5);

%caculate the compensation transfer function
R5=zeros(size(R0));
G5=zeros(size(G0));
B5=zeros(size(B0));
gray5=zeros(size(R0));
for i=1:size(R0,1)
    for j=1:size(R0,2)
        R5(i,j)=R4(R0(i,j)+1);
        G5(i,j)=G4(G0(i,j)+1);
        B5(i,j)=B4(B0(i,j)+1);
        gray5(i,j)=gray4(gray1(i,j)+1);
    end
end
figure(3);
imshow(image);
equalized=zeros(size(R0,1),size(R0,2),3);
equalized(:,:,1)=R5;
equalized(:,:,2)=G5;
equalized(:,:,3)=B5;
% 
equalized=uint8(equalized);
figure(4)
imshow(equalized)
% 
%         

        
