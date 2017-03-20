%% Matrix inversion
% A = [1 0 0;0 1 0;0 0 1]; B=[5;9;7];
A = [1 4 8 7;5 6 8 11;9 7 8 16; 15 4 3 2]; B = [61;85;111;40];
%% Running
n=size(A,1);
Atemp = zeros(n,2*n);
Ainv = zeros(n,n);
ratio=0;
temp=0;
for i=1:n
        Atemp(i,1:n) = A(i,1:n);
        Atemp(i,n+1:2*n) = zeros(1,n);
        Atemp(i,i+n) = 1;
end
for i=1:n
    for j = 1:n
      if(i~=j) 
        ratio = Atemp(j,i) / Atemp(i,i);
        for k=1:2*n
          Atemp(j,k) = Atemp(j,k) - ratio*Atemp(i,k);
        end
       end
    end
end

for i=1:n
    temp = Atemp(i,i);
    for j=1:2*n
      Atemp(i,j) = Atemp(i,j)/temp;
    end
end
for i=1:n
    Ainv(i,:) = Atemp(i,n+1:2*n);
end

%% Finding solutions
x = Ainv * B;