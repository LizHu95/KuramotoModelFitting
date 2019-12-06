function [ W1,W2,W3,not_good] = CubicEqu2(w1,w2,w3,k)
%% 三次方程求解
%   此处显示详细说明

M=w1+w2;
N=w3-w2;
L=k^2;
a=2*N;
b=2*(L-N*w3)-M*N-L;
c=-M*(L-N*w3)+L*w3;
delta=b^2-4*a*c;

p=[a b c];
W1=[];
W2=[];
W3=[];
not_good=1;
if delta>0
    W2=roots(p);
    W1=W2;
    W3=L/(W2-w3)+w3;    
    not_good=0;
end

end