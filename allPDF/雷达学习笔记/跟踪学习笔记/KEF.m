%% KEF计算存在空气阻尼的抛体运动轨迹方程
%% cui
close all;
clear all;
%% 真实轨迹模拟
kx =0.01; ky =0.05;     %阻尼系数
g = 9.8;
t = 15;                 %仿真时间
Ts = 0.1;               %采样周期
len = fix(t/Ts);        %仿真步数，直接取x的整数部分
dax = 3;day = 3;        %系统噪声
X = zeros(len, 4);     
X(1,:) = [0, 50, 500, 0]; %状态模拟的初值，第零次迭代
%% 建立状态方程
for k= 2:len
    x = X(k-1,1); vx = X(k-1,2); y = X(k-1,3); vy = X(k-1,4);
    x = x + vx*Ts;
    vx = vx + (-kx * vx^2 + dax*randn(1,1))*Ts;     %系统噪声服从高斯分布
    y = y + vy*Ts;
    vy = vy + (ky * vy^2 - g + day * randn(1))*Ts;
    X(k,:) = [x, vx, y, vy];
end
%% 构造量测量
dr = 8; dafa = 0.1;
for k = 1:len
    r = sqrt(X(k,1)^2 + X(k,3)^2) + dr*randn(1,1);      %量测量与状态量的关系式
    a = atan(X(k,1)/X(k,3)) * 57.3 + dafa * randn(1,1);
    Z(k,:) = [r, a];                                    %量测矩阵建立
end
%% EKF滤波
Qk = diag([0; dax/10; 0; day/10]) ^2;                   %预测状态的高斯噪声的协方差矩阵
Rk = diag([dr; dafa])^2;                                %传感器的测量误差
Pk = 10*eye(4);                                         %状态向量的协方差阵
Pkk_1 = 10*eye(4);
x_hat = [0, 40, 400, 0]';                               %初始的预测值
X_est = zeros(len, 4);                                  
x_forecast = zeros(4,1);
z = zeros(4,1);

for k = 1:len
    % 1 状态
    x1 = x_hat(1) + x_hat(2)*Ts;
    vx1 = x_hat(2) + (-kx*x_hat(2)^2)*Ts;
    y1 = x_hat(3) + x_hat(4)*Ts;
    vy1 = x_hat(4) + (ky*x_hat(4)^2 - g)*Ts;
    x_forecast = [x1; vx1; y1; vy1];
    
    % 2 观测
    r = sqrt(x1 * x1 + y1 * y1);
    alpha = atan(x1/y1) * 57.3;
    y_yuce = [r, alpha]';
    
    % 状态矩阵
    vx = x_forecast(2); vy = x_forecast(4);
    F = zeros(4, 4);                                       %状态转换矩阵F
    F(1,1) = 1; 
    F(1, 2) = Ts;
    F(2,2) = 1 - 2*kx*vx*Ts;
    F(3,3) = 1;
    F(3,4) = Ts;
    F(4,4) = 1 + 2*ky*vy*Ts;
    Pkk_1 = F*Pk*F' + Qk;
    
    % 观测矩阵
    x = x_forecast(1); y = x_forecast(3);
    H = zeros(2, 4);
    r = sqrt(x^2 + y^2); xy2 = 1 + (x / y) ^2;
    H(1,1) = x/r;
    H(1,3) = y / r;
    H(2,1) = (1/y)/xy2; 
    H(2,3) = (-x/y^2)/xy2;              %雅可比矩阵
    
    % 更新矩阵
    Kk = Pkk_1 * H' * (H * Pkk_1 * H' + Rk)^-1;             %卡尔曼增益
    x_hat = x_forecast + Kk*(Z(k,:)' - y_yuce);             %预测值校正
    Pk = (eye(4) - Kk*H) * Pkk_1;                           %更新矩阵
    X_est(k, :) = x_hat;
end
%% 作图
figure, hold on, grid on;
plot(X(:,1), X(:,3), '-b');
plot(Z(:,1).* sin(Z(:,2)* pi /180), Z(:,1).*cos(Z(:,2)*pi/180));
plot(X_est(:,1),X_est(:,3), 'r');
xlabel('X');
ylabel('Y');
title('EKF Simulation');
legend('Real', 'Measurement', 'EKF Estimated');
axis([-5, 230, 290, 530]);