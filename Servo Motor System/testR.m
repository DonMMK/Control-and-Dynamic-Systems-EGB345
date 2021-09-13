% function [alpha_est,K_est]=testR(t,data);
% 
%% your lines here
% Question 1
format long
%[km, alpha] = GenerateCSVRandom('EGB345RandomData.csv')

data = csvread('EGB345RandomData.csv',2,0); %read from row 2, col 0

t = data(:,1); %time vector
step_input = data(:,2); %voltage 1 
yn_random = data(:,3); %voltage 2

t_shifted = t;
%save('prelabdata_yn_random.txt','yn_random','-ascii')

timeShift = 0 - t(find(step_input > 1,1,'first'));
offset = mean(yn_random(1:round(timeShift)));

%removing offset and delays
for i = 1:length(t)
    t_shifted(i) = t_shifted(i) + timeShift; %time shift to start at 0
    yn_random_fixed(i) = yn_random(i) - offset; %removing offset 
end

%removing values when switch is off
t_shifted = t_shifted(step_input > 1.8);
yn_random_fixed = yn_random(step_input > 1.8);
step_input_fixed = step_input(step_input > 1.8);

%save('prelabdata_yn_random_fixed.txt','yn_random_fixed','-ascii')

%s term on numerator, multiply step input by 2

figure(1)
plot(t,yn_random,'r',t_shifted,yn_random_fixed,'b')

title('Motor Open Loop Step Response')
xlabel('Time')
ylabel('Voltage')
legend('YnRandom','YnRandomFixed')
%km = 9.073618431965894 alpha = 5.717375811226858
%Question 2
% Vp = 9.073618431965894;
% D1 = 0;
% a = 5.717375811226858;
% Vm = [D1 a];

old_cost = 1100;
for i = 4550:5:4580
    for j = 1 %add more for loops for k l and m
        
        numtest = i;
        dentest = [j k l m];
        %recreate transfer function
        systest = tf(numtest, dentest);
        sea_testtf = step(systest, t);
        cost = sse(SEA_speed - sea_testtf);
        if cost < old_cost
            Ol = i;
            Ea = [j k l m];
            old_cost = cost;
        end
    end
end

sys = tf(num, den);
figure(3)
sea_tf = step(sys,t);
plot(t,sea_tf,t,SEA_speed);



% end