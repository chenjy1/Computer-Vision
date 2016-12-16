function [ mark ] = boundary( input )%8连通的连通成分顺序标记算法，输入为标记好连通域的图像，输出为每个域的周长构成的向量
row=size(input,1);%行
col=size(input,2);%列
output=input;%输出与输入大小相同
round=[0,-1;-1,-1;-1,0;-1,+1;0,+1;+1,+1;+1,0;+1,-1];%8连通矩阵

num=[];
s=[];
%% 计算从左到右，从上到下，每次遇到新的连通域的第一个位置，存入s中，num为其对应的数字

for i=1:row
    for j=1:col
        if(output(i,j)>0)
            if(~ismember(output(i,j),num))
                s=[s;i,j];
                num=[num;output(i,j)];
            end
        end
    end
end

%% 

mark=zeros(size(s,1),1);
for i=1:size(s,1)%从每个域的最初位置开始寻找
    visited=[];%用于记录已访问过的点
    c=[0,0];%用于记录此时访问的点
    round_new=round;%顺时针序列所对应的数组
    b=[s(i,1),s(i,2)-1];%开始点west处的点，即为前一个点
    output(b(1),b(2))=0;
    visited=[-1,-1];
    while(c(1)~=s(i,1)||c(2)~=s(i,2))%当此时围绕的中心点不是初始点时
        if(c==0)%如果是第一次
            c(1)=s(i,1);%赋予初始点
            c(2)=s(i,2);
        end
        for k=1:8 %对于顺时针的每个情况
            x=c(1)+round_new(k,1);%计算要访问点的位置
            y=c(2)+round_new(k,2);
            n=output(x,y);%得到该点的值
            d=[x,y];%该点的坐标
            if(n==num(i))%如果该点是内部点
                if(~ismember(d,visited,'rows'))%如果未被访问过
                    c=d;%一次击中，存入c
                    sub=b-c;%计算此时对应的顺时针的方位
                    loc=find(ismember(round,sub,'rows'));%找到该方位在顺时针数组中对应的位置
                    round_new=circshift(round,8-loc);%将顺时针数组旋转对应的角度
                    mark(i)=mark(i)+1;%将周长的计数加1
                    visited=[visited;c];%将c加入访问过的中心点矩阵
                     break;%跳出该点的顺时针循环
                end
            end 
            b=d;%否则，另b为访问过的点，即为下一次循环的前一个点
        end
         if(b==s(i,:))%如果b回到了初始点
             c=[0,0];%则将c置0
         break;%跳出while循环
         end
    end
end
end

