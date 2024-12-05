%% 1
fh = 100;
syms t;
syms tau;
x_t= (sin(2*pi*fh*t))./t;
f = fourier(x_t);
ezplot(abs(f),[0,120*2*pi]);
%% 2
A=[0.3,0.6,1.2,1.8,2.4];
col = 1 ;
for i = A
    subplot(5,2,col);
    fs = i*fh;
    T=1/fs;
    n=0:500;
    t=n/fs;
    x_at= (sin(2*pi*fh*t))./t;
    x_at(1)=2*pi*fh;
    w=[0:fs];
    [y,w] = freqz(x_at, 1, 10000, 'whole',fs);
    mag =  abs(y)/max(abs(y));
    plot(w,mag);
    title("fs="+i*fh);
    xlabel('w');
    ylabel('Magnitude');
    hold on;
    col= col+1;
    subplot(6,2,col);
    [y,w] = freqz(x_at, 1, 10000, 'whole',120);
    ang =  angle(y);
    plot(w,ang);
    title("fs="+i*fh);
    xlabel('w');
    ylabel('angle');
    hold on;
    
    col = col+1;
end
%% 3
syms t
fq = 100;
x_2=exp(-100*t)*sin(2*pi*fq*t)*(heaviside(t));
X_2=fourier(x_2);
fplot(abs(X_2),[0,400]);%%带宽无限,频率高端幅度有明显衰减
B=[1,4,6,10];
num = 1;
for i = B
    subplot(4,1,num);
    fs=i*fq;
    T=1/fs;
    n=0:500;
    t=n/fs;
    x_2t=exp(-100*t).*sin(2*pi*fq*t);
    [y,f1] = freqz(x_2t,1,10000,'whole',fs);
    mag = abs(y)/max(abs(y));
    plot(f1,mag);
    title("fs="+fs);
    xlabel('f');
    ylabel('Mag');
    hold on;
    num = num+1;
end

