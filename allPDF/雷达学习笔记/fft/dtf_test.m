%%�ֶ�����fft,�����
clc ;
clear;
%%
n=1:256;       %nΪʱ����ɢ�źŵı�ţ�ȡֵ��ΧΪ1~N                                                                          
z=1:256;
N=256;         %NΪʱ����ɢ�źŵĵ���
m=1:N;

figure(3);
phaseComp= -sin( m'* n*2*pi/N)*1i + cos( m'*n*2*pi/N);

for m=1:3      %mΪƵ���źŵı�ţ�ȡֵ��ΧΪ1~N��
    x1= -sin( m* n*2*pi/N)*1i + cos( m*n*2*pi/N);%3��x1��������[1*256]%ŷ����ʽ��w= m*n*2*pi/N
    subplot(3,3,m) 
    plot3(real(x1),imag(x1),z);
end
%%
%e.g.ȡm=50,dtft_in
m=50;   
subplot(3,3,4) 
dtft_in= -sin(m*n*2*pi/N)*1i+cos(m*n*2*pi/N);%;[1*256] 
plot3(real(dtft_in),imag(dtft_in),z);

m=59;   
subplot(3,3,5) 
y1= -sin(m*n*2*pi/N)*1i+cos(m*n*2*pi/N)%;%;[1*256] 
plot3(real(y1),imag(y1),z);

m=78;   %
subplot(3,3,6) 
y2= -sin(m*n*2*pi/N)*1i+cos(m*n*2*pi/N);
plot3(real(y2),imag(y2),z);
%%
%m=1:N;
xya = abs(dtft_in * y1')%���ӷֺ������п����
xyb = abs(dtft_in * y2')%absȡģֵ


% w=hamming(256)+hamming(256)*1i;%�Ӵ�
dtft_out =  dtft_in * phaseComp';
subplot(3,3,7) 
plot(n,abs(dtft_out));


%%
%�Զ�����fft,����ֱ������
for k=1:1:256
    
    x(k)=sin(0.1*k);
end
subplot(3,3,8) 
plot(abs(fft(x)));