%% Ƥ����������ģ�� 
%% ģ��1��y=d/(1+b*e^(at)) 
% ��18~N-18+1 fitWell ������d=0.28;b=0.5;a=60;shift=0.195;k=-3.733333333333333;
% i=40,b=1.1~1.6;
% i=30,b=1.3~1.4;
% i=20,b=1.3~1.3; not good
% i=10,b=1.1; not good

%% Ϊ�����
close all
i=10;
b=0.9:0.1:1.2;
slope=5.8:0.1:6.4;
for index_b=1:length(b)
    for index_slope=1:length(slope)
        b_single=b(index_b);
        figure('numbertitle','off','name',['����b=',num2str(b_single),'����slope=',num2str(slope(index_slope))]);
        %% ���ֲ���
        hold on;
        plot(K,d_theta(i,:),'b');
        axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
        
        %% S��������ϵ�i������
        rate_single=rate(i);
        % Q_single=Q(i);
        Q_single=slope(index_slope)/rate(i);
        shift_single=shift(i);
        t=linspace(0,0.6,100);
        y=@(t)rate_single*(1+b_single)/(1+b_single*exp(Q_single*(1/b_single+1)*(t-shift_single)));
        for q=1:100
            if(t(q)>coordinate_K_fitWell(i,1))
                hold on
                scatter(t(q),y(t(q)),3,'r');
            end
        end
        hold on;
        scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
    end
end



%% ����ó��������,�ڻ�����������ͼ
% ��ϽϺõĲ���ֵ
% i:22~79 slope=3.7;b=1.5
% i:1~21 80~100 slope=6;b=1;
close all
slope=3.7;
Q=(w./abs(w))'.*slope./rate;  
b=1.5;
figure('numbertitle','off','name',['����b=',num2str(b),'����slope=',num2str(slope)]);
tic
for i=22:2:79
    b_single=b;
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
    
   %% S��������ϵ�i������
    rate_single=rate(i);
    Q_single=Q(i);
    shift_single=shift(i);
    t=linspace(0,0.6,100);
    y=@(t)rate_single*(1+b_single)/(1+b_single*exp(Q_single*(1/b_single+1)*(t-shift_single)));
    for q=1:100
        if(t(q)>coordinate_K_fitWell(i,1))
            hold on
            scatter(t(q),y(t(q)),1,'r');
        end
    end
    hold on;
    scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
    
end
toc



%% ģ��2��y=K/(1+b*e^(a2*t^2+a1t)) 
%% Ϊ�����
% ��ϽϺò���
% i=20~81: slope=5,b=1,a2=50
close all
i=6;
b=1:0.05:1.1;
%slope=-5;
slope=5:1:6;
slope=-slope;
a2=40:10:60;
sf=0.01:0.005:0.03;
%sf=0;
for index_a2=1:length(a2)
    for index_b=1:length(b)
        for index_slope=1:length(slope)
            for index_sf=1:length(sf)
                b_single=b(index_b);
                rate_single=rate(i);
                d_single=(1+b_single)*rate_single;
                shift_single=shift(i)+sf(index_sf);
                a1_single=-(1+b_single)*slope(index_slope)/b_single/rate_single;
                a2_single=a2(index_a2);
                figure('numbertitle','off','name',['����a2=',num2str(a2_single),' ; ����b=',num2str(b_single),' ; ����slope=',num2str(slope(index_slope)),' ; shift=',num2str(sf(index_sf))]);
                %% ���ֲ���
                hold on;
                plot(K,d_theta(i,:),'b');
                axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
                %% S��������ϵ�i������
                t=linspace(0,0.6,100);
                y=@(t)d_single/(1+b_single*exp(a1_single*(t-shift_single)+a2_single*(t-shift_single)^2));
                for q=1:100
                    if(t(q)>coordinate_K_fitWell(i,1))
                        hold on
                        scatter(t(q),y(t(q)),3,'r');
                    end
                end
                hold on;
                scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
            end
        end
    end
end


%% shift�޸�
shift(1:10)=shift(1:10)+0.02;
shift(11:15)=shift(11:15)+0.015;
shift(16:19)=shift(16:19)+0.010;

shift(91:100)=shift(91:100)+0.02;
shift(86:90)=shift(86:90)+0.015;
shift(82:85)=shift(82:85)+0.010;

%shift=shift_fitting;
%% ����ó��������,�ڻ�����������ͼ
close all
slope=-(w./abs(w))'.*5;  
b=1.1;
a2=50;
figure('numbertitle','off','name',['����a2=',num2str(a2),'����b=',num2str(b),'����slope=',num2str(slope(1))]);
tic
for i=1:50
    b_single=b;
    d_single=(1+b_single)*rate(i);
    shift_single=shift(i);
    a1_single=-slope(i)*(1+b_single)/b_single/rate(i);
    a2_single=a2;
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
    
   %% S��������ϵ�i������

    t=linspace(0,0.6,100);
    y=@(t)d_single/(1+b_single*exp(a2_single*(t-shift_single)^2+a1_single*(t-shift_single)));
    for q=1:100
        if(t(q)>coordinate_K_fitWell(i,1))
            hold on
            scatter(t(q),y(t(q)),1,'r');
        end
    end
    hold on;
    scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
    
end
toc

ylim([-0.7 ,0.7]);
xlim([0,0.45]);


%% ģ��3��y=K/(1+b*e^(a3*t^3+a2*t^2+a1t)) 
%% Ϊ�����
% ��ϽϺò���
% i=20: slope=5,b=1,a2=70,a3=240;2.1;shift=-0.1
% i=30: slope=5,b=1,a2=90,a3=500;2.5;shift=-0.1


i=91;
b=1:0.05:1.1;
%slope=-5:1:-4;
slope=5:1:6;
a2=50:10:70;
a3=200:20:240;
close all
tic
% figure('numbertitle','off','name',['����a3=',num2str(a3_single),'����a2=',num2str(a2_single),'����b=',num2str(b_single),'����slope=',num2str(slope(index_slope))]);            
for index_a2=1:length(a2)
    for index_a3=1:length(a3)
        for index_b=1:length(b)
            for index_slope=1:length(slope)
                b_single=b(index_b);
                rate_single=rate(i);
                shift_single=shift(i)+0.018;
                a1_single=-(1+b_single)*slope(index_slope)/b_single/rate_single;
                a2_single=a2(index_a2);
                a3_single=a3(index_a3);
                d_single=(1+b_single)*rate_single;
                figure('numbertitle','off','name',['����a3=',num2str(a3_single),'����a2=',num2str(a2_single),'����b=',num2str(b_single),'����slope=',num2str(slope(index_slope))]);
              %% ���ֲ���
                hold on;
                plot(K,d_theta(i,:),'b');
                xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
                hold on;
                scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
              %% S��������ϵ�i������
                t=linspace(0,0.6,100);
                y=@(t)d_single/(1+b_single*exp(a3_single*(t-shift_single)^3+a2_single*(t-shift_single)^2+a1_single*(t-shift_single)));
                for q=1:100
                    if(t(q)>coordinate_K_fitWell(i,1))
                        hold on
                        scatter(t(q),y(t(q)),3,'r');
                    end
                end
            end
        end
    end
end
toc


%% shift�޸�
shift(1:6)=shift(1:6)+0.02;
shift(7:11)=shift(7:11)+0.018;
shift(12:14)=shift(12:14)+0.015;
shift(15:18)=shift(15:18)+0.01;
shift(19:21)=shift(19:21)+0.005;

shift(95:100)=shift(95:100)+0.02;
shift(91:94)=shift(91:94)+0.018;
shift(88:90)=shift(88:90)+0.015;
shift(84:87)=shift(84:87)+0.01;
shift(81:83)=shift(81:83)+0.005;
%% ����ó��������,�ڻ�����������ͼ
close all
slope=-(w./abs(w))*5;
b=1.05;
a2=65;
a3=210;
figure('numbertitle','off','name',['����a3=',num2str(a3),'����a2=',num2str(a2),'����b=',num2str(b),'����slope=',num2str(slope(1))]);
tic
for i=1:50
    b_single=b;
    rate_single=rate(i);
    d_single=(1+b_single)*rate_single;
    shift_single=shift(i);
    a1_single=-(1+b_single)*slope(i)/b_single/rate_single;
    a2_single=a2;
    a3_single=a3;
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
    
    %% S��������ϵ�i������
    
    t=linspace(0,0.6,100);
    y=@(t)d_single/(1+b_single*exp(a3_single*(t-shift_single)^3+a2_single*(t-shift_single)^2+a1_single*(t-shift_single)));
    for q=1:100
        if(t(q)>coordinate_K_fitWell(i,1))
            hold on
            scatter(t(q),y(t(q)),1,'r');
        end
    end
    hold on;
    scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
    
end
toc

%% ��������ó��ĺ�����������S��������ϵ�ƽ��Ƶ��
%% shift�޸�
shift(1:6)=shift(1:6)+0.02;
shift(7:11)=shift(7:11)+0.018;
shift(12:14)=shift(12:14)+0.015;
shift(15:18)=shift(15:18)+0.01;
shift(19:21)=shift(19:21)+0.005;

shift(95:100)=shift(95:100)+0.02;
shift(91:94)=shift(91:94)+0.018;
shift(88:90)=shift(88:90)+0.015;
shift(84:87)=shift(84:87)+0.01;
shift(81:83)=shift(81:83)+0.005;

%shift=shift_fitting
slope=-(w./abs(w))*5;
b=1.05;
a2=65;
a3=210;
tic
clear w_SCfitting;
for i=1:50
    b_single=b;
    rate_single=rate(i);
    d_single=(1+b_single)*rate_single;
    shift_single=shift(i);
    a1_single=-(1+b_single)*slope(i)/b_single/rate_single;
    a2_single=a2;
    a3_single=a3;
    
    %% S��������ϵ�i������
    y=@(t)d_single/(1+b_single*exp(a3_single*(t-shift_single)^3+a2_single*(t-shift_single)^2+a1_single*(t-shift_single)));
    index=1;
    for j=index_K_fitWell(i):length(K)
        w_SCfitting{i}(index)=y(K(j));
        index=index+1;
    end
end
toc
save('SCFittingResult.mat','w_SCfitting');

% ��ͼ
figure;
for i=1:50
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
    hold on
    scatter(K(index_K_fitWell(i):5:length(K)),w_SCfitting{i}(1:5:end),1,'r');
end


%% ����S�����߳�ɶ��
slope=-(w./abs(w))*3;
b=1;
a2=40;
a3=200;
figure('numbertitle','off','name',['����a3=',num2str(a3),'����a2=',num2str(a2),'����b=',num2str(b),'����slope=',num2str(slope(1))]);
tic
for i=5
    b_single=b;
    rate_single=rate(i);
    d_single=(1+b_single)*rate_single;
    shift_single=shift(i)+0.05;
    a1_single=-(1+b_single)*slope(i)/b_single/rate_single;
    a2_single=a2;
    a3_single=a3;
    %% ���ֲ���
    hold on;
    plot(K,d_theta(i,:),'b');
    xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');
    
    %% S��������ϵ�i������
    
    t=linspace(0,0.6,100);
    y=@(t)d_single/(1+b_single*exp(a3_single*(t-shift_single)^3+a2_single*(t-shift_single)^2+a1_single*(t-shift_single)));
    for q=1:100
        
            hold on
            scatter(t(q),y(t(q)),1,'r');
    end
    hold on;
    scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
    
end
toc





