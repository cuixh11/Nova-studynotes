clc
clear all;
close  all;
A=[1,1,0.5;0,1,1;0,0,1];  %未忽略高次项
A=[1,1,0;0,1,1;0,0,1]; %忽略高次项
H=[1,0,0];  %观测阵

step=101;


Voice=normrnd(0,0.5,1,step);
true_x=0.5*(0:step-1)+0.5*(0:step-1).^2;   
temp_x=true_x+Voice(1,:);  %观测位置
%true_x=0.5*(0:step-1)+0.5*(0:step-1).^2;

position = zeros(1,step+1);   %记录数据
speed = zeros(1,step+1);
acc = zeros(1,step+1);

Q=[0.1,0,0;0,0.1,0;0,0,0.1];  %系统噪声
R=[0.5];   %量测噪声
Pk=[1,0,0;0,1,0;0,0,1];  
x = [0 0 0]';

position(1) = x(1);
speed(1) = x(2);
acc(1) = x(3);


for i=1:step
    x_ = A * x ; %①
    Pk_ = A * Pk * A' + Q ; %②
    Kk = (Pk_ * H')/(H * Pk_ * H' + R);  %③
    x = x_ + Kk * (temp_x(i)-H*x_);  %④
    Pk = (diag([1 1 1 ]) - Kk * H) * Pk_;  %⑤
    position(i+1) = x(1);
    speed(i+1) = x(2);
    acc(i+1) = x(3);
end

figure(1)
plot(temp_x)  %观测位置
hold on
plot(position,'*-')    %估计位置

figure(2)
plot(speed,'*-')  %估计速度

figure(3)
plot(acc,'*-') %估计加速度