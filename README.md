# Interior-Points-Solver-for-Non-Linear-Problems

In this project, two main solvers were constructed. The first one solves Inequality Quadratic Problems (IQP) and the second solves, using sequential quadratic programming (SQP), the more general problems where the objective and the constraints are only assumed to be twice differentiables, both were created using MATLAB. Theory of underlying Quadratic Programming and Sequential Quadratic Programming, and mathematical steps, is explained. Then, a detailed description of the constructed solvers is introduced. Multiple testings was done on the constructed solvers to study their functionality. These tests have been analysed and discussed together while comparing with another solver and providing recommendation for future work.


In this problem, $H$ is said to be positive definite (i.e., $H \succ 0$) and it is assumed that there are m inequalities meaning that $A \in R^{m \times n}$ and $b \in R^m$. In the
