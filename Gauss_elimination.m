%% Gauss Elimination code, class 1
% clc;
% clear all;
% B = [0 3 7 -4 7;5 4 8 1 -46;8 0 4 -2 0;-1 6 0 2 13];
B = [1 4 8 7 61;5 6 8 11 85;9 7 8 16 111; 15 4 3 2 40];
n = size(B,1); % Order of equations
x = zeros(n,1);
for i=1:n-1
   % Finding pivot element
   [pivot,index] = max(B(i:n,i));
   index=index+i-1;
   if(pivot ~= 0)
       B([i index],:) = B([index i],:);
       for j = i+1:n
           B(j,:) = B(j,:) - (B(j,i)/pivot) .* B(i,:);
       end
   end
end
%% Back substitution
for i=n:-1:1
    var = n-i+1;
    value = B(i,n+1);
    for j=var:-1:1
        index = i+j-1;
        if(index==i)
           x(i,1) = value / B(i,n-var+1);
        else
            value = value - B(i,index) * x(index,1);
        end
    end
end
disp('Soln is:');
x