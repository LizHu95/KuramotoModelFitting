clear,clc
addpath('./utils');
K=linspace(0,1,200);
T=500;
theta0=[0,pi];
reltol=1e-6;
abstol=1e-8;
N=2;

%% distribution:
%   distri=0:    linearly distribution
%   distri=1     random-uniform distribution
%   distri=2     truncated random-Gaussian distribution
distri=2;

if distri==0
    w=linspace(-1,1,N);
elseif distri==1
    w=2*rand(1,N)-1;
    w=sort(w);
else
    w=TruncatedGaussian( N,[-1,1] );
    w=sort(w);
end

%% 求解微分方程
for j=1:length(K)
    f=@(t,theta)[w(1)+K(j)*sin(theta(2)-theta(1));
        w(2)+K(j)*sin(theta(1)-theta(2))];
    options=odeset('RelTol',reltol,'AbsTol',abstol);
    [t,theta]=ode45(f,[0,500],theta0,options);
    [t,theta]=ode45(f,[0,T],theta(end,:),options);
    dtheta(:,j)=(theta(end,:)-theta(1,:))/T;
end


%% RG方法求解平均频率
tic
for j=2:length(K)
    [ W1{j},W2{j}] = QuadraticEqu(w(1),w(2),K(j));
end
toc

save('data_RG_N2.mat','w','dtheta','W1','W2','K');
