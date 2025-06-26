set I := 1..3; # depositi
set J; # clienti

param costoCostruzione{I};
param capacitàMax{I};
param richiesta{J};
param costoTrasporto{I,J}; #dal deposito i a j

var y{i in I} binary; # 1 (deposito i è costruito), 0 (altrimenti)
var x{i in I, j in J} >= 0; # quantitativo di merce in tonnellate trasportata dal deposito i a j

minimize costoComplessivo: sum{i in I}(costoCostruzione[i]*y[i]) + sum{i in I}(sum{j in J}(costoTrasporto[i,j]*x[i,j]));

s.t. max2depositi: sum{i in I} y[i] <= 2;
s.t. maxCapacity{i in I}: sum{j in J} x[i,j] <= capacitàMax[i]*y[i];
s.t. domanda{j in J}: sum{i in I} x[i,j] = richiesta[j];