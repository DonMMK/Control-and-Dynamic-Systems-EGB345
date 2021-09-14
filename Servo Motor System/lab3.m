close all
clear all

%% Task 1
%load csv file, *row/col starts from 0
servo = csvread('openloop_1.csv',2,0);
t = servo(:,1);
dataRaw = [servo(:,2) servo(:,3)];
figure(3)
plot(t,dataRaw(:,1),'b',t,dataRaw(:,2),'r')


%% Task 2
% load in the data
load('SEA_speed.mat')
N1 = 4674.15;
D1 = 1;
D2 = 168.36;
D3 = 988.38;
D4 = 39673;

%set up the TF function
num = [N1];
den = [D1 D2 D3 D4];
sys = tf(num,den)

%plot the response for the system and the raw data
SEA_TF = step(sys,t);
figure(2)
plot(t,SEA_speed,t,SEA_TF,'r')

%measure the performance of the estimate
perf = sse(SEA_speed-SEA_TF);

%find a way to optimise the results
%this can be done with for loops and looping around the existing areas
%I just used an search for speed. Use for loops if you haven't done 246.
% func = @(x0)SEA_system(x0);
% params = fminsearch(func,[N1,D1,D2,D3,D4]);
% 
% num =  params(1)
% den = [params(2) params(3) params(4) params(5)]

% using for loops (just takes a bit of time)
oldCost = 1e100;
for i = 4550:5:4560 %3 -12
    for j = 1 %0 - 10
        for k = 130:5:150
            for l = 1200:5:1250
                for m = 39000:5:39100
        
                    %set up tf function
                    numTest = [i];
                    denTest = [j k l m];    
                    sys = tf(numTest,denTest);

                    %response to a step input
                    SEA_TF = step(sys,t);

                    %error
                    cost = sse(SEA_speed-SEA_TF);

                    if cost<oldCost
                        num = [i];
                        den = [j k l m];  
                        oldCost = cost;
                    end
                end
            end
        end
    end
end   


%re-do the TF with the new params
sys = tf(num,den);

%re plot
figure(1)
SEA_TF = step(sys,t);
plot(t,SEA_speed,t,SEA_TF,'r')

%measure the new performance of the error
perf = sse(SEA_speed-SEA_TF);

