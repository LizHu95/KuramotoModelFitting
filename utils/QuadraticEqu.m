function [ W1,W2] = QuadraticEqu(w1,w2,k)
%% 三次方程求解
%   此处显示详细说明

a=1;
b=w2-w1;
c=k^2;
delta=b^2-4*a*c;

p=[a b c];
W1=[];
W2=[];

if delta>0
    delta_W2=roots(p);
    W2=delta_W2+w2;
    W1=(k^2)/(W2-w1)+w1;    
end

end