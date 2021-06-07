% Function for computing 
%
% f           Objective function
% gradf       Objective function gradient
% g           Constraint function
% A           Constraint Jacobian
% HessL       Hessian of Lagrangian function
% ( HessL = Hessf - sum lambda(i) Hessg{i} )
%
% at a given point (x,lambda)
%
% This function is for Example 5.11 in the SF2822 exercise booklet

function [f,gradf,g,A,HessL] = ex511(x,lambda)
  
f = 0.5*(x-[2 3]')'*(x-[2 3]');
gradf = (x-[2 3]');
Hessf = eye(2);

n = length(x);

g = [ 0.5-0.5*x(1)^2-0.5*x(2)^2 ];  
gradg{1} = [ -x(1)
             -x(2) ];
Hessg{1} = [ -1 0 
             0 -1 ];

m = length(g);

A = [];

HessL = Hessf;
for i=1:m
  HessL = HessL-lambda(i)*Hessg{i};
  A(i,:) = gradg{i}';
end



