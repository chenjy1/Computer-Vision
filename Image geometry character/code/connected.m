function [output area] = connected(input)%计算连通域，输入为二值图像，输出为标记后的连通域和每个域的面积
row=size(input,1);
col=size(input,2);
output=input;
max_label=1;
equivalent_table=cell(0,0);%等值表，存储连通的数字
cell_num=1;

%% 
for i=2:row-1
    for j=2:col-1%对于每个像素
        if(output(i,j)==1)%如果为目标图像
            if(output(i-1,j)>0&&output(i,j-1)==0)%如果只有左邻有值
                label=output(i-1,j);%则拷贝左邻的值
            else if (output(i,j-1)>0&&output(i-1,j)==0)%如果只有上邻有值
                label=output(i,j-1);%则拷贝上邻的值
                else if(output(i-1,j)>0&&(output(i-1,j)==output(i,j-1)))%如果左邻和上邻值都大于0且相等
                    label=output(i,j-1);%则拷贝
                    else if(output(i-1,j)>0&&output(i,j-1)>0&&output(i-1,j)~=output(i,j-1))%如果都有值且不相等
                         label=output(i,j-1); %拷贝左邻
                         if(~ismember(equivalent_table{output(i,j-1),1},output(i-1,j)))%将左邻和上邻的值加入等指标
                            equivalent_table{output(i,j-1),1}=[equivalent_table{output(i,j-1),1};equivalent_table{output(i-1,j),1}];
                         end
                         if(~ismember(equivalent_table{output(i-1,j),1},output(i,j-1)))
                            equivalent_table{output(i-1,j),1}=[equivalent_table{output(i-1,j),1};equivalent_table{output(i,j-1),1}];
                         end
                        else %若左邻和上邻都为0，则给该点赋予一个新的值，并加入等值表
                            label=max_label;
                            equivalent_table{label,1}=label;
                            max_label=max_label+1;%将此时最大的值加1
                        end
                    end
                end
            end
            output(i,j)=label;%对该点赋予label的值
        end
    end
end


%% 

for i=1:size(equivalent_table,1)%对于等值表中的每一行
    equivalent_table{i,1}=unique(equivalent_table{i,1});%去重
    min_label(i)=min(equivalent_table{i,1});%用最小的label代表该行
end

for i=1:row %把每个点赋予它对应的等值表中的min_label
    for j=1:col
        label=output(i,j);
        if(label>0)
            output(i,j)=min_label(label);
        end
    end
end

labels=unique(min_label);%计算连通域的个数

area=histc(output(:),labels);%计算每个连通域所包含的点个数，记为面积

end



