J = 2.75*10^(-3);
B = 0.0042;
Td = 0.123;

np = 7;
PSIPM = 0.0523;

wr = 300*2*pi/60;

isq= 3;
Ce = 3*np*PSIPM/2*isq;
Cr = 0;
v = (((Ce - Cr - Td) - B*wr)/J)*60/(2*pi)