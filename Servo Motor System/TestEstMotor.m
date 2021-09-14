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