function [  ] = ellipsefig(w,Kc)
%% ����Բ
%   ���룺w������ʼƵ��
%        Kc�����ֲ��ٽ����ǿ��
%   �������ͼ
t=0:0.01:2*pi;
K=Kc*cos(t);
W=w*sin(t);
plot(K,W,'r');
end

