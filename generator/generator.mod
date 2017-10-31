### generator.mod
### Author: Ruaridh Williamson

set TYPES = 1..3;
set HOURS = 1..24 circular;
set DEMAND dimen 2;

param cost_start{TYPES};
param cost_min{TYPES};
param cost_inc{TYPES};
param power_min{TYPES};
param power_max{TYPES};
param gen_max{TYPES};
param demand_threshold;

# The number of generators of a given TYPE running at a given HOUR
var x{TYPES, HOURS} integer;
# The total MW supplied by the generators of a given TYPE running at a given HOUR
var p_tot{TYPES, HOURS} >= 0;
# The incremental MW supplied by the generators of a given TYPE running at a given HOUR
var p_inc{TYPES, HOURS} >= 0;
# The additional number of generators starting up of a given TYPE at a given HOUR
var x_idx{TYPES, HOURS} >= 0;

minimize Total_Cost: sum{j in TYPES, t in HOURS} cost_start[j]*x_idx[j,t] + cost_min[j]*x[j,t] + cost_inc[j]*p_inc[j,t];

subject to
Demand {(t,d) in DEMAND}: sum{j in TYPES} p_tot[j,t] >= d;
Threshold {(t,d) in DEMAND}: sum{j in TYPES} (power_max[j]*x[j,t]) >= d * (1 + demand_threshold);
TotalPower {j in TYPES, t in HOURS}: p_tot[j,t] = power_min[j]*x[j,t] + p_inc[j,t];
SupplyUpper {j in TYPES, t in HOURS}: p_tot[j,t] <= power_max[j]*x[j,t];
StartingUp {j in TYPES, t in HOURS}: x_idx[j,t] >= x[j,t] - x[j,prev(t)];
MaxTypes {j in TYPES, t in HOURS}: x[j,t] <= gen_max[j];
