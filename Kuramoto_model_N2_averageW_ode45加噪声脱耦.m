clear,clc
addpath('D:\code\matlab代码\Kuramoto model\utils');
N=2;                  %振子数
K=linspace(0.1,0.4,5);    %耦合强度
%K=[K,linspace(1,2,125)];
TT=5000;               %为消除暂态，先运动TT时间
T=1000;                %观察T时间内运动情况
theta0=linspace(0,2*pi-2*pi/N,N);       %初始相位
reltol=1e-6;            %相对误差   
abstol=1e-8;           %绝对误差
data=load('D:\code\matlab代码\Kuramoto model\N100TT50000T100000LinearDisK环_Kc.mat','w','d_theta','K');
w=[data.w(30),data.w(71)];       %初始频率

%% 求解微分方程
SN=200;
disp(['SN=',num2str(SN)]);
tic
for j=1:length(K)
    tic
%     % 高斯噪声
%     f=@(t,theta)[awgn(w(1)+K(j)*(sin(theta(2)-theta(1))),SN);
%        awgn(w(2)+K(j)*(sin(theta(1)-theta(2))),SN)];
    %随机噪声
    f=@(t,theta)[w(1)+K(j)*(sin(theta(2)-theta(1))+SN*(2*rand(1)-1));w(2)+K(j)*(sin(theta(1)-theta(2))+SN*(2*rand(1)-1))];
    options=odeset('RelTol',reltol,'AbsTol',abstol);
    [t,theta]=ode45(f,[0,TT],theta0,options);
%     [t,theta]=ode45(f,[0,T],theta(end,:),options);
    [t,theta]=rk_4(f,[0,T,0.01],theta(end,:));
    d_theta(:,j)=(theta(end,:)-theta(1,:))/T;
    toc
    disp(['为第',num2str(j),'个K运行时间']);
end
toc
disp('为总运行时间');
save('N2TT5000T1000tt001K10_初始频率4_加随机噪声200','N','K','w','d_theta','T','TT','SN');

%% 画分岔树
%% 画真实K.vs.w曲线
figure;
for i=30
    plot(data.K,data.d_theta(i,:),'b');
    %scatter(K,d_theta(i,:),1,'b');
    hold on;
end
axis([0 0.6 -1 1 ]);xlabel('耦合强度：K');ylabel('平均频率：w');

data2=load('N2TT5000T1000K100直线_ode45_初始频率4.mat','K','d_theta');
for i=2
    hold on;
    plot(data2.K,data2.d_theta(i,:),'g');
    %scatter(K,d_theta(i,:),1,'b');
end
%% 加噪声模拟K.vs.w曲线
for i=1
    %plot(K(1:13),d_theta(i,:),'b');
    scatter(K(1:9),d_theta(i,:),5,'r');
    hold on;
end
