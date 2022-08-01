clc
clear all;
close  all;
A=[1,1,0.5;0,1,1;0,0,1];  %δ���Ըߴ���
A=[1,1,0;0,1,1;0,0,1]; %���Ըߴ���
H=[1,0,0];  %�۲���

step=101;


Voice=normrnd(0,0.5,1,step);
true_x=0.5*(0:step-1)+0.5*(0:step-1).^2;   
temp_x=true_x+Voice(1,:);  %�۲�λ��
%true_x=0.5*(0:step-1)+0.5*(0:step-1).^2;

position = zeros(1,step+1);   %��¼����
speed = zeros(1,step+1);
acc = zeros(1,step+1);

Q=[0.1,0,0;0,0.1,0;0,0,0.1];  %ϵͳ����
R=[0.5];   %��������
Pk=[1,0,0;0,1,0;0,0,1];  
x = [0 0 0]';

position(1) = x(1);
speed(1) = x(2);
acc(1) = x(3);


for i=1:step
    x_ = A * x ; %��
    Pk_ = A * Pk * A' + Q ; %��
    Kk = (Pk_ * H')/(H * Pk_ * H' + R);  %��
    x = x_ + Kk * (temp_x(i)-H*x_);  %��
    Pk = (diag([1 1 1 ]) - Kk * H) * Pk_;  %��
    position(i+1) = x(1);
    speed(i+1) = x(2);
    acc(i+1) = x(3);
end

figure(1)
plot(temp_x)  %�۲�λ��
hold on
plot(position,'*-')    %����λ��

figure(2)
plot(speed,'*-')  %�����ٶ�

figure(3)
plot(acc,'*-') %���Ƽ��ٶ�