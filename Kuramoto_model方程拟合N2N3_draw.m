%% N=2
clear,clc,close all
load('data_RG_N2.mat')
% 画分岔树
figure;
xlabel('耦合强度：K');ylabel('平均频率：w');
for i=1:2
    hold on;
    plot(K,dtheta(i,:),'b');
    %scatter(K,d_theta(i,:),1,'b');
end
% RG方法 解析解
for j=2:length(K)
    hold on;
    scatter(K(j)*ones(1,length(W2{j})),W2{j},12,'filled','r');
end


%% N=3
clear,clc,close all
load('data_RG_N3.mat')
% 画分岔树
figure;
xlabel('耦合强度：K');ylabel('平均频率：w');
for i=1:3
    hold on;
    plot(K,dtheta(i,:),'b');
    %scatter(K,d_theta(i,:),1,'b');
end
% RG方法 解析解
for j=2:(index_part1-1)
    hold on;
    scatter(K(j)*ones(length(W2{j}),1),W2{j},6,'filled','r');
end
for j=index_part1:length(W2)
    hold on;
    scatter(K(j)*ones(length(W2{j}),1),W2{j},6,'filled','r');
end
title(['w1=',num2str(w(1)),' ; w2=',num2str(w(2)),' ; w3=',num2str(w(3))]);
% ylim([-1,1]);
% xlim([0,1]);
