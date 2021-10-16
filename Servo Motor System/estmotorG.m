function [alpha_est, km_est] = estmotorG(t,ydata)
%Initializers
sse_list = zeros(101,3);
quality = 1;

%repeating search with increased precision around the found km and
%alpha value.

%(Course) -> (Finer) -> (Finer) -> (Fine)
counter = 1;

for x = 0:1:10
  for y = 0:1:10
        sys = tf(x,[1 y 0]);
        model_step_response = 2*step(sys,t);
        %finding sse between given data and modelled data
        sse_list(counter,:) = [sse(ydata-model_step_response), x, y];
        counter = counter + 1;
  end
end

%Finding the best alpha and km value(minimum sse value) in the search set 
km_model = sse_list(sse_list == min(sse_list(:,1)), 2);
alpha_model = sse_list(sse_list == min(sse_list(:,1)), 3);

while quality < 1000
counter = 1;
for x = km_model - 1/quality: 0.1/quality :km_model + 1/quality
  for y = alpha_model - 1/quality: 0.1/quality :alpha_model + 1/quality
        sys = tf(x,[1 y 0]);
        model_step_response = 2*step(sys,t);
        %finding sse between given data and modelled data
        sse_list(counter,:) = [sse(ydata-model_step_response), x, y];
        counter = counter + 1;
  end
end

quality = quality*10;
%Finding the best alpha and km value(minimum sse value) in the search set 
km_model = sse_list(sse_list == min(sse_list(:,1)), 2);
alpha_model = sse_list(sse_list == min(sse_list(:,1)), 3);


end

alpha_est = alpha_model;
km_est = km_model;

%Estimation accuracy
1 - rms(ydata-model_step_response)

end