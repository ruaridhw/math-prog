### killersudoku.mod
### Author: Ruaridh Williamson

# Define the feasible set of numbers available to use in Sudoku the problem
set N = 1..9;

# Instead of the set "A" of starting parameters, we have the two-dimensional
# set of m BOXES and their respective box-sums.
param m;
set BOXES {1..m} within N cross N;
param boxsum {1..m};

# The variable "x" is 1 for each square in row i, column j with value k, 0 otherwise
var x {N, N, N} binary;

# The dummy objective has no significance as this is a feasibility problem
maximize dummyObj: 0;

subject to
# For every grid point, we need one of the numbers 1-9 (ie. k)
OneNum {i in N, j in N}: sum{k in N} x[i,j,k] = 1;
# For every row, each number must appear in one column
Rows {i in N, k in N}: sum{j in N} x[i,j,k] = 1;
# For every column, each number must appear in one row
Cols {j in N, k in N}: sum{i in N} x[i,j,k] = 1;
# For every 3x3 box, each number must appear once
Boxes {s in {1..3}, t in {1..3}, k in N}: sum {(i, j) in {(3*s-2)..3*s} cross {(3*t-2)..3*t}} x[i,j,k] = 1;
# The sum of the entries in one of the BOXES must total the respective boxsum
KillerConstraint {r in {1..m}}: sum{(i, j) in BOXES[r], k in N} k * x[i,j,k] = boxsum[r];

option solver cplex;
