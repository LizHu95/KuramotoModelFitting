clear,clc
addpath('D:\code\matlab代码\Kuramoto model\utils');
K=linspace(0,1.2,200);
T=10000;
theta0=linspace(0,2*pi-2*pi/3,3);
reltol=1e-8;
abstol=1e-10;
N=3;
w=[-0.3,-0.6,0.8];
%% 求解微分方程
tic
for j=1:length(K)
    f=@(t,theta)[w(1)+K(j)*sin(theta(2)-theta(1));
        w(2)+K(j)*(sin(theta(3)-theta(2))+sin(theta(1)-theta(2)));
        w(3)+K(j)*sin(theta(2)-theta(3))];
    options=odeset('RelTol',reltol,'AbsTol',abstol);
    [t,theta]=ode45(f,[0,2000],theta0,options);
    [t,theta]=ode45(f,[0,T],theta(end,:),options);
    dtheta(:,j)=(theta(end,:)-theta(1,:))/T;
end
toc

%% RG方法求解平均频率
tic
for j=2:length(K)
    [ W1{j},W2{j},W3{j},not_good(j) ] = CubicEqu(w(1),w(2),w(3),K(j));
    if(not_good(j)==1)
        break;
    end
end
toc

index_part1=j;
if (dtheta(3,index_part1)-dtheta(2,index_part1))<(dtheta(2,index_part1)-dtheta(1,index_part1))
    ww(3)=w(1);
    ww(2)=w(2);
    ww(1)=w(3);
else
    ww=w;
end

tic
for j=index_part1:length(K)
    [ W3{j},W2{j},W1{j},not_good(j) ] = CubicEqu2(ww(1),ww(2),ww(3),K(j));
    if(not_good(j)==1)
        index_part2=j;
        break;
    end
end
toc
%save('data_RG_N3.mat','w','dtheta','W1','W2','W3','K','WW1','WW2','WW3','qq');
