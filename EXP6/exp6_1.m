%% 1024
N = 1024;
n = 0:N-1;
x2 = 31.6*exp(1i*3*pi/7*n)+10*exp(1i*(1/7+1/1024)*3*pi*n);
x2_1024 = x2.*blackman(N)';
x2_1024_fft = fft(x2_1024,2*N);
res1024_dB=20*log10(abs(x2_1024_fft));
subplot(2,1,1);
plot(res1024_dB);
title("N=1024时,blackman窗对x_2(n)做DFT得到的X_2(k)");
xlabel("n");
ylabel("幅度/dB");
%% 2048
N = 2048;
n = 0:N-1;
x2 = 31.6*exp(1i*3*pi/7*n)+10*exp(1i*(1/7+1/1024)*3*pi*n);
x2_1024 = x2.*blackman(N)';
x2_1024_fft = fft(x2_1024,2*N);
res1024_dB=20*log10(abs(x2_1024_fft));
subplot(2,1,2);
plot(res1024_dB);
title("N=2048时,blackman窗对x_2(n)做DFT得到的X_2(k)");
xlabel("n");
ylabel("幅度/dB");