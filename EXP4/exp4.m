N = 16;
n = 0:N-1;
x = 2*sin(pi/4*n)+sin(5*pi/8*n)+3*sin(3*pi/4*n);
%% DFT
subplot(1,2,1);
X_DFT = x * (exp(-1j * 2*pi / N)).^(n' * n);
stem(n,abs(X_DFT))
%% FFT
subplot(1,2,2);
X_FFT=FFT(x,N,1);
abs(X_FFT)
stem(n,abs(X_FFT));
function X=FFT(a,n,inv)
    tot = 1;
    while tot < n
        tot=tot*2;
    end
    if(n==1)
        X=[a(1)];
    else
        n=tot;
        eve = zeros((n)/2);
        odd = zeros((n)/2);
        for i = 1:2:n
            eve((i+1)/2)=a(i+1);
            odd((i+1)/2)=a(i);
        end
        evefft=FFT(eve,n/2,inv);
        oddfft=FFT(odd,n/2,inv);
        w=exp(inv*j*2*pi/n);
        for i = 1:1:(n+1)/2
            X(i)=evefft(i)+w^i*oddfft(i);
            X((i+floor((n+1)/2))) = evefft(i)-w^i*oddfft(i);
        end
    end
end