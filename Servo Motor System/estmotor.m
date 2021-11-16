function [alpha_est,K_est]=estmotor(t,ydata)

% % Using the transfer function that has been given
% N1 = km;
% D1 = 1;
% D2 = alpha;
% 
% % set up the transfer function
% nancy = [N1];
% donkey = [D1 D2 0];
% sys = tf(nancy, donkey);
% 
% %plot the response for the system and the raw data
% SEA_TF = step(sys,t);
% 
% %figure(2)
% %plot(t,SEA_speed,t,SEA_TF,'r')


% Using for loops 
oldCost = 1e100;
% Estimaton for 1 sf
for i = 1:1:14
    for j = 0:1:10
        
        
        %set up tf function
        numTest = [i];
        denTest = [1 j 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %cost -> Square Sum Error 
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num = [i];
            den = [1 j 0];
            oldCost = cost;
        end
    end
end 

num1sig = num;
den1sig = den(2);

% Estimaton for 2 sf
for k = num1sig -3 :0.1:num1sig+3
    for l = den1sig - 4:0.1:den1sig +4
        
        
        %set up tf function
        numTest = [k];
        denTest = [1 l 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %cost -> Square Sum Error 
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num2 = [k];
            den2 = [1 l 0];
            oldCost = cost;
        end
    end
end 

num2sig = num2;
den2sig = den2(2);

% Estimaton for 3 sf
for m = num2sig-.1:0.01:num2sig+.1
    for n = den2sig - .1:0.01:den2sig +.1
        
        
        %set up tf function
        numTest = [m];
        denTest = [1 n 0];
        sys = tf(numTest,denTest);
        
        %response to a step input
        SEA_TF = 2*step(sys,t);
        
        %cost -> Square Sum Error 
        cost = sse(ydata-SEA_TF);
        
        if cost<oldCost
            num3 = [m];
            den3 = [1 n 0];
            oldCost = cost;
        end
    end
end

disp('done');

K_est = num3

alpha_est = den3(2)

end
