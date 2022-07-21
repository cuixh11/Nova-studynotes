close all;       % �ȹر�����ͼƬ
Adc=0;           % ֱ���������� 
A1=1;            % Ƶ��F1�źŵķ���
A2=0.5;          % Ƶ��F2�źŵķ���
F1=1000;           % �ź�1Ƶ��(Hz)
F2=2000;           % �ź�2Ƶ��(Hz)
Fs=8000;          % ����Ƶ��(Hz) ��ũ��������:fs��2f max
P1=0;          % �ź�1��λ(��)
P2=90;           % �ź�2��λ(��)
N=256;           % ��������256
t=[0:1/Fs:(N-1)/Fs]; % ����ʱ��
n=0:255;

%%
% ʱ���ź�
xt=Adc+A1*cos(2*pi*F1*t+pi*P1/180)+A2*sin(2*pi*F2*t+pi*P2/180);
xt1=A1*cos(2*pi*F1*t+pi*P1/180);
xt2=A2*cos(2*pi*F2*t+pi*P2/180);
% ��ʾԭʼʱ���ź�
figure(1);
plot(t,xt,t,xt1,t,xt2);
title('ԭʼ�ź�');

%%
%��ɢ�ź�
xn=Adc+A1*cos(2*pi*F1*n*1/Fs+pi*P1/180)+A2*sin(2*pi*F2*n*1/Fs+pi*P2/180);
figure(2);
plot(n,xn);
%�ӽ�һ������DFT�Ĺ����У�����/���ұ��ʽ�е�n��Ϊ�Ա���.
% for m=0:255
%       Xn =[cos(2*pi*m*n*1/Fs)-1j*sin(2*pi*m*n*1/Fs)]; 
%      sum(Xn)
% end
% m=2;
% Xn = [cos(2*pi*m*n*1/Fs)-1j*sin(2*pi*m*n*1/Fs)]%Xn = x(n)*[cos(2*pi*m*n*1/Fs)-1j*sin(2*pi*m*n*1/Fs)]
% sum(Xn)


%%
Y = fft(xt,N);                % ��FFT�任������ N�� DFT��
Ayy = (abs(Y));              % ȡģ
figure(4);
plot(Ayy(1:N));              % ��ʾԭʼ��FFTģֵ���
title('FFT ģֵ');

Ayy=Ayy/(N/2);               % �����ʵ�ʵķ���
Ayy(1)=Ayy(1)/2;             %������Ƶ��˫�����б�û�б�һ��Ϊ�������Զ�����Ƶ��ĵ㻹�г���2���õ��Ĳ�����ʵ��Ƶ�ʷ�ֵ��
F=([1:N]-1)*Fs/N;            % �����ʵ�ʵ�Ƶ��ֵ
figure(5);
plot(F(1:N/2),Ayy(1:N/2));   % ��ʾ������FFTģֵ���
title('����-Ƶ������ͼ');


Pyy=[1:N/2];
for i=[1:N/2]
Pyy(i)=phase(Y(i));          % ������λ
Pyy(i)=Pyy(i)*180/pi;        % ����Ϊ�Ƕ�
end
figure(6);
plot(F(1:N/2),Pyy(1:N/2));   % ��ʾ��λͼ
title('��λ-Ƶ������ͼ');