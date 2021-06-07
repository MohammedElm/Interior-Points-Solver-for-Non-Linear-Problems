# Interior-Points-Solver-for-Non-Linear-Problems



## Abstract

In this project, two main solvers were constructed. The first one solves Inequality Quadratic Problems (IQP) and the second solves, using sequential quadratic programming (SQP), the more general problems where the objective and the constraints are only assumed to be twice differentiables, both were created using MATLAB. Theory of underlying Quadratic Programming and Sequential Quadratic Programming, and mathematical steps, is explained. Then, a detailed description of the constructed solvers is introduced. Multiple testings was done on the constructed solvers to study their functionality. These tests have been analysed and discussed together while comparing with another solver and providing recommendation for future work.


## Content

### The file qp.m:
- Solves Inequality Quadratic Problems (IQP) in the form:


 ![plot](./iqp_pb.png)
 
 Where H is a symmetric positive definite matrix.
 
 To so, we developed the following algorithm (Based on Interior Points Method):
 
 ![plot](./qp_algo.png)
 
 
 ### The file sqp.m:
- Solves Non Linear Problems (NLP) in the form:


 ![plot](./sqp_pb.png)
 
 
Where f and g are twice differentiables.
 
 To so, we developed the following algorithm (Based on Sequential Quadratic Programming ):
 
 ![plot](./sqp_algo.png)
 
 
 ### The file solvers_report.pdf:
 
 A detailed report explaining the underlying mathematics behind the solvers and a multitude of examples.
 
 ### The files ex511.m, ex512.m, ex58.m, hexagone.m
 
 All these files are examples of some optimization problems that we solved using out approach.
 
 
 # Note:
 
 This project was conducted for the KTH Royal Institute of Technology SF2822 COURSE (Applied Non Linear Optimization). We received the the full grade (A-5/5) for this work.


