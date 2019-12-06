%% ����Բ��S�����߻���һ��
% �ٽ�� index_K_fitWell
% ��ϵ�w_fitting

load('SCFittingResult.mat');
load('OvalFittingResult.mat');
load('ovalfittingWellOut.mat');

clear w_fitting;
for i=1:N
    len_Oval=length(w_ovalfitting{i});
    len_SC=length(w_SCfitting{i});
     w_fiiting{i}(1:len_Oval)=w_ovalfitting{i};
     w_fiiting{i}((len_Oval+1):(len_Oval+len_SC))=w_SCfitting{i};
end

figure
for i=1:N
    len=length(w_fiiting{i});
    hold on;
    plot(K(1:5:len),w_fiiting{i}(1:5:end),'r')
    
     %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
end

figure
for i=1:50
    len=length(w_fiiting{i});
    hold on;
    scatter(K(1:5:len),w_fiiting{i}(1:5:end),3,'r')
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
end

hold on;
scatter(coordinate_K_fitWell(:,1),coordinate_K_fitWell(:,2),5,'g');
    

            