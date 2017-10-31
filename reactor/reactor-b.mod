### reactor-b.mod
### Author: Ruaridh Williamson

set N = 1..6;
param A{N};
param B{N};

var x >= 0;
var y >= 0;
var z >= 0;

var u_pos{N};
var u_neg{N};
var v_pos{N};
var v_neg{N};

var theta_1{N} binary;
var theta_2{N} binary;

param M_1 = 10;
param M_2 = 10;

maximize object: z;

subject to

const_z {i in N}: z <= (u_pos[i] + u_neg[i]) + (v_pos[i] + v_neg[i]);

const_1 {i in N}: u_pos[i] <= M_1 * (1 - theta_1[i]);
const_2 {i in N}: u_neg[i] <= M_1 * theta_1[i];
const_3 {i in N}: (x - A[i]) = u_pos[i] - u_neg[i];

const_4 {i in N}: v_pos[i] <= M_2 * (1 - theta_2[i]);
const_5 {i in N}: v_neg[i] <= M_2 * theta_2[i];
const_6 {i in N}: (y - B[i]) = v_pos[i] - v_neg[i];

const_x: x <= 10;
const_y: y <= 10;

option solver cplex;
