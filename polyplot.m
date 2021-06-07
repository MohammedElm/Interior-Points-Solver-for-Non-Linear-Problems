%POLYPLOT  function polyplot(A,b,x1int,x2int,linstp,linlen)
%
%          Polyplot plots the feasible region given by the two-dimensional
%          polyhedron { x | Ax >= b }.
%
%          x1int     is a two-dimensional vector [x1min x1max]' denoting the
%                    minimal and maximal x1-coordinates of the plot.
%          x2int     is a two-dimensional vector [x2min x2max]' denoting the
%                    minimal and maximal x2-coordinates of the plot. (Default
%                    ix x1int)
%          linstp    steplength between lines denoting the infeasible side of
%                    the inequality. (Default is (x2max-x2min)/60)
%          linlen    length of the shaded lines denoting the infeasible side
%                    of the inequality. (Default is (x2max-x2min)/30)

%           Anders Forsgren
%           Division of Optimization and Systems Theory
%           Department of Mathematics
%           KTH Royal Institute of Technology
%           andersf@kth.se

%           This version dated October 31, 2018

function [dummy] = polyplot(A,b,x1int,x2int,linstp,linlen)

if nargin < 3
   fprintf(' \n')
   fprintf(' Too few input arguments to polyplot. At least three required.\n' )
   fprintf(' \n')
else

   [m,n] = size(A);

   if nargin < 4
      x2int = x1int;
   end
   
   if nargin < 5
      linstp = (x2int(2)-x2int(1))/60;
   end

   if nargin < 6
      linlen = (x2int(2)-x2int(1))/30;
   end

   clf;
   hold on;

   for irow = 1:m,
      ineqplot(A(irow,:),b(irow),x1int,x2int,linstp,linlen);
   end

%  Just to get same scale on the axes
   
%   axis( [ x1int(1) x1int(2) x2int(1) x2int(2) ] );
   axis equal
   
end


%INEQPLOT  function ineqplot(a,b,x1int,x2int,linstp,linlen)
%
%          Ineqplot plots the inequality constraint { x | a'*x >= b }, i.e.,
%          draws the line and shades the infeasible side.
%
%          x1int     is a two-dimensional vector [x1min x1max]' denoting the
%                    minimal and maximal x1-coordinates of the plot.
%          x2int     is a two-dimensional vector [x2min x2max]' denoting the
%                    minimal and maximal x2-coordinates of the plot.
%          linstp    steplength between lines denoting the infeasible side of
%                    the inequality. (Default is (x2max-x2min)/60)
%          linlen    length of the shaded lines denoting the infeasible side
%                    of the inequality. (Default is (x2max-x2min)/30)

%           Anders Forsgren
%           Division of Optimization and Systems Theory
%           Department of Mathematics
%           KTH Royal Institute of Technology
%           andersf@kth.se

%           This version dated October 31, 2018

function [dummy] = ineqplot(a,b,x1int,x2int,linstp,linlen)

if nargin < 4
   fprintf(' \n')
   fprintf(' Too few input arguments to ineqplot. At least four required.\n' )
   fprintf(' \n')
else

   if nargin < 5
      linstp = (x2int(2)-x2int(1))/60;
   end

   if nargin < 6
      linlen = (x2int(2)-x2int(1))/30;
   end


   x1cand = [ -inf x1int(1) x1int(2) inf ]';
   x2cand = [ x2int(1) -inf inf x2int(2) ]';

   if a(1) ~= 0 & a(2) ~= 0
      x1cand([1 4]) = (b*ones(size(x2int))-a(2)*x2int)/a(1);
      x2cand([2 3]) = (b*ones(size(x1int))-a(1)*x1int)/a(2);
   elseif a(1) == 0 & a(2) ~= 0
      x2cand([2 3]) = (b*ones(size(x2cand([2 3]))))/a(2);
   elseif a(1) ~= 0 & a(2) == 0
      x1cand([1 4]) = (b*ones(size(x1cand([1 4]))))/a(1);
   else
      return
   end

   [x1cand,ix1] = sort(x1cand);
   x2cand = x2cand(ix1);
   
   x1ok = find(x1cand >= x1int(1) & x1cand <= x1int(2));
   x1x2ok = x1ok(find(x2cand(x1ok) >= x2int(1) & x2cand(x1ok) <= x2int(2)));

   if length(x1x2ok) < 2
      fprintf(' \n')
      fprintf(' Warning, inequality does not fit in given box. \n')
      fprintf(' \n')
   return
   end
   
   x1coord = x1cand(x1x2ok([1 length(x1x2ok)]));
   x2coord = x2cand(x1x2ok([1 length(x1x2ok)]));
   
   plot(x1coord,x2coord,'b');

   a = a/norm(a);
   v = [ x1coord(2)-x1coord(1) ; x2coord(2)-x2coord(1) ]';
   normv = norm(v);
   if normv == 0
      fprintf(' \n')
      fprintf(' Warning, inequality only touches corner of given box. \n')
      fprintf(' \n')
      return
   end
   v = v/normv;

   maxi = normv;

   for ii = 0:linstp:maxi,
      x1c1 = x1coord(1)+ii*v(1);
      x2c1 = x2coord(1)+ii*v(2);
      plot([x1c1 x1c1-linlen*a(1)], [x2c1 x2c1-linlen*a(2)],'b');
   end

end
