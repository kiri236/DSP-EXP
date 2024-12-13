%% 1
f1 = 24;
f2 = 60;
syms t;
syms w;
x_t = exp(1i*2*pi*f1*t)+exp(1i*2*pi*f2*t);%%delta(f-f1)+delta(f-f2)
y = fourier(x_t,w);
w1 = 0:pi/10:130*pi;
y1 = subs(y,w,w1);
idx = (y1==inf);
y1(idx)=1;
plot(w1/2/pi,abs(y1));
xlabel('\Omega/2\pi');
ylabel('|X({j\Omega})|');
title('X({j\Omega})的幅频特性');
%% 2
%是周期函数,最小正周期是T0=1/12.基频W0=12Hz
%做FS得傅里叶系数F_2=1,F_5=1其他F_k=0
w0 = 2*pi*12;
T0 = 2*pi/20;
F_k = zeros(1,20);
for k = 1:20
    F_k(k) = int(x_t*exp(-j*w0*k*t),t,0,1/12)*12;
end
k = 1:20;
stem(k,F_k,'filled');
xlabel('k');
ylabel('F_k');
title('FS')
%% 3 R1
%subplot(2,1,1);
R1 = heaviside(t+T0)-heaviside(t-T0);
x_t_1 = x_t*R1;
x_1f = fourier(x_t_1);
x_1f = subs(x_1f,w*(2*pi));
ezplot(abs(x_1f),[0,80]);
xlabel('\Omega/2\pi');
ylabel('|X_1(j\Omega)|');
title('被宽度=2T0的矩形窗截断后的频谱');
%% 3 R2
%subplot(2,1,2);
R2 = heaviside(t+0.8*T0)-heaviside(t-0.8*T0);
x_t_2 = x_t*R2;
x_2f = fourier(x_t_2);
syms w ; 
x_2f = subs(x_2f,w*(2*pi));
ezplot(abs(x_2f),[0,80]);
xlabel('\Omega/2\pi');
ylabel('|X_1(j\Omega)|');
title('被宽度=1.6T0的矩形窗截断后的频谱');
%% 4
fs1 = 600;
N = 400;
T0 = 1/12;
n=0:N-1;
t1 = n * (1 / fs1);
n1 = n .* (t1 >= -T0) .* (t1 <= T0);
r1 = (t1 >= -T0) .* (t1 <= T0);
x_11 = exp(1i*2*pi*f1*t1)+exp(1i*2*pi*f2*t1);%%delta(f-f1)+delta(f-f2)
[X_1,w_1] = DTFT(n1,x_11,5000);
w_11 = [-fliplr(w_1),w_1];
X_11 = [X_1,X_1];
subplot(2,1,1);
plot(w_11/pi,abs(X_11));
xlabel('\omega/\pi');
ylabel('|X_1(e^{j\omega})|');
title('被2T0截断后的DTFT');
n2 = n .* (t1 >= -0.8*T0) .* (t1 <= 0.8*T0);
r2 = (t1>=0.8*T0).*(t1<=0.8*T0);
x_12 = exp(1i*2*pi*f1*t1)+exp(1i*2*pi*f2*t1);%%delta(f-f1)+delta(f-f2)
[X_2,w_2] = DTFT(n2,x_12,5000);
w_22 = [-fliplr(w_2),w_2];
X_22 = [X_2,X_2];
subplot(2,1,2);
plot(w_22/pi,abs(X_22));
xlabel('\omega/\pi');
ylabel('|X_1(e^{j\omega})|');
title('被1.6T0截断后的DTFT');
%% 5
%%R1
N11 = fs1/12*2;
n11=0:N11-1;
t1 = n11 * (1 / fs1);
x_11 = exp(1i*2*pi*f1*t1)+exp(1i*2*pi*f2*t1);%%delta(f-f1)+delta(f-f2)
X_DFT1 = x_11 * (exp(-1j * 2*pi / N11)).^(n11' * n11);
subplot(2,1,1);
stem(n11,abs(X_DFT1),'filled');
xlabel('k');
ylabel('|X_1(k)|');
title('被2T0截断后的DFT');
%R2
N12 = fs1/12*1.6;
n12=0:N12-1;
t2 = n12 * (1 / fs1);
x_12 = exp(1i*2*pi*f1*t2)+exp(1i*2*pi*f2*t2);%%delta(f-f1)+delta(f-f2)
X_DFT2 =x_12 * (exp(-1j * 2*pi / N12)).^(n12' * n12);
subplot(2,1,2);
stem(n12,abs(X_DFT2),'filled');
xlabel('k');
ylabel('|X_1(k)|');
title('被1.6T0截断后的DFT')
%% 6
N111 = 2*N11;
n111 = 0:N111-1;
tmp = zeros(size(x_11));
x_111 = [x_11,tmp];
X_DFT_11 =x_111 * (exp(-1j * 2*pi / N111)).^(n111' * n111);
subplot(2,1,1);
stem(n111,abs(X_DFT_11));
xlabel('k');
ylabel('|X_2(k)|');
title('被2T0截断后补相同长度0的DFT');
N222 = 2*N12;
n222 = 0:N222-1;
tmp = zeros(size(x_12));
x_222 = [x_12,tmp];
X_DFT_22 =x_222 * (exp(-1j * 2*pi / N222)).^(n222' * n222);
subplot(2,1,2);
stem(n222,abs(X_DFT_22));
xlabel('k');
ylabel('|X_2(k)|');
title('被1.6T0截断后补相同长度0的DFT');
%% DTFT
function [X, w] = DTFT(n, x, N)
    k = 0:N-1; 
    w = (2*pi/N) * k;
    X = x * (exp(-1j * 2*pi / N)).^(n' * k);
end


