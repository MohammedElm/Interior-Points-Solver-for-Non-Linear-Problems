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
% This function is for Example 5.8 in the SF2822 exercise booklet

function [f,gradf,g,A,HessL] = ex58(x,lambda)
  
f = 0.5*(x+[1 2]')'*(x+[1 2]');
gradf = (x+[1 2]');
Hessf = eye(2);

n = length(x);

g = [ 6-3*(x(1)+x(2)-2)^2-(x(1)-x(2))^2 
      x(1)
      x(2) ];  
gradg{1} = [ -6*(x(1)+x(2)-2)-2*(x(1)-x(2)) 
          -6*(x(1)+x(2)-2)+2*(x(1)-x(2)) ];
gradg{2} = [ 1 0 ]';
gradg{3} = [ 0 1 ]';
Hessg{1} = [ -8 -4 
             -4 -8 ];
Hessg{2} = zeros(n);
Hessg{3} = zeros(n);

m = length(g);

A = [];

HessL = Hessf;
for i=1:m
  HessL = HessL-lambda(i)*Hessg{i};
  A(i,:) = gradg{i}';
end



