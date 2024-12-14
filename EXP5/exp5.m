%% 1.IIR
N = 100; % 总采样点数
r_values = [5, 10, 15, 20, 40]; % r 的不同取值
b_values = cell(5,1);
a_values = cell(5,1);
% 滤波器设计要求
Ap = 1;  % 通带起伏/纹波（dB）
As = 40; % 止带衰减（dB）
transition_width = 0.1 * pi; % 过渡带宽

fs = 2 * pi; % 归一化采样频率
i=1;
for r = r_values
    
    wc = r * 2 * pi / N; % 通带截止频率
    wp = wc / fs; % 归一化通带截止频率
    %%通带和止带之间有一个过渡带
    ws = (wc + transition_width) / fs; % 归一化止带开始频率

    % 使用 buttord 计算巴特沃斯滤波器的最小阶数
    [n1, Wn] = buttord(wp, ws, Ap, As);
    
    % 设计巴特沃斯滤波器
    [b, a] = butter(n1, Wn);%b是归一化频率,a是幅度
    b_values{i}=b;
    a_values{i}=a;
    % 绘制频率响应
    fvtool(b, a);
    title(sprintf('r=%d时的低通滤波器',r));
    i=i+1;
end
%% 2
N=100;
n=0:10*N;
x=square(2*pi/N*n);
X=fft(x);
subplot(4,1,1);
plot(n,abs(X));
xlabel('k');
ylabel('|X(k)|');
title('x(n)的幅频响应');
%%
i=3;
for j = 1:1:5
    subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    Y=fft(y);
    plot(n,abs(Y));
    xlabel('k');
    ylabel('|Y(k)|');
    title(sprintf('r=%d时x(n)通过滤波器后的波形y(n)的幅频响应',r_values(j)));
    i=i+1;
end
%% 3
n = 2*N:5*N;
x=square(2*pi/N*n);
subplot(4,1,1);
plot(n,x);
xlabel('n');
ylabel('x(n)');
ylim([-1/2,1.2]);
title('周期为100的方波信号x(n)(取第2-5个周期)');
%%
i=3;
for j = 1:1:5
    subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    plot(n,y);
    xlabel('n');
    ylabel('y(n)');
    title(sprintf('r=%d时x(n)通过滤波器后的波形(取第2-5个周期)',r_values(j)));
    i=i+1;
end
%% 4
% 规格参数
n=0:10*N;
x=square(2*pi/N*n);
Ap = 1;      % 通带起伏（dB）
As = 15;     % 止带衰减（dB）
wp = 0.3 * pi; % 通带截止频率（弧度）
ws = 0.2 * pi; % 止带截止频率（弧度）
fs = 2 * pi; % 归一化采样频率

% 转换频率为归一化频率（从0到1, 1对应pi弧度）
wp = wp / (fs / 2);
ws = ws / (fs / 2);

% 计算切比雪夫 I 型滤波器的最小阶数和截止频率
[n1, Wp] = cheb1ord(wp, ws, Ap, As);

% 设计切比雪夫 I 型高通滤波器
[b, a] = cheby1(n1, Ap, Wp, 'high');

% 绘制频率响应
% fvtool(b, a);
% title('切比雪夫 I 型高通滤波器的幅频响应');
%%
y_hp=filtfilt(b,a,x);
%%subplot(4,1,1);
plot(n,y_hp);
xlabel('n');
ylabel('y_{hp}(n)');
title('x(n)经过切比雪夫 I 型高通滤波器后的波形y_{hp}(n)');
%%
i=3;
for j = 1:1:5
    %subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    y1 = y+y_hp;
    plot(n,y1);
    xlabel('n');
    ylabel('y(n)+y_{hp}(n)');
    title(sprintf('r=%d时y(n)和y_{hp}(n)叠加后的波形',r_values(j)));
    i=i+1;
end


