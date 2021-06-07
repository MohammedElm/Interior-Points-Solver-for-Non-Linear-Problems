%% PROJECT 2

clear; clc; close all;

%% Dimensioning figures

set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

set(0,'defaultfigurecolor',[1 1 1])
titsize=18;
labsize=13;
axisize=12;
linWidth=2;

%% Testing exercise P2 from Ex session 4 with QP (Ex 6.1 from booklet)

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
A = [2 1;
     1 0;
     0 1];

b = [4 1 0]';

H = [2 0;
     0 2];

c = [0 0]';

x0 = [2 2]';
s = A*x0 - b;
lambda0 = [2 2 2]';

[x,s,lambda] = qp(A,b,c,H,x0,lambda0);

% For printing: [x,s,lambda,x_saved] = qp(A,b,c,H,x0,lambda0);
% figure(1)
% x1int = [-10 10]';
% polyplot(A,b,x1int);
% xlabel("x1");
% ylabel("x2");
% title("Exercise 6.1 evolution of the solution starting from the third quadrant")
% hold on;
% plot(x_saved(1,:), x_saved(2,:));
% plot(x(1), x(2), '*r');
% grid on;
% hold off;

% Optimal solution: x = [1.6 0.8]
disp(x)

%% Testing exercise P1 from Ex session 4 with QP

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
A = [1 0;
     0 -1;
     4 1];

b = [1/2 1/4 3/2]';

H = [1 0;
     0 8];

c = [0 0]';

x0 = [1 -2]';
lambda0 = [2 2 2]';

[x,s,lambda] = qp(A,b,c,H,x0,lambda0);

% Optimal solution: x = [0.5 -0.25]
disp(x)

%% Testing exercise 4.7 from the booklet

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
A = [-1 -1 -1;
     -1 0 1;
     1 0 0;
     0 0 1];

b = [-2 -1 0 0]';

H = [2 1 0;
     1 3 0; 
     0 0 4];

c = [-4 -7 4]';

x0 = [0 0 0]';
s = A*x0 - b;
lambda0 = [3 3 3 3]';

[x,s,lambda] = qp(A,b,c,H,x0,lambda0);

% Optimal solution: x = [0.3333 1.6667 0.0000]
disp(x)

%% For the SQP Part - EX 5.12 problem

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
x0 = [4 3]';
lambda0 = ones(2,1);
prob = @(x_var, lambda_var) ex512(x_var,lambda_var);

[x, lambda, f, gradf, g, A, HessL] = sqp(prob, x0, lambda0);

% Optimal solution: x = [0.5168 0.3316]
disp(x)

%% For the SQP Part - EX hexagon

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
x0 = 1*rand(9,1);
lambda0 = ones(24,1);
prob = @(x_var, lambda_var) hexagon(x_var,lambda_var);

[x, lambda, f, gradf, g, A, HessL] = sqp(prob, x0, lambda0);

% Optimal solution: x1 = [0.4024 0.9391 1.0000 0.9391 0.4024 
%                        0.5000 0.3438 -0.3438 -0.5000]
% Optimal solution: x2 = [0.1562 0.7941 1.0000 0.5801 0.2574 
%                         0.5367 0.6078 -0.3690 -0.2359]
% Optimal solution: x3 = [0.2059 0.8438 1.0000 0.7426 0.4199 
%                         0.6078 0.5367 -0.2359 -0.3690]
% Optimal solution: x4 = [0.0609 0.5976 1.0000 0.5976 0.0609 
%                         0.3438 0.5000 -0.5000 -0.3438]
% Optimal solution: x5 = [0.4199 0.7426 1.0000 0.8438 0.2059 
%                         0.3690 0.2359 -0.5367 -0.6078]
% Optimal solution: x6 = [0.2574 0.5801 1.0000 0.7941 0.1562 
%                         0.2359 0.3690 -0.6078 -0.5367]
disp(x)

figure(2)
pgon = polyshape([x(1) x(6); x(2) x(7); x(3) 0; x(4) x(8); x(5) x(9); 0 0]);
plot(pgon);
title("Hexagon obtained")
grid on;

%% For the SQP Part - EX 5.8 problem

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
x = [-1 -2]';
lambda = zeros(3,1);
prob = @(x_var, lambda_var) ex58(x_var,lambda_var);

[x, lambda, f, gradf, g, A, HessL] = sqp(prob, x, lambda);

% Optimal solution: x = [0.5767 0.0431]
disp(x)

%% For the SQP Part - EX 5.11 problem

% Clear workspace to start from scratch
clear; clc; close all;

% State the problem
x = [0 1]';
lambda = 1;
prob = @(x_var, lambda_var) ex511(x_var,lambda_var);

[x, lambda, f, gradf, g, A, HessL] = sqp(prob, x, lambda);

% Optimal solution: x = [0.5547 0.8321]
disp(x)
