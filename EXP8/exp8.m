fs = 1;
wp = 0.8*pi;
deltaw = 0.1*pi;
ws = wp+deltaw;
Rp = 1;
As = 40;

%%�������:
[n,Wn] = buttord(wp/pi*fs,ws/pi*fs,Rp,As);
[b,a] = butter(n,Wn);
%% Ƶ����Ӧ
freqz(b,a);
title("IIR�˲����ķ�Ƶ���Ժ���Ƶ����");
%% Ⱥʱ��
grpdelay(b,a);
ylim([0,20])
title("IIR�˲�����Ⱥʱ��");


