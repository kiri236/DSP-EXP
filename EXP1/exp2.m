%% DTFT
x=[1,1,0,1];
syms w
subplot(4,1,1);%%subplot要写在画的subplot的上面
X_dtft = 1+exp(-1i*w)+exp(-1i*3*w);
ezplot(abs(X_dtft),[0,2*pi]);
xlabel('w');
ylabel('|x(e^{j\omega})|');
title('DTFT');
%% DFT
subplot(4,1,2)
N = 4;
W_N=exp(-1i*2*pi/N);
DFT_w=[1,1,1,1;
       1,W_N,W_N^2,W_N^3;
       1,W_N^2,W_N^4,W_N^8;
       1,W_N^3,W_N^6,W_N^9];
X_DFT=DFT_w*x';
k=0:3;
stem(k,abs(X_DFT),'filled');
xlabel('k');
ylabel('|x(k)|');
title('DFT');
%% 内插重建
subplot(4,1,3);
X_ejw = 0 ;
for k_1 = 0 : N-1
    X_ejw =X_ejw + X_DFT(k_1+1)*(1-exp(-1i*w*N))/(1-W_N^k_1*exp(-1i*w));
end
X_ejw = X_ejw/N;
ezplot(abs(X_ejw),[0,2*pi]);
xlabel('w');
ylabel('|x_1(e^{j\omega})|');
title('内插重建');
%% 比较
subplot(4,1,4);
ezplot(abs(X_ejw),[0,2*pi]);
hold on;
n = 0:pi/4:2*pi;
X_dtft1 = 1+exp(-1i*n)+exp(-1i*3*n);
ezplot(abs(X_dtft),[0,2*pi]);
ylabel('|x(e^{j\omega})|');
xlabel('w');
title('比较');
legend('内插重建','DTFT');
hold on;

