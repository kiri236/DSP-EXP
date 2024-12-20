rectw = 1.8*pi;
trianw = 2*rectw;
hanningw = 6.2*pi;
hammingw = 6.6*pi;
blackmanw = 11*pi;
MHz = 1;
fs = 500*MHz;
f0 = 150*MHz;
B = 100*MHz;
As=20;
T = 2*pi/fs;%采样周期
%% 矩形窗
i = 1;
for deltaf = 1*MHz:1*MHz:12*MHz
    %subplot(6,2,i);
    %通带
    fh = B/2+f0;
    fl = f0-B/2;
    %阻带；
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(rectw/deltaw);
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], boxcar(N_rect));
    [h,w] = freqz(b,1,fs,'whole');
    resdB = abs(h);
%     %%计算截止频率处的衰减
%     l = 1 ;
%     r = length(w);
%     while(l<r)
%         mid = floor((l + r)/2);
%         if(w(mid)<=0.84*pi)
%             l = mid ;
%         else
%             r = mid - 1;
%         end
%     end
%     l= l + 1;
%     20*log10(resdB(l))
    maxn = max(resdB);
    plot(w/(2*pi)*fs,resdB/maxn);
    title(sprintf("N=%d时采用矩形窗设计的带通滤波器",N_rect));
    xlabel("f/MHz");
    ylabel("幅度");
    grid on;
end

%% 三角形窗
i = 1;
for deltaf = 1*MHz:1*MHz:12*MHz
    subplot(2,1,i);
    %通带
    fh = B/2+f0;
    fl = f0-B/2;
    %阻带；
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(trianw/deltaw)+16;
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], triang(N_rect));
    [h,w] = freqz(b,1,fs,'whole');
    resdB = abs(h);
%    %%计算截止频率处的衰减
%      l = 1 ;
%     r = length(w);
%     while(l<r)
%         mid = floor((l + r)/2);
%         if(w(mid)<=0.84*pi)
%             l = mid ;
%         else
%             r = mid - 1;
%         end
%     end
%     idx = find(w==0.36*pi)
%     st1 = 20*log10(resdB(idx));
%     l= l + 1;
%     st2 = 20*log10(resdB(l));
    maxn = max(resdB);
    plot(w/(2*pi)*fs,resdB/maxn);
    title(sprintf("N=%d时采用三角窗设计的带通滤波器",N_rect));
    xlabel("f/MHz");
    ylabel("幅度");
    grid on;
end

%% hanning窗
i = 1;
for deltaf = 1*MHz:1*MHz:12*MHz
    subplot(6,2,i);
    %通带
    fh = B/2+f0;
    fl = f0-B/2;
    %阻带；
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(hanningw/deltaw);
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], hann(N_rect));
    [h,w] = freqz(b,1,fs,'whole');
    resdB = abs(h);
%    %%计算截止频率处的衰减
%      l = 1 ;
%     r = length(w);
%     while(l<r)
%         mid = floor((l + r)/2);
%         if(w(mid)<=0.84*pi)
%             l = mid ;
%         else
%             r = mid - 1;
%         end
%     end
%     idx = find(w==0.36*pi)
%     st1 = 20*log10(resdB(idx));
%     l= l + 1;
%     st2 = 20*log10(resdB(l));
    maxn = max(resdB);
    plot(w/2/pi*fs,resdB/maxn);
    title(sprintf("N=%d时采用汉宁窗设计的带通滤波器",N_rect));
    xlabel("f/MHz");
    ylabel("幅度");
    grid on;
end

%% hamming窗
i = 1;
for deltaf = 1*MHz:1*MHz:12*MHz
    subplot(6,2,i);
    %通带
    fh = B/2+f0;
    fl = f0-B/2;
    %阻带；
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(hammingw/deltaw);
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], hamming(N_rect));
    [h,w] = freqz(b,1,fs,'whole');
    resdB = abs(h);
%        %%计算截止频率处的衰减
%      l = 1 ;
%     r = length(w);
%     while(l<r)
%         mid = floor((l + r)/2);
%         if(w(mid)<=0.84*pi)
%             l = mid ;
%         else
%             r = mid - 1;
%         end
%     end
%     idx = find(w==0.36*pi);
%     st1 = 20*log10(resdB(idx))
%     l= l + 1;
%     st2 = 20*log10(resdB(l))
    maxn = max(resdB);
    plot(w/2/pi*fs,resdB/maxn);
    title(sprintf("N=%d时采用汉明窗设计的带通滤波器",N_rect));
    xlabel("f/MHz");
    ylabel("幅度");
    grid on;
end

%% blackman窗
i = 1;
for deltaf = 1*MHz:1*MHz:12*MHz
    subplot(6,2,i);
    %通带
    fh = B/2+f0;
    fl = f0-B/2;
    %阻带；
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(blackmanw/deltaw);
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], blackman(N_rect));
    [h,w] = freqz(b,1,fs,'whole');
    resdB = abs(h);
%        %%计算截止频率处的衰减
%      l = 1 ;
%     r = length(w);
%     while(l<r)
%         mid = floor((l + r)/2);
%         if(w(mid)<=0.84*pi)
%             l = mid ;
%         else
%             r = mid - 1;
%         end
%     end
%     idx = find(w==0.36*pi);
%     st1 = 20*log10(resdB(idx))
%     l= l + 1;
%     st2 = 20*log10(resdB(l))
    maxn = max(resdB);
    plot(w/2/pi*fs,resdB/maxn);
    title(sprintf("N=%d时采用Blackman窗设计的带通滤波器",N_rect));
    xlabel("f/MHz");
    ylabel("幅度");
    grid on;
end