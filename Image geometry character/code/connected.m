function [output area] = connected(input)%������ͨ������Ϊ��ֵͼ�����Ϊ��Ǻ����ͨ���ÿ��������
row=size(input,1);
col=size(input,2);
output=input;
max_label=1;
equivalent_table=cell(0,0);%��ֵ���洢��ͨ������
cell_num=1;

%% 
for i=2:row-1
    for j=2:col-1%����ÿ������
        if(output(i,j)==1)%���ΪĿ��ͼ��
            if(output(i-1,j)>0&&output(i,j-1)==0)%���ֻ��������ֵ
                label=output(i-1,j);%�򿽱����ڵ�ֵ
            else if (output(i,j-1)>0&&output(i-1,j)==0)%���ֻ��������ֵ
                label=output(i,j-1);%�򿽱����ڵ�ֵ
                else if(output(i-1,j)>0&&(output(i-1,j)==output(i,j-1)))%������ں�����ֵ������0�����
                    label=output(i,j-1);%�򿽱�
                    else if(output(i-1,j)>0&&output(i,j-1)>0&&output(i-1,j)~=output(i,j-1))%�������ֵ�Ҳ����
                         label=output(i,j-1); %��������
                         if(~ismember(equivalent_table{output(i,j-1),1},output(i-1,j)))%�����ں����ڵ�ֵ�����ָ��
                            equivalent_table{output(i,j-1),1}=[equivalent_table{output(i,j-1),1};equivalent_table{output(i-1,j),1}];
                         end
                         if(~ismember(equivalent_table{output(i-1,j),1},output(i,j-1)))
                            equivalent_table{output(i-1,j),1}=[equivalent_table{output(i-1,j),1};equivalent_table{output(i,j-1),1}];
                         end
                        else %�����ں����ڶ�Ϊ0������õ㸳��һ���µ�ֵ���������ֵ��
                            label=max_label;
                            equivalent_table{label,1}=label;
                            max_label=max_label+1;%����ʱ����ֵ��1
                        end
                    end
                end
            end
            output(i,j)=label;%�Ըõ㸳��label��ֵ
        end
    end
end


%% 

for i=1:size(equivalent_table,1)%���ڵ�ֵ���е�ÿһ��
    equivalent_table{i,1}=unique(equivalent_table{i,1});%ȥ��
    min_label(i)=min(equivalent_table{i,1});%����С��label�������
end

for i=1:row %��ÿ���㸳������Ӧ�ĵ�ֵ���е�min_label
    for j=1:col
        label=output(i,j);
        if(label>0)
            output(i,j)=min_label(label);
        end
    end
end

labels=unique(min_label);%������ͨ��ĸ���

area=histc(output(:),labels);%����ÿ����ͨ���������ĵ��������Ϊ���

end



