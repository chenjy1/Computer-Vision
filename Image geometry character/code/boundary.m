function [ mark ] = boundary( input )%8��ͨ����ͨ�ɷ�˳�����㷨������Ϊ��Ǻ���ͨ���ͼ�����Ϊÿ������ܳ����ɵ�����
row=size(input,1);%��
col=size(input,2);%��
output=input;%����������С��ͬ
round=[0,-1;-1,-1;-1,0;-1,+1;0,+1;+1,+1;+1,0;+1,-1];%8��ͨ����

num=[];
s=[];
%% ��������ң����ϵ��£�ÿ�������µ���ͨ��ĵ�һ��λ�ã�����s�У�numΪ���Ӧ������

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
for i=1:size(s,1)%��ÿ��������λ�ÿ�ʼѰ��
    visited=[];%���ڼ�¼�ѷ��ʹ��ĵ�
    c=[0,0];%���ڼ�¼��ʱ���ʵĵ�
    round_new=round;%˳ʱ����������Ӧ������
    b=[s(i,1),s(i,2)-1];%��ʼ��west���ĵ㣬��Ϊǰһ����
    output(b(1),b(2))=0;
    visited=[-1,-1];
    while(c(1)~=s(i,1)||c(2)~=s(i,2))%����ʱΧ�Ƶ����ĵ㲻�ǳ�ʼ��ʱ
        if(c==0)%����ǵ�һ��
            c(1)=s(i,1);%�����ʼ��
            c(2)=s(i,2);
        end
        for k=1:8 %����˳ʱ���ÿ�����
            x=c(1)+round_new(k,1);%����Ҫ���ʵ��λ��
            y=c(2)+round_new(k,2);
            n=output(x,y);%�õ��õ��ֵ
            d=[x,y];%�õ������
            if(n==num(i))%����õ����ڲ���
                if(~ismember(d,visited,'rows'))%���δ�����ʹ�
                    c=d;%һ�λ��У�����c
                    sub=b-c;%�����ʱ��Ӧ��˳ʱ��ķ�λ
                    loc=find(ismember(round,sub,'rows'));%�ҵ��÷�λ��˳ʱ�������ж�Ӧ��λ��
                    round_new=circshift(round,8-loc);%��˳ʱ��������ת��Ӧ�ĽǶ�
                    mark(i)=mark(i)+1;%���ܳ��ļ�����1
                    visited=[visited;c];%��c������ʹ������ĵ����
                     break;%�����õ��˳ʱ��ѭ��
                end
            end 
            b=d;%������bΪ���ʹ��ĵ㣬��Ϊ��һ��ѭ����ǰһ����
        end
         if(b==s(i,:))%���b�ص��˳�ʼ��
             c=[0,0];%��c��0
         break;%����whileѭ��
         end
    end
end
end

