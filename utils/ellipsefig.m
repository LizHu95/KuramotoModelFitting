function [  ] = ellipsefig(w,Kc)
%% 画椭圆
%   输入：w——初始频率
%        Kc——局部临界耦合强度
%   输出：画图
t=0:0.01:2*pi;
K=Kc*cos(t);
W=w*sin(t);
plot(K,W,'r');
end

