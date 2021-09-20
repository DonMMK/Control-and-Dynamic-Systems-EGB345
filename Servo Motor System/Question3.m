UnknownData('EGB345UnknownData.csv',10496262)

% Read CSV file
data = readtable('EGB345UnknownData.csv');

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
in = Step_Input(x:x+539);


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

t = Shifted_Time;
ydata = yn_random_fixed;

oldCost = 1e100;
for i = 4:1:14
    for j = 0:1:8
        
        
        %set up tf function
        numTest = [i];
        denTest = [1 j 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %error
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num = [i];
            den = [1 j 0];
            oldCost = cost;
        end
    end
end 

num1sig = num
den1sig = den(2);

for k = num1sig -3 :0.1:num1sig+3
    for l = den1sig - 3:0.1:den1sig +3
        
        
        %set up tf function
        numTest = [k];
        denTest = [1 l 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %error
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num2 = [k];
            den2 = [1 l 0];
            oldCost = cost;
        end
    end
end 

num2sig = num2
den2sig = den2(2);
for k = num2sig-.1:0.01:num2sig+.1
    for l = den2sig - .1:0.01:den2sig +.1
        
        
        %set up tf function
        numTest = [k];
        denTest = [1 l 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %error
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num3 = [k];
            den3 = [1 l 0];
            oldCost = cost;
        end
    end
end

disp('done');

K_est = num3

alpha_est = den3(2);