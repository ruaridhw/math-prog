set LOCATIONS;
set ROUTES within {LOCATIONS, LOCATIONS};

param cost{ROUTES};
param demand{LOCATIONS} default 0;
param supply{LOCATIONS} default 0;
param max_throughput{LOCATIONS} default Infinity;
param preference_penalty{ROUTES} default 0;
var x{ROUTES} >= 0;

minimize total_cost:
        sum{(i,j) in ROUTES} ((cost[i,j] + preference_penalty[i,j]) * x[i,j])
      ;

subject to
CityConstraints {city in LOCATIONS}:

      sum{(i,j) in ROUTES: j = city} (x[i,j])
    - sum{(i,j) in ROUTES: i = city} (x[i,j])

             >= demand[city] - supply[city]
;

ThroughputConstraints {city in LOCATIONS}:

      sum{(i,j) in ROUTES: j = city} (x[i,j])

             <= max_throughput[city]
;
