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
% This function is for Example 5.12 in the SF2822 exercise booklet

function [f,gradf,g,A,HessL] = ex512(x,lambda)
  
f = 0.5*(x+[1 1]')'*(x+[1 1]');
gradf = (x+[1 1]');
Hessf = eye(2);

n = length(x);

g = [ -3*(x(1)+x(2)-2)^2-(x(1)-2*x(2))^2+4 
      4*x(2)-1 ];
gradg{1} = [ -6*(x(1)+x(2)-2)-2*(x(1)-2*x(2)) 
          -6*(x(1)+x(2)-2)+4*(x(1)-2*x(2)) ];
gradg{2} = [ 0 4 ]';
Hessg{1} = [ -8 -2 
             -2 -14 ];
Hessg{2} = zeros(n);

m = length(g);

A = [];

HessL = Hessf;
for i=1:m
  HessL = HessL-lambda(i)*Hessg{i};
  A(i,:) = gradg{i}';
end



