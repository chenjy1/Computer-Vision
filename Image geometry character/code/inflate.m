function [output] = inflate(input)%膨胀
row=size(input,1);
col=size(input,2);
output=input;
for i=2:row-1
    for j=2:col-1
        around=input(i-1,j-1)+input(i-1,j)+input(i-1,j+1)+input(i,j-1)+input(i,j+1)+input(i+1,j-1)+input(i+1,j)+input(i+1,j+1);
        if around>=1%八邻域中存在一个点为1
            output(i,j)=1;%则该点为1
        end
    end
end

