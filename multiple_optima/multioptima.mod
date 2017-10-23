# ORIGINAL LP

var x1 >= 0;
var x2 >= 0;

maximize objec: 2*x1 + 10*x2;

subject to
constone: 2*x1 + 10*x2 <= 61;
consttwo: 2*x1 + x2 <= 28;
constthree: -x1 + 4*x2 <= 24.4;
constfour: 4*x1 - x2 <= 38;
constfive: 2*x1 + 3*x2 <= 54;

# objective is 61
# solution is (0, 6.1)

/*
# NEW MULTIPLE OPTIMA LP

maximize objec: (61 - 2*x1 - 10*x2) + (24.4 + x1 - 4*x2) + (0 + x1);

subject to
constobj: 2*x1 + 10*x2 = 61;
constone: 2*x1 + 10*x2 <= 61;
consttwo: 2*x1 + x2 <= 28;
constthree: -x1 + 4*x2 <= 24.4;
constfour: 4*x1 - x2 <= 38;
constfive: 2*x1 + 3*x2 <= 54;

# objective = 29.4
# solution is (10.5, 4)

# original objective = 2*10.5 + 10*4 = 61
*/
