rectw = 1.8*pi;
trianw = 2*rectw;
hanningw = 6.2*pi;
hammingw = 6.6*pi;
blackmanw = 11*pi;
MHz = 1;
fs = 500*MHz;
f0 = 150*MHz;
B = 100*MHz;
As=30;
T = 2*pi/fs;%��������
%% ���δ�
i = 1;
for deltaf = 1*MHz:1*MHz:10*MHz
    subplot(5,2,i);
    %ͨ��
    fh = B/2+f0;
    fl = f0-B/2;
    %�����
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
    [h,w] = freqz(b,1,fs);
    resdB = abs(h);
    maxn = max(resdB);
    plot(w/(pi)*fs,resdB/maxn);
    title(sprintf("N=%dʱ���þ��δ���ƵĴ�ͨ�˲���",N_rect));
    xlabel("f/MHz");
    ylabel("����");
    grid on;
end

%% �����δ�
i = 1;
for deltaf = 1*MHz:1*MHz:10*MHz
    subplot(5,2,i);
    %ͨ��
    fh = B/2+f0;
    fl = f0-B/2;
    %�����
    fth = fh+deltaf;
    ftl = fl-deltaf;

    f01 = (fl+ftl)/2;
    f02 = (fh+fth)/2;

    w01 = f01*T;
    w02 = f02*T;
    deltaw = deltaf*T;
    N_rect = ceil(trianw/deltaw);
    i = i + 1;
    b = fir1(N_rect-1,[w01/pi, w02/pi], triang(N_rect));
    [h,w] = freqz(b,1,fs);
    resdB = abs(h);
    maxn = max(resdB);
    plot(w/pi*fs,resdB/maxn);
    title(sprintf("N=%dʱ�������Ǵ���ƵĴ�ͨ�˲���",N_rect));
    xlabel("f/MHz");
    ylabel("����");
    grid on;
end

%% hanning��
i = 1;
for deltaf = 1*MHz:1*MHz:10*MHz
    subplot(5,2,i);
    %ͨ��
    fh = B/2+f0;
    fl = f0-B/2;
    %�����
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
    [h,w] = freqz(b,1,fs);
    resdB = abs(h);
    maxn = max(resdB);
    plot(w/pi*fs,resdB/maxn);
    title(sprintf("N=%dʱ���ú�������ƵĴ�ͨ�˲���",N_rect));
    xlabel("f/MHz");
    ylabel("����");
    grid on;
end

%% hamming��
i = 1;
for deltaf = 1*MHz:1*MHz:10*MHz
    subplot(5,2,i);
    %ͨ��
    fh = B/2+f0;
    fl = f0-B/2;
    %�����
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
    [h,w] = freqz(b,1,fs);
    resdB = abs(h);
    maxn = max(resdB);
    plot(w/pi*fs,resdB/maxn);
    title(sprintf("N=%dʱ���ú�������ƵĴ�ͨ�˲���",N_rect));
    xlabel("f/MHz");
    ylabel("����");
    grid on;
end

%% blackman��
i = 1;
for deltaf = 1*MHz:1*MHz:10*MHz
    subplot(5,2,i);
    %ͨ��
    fh = B/2+f0;
    fl = f0-B/2;
    %�����
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
    [h,w] = freqz(b,1,fs);
    resdB = abs(h);
    maxn = max(resdB);
    plot(w/pi*fs,resdB/maxn);
    title(sprintf("N=%dʱ���ú�������ƵĴ�ͨ�˲���",N_rect));
    xlabel("f/MHz");
    ylabel("����");
    grid on;
end