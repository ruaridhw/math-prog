### piecewise_linear.mod
### Author: Ruaridh Williamson

set idx = 1..5;
set K = {(1,2), (2,2.5), (3,3), (4,3.5), (5,4)};

var x >= 0;
var y >= 0;
var theta{idx} >= 0;

param f_a{idx};

for {(i,bp) in K} {
  let f_a[i] := 2 * bp ^ 2;
}

minimize objective_func: sum{i in idx} (f_a[i]*theta[i]) + 12.5*y;

subject to
ConstX : sum{(i,bp) in K} (bp*theta[i]) = x;
Thetas: sum{i in idx} theta[i] = 1;
Const_one: x >= 2;
Const_two: x + y >= 12;
Const_three: x <= 4;
