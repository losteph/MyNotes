set N := 1..5;
param T{N,N};

var x{N,N} binary;

maximize tot_pass: sum{i in N, j in N} T[i,j]*x[i,j];

s.t. solo1aereoParte {i in N} : sum {j in N} x[i,j] = 1;
s.t. solo1aereoArriva {j in N}: sum {i in N} x[i,j] = 1;