%% Perceptron
load('perceptrons/Input_data.mat');
load('perceptrons/Output_data.mat');
I = Input_data;
O = Output_data;
M = max(abs(I));
N = max(abs(O));
I(:,1) = I(:,1)./M(1);
I(:,2) = I(:,2)./M(2);
O(:,1) = O(:,1)./N(1);
O(:,2) = O(:,2)./N(2);

x = 2;
y = 2;
W = zeros(x,y);

%% Inititalizing

n = 0.2;   
W = rand(2,2);

%% Solver loop

for t = 1:100
    gerr = 0;
    for p = 1:size(I,1)
        x = I(p,:)';
        z = O(p,:)';
        ys = W'*x;
        y = logsig(ys);
        lerr = rms(z-y);
        gerr = gerr + lerr;
        dW = n *x*(z-y)';
        W = W + dW;
    end
    gerr = gerr/p;
end


%% Plotting
yob = zeros(1199,2);
for i = 1:size(I,1)
    yob(i,:) = W' * I(i,:)';
end
term = 2;
hold on;
scatter(I(:,term),yob(:,term),10,'filled');
scatter(I(:,term),O(:,term),15,'filled');
% plot(I(:,term),yob(:,term));
% plot(I(:,term),O(:,term));