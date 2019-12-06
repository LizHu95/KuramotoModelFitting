function [ W1,W2,W3,not_good] = CubicEqu(w1,w2,w3,k)
%% 三次方程求解
%   此处显示详细说明

M=w1-w2;
N=w3-w2;
R=1/(k^2);
a=M*N*(R^2);
b=-a*(M+N);
c=(M^2)*(N^2)*(R^2)+2*M*N*R-1;
d=(M+N)*(1-M*N*R);
A=b^2-3*a*c;
B=b*c-9*a*d;
C=c^2-3*b*d;
delta=B^2-4*A*C;

p=[a b c d];
W1=[];
W2=[];
W3=[];
not_good=1;
if delta<0
    delta_W2=roots(p);
    W2=delta_W2+w2;
    W1=(k^2)/(W2-w1)+w1;
    W3=(k^2)/(W2-w3)+w3;   
    not_good=0;
end


end

