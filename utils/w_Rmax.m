function ww = w_Rmax(N,w)
%% ����Rmax���ֵ�w�ֲ�
%   ���������
%       N�����Ӹ���
%       w:��ʼƵ��

ww=zeros(1,N);
center=ceil(N/2);
k=1;
while(k<=N)
    if(k<=center)
        ww(k)=w(k); k=k+1;
    else break;
    end
    if(k<=center)
        ww(k)=w(N-k+1);k=k+1;
    else break;
    end
end
k=N;
while(1)
    if(k>center)
        ww(k)=w(k);k=k-1;
    else break;
    end
    if(k>center)
        ww(k)=w(N+1-k);k=k-1;
    else break;
    end
end

end