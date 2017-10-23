### student.mod
### Author: Ruaridh Williamson

## Part A

# Define the ranges for the number of Papers and Weeks
set PAPER = 1..3;
set WEEK  = 1..10;

# Define the required parameters
param passmark;           # Constant
param maxmark;            # Constant
param minmark{PAPER};     # Function of the Paper
param raisemark{PAPER};   # Function of the Paper

param restrictgrade;      # Constant for Part B

# Define the required variables
var allpass_bin binary;             # Binary indicator: all papers were passed
var passed_bin{PAPER} binary;       # Binary indicator: each PAPER was passed
var mark{PAPER} >= 0;               # Real variable: final mark for each PAPER
var study_bin{PAPER, WEEK} binary;  # Binary indicator: study for PAPER p in WEEK t

## Since we are not interested in the exact week numbers in which each paper was
## studied, we could simplify the problem slightly by converting the 30 binary
## variables for study_bin into the Total Count of Weeks for each PAPER.

# Wish to maximise the average mark provided that allpass_bin = 1
maximize Grade: allpass_bin * (sum{p in PAPER} mark[p]) / card(PAPER);

## card(PAPER) returns the cardinality of the set or number of elements n

subject to
# Require that every paper is passed for allpass_bin = 1
AllPass: sum{p in PAPER} passed_bin[p] >= card(PAPER) * allpass_bin;
# Require that each mark[p] is above passmark for passed_bin = 1
PassMark {p in PAPER} : mark[p] >= passmark * passed_bin[p];
# Mark[p] is bounded above by maxmark
MaxMark {p in PAPER} : mark[p] <= maxmark;
# Can only study on one paper in any given week
OnePaperPerWeek {t in WEEK} : sum{p in PAPER} study_bin[p, t] = 1;
# Each PAPER mark is calculated as the minmark plus (weekly mark increment) * (total number of weeks studied)
EachMark {p in PAPER} : mark[p] = minmark[p] + raisemark[p] * sum{t in WEEK} study_bin[p, t];

## Part B

# The additional restriction has the effect of forcing Grade to be no more than
# "restrictgrade" marks higher than any given mark
AddRestriction {q in PAPER} : sum{p in PAPER} mark[p] / card(PAPER) <= restrictgrade + mark[q];

option solver cplex;
