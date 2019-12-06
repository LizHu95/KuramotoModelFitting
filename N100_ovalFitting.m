%% ��Բ���

addpath('./utils');

for i=1:N/2
    temp(i)=find(K>Kc(i),1);
end
%% ������Ż�����
str='@(A)';
for j=2:4:290       %K(1)=0
    q=find(Kc<K(j), 1);
    if(isempty(q))
        q=0;               %δ���
    elseif(q==1)           %ȫ�����
        break;
    else                    
        q=N/2+1-q;          %�����q��
    end
    if(j>2)
        str=[str,'+'];
    end
    %     (K(j)^2/(w(i-1)*sqrt(1-K(j)^2/(A(1)*(i-1)+A(2))^2)-w(i))+K(j)^2/(w(i+1)*sqrt(1-K(j)^2/(A(1)*(i+1)+A(2))^2)-w(i))-w(i)*sqrt(1-K(j)^2/(A(1)*i+A(2))^2)+w(i))^2;
    str=[str,'(',num2str(K(j)),'^2/(',num2str(w(N)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*',num2str(N),'+A(2))^2)-',num2str(w(1)),')+',num2str(K(j)),'^2/(',num2str(w(2)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*2+A(2))^2)-',num2str(w(1)),')-',num2str(w(1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*1+A(2))^2)+',num2str(w(1)),')^2'];
    if(q==0)
        for i=2:(N-1)
            str=[str,'+(',num2str(K(j)),'^2/(',num2str(w(i-1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i-1),')+A(2))^2)-',num2str(w(i)),')+',num2str(K(j)),'^2/(',num2str(w(i+1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i+1),')+A(2))^2)-',num2str(w(i)),')-',num2str(w(i)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*',num2str(i),'+A(2))^2)+',num2str(w(i)),')^2'];
        end
    elseif((N/2-q)>=2 && q~=0)
        for i=2:(N/2-q)
            str=[str,'+(',num2str(K(j)),'^2/(',num2str(w(i-1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i-1),')+A(2))^2)-',num2str(w(i)),')+',num2str(K(j)),'^2/(',num2str(w(i+1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i+1),')+A(2))^2)-',num2str(w(i)),')-',num2str(w(i)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*',num2str(i),'+A(2))^2)+',num2str(w(i)),')^2'];
        end
        for i=(N/2+q):N-1
            str=[str,'+(',num2str(K(j)),'^2/(',num2str(w(i-1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i-1),')+A(2))^2)-',num2str(w(i)),')+',num2str(K(j)),'^2/(',num2str(w(i+1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*(',num2str(i+1),')+A(2))^2)-',num2str(w(i)),')-',num2str(w(i)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*',num2str(i),'+A(2))^2)+',num2str(w(i)),')^2'];
        end
    else
    end
    str=[str,'+(',num2str(K(j)),'^2/(',num2str(w(N-1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*',num2str(N-1),'+A(2))^2)-',num2str(w(N)),')+',num2str(K(j)),'^2/(',num2str(w(1)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*1+A(2))^2)-',num2str(w(N)),')-',num2str(w(N)),'*sqrt(1-',num2str(K(j)),'^2/(A(1)*100+A(2))^2)+',num2str(w(N)),')^2'];
end
fun=eval(str);
[a0,b0]=meshgrid(linspace(-0.08,-0.010,20),linspace(0.1,1.0,20));
a0=a0(:);b0=b0(:);

tic
for i=1:length(a0)
    [ab(i,:),fu(i),flag(i),output]=fminsearch(fun,[a0(i),b0(i)]);
end
toc
[index1,index2]=find(flag==0);
fu(index1,index2)=inf.*ones(length(index1),length(index2));


%% ��Բ������ƽ��Ƶ�� f_averageW���ٽ����ǿ��f_Kc
mi=find(abs(fu)==min(abs(fu)),1);
f_Kc=zeros(N,1);
f_Kc_inital=zeros(N,1);
f_averageW=zeros(N,length(K));
% ����ϵľֲ��ٽ����ǿ��f_Kc
for i=1:N
    f_Kc_inital(i)=ab(mi,1)*i+ab(mi,2);
end
for i=1:N/2
    f_Kc(i)=0.5*abs(f_Kc_inital(i)-f_Kc_inital(N+1-i));
    f_Kc(N+1-i)=f_Kc(i);
end
% ����ϵ�ƽ��Ƶ�� f_averageW
for i=1:N
    for j=1:length(K)
        f_averageW(i,j)=w(i)*sqrt(1-K(j)^2/f_Kc(i)^2);
    end
end

%% ���ֲ���
figure;
for i=1:N
    plot(K,d_theta(i,:),'b');
    hold on;
end
axis([0 0.6 -1 1 ]);xlabel('���ǿ�ȣ�K');ylabel('ƽ��Ƶ�ʣ�w');

%% ������Բ���ͼa=f_Kc b=w0
for i=1:N/2
    ellipsefig(ww(i),f_Kc(i));
    %scatter(f_Kc(i),0,3,'r');
    hold on;
end
for i=1:100
    for j=2:290
        if j<index_K_fitWell(i)
            scatter(K(j),f_averageW(i,j),3,'y');
            hold on;
        end
    end
end


%% find��Բ����fitting_well���ٽ��
for i=1:N
    for j=1:length(K)
    	if abs(f_averageW(i,j)-d_theta(i,j))>0.01
            index_K_fitWell(i)=j;
            coordinate_K_fitWell(i,:)=[K(j),d_theta(i,j)];
            break;
        end
    end
end
for i=1:N
    scatter(coordinate_K_fitWell(i,1),coordinate_K_fitWell(i,2),5,'g');
end   

%% ���Scurve�����Ҫ�Ĳ���
%   ����slope_average=-d*a*b/(1+b)^2=-rate*a*b/(1+b)
%   ƽ����shift
%   Ƥ����������x=shift����ֵ rate=d/(1+b);
shift=(coordinate_K_fitWell(:,1)+f_Kc)./2;
rate=coordinate_K_fitWell(:,2)./2;

save('ovalfittingWellOut','coordinate_K_fitWell','shift','rate','index_K_fitWell','f_averageW')
    

%% ��Բ��ϵ�
for i=1:100
    index=1;
    for j=1:length(K)
        if j<index_K_fitWell(i)
            w_ovalfitting{i}(j)=f_averageW(i,j);
        end
    end
end
save('OvalFittingResult','w_ovalfitting');