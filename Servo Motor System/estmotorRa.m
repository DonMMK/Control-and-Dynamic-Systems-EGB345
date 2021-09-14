function [alpha_est,K_est]=estmotor(t,ydata);
% Write the estmotor to get the best estimate for km and alpha

% Reconstruct the transfer function and plot the response against
% yn_random_fixed

close all; clc

oldCost = 1e100;

% estimation for 0 decimal places
for k0 = 5:1:10
    for a0 = 1:1:5
        
        %set up tf function
        numTest = [k0];
        denTest = [1 a0 0];
        motor_TF = tf(numTest, denTest);
                    
        % response to step input
        motor_SR = step(motor_TF, t);
        
        % error
        error = motor_SR - ydata;
                    
        % cost (Squared Sum Error)
        cost = sse(error);
                    
        if cost < oldCost
            num = [k0];
            den = [1 a0 0];
            
            oldCost = cost;
        end
    end
end


% estimation for 1st decimal place
for k1 = k0 - 3:0.1:k0 + 3
    for a1 = a0 - 3:0.1:a0 + 3
        
        %set up tf function
        numTest = [k1];
        denTest = [1 a1 0];
        motor_TF = tf(numTest, denTest);
                    
        % response to step input
        motor_SR = step(motor_TF, t);
        
        % error
        error = motor_SR - ydata;
                    
        % cost (Squared Sum Error)
        cost = sse(error);
                    
        if cost < oldCost
            num = [k1];
            den = [1 a1 0];
          
            oldCost = cost;
        end
    end
end


% estimation for 2 decimal places
for k2 = k1 - 2:0.01:k1 + 2
    for a2 = a1 - 2:0.01:a1 + 2
        
        %set up tf function
        numTest = [k2];
        denTest = [1 a2 0];
        motor_TF = tf(numTest, denTest);
                    
        % response to step input
        motor_SR = step(motor_TF, t);
        
        % error
        error = motor_SR - ydata;
                    
        % cost (Squared Sum Error)
        cost = sse(error);
                    
        if cost < oldCost
            num = [k2];
            den = [1 a2 0];
           
            oldCost = cost;
        end
    end
end


K_est = num;
alpha_est = den(:,2);

sysPerfect_TF = tf(num, den);
sysPerfect_SR = step(sysPerfect_TF, t);

figure();
plot(t, sysPerfect_SR, 'blue', 'LineWidth', 1, 'MarkerSize', 14);
hold on
grid on
plot(t, ydata, 'red', 'LineWidth', 1, 'MarkerSize', 14);

end