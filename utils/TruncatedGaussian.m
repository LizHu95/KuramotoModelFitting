function w= TruncatedGaussian( N,range )
% 截断高斯分布


w=randn(1,N);
while(1)
    index=find(w<range(1)|w>range(2));
    if isempty(index)
        break;
    else
        w(index)=randn(1,length(index));
    end
end

end

