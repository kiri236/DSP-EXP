hammingw = 6.6*pi;
wh = 0.8*pi;%ͨ����ֹƵ��
deltaw = 0.1*pi;
wts = wh+deltaw;%���Ƶ��
N = ceil(hammingw/deltaw);
w0 = (wh+wts)/2;
As = 40;
b = fir1(N-1,w0/pi,hamming(N));
%% Ƶ����Ӧ
freqz(b,1);
title("FIR��ͨ�˲����ķ�Ƶ���Ժ���Ƶ����");
%% Ⱥ��ʱ
grpdelay(b,1);
title("FIR��ͨ�˲�����Ⱥʱ��");