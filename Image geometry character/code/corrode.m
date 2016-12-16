function [output] = corrode(input)%腐蚀函数
row=size(input,1);
col=size(input,2);
output=input;
for i=2:row-1
    for j=2:col-1
        around=input(i-1,j-1)+input(i-1,j)+input(i-1,j+1)+input(i,j-1)+input(i,j+1)+input(i+1,j-1)+input(i+1,j)+input(i+1,j+1);
        if around<=7%八邻域中存在一个点为0
            output(i,j)=0;%则该点为0
        end
    end
end



