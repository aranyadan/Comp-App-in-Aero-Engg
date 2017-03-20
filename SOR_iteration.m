% SOR iteration method.
% A = [1 4 8 7;5 6 8 11;9 7 8 16; 15 4 3 2]; B = [61;85;111;40];
% A=[4 1 1;1 2 3;1 5 2]; B=[2;-4;-6];
A=[1 1 6;1 9 -2;8 2 -1]; B=[-61.3;49.1;185.8];
n=size(A,1);
X0 = zeros(n,1);
k=100;          % steps
delx = 0.000001;
w=1.2;
%% pivoting
for i=1:n-1
   % Finding pivot element
   [pivot,index] = max(A(i:n,i));
   index=index+i-1;
   if(pivot ~= 0)
       A([i index],:) = A([index i],:);
       B([i index]) = B([index i]);
   end
end
%% dividing the dagonal elements
for i=1:n
    if(A(i,i)~=0)
        B(i) = B(i)./A(i,i);
        A(i,:) = A(i,:)./A(i,i);
    end
end
%% SOR iteration
Xn=X0;
Xnn = X0;
its = zeros(21,1);
turns=0;
for l=1:21
    w=(l-1)*0.1;
    for i=1:k
       for j=1:n
           Xnn(j) = Xn(j) +w*(B(j) - (A(j,1:j-1)*Xnn(1:j-1) + A(j,j:n)*Xn(j:n)));
       end
       turns=i;
       if(max(abs(Xn-Xnn))<delx)
          break; 
       end
       Xn = Xnn;
    end
    its(l) = turns;
end
