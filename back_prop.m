%% Back propagation
clc;clear all;
%% Taking inputs
load('perceptrons/Input_data.mat');
load('perceptrons/Output_data.mat');
I = Input_data;
O = Output_data;
%% Scaling
SCmin = -0.5;
SCmax = 0.5;

[n,nI] = size(I);
[n1,nO] = size(O);
Smin = min([I O]);
Smax = max([I O]);
sf = (SCmax - SCmin)./(Smax - Smin);
X = I;
Y = O;
for i=1:nI
    X(:,i) = SCmin + (I(:,i) - Smin(i)).*sf(i);
end
for i=1:nO
    Y(:,i) = SCmin + (O(:,i) - Smin(i+nI)).*sf(i+nI);
end

%% NN algo
h = waitbar(0,'Starting Training');
nh = 5;
nu=nI;
no=nO;

w1 = rand(nh,nu)-0.5;
w2 = rand(no,nh)-0.5;

iter = 1000;
alpha = 0.005;                            % Learning rate
for it=1:iter
    globerr = 0;
    for index = 1:n
        ai = X(index,:);                % Output of input layer
        zj = ai*w1';                    % Input to hidden layer activation function
        aj = tanh(zj);                  % Output of hidden layer activation function
        zk = aj*w2';                    % Input to output layer activation function
        ak = tanh(zk);                  % Output of output layer activation function
        err = (Y(index,:)-ak);          % Error calculated
        
        dgk = 1 - zk.*zk;               % Derivative of tanh for output layer
        deltak = err .* dgk;  
        dw2 = (aj' * deltak)';          % Weight change
        w2 = w2 + alpha * dw2;          % New weights
        
        dg2k = 1 - zj.*zj;              % Derivative of tanh for hidden layer
        deltaj = (deltak * w2).*dg2k;
        dw1 = (ai' * deltaj)';          % weight change
        w1 = w1 + alpha * dw1;          % New weights
        
        globerr = globerr + sum(err.^2);
    end
    globerr = globerr/(nO*n);
%     disp([num2str(it*100/iter) '%, iter = ' num2str(it) '    global error = ' num2str(globerr)]);
    perc = it*100/iter;
    waitbar(perc/100,h,sprintf('%0.2f%% done (%d/%d)    globalerror = %d',perc,it,iter,globerr));
    if(globerr < 0.001)
        waitbar(1,h,sprintf('Converged (iteration %d/%d)    globalerror = %d',it,iter,globerr));
        break;
    end
end

%% Evaluation and plotting
Zj = X * w1';
Aj = tanh(Zj);
Zk = Aj*w2';

for i=1:nO
    Zk(:,i) = Smin(i+nI) + (Zk(:,i) - SCmin)./sf(i+nI);
end

subplot(2,2,1); scatter(I(:,1),Zk(:,1)); hold on; scatter(I(:,1),O(:,1)); grid on; box on;
subplot(2,2,2); scatter(I(:,2),Zk(:,1)); hold on; scatter(I(:,2),O(:,1)); grid on; box on;
subplot(2,2,3); scatter(I(:,1),Zk(:,2)); hold on; scatter(I(:,1),O(:,2)); grid on; box on;
subplot(2,2,4); scatter(I(:,2),Zk(:,2)); hold on; scatter(I(:,2),O(:,2)); grid on; box on;
close(h);