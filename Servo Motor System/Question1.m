close all; clear; clc

%% Question 1
% Generate the CSV file and get alpha and km 
% Used format long
%[km, alpha] = GenerateCSVRandom('EGB345RandomData.csv');

% True values for 
% alpha = 3.166842158940395
% km = 9.402273945004236

% Read CSV file
data = readtable('EGB345RandomData.csv');

% Remove the headings in the dataset
data(1:2 , :) = [] ;

% Get Data from coloumns
Time = str2double(data.Var1);
Step_Input = str2double(data.Var2);
Step_Response = str2double(data.Var3);
yn_random = Step_Response; % as per task sheet instructions

% Fix the offsets and delays from Step response and Step input%
UseFindFunc = find(Step_Input > 1,1, 'first');
StepInput_shift = 0 - Time(UseFindFunc);

Step_Input_Offset = yn_random( 1 : round(StepInput_shift) );
Step_Input_Offset = mean(Step_Input_Offset);

bin = ischange(Step_Input, 'linear');
x = find(bin, 1);
in = Step_Input(x:x+662);


for i = 1: length(Time)
    yn_random_fixed(i) = yn_random(i) - Step_Input_Offset; 
end

Shifted_Time = Time;
for i = 1: length(Time)
    Shifted_Time(i) = Shifted_Time(i) + StepInput_shift;
end

% When the thing is turned off. Fix the values
Shifted_Time = Shifted_Time(Step_Input > 1.8);
yn_random_fixed = yn_random(Step_Input > 1.8);

% vertical offset
offS = yn_random_fixed(1);
yn_random_fixed = yn_random_fixed - offS;


% Plot the data
figure();
hold on
grid on
box on
% plot(Time , Shifted_Time ); % plot time against 2V step input
plot(Shifted_Time , yn_random_fixed, 'r'); % plot time against step response
yn_random = in(1:end-1);
plot(Shifted_Time, yn_random, 'b');
% legend('Step Input','Step Response')
xlabel("Time (s)");
ylabel("Voltage (V)");

save('prelabdata_yn_random.txt','yn_random','-ascii');
save('prelabdata_yn_random_fixed.txt','yn_random_fixed','-ascii');

%alpha_est=1; %% remember to delete this line
%K_est=1; %% remember to delete this line