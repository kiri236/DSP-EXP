hammingw = 6.6*pi;
wh = 0.8*pi;%通带截止频率
deltaw = 0.1*pi;
wts = wh+deltaw;%阻带频率
N = ceil(hammingw/deltaw);
w0 = (wh+wts)/2;
As = 40;
b = fir1(N-1,w0/pi,hamming(N));
%% 频率响应
freqz(b,1);
title("FIR低通滤波器的幅频特性和相频特性");
%% 群延时
grpdelay(b,1);
title("FIR低通滤波器的群时延");