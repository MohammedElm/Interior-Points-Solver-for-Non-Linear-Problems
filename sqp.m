% function [x,lambda,f,gradf,g,A,HessL] = sqp(prob,x,lambda);
%
% solves the problem
%
% minimize   f(x)
% subject to g_i(x) >= 0, i=1,...,m
%
% The input variable prob points to an m file that provides problem
% data for each iteration on the form
%
% [f,gradf,g,A,HessL] = ex512(x,lambda)
%
% where
%
% f           Objective function
% gradf       Objective function gradient
% g           Constraint function
% A           Constraint Jacobian
% HessL       Hessian of Lagrangian function
% ( HessL = Hessf - sum lambda(i) Hessg{i} )
%
% at a given point (x,lambda)

% Write your solver here. You may want to add additional input
% and/or output arguments and omit some of the output arguments.

% At each iteration, compute problem data for the problem specified
% by prob.

% [f,gradf,g,A,HessL] = feval(prob,x,lambda);

function [x, lambda, f, gradf, g, A, HessL] = sqp(prob, x, lambda)
n = length(x);

% Evaluate the problem at the initial point
[f, gradf, g, A, HessL] = prob(x, lambda);

% Start the iterations
i = 0;

% Stop the loop when the optimality conditions have been reached
while ~(prod(g >= 0) && prod(abs(gradf - A'*lambda) < 1e-7) && prod(lambda >= 0))
    % Check that the Hessian is positive definite
    if min(eig(HessL)) <= 0
        min_eigen_val= min(eig(HessL));
        pert_matrix= max(0, 1e-7  - min_eigen_val)*eye(size(HessL));
        HessL= HessL+pert_matrix;
    end 
    
    % Solve the QP-subptoblem
    [p,s,lambda] = qp(A, -g, gradf, HessL, zeros(n,1), lambda); 
    % Use the result to step in the optimal direction
    x = x + p;
    % Compute the new result
    [f,gradf,g,A,HessL] = prob(x,lambda);
    
    i = i + 1;
    fprintf("Iteration %d\n", i);
end
% fprintf("Total iterations %d\n", i);
end
