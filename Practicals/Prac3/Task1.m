data = csvread('openloop_1(1).csv', 2,0);

figure(1)
title('Open loop plot');
xlabel('Time (seconds)');
ylabel('Voltage');
hold on
plot(data(:,1) , data(:,2) );
plot(data(:,1) , data(:,3) );
hold off