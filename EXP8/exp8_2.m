%% FIR
hammingw = 6.6*pi;
wh = 0.8*pi;%通带截止频率
deltawFIR = 0.1*pi;
wts = wh+deltawFIR;%阻带频率
N_hamming = ceil(hammingw/deltawFIR);
w0 = (wh+wts)/2;
AsFIR = 40;
firb = fir1(N_hamming-1,w0/pi,hamming(N_hamming));

%% IIR
fsIIR = 1;
wp = 0.8*pi;
deltawIIR = 0.1*pi;
ws = wp+deltawIIR;
Rp = 1;
AsIIR = 40;

%%计算阶数:
[n,Wn] = buttord(wp/pi*fsIIR,ws/pi*fsIIR,Rp,AsIIR);
%%butterworth
[IIRb,IIRa] = butter(n,Wn);
%% 定义信号
N = 80;
n = 0:N-1;
w1 = 0.1*pi;
w2 = 0.7*pi;
x1 = sin(w1*n);
x2 = sin(w2*n);
%% x1
subplot(2,3,1);
stem(n,x1);
xlabel("n");
ylabel("x_1(n)");
title("x_1(n)的时域波形");
%% x1经过IIR
x1_IIR = filter(IIRb,IIRa,x1);
subplot(2,3,2);
stem(n,x1_IIR);
xlabel("n");
ylabel("x_{1IIR}(n)");
title("x_1(n)经过IIR滤波器后的时域波形");
%% x1经过FIR
x1_FIR = filter(firb,1,x1);
subplot(2,3,3);
stem(n,x1_FIR);
xlabel("n");
ylabel("x_{1FIR}(n)");
title("x_1(n)经过FIR滤波器后的时域波形");

%% x2
subplot(2,3,4);
stem(n,x2);
xlabel("n");
ylabel("x_2(n)");
title("x_2(n)的时域波形");
%% x2经过IIR
x2_IIR = filter(IIRb,IIRa,x2);
subplot(2,3,5);
stem(n,x2_IIR);
xlabel("n");
ylabel("x_{2IIR}(n)");
title("x_2(n)经过IIR滤波器后的时域波形");
%% x2经过FIR
x2_FIR = filter(firb,1,x2);
subplot(2,3,6);
stem(n,x2_FIR);
xlabel("n");
ylabel("x_{2FIR}(n)");
title("x_2(n)经过FIR滤波器后的时域波形");

%% 群时延
subplot(2,2,1);
grpdelay(x1_IIR,1)
title("x_1(n)经过IIR低通滤波器后的群时延");
subplot(2,2,2);
grpdelay(x1_FIR,1)
title("x_1(n)经过FIR低通滤波器后的群时延");
subplot(2,2,3);
grpdelay(x2_IIR,1)
title("x_2(n)经过IIR低通滤波器后的群时延");
subplot(2,2,4);
grpdelay(x2_FIR,1)
title("x_2(n)经过FIR低通滤波器后的群时延");
%% x=x1+x2
x3 = x1+x2;
subplot(3,1,1);
stem(n,x3);
xlabel('n');
ylabel('x(n)');
title('x(n)=x_1(n)+x_2(n)');
%% x3经过IIR
x3_IIR = filter(IIRb,IIRa,x3);
subplot(3,1,2);
stem(n,x3_IIR);
xlabel("n");
ylabel("x_{IIR}(n)");
title("x(n)经过IIR滤波器后的时域波形");

%% x2经过FIR
x3_FIR = filter(firb,1,x3);
subplot(3,1,3);
stem(n,x3_FIR);
xlabel("n");
ylabel("x_{FIR}(n)");
title("x(n)经过FIR滤波器后的时域波形");