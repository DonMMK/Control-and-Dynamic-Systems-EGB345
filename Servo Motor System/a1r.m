% Create Randomly assigned data
%[km, alpha] = GenerateCSVRandom('EGB345RandomData.csv');
km = 5.527416188207571;
alpha = 3.239426161205120;

%Read CSV file into workspace
randomdata = csvread('EGB345RandomData.csv',2,0);

%Rename Step response Data
yn_random = [randomdata(:,3)];

%create a time vector 
t = [randomdata(:,1)];

%Step input data
stepin = [randomdata(:,2)];

offset = mean(yn_random(t < 0));

% offset = yn_random(1);

%Remove time offset
t = t - 0.046273;

t_fixed = t((t < 1.973) & (t > 0));
stepin = stepin((t < 1.973) & (t > 0));
yn_random = yn_random((t < 1.973) & (t > 0));

%Remove offset of step response 
yn_random_fixed = yn_random - offset;

%1.16291
figure(1);
plot (t_fixed,(yn_random),'r')
hold on 
plot (t_fixed,(yn_random_fixed),'b')

xlabel('Time (s)');
ylabel('V_p (V)');
title ('yn\_random and yn\_random\_fixed');
legend('yn\_random','yn\_random\_fixed','Location', 'northwest');


% 
save('prelabdata_yn_random.txt','yn_random','-ascii');
save('prelabdata_yn_random_fixed.txt','yn_random_fixed','-ascii');


%% TASK 2

% Set up TF
[alpha_est,K_est] = estmotor(t_fixed,yn_random_fixed);

num = K_est;
dem = [1 alpha_est 0];

sys = tf(num,dem);

SEA_TF = step(sys,t_fixed);
figure(5)
plot(t_fixed,yn_random_fixed,'r','LineWidth', 1.5)
hold on 
plot(t_fixed,SEA_TF,'b','LineWidth', 1.5)
title ('Estimated model data and yn\_random\_fixed')
xlabel ('Time (s)');
ylabel ('V_p (V)');
legend('yn\_random\_fixed','Estimated model','Location', 'northwest');




%% TASK 3 

%UnknownData('EGB345UnknownData.csv',10295399)

unknown_data = csvread('EGB345UnknownData.csv',2,0);

unknown_time = unknown_data(:,1);
unknown_input = unknown_data(:,2);
unknown_ynrand = unknown_data(:,3);

unknown_time = unknown_time - 0.1388;

unknown_offset = mean(unknown_ynrand(t < 0));

Utime_fixed = unknown_time((unknown_time < 1.866) & (unknown_time > 0));
unknown_input = unknown_input((unknown_time < 1.866) & (unknown_time > 0));
unknown_ynrand = unknown_ynrand((unknown_time < 1.866) & (unknown_time > 0));

y1 = unknown_ynrand - unknown_offset;
figure(8)

plot (Utime_fixed,unknown_ynrand,'r')
hold on 
plot (Utime_fixed,unknown_input,'k')

plot (Utime_fixed,y1,'b')

% 
% save('prelabdata_y1.txt','y1','-ascii');

[unknown_alpha_est,unknown_K_est]=estmotor(Utime_fixed,y1);


num = [unknown_K_est];
dem = [1 unknown_alpha_est 0];

sys = tf(num,dem);

Un_step = step(sys,Utime_fixed);

figure(9)
plot(Utime_fixed,y1,'r','LineWidth', 1.5)
hold on 
plot(Utime_fixed,Un_step,'b','LineWidth', 1.5)

title ('Estimated model data and EGB345 UnknownData')
xlabel ('Time (s)');
ylabel ('V_p (V)');
legend('EGB345 Unknown Data y1','Estimated Model Data','Location', 'northwest');


%Error for Km
esti_errork = abs(((K_est-km)/km)*100)

%Error for alpha 
esti_erroralp = abs(((alpha_est-alpha)/alpha)*100)


