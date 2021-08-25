% Task 2
hold on 
load('SEA_speed(1).mat');
plot(t , SEA_speed)

numerator = [4674.15];
denominator = [1 168.36 988.38 39673]; % No zero at the end

sys = tf(numerator,denominator);

step(sys , t , 'r');
appx = step(sys, t , 'r');

sse(SEA_speed , appx);

hold off