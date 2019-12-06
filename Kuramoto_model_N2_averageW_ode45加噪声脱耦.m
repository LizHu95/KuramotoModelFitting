clear,clc
addpath('D:\code\matlab����\Kuramoto model\utils');
N=2;                  %������
K=linspace(0.1,0.4,5);    %���ǿ��
%K=[K,linspace(1,2,125)];
TT=5000;               %Ϊ������̬�����˶�TTʱ��
T=1000;                %�۲�Tʱ�����˶����
theta0=linspace(0,2*pi-2*pi/N,N);       %��ʼ��λ
reltol=1e-6;            %������   
abstol=1e-8;           %�������
data=load('D:\code\matlab����\Kuramoto model\N100TT50000T100000LinearDisK��_Kc.mat','w','d_theta','K');
w=[data.w(30),data.w(71)];       %��ʼƵ��

%% ���΢�ַ���
SN=200;
disp(['SN=',num2str(SN)]);
tic
for j=1:length(K)
    tic
%     % ��˹����
%     f=@(t,theta)[awgn(w(1)+K(j)*(sin(theta(2)-theta(1))),SN);
%        awgn(w(2)+K(j)*(sin(theta(1)-theta(2))),SN)];
    %�������
    f=@(t,theta)[w(1)+K(j)*(sin(theta(2)-theta(1))+SN*(2*rand(1)-1));w(2)+K(j)*(sin(theta(1)-theta(2))+SN*(2*rand(1)-1))];
    options=odeset('RelTol',reltol,'AbsTol',abstol);
    [t,theta]=ode45(f,[0,TT],theta0,options);
%     [t,theta]=ode45(f,[0,T],theta(end,:),options);
    [t,theta]=rk_4(f,[0,T,0.01],theta(end,:));
    d_theta(:,j)=(theta(end,:)-theta(1,:))/T;
    toc
    disp(['Ϊ��',num2str(j),'��K����ʱ��']);
end
toc
disp('Ϊ������ʱ��');
save('N2TT5000T1000tt001K10_��ʼƵ��4_���������200','N','K','w','d_theta','T','TT','SN');

%% ���ֲ���
%% ����ʵK.vs.w����
figure;
for i=30
    plot(data.K,data.d_theta(i,:),'b');
    %scatter(K,d_theta(i,:),1,'b');
    hold on;
end
axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');

data2=load('N2TT5000T1000K100ֱ��_ode45_��ʼƵ��4.mat','K','d_theta');
for i=2
    hold on;
    plot(data2.K,data2.d_theta(i,:),'g');
    %scatter(K,d_theta(i,:),1,'b');
end
%% ������ģ��K.vs.w����
for i=1
    %plot(K(1:13),d_theta(i,:),'b');
    scatter(K(1:9),d_theta(i,:),5,'r');
    hold on;
end
