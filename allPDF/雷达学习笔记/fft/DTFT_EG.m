close all;       % 先关闭所有图片
Adc=0;           % 直流分量幅度 2
A1=1;            % 频率F1信号的幅度
A2=0.5;          % 频率F2信号的幅度
F1=1000;           % 信号1频率(Hz)
F2=2000;           % 信号2频率(Hz)
Fs=8000;          % 采样频率(Hz)
P1=-30;          % 信号1相位(度)
P2=90;           % 信号2相位(度)
N=256;           % 采样点数256
t=[0:1/Fs:N/Fs]; % 采样时刻

%%
% 信号
S=Adc+A1*cos(2*pi*F1*t+pi*P1/180)+A2*cos(2*pi*F2*t+pi*P2/180);
S1=A1*cos(2*pi*F1*t+pi*P1/180);
S2=A2*cos(2*pi*F2*t+pi*P2/180);
% 显示原始信号
plot(t,S,t,S1,t,S2);
title('原始信号');


Y = fft(S,N);                % 做FFT变换，返回 N点 DFT。
Ayy = (abs(Y));              % 取模
figure;
plot(Ayy(1:N));              % 显示原始的FFT模值结果
title('FFT 模值');


Ayy=Ayy/(N/2);               % 换算成实际的幅度
Ayy(1)=Ayy(1)/2;             %由于零频在双边谱中本没有被一分为二，所以对于零频外的点还有乘以2，得到的才是真实的频率幅值。
F=([1:N]-1)*Fs/N;            % 换算成实际的频率值
figure;
plot(F(1:N/2),Ayy(1:N/2));   % 显示换算后的FFT模值结果
title('幅度-频率曲线图');


Pyy=[1:N/2];
for i=[1:N/2]
Pyy(i)=phase(Y(i));          % 计算相位
Pyy(i)=Pyy(i)*180/pi;        % 换算为角度
end
figure;
plot(F(1:N/2),Pyy(1:N/2));   % 显示相位图
title('相位-频率曲线图');