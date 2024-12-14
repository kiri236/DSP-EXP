fs = 1;
wp = 0.8*pi;
deltaw = 0.1*pi;
ws = wp+deltaw;
Rp = 1;
As = 40;

%%计算阶数:
[n,Wn] = buttord(wp/pi*fs,ws/pi*fs,Rp,As);
[b,a] = butter(n,Wn);
%% 频率响应
freqz(b,a);
title("IIR滤波器的幅频特性和相频特性");
%% 群时延
grpdelay(b,a);
ylim([0,20])
title("IIR滤波器的群时延");


