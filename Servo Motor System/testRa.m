function [alpha_est, K_est] = test(t,ydata);
oldCost = 1e100;
for i1 = 5:0.5:10
    for j1 = 1:0.5:5
%Create TF
       Numtest = [i1];
       Dentest = [1 j1 0];
       sys = tf(Numtest, Dentest);
       %Step response
       motor_step = step(sys, t);
       %Find Squared Sum Error
       cost = sse(motor_step - ydata);
       %Update oldCost
       if cost < oldCost
           num = [i1];
den = [1 j1 0];
           oldCost = cost;
       end
    end
end
for i2 = num() - 2:0.03:num() +2
    for j2 = den(2) - 3:0.03:den(2) +2
%Create TF
       Numtest = [i2];
       Dentest = [1 j2 0];
       sys = tf(Numtest, Dentest);
       
%Step response
       motor_step = step(sys, t);
       %Find Squared Sum Error
       cost = sse(motor_step - ydata);
       %Update oldCost
       if cost < oldCost
           num = [i2];
den = [1 j2 0];
           oldCost = cost;
       end
    end
end
for i3 = num() - 2:0.03:num() +2
    for j3 = den(2) - 3:0.03:den(2) +2
%Create TF
       Numtest = [i3];
       Dentest = [1 j3 0];
       sys = tf(Numtest, Dentest);
       %Step response
       motor_step = step(sys, t);
       %Find Squared Sum Error
       cost = sse(motor_step - ydata);
       %Update oldCost
       if cost < oldCost
           num = [i3];
den = [1 j3 0];
           oldCost = cost;
       end
    end
end
% K_est value
K_est = num;
% alpha_est value
alpha_est = den(:,2);
end