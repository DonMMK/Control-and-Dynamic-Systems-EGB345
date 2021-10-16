close all; clc % ; clear; clc
% [km, alpha] = GenerateCSVRandom('EGB345RandomData.csv');

EGB345RandomData = csvread('EGB345RandomData.csv',2,0);

t_original = EGB345RandomData(:,1);
step_input = EGB345RandomData(:,2);
yn_random = EGB345RandomData(:,3);


%%%Question 1%%%
r = find(step_input > 0.5);
r_f = r(1);
r_e = r(end);

t = t_original(r_f:r_e);
t = -t(1) + t;
step_input = step_input(r_f:r_e);

yn_random_fixed = yn_random(r_f:r_e);
yn_random_fixed = yn_random_fixed - yn_random_fixed(1);

figure(1)
hold on
grid on
box on
plot(t_original,yn_random, 'red', 'Linewidth', 1, 'MarkerSize', 14);
plot(t,yn_random_fixed, 'blue', 'Linewidth', 1, 'MarkerSize', 14);
legend({'yn random','yn random fixed'}, 'FontSize', 16, 'Location', 'Best')
title('Question 1 Plot', 'FontSize', 20)
xlabel('Time(s)', 'FontSize', 16)
ylabel('Voltage(V)', 'FontSize', 16)

save('prelabdata_yn_random.txt','yn_random','-ascii')
save('prelabdata_yn_random_fixed.txt','yn_random_fixed','-ascii')

%%%Question 2%%%
[alpha_est, km_est] = estmotor(t,yn_random_fixed);

% erra = abs(alpha - alpha_est);
% errk = abs(km - km_est);
% 
% disp('alpha_error');  disp(' ');
% disp(erra);
% 
% disp('km_error'); disp(' ');
% disp(errk);
% 
% if erra < 0.1 || errk < 0.1
%     disp('found');
% end

sys = tf(km_est,[1 alpha_est 0]);
motor_est = step(2*sys,t);

figure(2)
hold on
grid on
box on
plot(t,motor_est, 'blue', 'Linewidth', 1, 'MarkerSize', 14);
plot(t,yn_random_fixed, 'red', 'Linewidth', 1, 'MarkerSize', 14);
legend({'Motor Estimate','Motor Simulation'}, 'FontSize', 16, 'Location', 'Best')
title('Question 2 Plot', 'FontSize', 20)
xlabel('Time(s)', 'FontSize', 16)
ylabel('Voltage(V)', 'FontSize', 16)

%%%Question 3%%%
EGB345UnkownData = csvread('EGB345UnknownData.csv',2,0);
y1_original = EGB345UnkownData(:,3);
step_input_1 = EGB345UnkownData(:,2);
t_original_1 = EGB345UnkownData(:,1);

r = find(step_input_1 > 0.5);
r_f = r(1);
r_e = r(end);

t_1 = t_original_1(r_f:r_e);
t_1 = -t_1(1) + t_1;

y1 = y1_original(r_f:r_e);
y1 = y1 - y1(1);

[alpha_est_1,K_est_1] = estmotor(t_1,y1);
sys_1 = tf(K_est_1,[1 alpha_est_1 0]);
motor_est_1 = 2*step(sys_1,t_1);

figure(3)
hold on
grid on
box on
plot(t_1,y1, 'blue', 'Linewidth', 1, 'MarkerSize', 14);
plot(t_1,motor_est_1, 'red', 'Linewidth', 1, 'MarkerSize', 14);
legend({'Unknown Motor Estimate','Unknown Motor Simulation'}, 'FontSize', 16, 'Location', 'Best')
title('Question 3 Plot', 'FontSize', 20)
xlabel('Time(s)', 'FontSize', 16)
ylabel('Voltage(V)', 'FontSize', 16)

save('prelabdata_y1.txt','y1','-ascii')