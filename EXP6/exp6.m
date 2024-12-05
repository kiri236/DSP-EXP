N=1024;
n = 0:N-1;
x1 = 31.6*exp(1i*(3*pi)/7*n)+0.005*exp(1i*(4*pi)/5*n);
%% rect
x1_rect=x1.*boxcar(N)';
x_rect_fft = fft(x1_rect,2*N);
res0_dB=20*log10(abs(x_rect_fft));
subplot(2,1,1);
plot(res0_dB);
title("矩形窗对x_1(n)做DFT得到的X_1(k)");
xlabel("n");
ylabel("幅度/dB");
%% hamming
x1_hamming = x1.*hamming(N)';
x_hamming_fft = fft(x1_hamming,2*N);
res1_dB=20*log10(abs(x_hamming_fft));
subplot(2,1,2);
plot(res1_dB);
title("汉明窗对x_1(n)做DFT得到的X_1(k)");
xlabel("n");
ylabel("幅度/dB");