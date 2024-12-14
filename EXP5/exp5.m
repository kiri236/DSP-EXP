%% 1.IIR
N = 100; % �ܲ�������
r_values = [5, 10, 15, 20, 40]; % r �Ĳ�ͬȡֵ
b_values = cell(5,1);
a_values = cell(5,1);
% �˲������Ҫ��
Ap = 1;  % ͨ�����/�Ʋ���dB��
As = 40; % ֹ��˥����dB��
transition_width = 0.1 * pi; % ���ɴ���

fs = 2 * pi; % ��һ������Ƶ��
i=1;
for r = r_values
    
    wc = r * 2 * pi / N; % ͨ����ֹƵ��
    wp = wc / fs; % ��һ��ͨ����ֹƵ��
    %%ͨ����ֹ��֮����һ�����ɴ�
    ws = (wc + transition_width) / fs; % ��һ��ֹ����ʼƵ��

    % ʹ�� buttord ���������˹�˲�������С����
    [n1, Wn] = buttord(wp, ws, Ap, As);
    
    % ��ư�����˹�˲���
    [b, a] = butter(n1, Wn);%b�ǹ�һ��Ƶ��,a�Ƿ���
    b_values{i}=b;
    a_values{i}=a;
    % ����Ƶ����Ӧ
    fvtool(b, a);
    title(sprintf('r=%dʱ�ĵ�ͨ�˲���',r));
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
title('x(n)�ķ�Ƶ��Ӧ');
%%
i=3;
for j = 1:1:5
    subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    Y=fft(y);
    plot(n,abs(Y));
    xlabel('k');
    ylabel('|Y(k)|');
    title(sprintf('r=%dʱx(n)ͨ���˲�����Ĳ���y(n)�ķ�Ƶ��Ӧ',r_values(j)));
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
title('����Ϊ100�ķ����ź�x(n)(ȡ��2-5������)');
%%
i=3;
for j = 1:1:5
    subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    plot(n,y);
    xlabel('n');
    ylabel('y(n)');
    title(sprintf('r=%dʱx(n)ͨ���˲�����Ĳ���(ȡ��2-5������)',r_values(j)));
    i=i+1;
end
%% 4
% ������
n=0:10*N;
x=square(2*pi/N*n);
Ap = 1;      % ͨ�������dB��
As = 15;     % ֹ��˥����dB��
wp = 0.3 * pi; % ͨ����ֹƵ�ʣ����ȣ�
ws = 0.2 * pi; % ֹ����ֹƵ�ʣ����ȣ�
fs = 2 * pi; % ��һ������Ƶ��

% ת��Ƶ��Ϊ��һ��Ƶ�ʣ���0��1, 1��Ӧpi���ȣ�
wp = wp / (fs / 2);
ws = ws / (fs / 2);

% �����б�ѩ�� I ���˲�������С�����ͽ�ֹƵ��
[n1, Wp] = cheb1ord(wp, ws, Ap, As);

% ����б�ѩ�� I �͸�ͨ�˲���
[b, a] = cheby1(n1, Ap, Wp, 'high');

% ����Ƶ����Ӧ
% fvtool(b, a);
% title('�б�ѩ�� I �͸�ͨ�˲����ķ�Ƶ��Ӧ');
%%
y_hp=filtfilt(b,a,x);
%%subplot(4,1,1);
plot(n,y_hp);
xlabel('n');
ylabel('y_{hp}(n)');
title('x(n)�����б�ѩ�� I �͸�ͨ�˲�����Ĳ���y_{hp}(n)');
%%
i=3;
for j = 1:1:5
    %subplot(4,2,i);
    y=filtfilt(b_values{j},a_values{j},x);
    y1 = y+y_hp;
    plot(n,y1);
    xlabel('n');
    ylabel('y(n)+y_{hp}(n)');
    title(sprintf('r=%dʱy(n)��y_{hp}(n)���Ӻ�Ĳ���',r_values(j)));
    i=i+1;
end


