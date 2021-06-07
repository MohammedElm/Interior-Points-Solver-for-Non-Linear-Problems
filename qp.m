function [x,s,lambda] = qp(A,b,c,H,x,lambda)

% Function to solve the problem
%                        minimize     c'x + 0.5 x'H x
%                        subject to   A x -s = b
%                                     s >= 0

% x_saved = x;

% Initial parameters
s = A*x - b;
mu = 1; % HYPERPARAMETER
e = ones(length(lambda), 1);
i = 0;
alpha_lambda = 0;
pert_x = 0;
pert_lambda = 0;
[m, n] = size(A);
I = eye(m);

% Compute Divergence from KKT condition in variable merit
norm_1 = norm(A*x-b-s);
norm_2 = norm(H*x+c-A'*lambda);
merit = max([norm_1 norm_2 mu]);

% Check that the initial s is positive
while min(s)<0
    [~,pos] = min(s);
    s(pos) = abs(s(pos)); 
end
s(s == 0) = 1;

% Iterate until our merit function is smaller than the tolerance
while ~(merit <= 10^-7)
    % STEP 1: Select mu
    if (prod(abs(alpha_lambda*pert_x) < 10^(-3)) && prod(abs(alpha_lambda*pert_lambda) < 10^(-3)))
        mu = mu*0.001;
    end
    
    % STEP 2: Solving the linear system
    diag_s = diag(s);
    diag_lambda = diag(lambda);
    
    obj = [H -A';
           diag_lambda*A diag_s];
    
    g = -[H*x + c - A'*lambda;
          diag_lambda*(A*x-b) - mu*e];

    pert_xlambda = pinv(obj)*g;
    pert_x = pert_xlambda(1:length(x));
    pert_lambda = pert_xlambda(length(x)+1:end);
    pert_s = -(s-mu*pinv(diag_lambda)*e)-pinv(diag_lambda)*diag_s*pert_lambda;

    % STEP 3: Get the maximum step length
    % Compute maximum steplength dor lambda
    alpha_lambda = 1;
    test_lambda = lambda + alpha_lambda*pert_lambda;
    while ((sum(test_lambda < 0) > 0) && (alpha_lambda>0.001))
        alpha_lambda = alpha_lambda - 0.0001; % HYPERPARAMETER
        test_lambda = lambda + alpha_lambda*pert_lambda;
    end
    % Compute maximum steplength for s
    alpha_s = 1;
    test_s = s + alpha_s*pert_s;
    while ((sum(test_s < 0) > 0)&& (alpha_s>0.001))
        alpha_s = alpha_s - 0.0001; % HYPERPARAMETER
        test_s = s + alpha_s*pert_s;
    end

    alpha_max = min(alpha_s, alpha_lambda);
  
    % STEP 4: Get the step length for s and lambda
    eta = 0.999; % HYPERPARAMETER
    alpha = min(1, eta*alpha_max);
    
    % STEP 5: Update state vector
    x = x + alpha*pert_x;
    s = s + alpha*pert_s;
    lambda = lambda + alpha*pert_lambda;

    % Print the evolution of the solution and saved it for plotting
    i = i + 1;
    % x_saved = [x_saved x];
    
    % Compute Divergence from KKT condition in variable merit
    norm_1 = norm(A*x-b-s);
    norm_2 = norm(H*x+c-A'*lambda);
    merit = max([norm_1 norm_2 mu]);
    
    fprintf("Iteration in qp %d: x1 = %f, x2 = %f \n", i,x(1), x(2));
end

end