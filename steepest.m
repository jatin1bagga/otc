clc
clear all

syms x1 x2
% Define objective function (min)
f1= x1-x2+(2.*x1^2)+(2.*x1*x2)+(x2^2);
%f1=126*x1+182*x2-9*x1^2-13*x2^2;
% f1=10*(x2-x1^2)+(1-x1)^2
fx=inline(f1)    % convert to function
fobj=@(X) fx(X(1),X(2))

% Gradient of f
grad=gradient(f1)
G=inline(grad)
gradX=@(X) G(X(:,1),X(:,2))

% Hessian matrix
H1=hessian(f1)
Hx=inline(H1)

X0=[0 0]     % Set initial vector
maxiter=20;   % Set max iteration
tol=10^(-4); % Max tolerance
iter=0;      % Initial counter

% Steps
X=[];
while (norm(gradX(X0))>tol && iter<maxiter)
    X= [X;X0]      % Save all vectors
    S= -gradX(X0)     % Compute gradient at X
    H= Hx(X0)      % Compute Hessian at X
    lambda= (S'*S)/(S'*H*S)  % Compute lambda
    Xnew= X0+(lambda.*S')     % Update X
    X0= Xnew               % Save new X
    iter= iter+1           % Update iteration
end

fprintf('Optimal solution is (%f, %f)\n', X0(1),X0(2))
fprintf('Optimal value is %f', fobj(X0))
